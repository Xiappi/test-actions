#!/bin/bash

search_dir=./scripts
reg_expr="^[\d]{6}\w{2}\d{2}.sql$"
for entry in "$search_dir"/*sql;
do
    # check for file
    if [ -f "$entry" ];
    then
        check=0

        # read line
        while read line;
        do
            
            # check for applied script statement
            if [[ "${line^^}" == *"APPLIED_SCRIPTS"* ]]; then
                
                if [[ $line =~ $reg_expr ]]
                then
                    echo $BASH_REMATCH
                fi


                # check next 3 lines for file name
                # for i in {1..3}
                # do
                #     read 

                # done
                
                # echo $line
                # read line2
                # echo $line2
                # echo $entry
                check=1
            fi
        done <$entry
        
        if [ $check -eq 0 ]; then
            
            echo $entry
        fi
    fi
done

#!/bin/bash
filename='./scripts/210811DC03.sql'
n=1

# pass current branch, destination branch
# do git diff
# process each sql file

# while read line; do

# if [[ "${line^^}" == *"APPLIED_SCRIPTS"* ]]; then
#     echo "Line No. $n : $line"
#     read line2
#     echo $0
# fi

# n=$((n+1))
# # reading each line
# done < $filename