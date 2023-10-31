# edge_computing

## Storage performance benchmarking OF NVIDIA Jetson AGX Orin 

## Notation

 | Abbreviation  | Meaning |  Measurement  |
| ------------- | ------------- | ------------- | 
| BW  | bandwidth  |  MiB/s |
| SLAT  | submission latency, the time it took to submit the I/O |  usec |
| CLAT  | completion latency, the time from submission to completion of the I/O pieces |  usec |
| TLAT  | total latency, the time from when Fio created the I/O unit to the completion of the I/O operation. |  usec |

## Experiments

Storage performance benchmarking was done by using the [FIO linux tool](https://portal.nutanix.com/page/documents/kbs/details?targetId=kA07V000000LX7xSAG#:~:text=Flexible%20IO%20Tester%20(Fio)%20is,used%20for%20storage%20performance%20benchmarking.) which ensures data randomness, avoids OS level caching in order to benchmark only the underlying storage. All the tests were run separately to ensure clarity of results and benchmark certain processes in isolation. 

#### Standard command line for running a FIO test:
```
fio --name=fiotest --filename=/home/test1 --size=16Gb --rw=randread --bs=8K --direct=1 --numjobs=8 --ioengine=libaio --iodepth=32 --group_reporting --runtime=60 --startdelay=60
```

## Results

| IO Pattern | Test description | Size of file | Block Size | Explanation |  Min BW |  Avg BW  | Max BW | Min SLAT | Avg SLAT | Max SLAT | Min CLAT | Avg CLAT | Max CLAT | 95th percentile of CLAT | 99th percentile of CLAT | 99.99th percentile of CLAT | Min TLAT | Avg TLAT | Max TLAT | 
| ------------- | ------------- | ------------- | ------------- | ------------- | ------------- | ------------- | ------------- | ------------- | ------------- | ------------- | ------------- | ------------- | ------------- | ------------- | ------------- | ------------- | ------------- | ------------- | ------------- |
| Write | Sequential writes | 16 GB | 1 Mb| Imitates write backup activity or large file copies.  | 948 | 1929.80 | 3740 | 74 | 192.35 | 49057 | 1327 | 32960.68 | 119571 | 37000 | 55000 | 112000 | 1610 | 33153.64 | 119786 | 
| Read | Sequential reads | 16 GB | 1 Mb | Imitates read backup activity or large file copies.  | 3610 | 3683.47 | 3720 | 29 | 147.19 | 1189 | 8342 | 17219.58 | 33357 | 17957 | 18482 | 25297 | 9156 | 17367.35 | 33393 |
| Write | Random writes | 16 GB | 64 Kb | Imitates medium block size workload for writes.  | 1534 | 1937.32 | 2891 | 9 | 83.27 | 16785 | 92 | 4042.62 | 28713 | 4752 | 6063 | 25297 | 121 | 4126.30 | 28748 |
| Read | Random reads | 16 GB | 64 Kb | Imitates medium block size workload for reads.  | 3619 | 3683.59 | 4097 | 7 | 26.46 | 2016 | 295 | 2140.07 | 9425 | 2933 | 3687 | 5932 | 308 | 2166.84 | 9483 |
| Write | Random writes | 16 GB | 8 Kb | Imitates common database workload simulation for writes. [small workloads]  | 291,4 | 511,5 | 935 | 5 | 117.1 | 6988 | 3 | 3786.24 | 24748 | 5866 | 7177 | 20055 | 141 | 3903.65 | 24805 |
| Read | Random reads | 16 GB | 8 Kb | Imitates common database workload simulation for reads. [small workloads]  | 1649 | 1671.51 | 1689 | 3 | 9.75 | 4676 | 146 | 1185.44 | 9355 | 1647 | 2073 | 3392 | 171 | 1195.36 | 9366 |
