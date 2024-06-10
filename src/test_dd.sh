#!/bin/bash

# Target device
device="/dev/mmcblk3"

# Output file to store the results
output_file="dd_results_middle.txt"

# Clear the output file at the start
echo "" > $output_file

# Loop over powers of 2 from 2^0 (1 KB) to 2^20 (1,048,576 KB or 1 GB)
for i in {12..20}; do
  # Calculate the size in KB for the current power of 2
  size=$((2**i))

  # Run the dd command with calculated size and append the last line of the output to the file
  echo "Testing with block size: $size KB" >> $output_file
  sudo dd if=$device of=/dev/null bs=1K count=$size iflag=direct 2>&1 | tail -n 1 >> $output_file
done

echo "All tests completed, results stored in $output_file."
