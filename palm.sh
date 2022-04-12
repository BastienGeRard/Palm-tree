#!/bin/sh

if [[ $1 == "-h" ]];
then
    echo "USAGE :"
    echo "      ./palm-tree/find_bin.sh ninary_name"
    echo "      If all the conditions are validated  you can push on your repository"
    echo "      Enter 'y' if you want to push or 'n' if you don't want"
    echo "      If you enter 'y' enter your commit to push"
    exit 1
fi;

make
make tests_run
make clean
clear
bubulle > palm-tree/norme

bin_file="$(find . -type f -name $1)"
test_file="$(find . -type f -name "test")"
unw_file="$(find . -type f -name "#*#" -o -name "*.gcna" -o -name "*~" -o -name "*.gcno" -o -name "*.o" -o -name "*.a" -o -name "*.so" -o -name "*.gcda" -o -name "*.gcov")"
unw_file+="$(find . -type d -name "tmp")"
if [[ $bin_file != "" ]];
then
    echo "Find" > palm-tree/resume
else
    echo "No_find" > palm-tree/resume
fi;
if [[ $test_file != "" ]];
then
    echo "Find" >> palm-tree/resume
else
    echo "No_find" >> palm-tree/resume
fi;
for i in $unw_file ;
do
    echo "Find_unwanted_file : $i" >> palm-tree/resume
done;
if [[ $unw_file == "" ]];
then
    echo "No_unwanted_file_find" >> palm-tree/resume
fi;

./palm-tree/print_check

nb=1
push=0

for line in $(cat palm-tree/push_that);
do
    if [ $nb -eq 1 ] && [ $line == "y" ];
    then
        make fclean
        rm test
        rm lib/libmy.a
        rm palm-tree/norme
        rm palm-tree/resume
        rm palm-tree/push_that
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
