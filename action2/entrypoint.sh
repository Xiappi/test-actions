#!/bin/sh -l

echo "Hello $1"
time=$(date)
echo "::set-output name=time::$time" 


# #!/bin/bash
# filename='test.txt'
# n=1

# # pass current branch, destination branch
# # do git diff
# # process each sql file

# while read line; do

# if [[ "${line^^}" == *"APPLIED_SCRIPTS"* ]]; then
#     echo "Line No. $n : $line"
#     read line2
#     echo $0
# fi

# n=$((n+1))
# # reading each line
# done < $filename