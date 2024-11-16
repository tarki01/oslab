#!/bin/bash

MENU_HEIGHT=15
MENU_WIDTH=80

WORKDIR_FILE="./workdir.txt"
if [[ ! -f "$WORKDIR_FILE" || "$1" == "-reset" ]]; then
	workdir=$(dialog --title "Укажите директорию" --dselect "$HOME/" "$MENU_HEIGHT" "$MENU_WIDTH" 3>&1 1>&2 2>&3)
	echo "$workdir" >"$WORKDIR_FILE"
else
	workdir=$(cat "$WORKDIR_FILE")
fi

while true; do
	choice=$(dialog --menu "Главное меню" $MENU_HEIGHT $MENU_WIDTH 4 \
		1 "Вывести занятие с минимальной посещаемостью" \
		2 "Вывести студентов, сдавших тесты с первой попытки" \
		3 "Вывести список группы, упорядоченный по посещаемости" \
		4 "Вывести студентов с максимальной и минимальной длиной ФИО" 3>&1 1>&2 2>&3)

	if [[ $? -ne 0 ]]; then
		clear
		echo "Работа завершена."
		exit 0
	fi

	case $choice in
	1) ./front/list_min_attendance.sh "$workdir" ;;
	2) ./front/list_perfect_tests.sh "$workdir" ;;
	3) ./front/list_sorted_group.sh "$workdir" ;;
	4) ./front/list_min_max_name.sh "$workdir" ;;
	esac
done
