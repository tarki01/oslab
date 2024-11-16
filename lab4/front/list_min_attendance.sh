#!/bin/bash

workdir=$1

subject=$(dialog --menu "Выберите предмет" 15 50 2 \
	"Пивоварение" "1" \
	"Уфология" "2" 3>&1 1>&2 2>&3)

if [[ $? -ne 0 ]]; then
	exit 0
fi

input=$(dialog --title "Введите группу и год" \
	--form "Введите префикс группы (A или Ae), номер группы и год начала обучения (например: Ae-09-21):" \
	20 80 3 \
	"Префикс:" 1 1 "" 1 10 10 0 \
	"Группа:" 2 1 "" 2 10 10 0 \
	"Год:" 3 1 "" 3 10 10 0 3>&1 1>&2 2>&3)

if [[ $? -ne 0 ]]; then
	exit 0
fi

alpha=$(echo "$input" | sed -n 1p)
group=$(echo "$input" | sed -n 2p)
year=$(echo "$input" | sed -n 3p)

if [[ -z "$alpha" || -z "$group" || -z "$year" ]]; then
	dialog --msgbox "Ошибка: Префикс, группа или год не введены." 10 40
	exit 1
fi

result=$(./back/find_min_attendance.sh "$workdir" "$alpha" "$group" "$year")

if [[ $? -ne 0 ]]; then
	dialog --msgbox "$result" 20 80
	exit 1
fi

dialog --title "Результат" --msgbox "$result" 20 80
