#!/bin/bash

workdir=$1
alpha=$2
group=$3
year=$4

attendance_brewing="$workdir/Пивоварение/$alpha-$group-$year-attendance"
attendance_ufology="$workdir/Уфология/$alpha-$group-$year-attendance"

if [[ ! -f "$attendance_brewing" && ! -f "$attendance_ufology" ]]; then
	echo "Ошибка: Группа $alpha-$group-$year не найдена в обоих предметах."
	exit 1
fi

calculate_percentage() {
	total_classes=$(awk '{print length($2)}' "$1" | awk '{s+=$1} END {print s}')
	total_attendance=$(awk '{s+=gsub(/\+/, "&")} END {print s}' "$1")
	if ((total_classes > 0)); then
		echo "$((100 * total_attendance / total_classes))"
	else
		echo "0"
	fi
}

if [[ -f "$attendance_brewing" ]]; then
	brewing_percentage=$(calculate_percentage "$attendance_brewing")
else
	brewing_percentage=0
fi

if [[ -f "$attendance_ufology" ]]; then
	ufology_percentage=$(calculate_percentage "$attendance_ufology")
else
	ufology_percentage=0
fi

if ((brewing_percentage < ufology_percentage)); then
	result="Минимальная посещаемость для группы $alpha-$group-$year: Пивоварение ($brewing_percentage%)"
elif ((ufology_percentage < brewing_percentage)); then
	result="Минимальная посещаемость для группы $alpha-$group-$year: Уфология ($ufology_percentage%)"
else
	result="Посещаемость для группы $alpha-$group-$year равна: Пивоварение ($brewing_percentage%) и Уфология ($ufology_percentage%)"
fi

echo "$result"
