#!/bin/bash




# search_dir=./scripts
# for entry in "$search_dir"/*sql
# do
#   if [ -f "$entry" ];then

#     while read line; do

#     if [[ "${line^^}" == *"APPLIED_SCRIPTS"* ]]; then
#         echo "Line No. $n : $line"
#         read line2
#         echo $0
#     fi

#     echo "$entry"
#   fi
# done

#!/bin/bash
filename='./scripts/210811DC03.sql'
n=1

# pass current branch, destination branch
# do git diff
# process each sql file

while read line; do

if [[ "${line^^}" == *"APPLIED_SCRIPTS"* ]]; then
    echo "Line No. $n : $line"
    read line2
    echo $0
fi

n=$((n+1))
# reading each line
done < $filename