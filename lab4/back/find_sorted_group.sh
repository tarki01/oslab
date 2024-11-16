#!/bin/bash

workdir=$1
subject=$2
alpha=$3
group=$4
year=$5

attendance_file="$workdir/$subject/$alpha-$group-$year-attendance"
if [[ ! -f "$attendance_file" ]]; then
	    echo "Ошибка: Группа $alpha-$group-$year не найдена."
	        exit 1
fi

sorted_students=$(awk '{print $1, gsub(/\+/, "&")}' "$attendance_file" | sort -k2,2nr)
echo "Список студентов в группе $alpha-$group-$year, упорядоченный по посещаемости:"
echo "$sorted_students"

