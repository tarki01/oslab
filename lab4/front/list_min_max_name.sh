#!/bin/bash

WORKDIR=$1

while true; do
	option=$(dialog --menu "Выберите действие" 15 80 2 \
		1 "Поиск по отдельной группе" \
		2 "Поиск среди всех групп" 3>&1 1>&2 2>&3)

	if [[ $? -ne 0 ]]; then exit 0; fi

	if [[ $option -eq 1 ]]; then
		input=$(dialog --inputbox "Введите префикс группы (A или Ae), номер группы и год через дефис (например, Ae-09-21):" 10 50 3>&1 1>&2 2>&3)
		if [[ $? -ne 0 ]]; then exit 0; fi

		alpha=$(echo "$input" | cut -d '-' -f 1)
		group=$(echo "$input" | cut -d '-' -f 2)
		year=$(echo "$input" | cut -d '-' -f 3)

		if [[ -z "$alpha" || -z "$group" || -z "$year" ]]; then
			dialog --msgbox "Ошибка: Неверный формат ввода. Попробуйте снова." 10 40
			continue
		fi

		alpha_group_year="$alpha-$group-$year"

		result=$(./back/find_min_max_name_for_group.sh "$WORKDIR" "Уфология" "$alpha_group_year")
	else
		result=$(./back/find_min_max_name_for_all_groups.sh "$WORKDIR" "Пивоварение")
	fi

	dialog --msgbox "$result" 20 80
done
