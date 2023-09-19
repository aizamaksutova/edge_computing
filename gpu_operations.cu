#include <cuda_runtime.h>
#include <iostream>
#include <math.h>
#include <fstream>
#include <vector>
// Define the kernel function
__global__ void intensiveComputation(float *device_array, int n) {
    int idx = blockIdx.x * blockDim.x + threadIdx.x;
    if (idx < n) {
        for (int i = 0; i < 400; i++) {
            for (int j = 0; j < 400; j++) {
                device_array[idx] = sinf(device_array[idx]) + cosf(device_array[idx]);
            }
        }
    }
}

int main() {
    const int N = 10;
    float *host_array, *device_array;
    const int num_iterations = 500;

    // Allocate memory on the host and device
    host_array = (float *)malloc(N * sizeof(float));
    cudaMalloc((void **)&device_array, N * sizeof(float));

    // Initialize host array
    for (int i = 0; i < N; i++) {
        host_array[i] = i;
    }

    // CUDA events for timing
    cudaEvent_t start, stop;
    cudaEventCreate(&start);
    cudaEventCreate(&stop);
    float milliseconds = 0;
    std::vector<double> inferenceTimings;

    for (int iter = 0; iter < num_iterations; ++iter) {
        // Start timing
        cudaEventRecord(start);

        // Transfer data from host to device
        cudaMemcpy(device_array, host_array, N * sizeof(float), cudaMemcpyHostToDevice);

        // Launch the intensive computation kernel
        int threadsPerBlock = 256;
        int blocksPerGrid = (N + threadsPerBlock - 1) / threadsPerBlock;
        intensiveComputation<<<blocksPerGrid, threadsPerBlock>>>(device_array, N);

        // Transfer data from device back to host
        cudaMemcpy(host_array, device_array, N * sizeof(float), cudaMemcpyDeviceToHost);

        // Stop timing
        cudaEventRecord(stop);
        cudaEventSynchronize(stop);

        cudaEventElapsedTime(&milliseconds, start, stop);
        inferenceTimings.push_back(milliseconds);
    }


    std::ofstream timingsFile("inference_timings.txt");
    if (timingsFile.is_open()) {
        for (const auto& timing : inferenceTimings) {
            timingsFile << timing << std::endl;
        }
        timingsFile.close();
        std::cout << "Inference timings stored in 'inference_timings.txt'." << std::endl;
    }
    else {
        std::cerr << "Unable to open file for writing." << std::endl;
    }
    // Cleanup
    free(host_array);
    cudaFree(device_array);
    cudaEventDestroy(start);
    cudaEventDestroy(stop);
    return 0;
}
