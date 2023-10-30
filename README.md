# edge_computing

## Benchmarking NVIDIA Jetson AGX Orin storage

## Notation

 | Abbreviation  | Meaning |  Measurement  |
| ------------- | ------------- | ------------- | 
| BW  | bandwidth  |  MiB/s |
| SLAT  | submission latency, the time it took to submit the I/O |  usec |
| CLAT  | completion latency, the time from submission to completion of the I/O pieces |  usec |
| TLAT  | total latency, the time from when Fio created the I/O unit to the completion of the I/O operation. |  usec |

## Results

| IO Pattern | Size of file | Block Size | Explanation |  Min BW |  Avg BW  | Max BW | Min SLAT | Avg SLAT | Max SLAT | Min CLAT | Avg CLAT | Max CLAT | 95th percentile of CLAT | 99th percentile of CLAT | 99.99th percentile of CLAT | Min TLAT | Avg TLAT | Max TLAT | 
| ------------- | ------------- | ------------- | ------------- | ------------- | ------------- | ------------- | ------------- | ------------- | ------------- | ------------- | ------------- | ------------- | ------------- | ------------- | ------------- | ------------- | ------------- | ------------- |
| Sequential writes |  16 GB | 1 M| Imitates write backup activity or large file copies.  | 948 | 1929.80 | 3740 | 74 | 192.35 | 49057 | 1327 | 32960.68 | 119571 | 37000 | 55000 | 112000 | 1610 | 33153.64 | 119786 | 
