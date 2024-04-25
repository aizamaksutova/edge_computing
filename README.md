# edge_computing

## Draft of the paper

[Link](https://github.com/aizamaksutova/edge_computing/blob/main/proposal.pdf) to the first draft of the paper 


## Storage performance benchmarking OF NVIDIA Jetson AGX Orin 

## Notation

 | Abbreviation  | Meaning |  Measurement  |
| ------------- | ------------- | ------------- | 
| BW  | bandwidth - the amount of data which can be transmitted from SSD to eMMC Flash memory  |  GB/s |

## Experiments

Storage performance benchmarking was done by using the [FIO linux tool](https://portal.nutanix.com/page/documents/kbs/details?targetId=kA07V000000LX7xSAG#:~:text=Flexible%20IO%20Tester%20(Fio)%20is,used%20for%20storage%20performance%20benchmarking.) which ensures data randomness, avoids OS level caching in order to benchmark only the underlying storage. All the tests were run separately to ensure clarity of results and benchmark certain processes in isolation. 

#### Standard command line for running a FIO test:
```
fio --name=fiotest --filename=/mnt/small_fio_test_read --size=16Gb --rw=read --bs=4K --direct=1 --numjobs=1 --ioengine=libaio --iodepth=1 --group_reporting --runtime=60 --startdelay=60
```
In our experiments we were mainly changing the size of the file (size parameter), block size (bs) and number of I/O units to keep in flight against the file (iodepth). 
Our hypothesis is that when we increase the amount of data that is transmitted through the PCIe between the SSD and eMMC Flash memory, it should occupy the PCIe bus more extensively, giving us higher amounts of bandwidth. The maximum theoretical bandwidth of the PCIe bus on Jetson AGX Orin, as listed in the official documentation, is 4 GB/s. Our experiments have proved this hypothesis. 

## Results

| IO Pattern | Test description | Size of file | Block Size | Explanation |  Min BW |  Avg BW  | Max BW | IODepth | 
| ------------- | ------------- | ------------- | ------------- | ------------- | ------------- | ------------- | ------------- | ------------- |
| Read | Sequential reads | 16 GB | 4 Kb| Imitates read backup activity or large file copies.  | 0.147 GB/s | 0.17 GB/s | 0.18 GB/s | 1 |
| Read | Sequential reads | 16 GB | 4 Kb | Imitates read backup activity or large file copies.  | 0.38 GB/s | 0.4 GB/s | 0.42 GB/s | 12 |
| Read | Sequential reads | 16 GB | 4 Kb | Imitates read backup activity or large file copies.  |  0.38 GB/s | 0.41 GB/s | 0.42 GB/s | 24 |
| Read | Sequential reads | 16 GB | 4 Mb | Imitates read backup activity or large file copies.  | 3,73 GB/s | 3.79 GB/s | 3.82 GB/s | 24 | 
| Read | Sequential reads | 16 GB | 4 Gb | Imitates read backup activity or large file copies.    | 4.01 Gb/s | 4.05 GB/s | 4.06 GB/s | 4 |


As we can see, the maximum theoretical bandwidth of the PCIe bus between SSD and eMMC flash memory can be reached with large block sizes of transmitted data and a big size of the file, which ensures that we are not stressing the caches. 

