#!/bin/bash

workdir=$1
subject=$2

subject_dir="$workdir/$subject"

if [[ ! -d "$subject_dir" ]]; then
	echo "Ошибка: Предмет $subject не найден."
	exit 1
fi

shortest_name=""
longest_name=""
shortest_length=99999
longest_length=0

for attendance_file in "$subject_dir"/A-*-*-attendance; do
	if [[ -f "$attendance_file" ]]; then
		names=$(awk '{print $1}' "$attendance_file")

		for name in $names; do
			name_length=$(echo -n "$name" | wc -m)
			if ((name_length < shortest_length)); then
				shortest_length=$name_length
				shortest_name=$name
			fi
			if ((name_length > longest_length)); then
				longest_length=$name_length
				longest_name=$name
			fi
		done
	fi
done

echo "Среди всех групп:"
echo "Студент с самой короткой ФИО: $shortest_name"
echo "Студент с самой длинной ФИО: $longest_name"
