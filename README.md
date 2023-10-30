# edge_computing

## Benchmarking NVIDIA Jetson AGX Orin storage

BW - bandwidth, MiB/s
Latency measurements - usec
Slat - submission latency, usec
Clat - completion latency, usec

| IO Pattern | Size of file | Block Size | Explanation |  Min BW |  Avg BW  | Max BW | Min SLAT | Avg SLAT | Max SLAT | Min CLAT | Avg CLAT | Max CLAT | 95th percentile of CLAT | 99th percentile of CLAT | 99.99th percentile of CLAT | Min TLAT | Avg TLAT | Max TLAT | 
| ------------- | ------------- | ------------- | ------------- | ------------- | ------------- | ------------- | ------------- | ------------- | ------------- | ------------- | ------------- | ------------- | ------------- | ------------- | ------------- | ------------- | ------------- | ------------- |
| Sequential writes |  16 GB | 1 M| Imitates write backup activity or large file copies.  | 948 | 1929.80 | 3740 | 74 | 192.35 | 49057 |
