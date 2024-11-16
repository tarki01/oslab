#!/bin/bash

workdir=$1
subject=$2

if [[ -z "$workdir" || -z "$subject" ]]; then
	echo "Ошибка: Не переданы необходимые параметры."
	exit 1
fi

test_dir="$workdir/$subject/tests"
if [[ ! -d "$test_dir" ]]; then
	echo "Ошибка: Директория тестов $test_dir не найдена."
	exit 1
fi

students=$(awk -F',' '{print $2}' "$test_dir"/TEST-* | sort | uniq)

perfect_students=()
for student in $students; do
	count=$(grep -h -F "$student" "$test_dir"/TEST-* | wc -l)
	if [[ $count -eq 4 ]]; then
		perfect_students+=("$student")
	fi
done

if [[ ${#perfect_students[@]} -eq 0 ]]; then
	echo "Нет студентов, сдавших все тесты с первой попытки."
else
	echo "Студенты, сдавшие все тесты с первой попытки:"
	for student in "${perfect_students[@]}"; do
		echo "$student"
	done
fi
