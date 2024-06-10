bandwidthTest="cuda-samples/Samples/1_Utilities/bandwidthTest"
currentDir=$(pwd)
resultFile="$currentDir/bandwidth_results.txt"

# Array of memory sizes to test
sizes=(1e3 4e3 16e3 64e3 256e3 1e4 4e4 16e4 64e4 256e4 1e5 4e5 16e5 64e5 256e5 1e6 4e6 16e6 64e6 256e6 1024e6 4096e6)

# Change to the directory containing the bandwidth test
cd $bandwidthTest

# Clear the previous results file
echo "" > $resultFile

# Loop through each size and run the test
for size in "${sizes[@]}"; do
    # Define old and new text
    old_text='#define DEFAULT_SIZE (1024 * (1e6))'
    new_text="#define DEFAULT_SIZE ($size)"

    # Update the DEFAULT_SIZE in the source file
    sed -i "s|$old_text|$new_text|g" bandwidthTest.cu

    # Recompile the program
    make clean
    make

    echo "Testing with DEFAULT_SIZE = $size bytes" >> $resultFile
    # Run the bandwidth test and append the output to the results file
    ./bandwidthTest >> $resultFile

    # Restore the original text
    sed -i "s|$new_text|$old_text|g" bandwidthTest.cu
    make clean
done

# Optionally, navigate back to the original directory
cd $currentDir
