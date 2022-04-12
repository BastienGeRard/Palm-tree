#!/bin/sh

if [[ $1 == "-h" ]];
then
    echo "USAGE :"
    echo "      ./Check/find_bin.sh ninary_name"
    echo "      If all the conditions are validated  you can push on your repository"
    echo "      Enter 'y' if you want to push or 'n' if you don't want"
    echo "      If you enter 'y' enter your commit to push"
    exit 1
fi;

make
make tests_run
make clean
clear
bubulle > Check/norme

bin_file="$(find . -type f -name $1)"
test_file="$(find . -type f -name "test")"
unw_file="$(find . -type f -name "#*#" -o -name "*.gcna" -o -name "*~" -o -name "*.gcno" -o -name "*.o" -o -name "*.a" -o -name "*.so" -o -name "*.gcda" -o -name "*.gcov")"
unw_file+="$(find . -type d -name "tmp")"
if [[ $bin_file != "" ]];
then
    echo "Find" > Check/resume
else
    echo "No_find" > Check/resume
fi;
if [[ $test_file != "" ]];
then
    echo "Find" >> Check/resume
else
    echo "No_find" >> Check/resume
fi;
for i in $unw_file ;
do
    echo "Find_unwanted_file : $i" >> Check/resume
done;
if [[ $unw_file == "" ]];
then
    echo "No_unwanted_file_find" >> Check/resume
fi;

./Check/print_check
nb=1
push=0

for line in $(cat Check/push_that);
do
    if [ $nb -eq 1 ] && [ $line == "y" ];
    then
        make fclean
        rm Check/norme
        rm Check/resume
        rm Check/push_that
        git add .
        push=1
    fi;
    if [ $nb -eq 2 ] && [ $push -eq 1 ];
    then
        git commit -m "$line"
        git push
        break
    fi;
    nb=2
done

