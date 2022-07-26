#!/bin/bash

# parse input as array, trim first and last character which are [ ]
IFS=', ' read -r -a array <<< "${1:1:-1}"

file_reg_expr=[0-9]{5,6}[a-zA-Z]{2,3}[0-9]{1,3}
insert_reg_expr=[0-9]{5,6}[a-zA-Z]{2,3}[0-9]{1,3}[\'\"]

failures=()
count=0

for entry in "${array[@]}"
do
    fileIsValid=0
    # check for file
    if [ -f "$entry" ];
    then
        check=0

        # capture applied script filename
        if [[ $entry =~ $file_reg_expr ]]
        then
            fileName="${BASH_REMATCH[0]}"
        else
            # only processe numbered scripts
            continue
        fi

        # read line
        while read line;
        do

            # check for applied script statement
            if [[ "${line^^}" == *"INSERT INTO APPLIED_SCRIPTS"* ]];
            then

                # grab next line, formatter should put it on the next line
                read line2


                # capture insert into applied scripts filename, also check the actual insert line to handle cheeky one liners
                if [[ ${line2^^} =~ ${insert_reg_expr^^} || ${line^^} =~ ${insert_reg_expr^^} ]]
                then

                    # grab value, and remove trailing quotation
                    applied_entry="${BASH_REMATCH[0]}"
                    applied_entry=${applied_entry::-1}

                    # compare, we just need one applied scripts entry to match filename so use a flag
                    if [ ${fileName^^} == ${applied_entry^^} ]
                    then
                        fileIsValid=1
                        break
                    fi
                fi

            fi
        done <$entry

        if [ $fileIsValid -ne 1 ]
        then
            failures+=( $entry )
        fi

    fi
done

if [ ${#failures[@]} -ne 0 ]
then
    echo ${failures[*]}
    exit 1
fi
