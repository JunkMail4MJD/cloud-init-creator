#!/bin/bash
user_data_file=""
instance_meta_data_file=""
file_count=0

if test -f "/usr/src/files/meta-data"; then
   instance_meta_data_file="/usr/src/files/meta-data";
fi

if test -f "/usr/src/files/user-data"; then
   user_data_file="/usr/src/files/user-data";
   cloud-localds --verbose /usr/src/files/config-data.iso ${user_data_file} ${instance_meta_data_file}
else
  printf "No user-data file provided!!\n\n"
fi
