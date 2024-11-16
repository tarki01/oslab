#!/bin/bash

workdir=$1
subject=$2
alpha_group_year=$3

alpha=$(echo "$alpha_group_year" | cut -d '-' -f 1)
group=$(echo "$alpha_group_year" | cut -d '-' -f 2)
year=$(echo "$alpha_group_year" | cut -d '-' -f 3)

attendance_file="$workdir/$subject/$alpha-$group-$year-attendance"

if [[ ! -f "$attendance_file" ]]; then
	    echo "Ошибка: Группа $alpha-$group-$year не найдена."
	        exit 1
fi

names=$(awk '{print $1}' "$attendance_file")

shortest_name=$(echo "$names" | awk '{print length, $0}' | sort -n | head -1 | cut -d ' ' -f2)
longest_name=$(echo "$names" | awk '{print length, $0}' | sort -n | tail -1 | cut -d ' ' -f2)

echo "Для группы $alpha-$group-$year:"
echo "Студент с самой короткой ФИО: $shortest_name"
echo "Студент с самой длинной ФИО: $longest_name"

