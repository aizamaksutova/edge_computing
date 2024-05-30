# edge_computing




## Analysis of SSD and DRAM Interaction

## Experiments

Storage performance benchmarking was done by using the [FIO linux tool](https://portal.nutanix.com/page/documents/kbs/details?targetId=kA07V000000LX7xSAG#:~:text=Flexible%20IO%20Tester%20(Fio)%20is,used%20for%20storage%20performance%20benchmarking.) which ensures data randomness, avoids OS level caching in order to benchmark only the underlying storage. All the tests were run separately to ensure clarity of results and benchmark certain processes in isolation. 

#### Standard command line for running a FIO test:
```
fio --name=fiotest --filename=/nvme/small_fio_test_read --size=16Gb --rw=read --bs=4K --direct=1 --numjobs=1 --ioengine=libaio --iodepth=1 --group_reporting --runtime=60 --startdelay=60
```
The filename should be on path /nvme/ in order for the filename to be created on SSD and the proper bandwidth to be tested. To see the storage devices on your device and their paths utilize:
```
lsblk -o KNAME,TYPE,SIZE,MODEL
```
In our experiments we were mainly changing the block size (bs) and number of I/O units to keep in flight against the file (iodepth). 

Considering the crucial role of efficient models and data loading/unloading for these vehicles' operational performance, we hypothesized that the bandwidth utilization between SSDs and DRAM directly affects the speed of these processes. Specifically, we proposed that higher bandwidth occupancy would correlate with quicker data handling speeds, particularly for loading and offloading models.


## Results

The hypothesis in this experiment was that increasing the load on the PCIe bus would enhance bandwidth utilization, maximizing the bus's capacity and accelerating data transfer rates. This was confirmed as the experiments in figure below showed a significant increase in bandwidth with larger block sizes. Notably, the bandwidth stabilized around the maximum theoretical rate of approximately 4 GB/s, per the specifications of the PCIe bus on the Jetson AGX Orin platform, upon reaching a block size of 0.5 GB.

![](https://github.com/aizamaksutova/edge_computing/blob/main/imgs/fio%20(1).png)

Analysis of smaller block sizes (below 15KB) in figure below revealed a gradual increase in bandwidth, illustrating poor occupation of the PCIe bus with minimal I/O load; for instance, a block size of 64KB achieved only 0.09 GB/s. These findings confirm that to fully utilize the PCIe's capacity on the Jetson AGX Orin, a minimum block size of 0.5 GB is necessary, and it must be processed concurrently to achieve optimal data transfer rates. This experiment substantiates our hypothesis that larger block sizes result in more efficient utilization of the available bandwidth on the PCIe bus.

![](https://github.com/aizamaksutova/edge_computing/blob/main/imgs/fio_1.png)

