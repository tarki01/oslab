#!/bin/bash

# Показ посещаемости по предмету Пивоварение
function show_Pivo_attend {
        Pivo=~/oslab/labfiles/Пивоварение/A-06-21-attendance

	Res=$(grep . "$Pivo" | while read -r line; do
		name=$(echo "$line" | cut -d ' ' -f 1)
		attendance=$(echo "$line" | cut -d ' ' -f 2-)
		count=$(echo "$attendance" | tr -cd '+' | wc -c)
		echo "$count $name $attendance"
	done | sort -nr | cut -d ' ' -f 2-)

	dialog --title "Посещаемость по Пивоварению" --msgbox "$Res" 15 60
}

# Показ посещаемости по предмету Уфология
function show_Ufo_attend {
        Ufo=~/oslab/labfiles/Уфология/A-06-21-attendance

	Res=$(grep . "$Ufo" | while read -r line; do
		name=$(echo "$line" | cut -d ' ' -f 1)
		attendance=$(echo "$line" | cut -d ' ' -f 2-)
		count=$(echo "$attendance" | tr -cd '+' | wc -c)
		echo "$count $name $attendance"
	done | sort -nr | cut -d ' ' -f 2-)

	dialog --title "Посещаемость по Уфологии" --msgbox "$Res" 15 60
}

# Показ студентов с самым длинным и коротким именем
function show_max_min {
	MaxMin=~/oslab/labfiles/Уфология/tests/TEST-4
	
	Res1=$(while read -r line; do
		name=$(echo "$line" | cut -d ',' -f 2)
		echo "${#name} $name"
	done < <(grep . "$MaxMin") |  sort -nr | head -n 1 | cut -d ' ' -f 2)

	Res2=$(while read -r line; do
		name=$(echo "$line" | cut -d ',' -f 2)
		echo "${#name} $name"
	done < <(grep . "$MaxMin") |  sort -n | head -n 1 | cut -d ' ' -f 2)
	
	dialog --title "Самое длинное и короткое имя" --msgbox "Самое длинное имя : $Res1\nСамое короткое имя : $Res2" 15 60
}

# Меню выбора предмета для показа посещаемости
function subject_menu {
	while true; do
		dialog --title "Выбор предмета" \
		       --yes-label "Пивоварение" \
		       --no-label "Уфология" \
		       --yesno "Выберите предмет:" 20 80
	        next_response=$?
		
		if [ $next_response -eq 0 ]; then
			show_Pivo_attend
		else
			show_Ufo_attend
		fi

		dialog --title "Вернуться к выбору предмета" \
		       --yes-label "Да, я хочу выбрать другой предмет" \
		       --no-label "Нет" \
		       --yesno "Хотите выбрать другой предмет?" 20 80

       		if [ $? -ne 0 ]; then
      			clear
 			break;
		fi
	done
}

# Меню выбора предмета для показа посещаемости
function main_menu {
	while true; do
		dialog --title "Выбор действия" \
		       --yes-label "Показать посещаемость" \
		       --no-label "Самое длинное и короткое имя" \
		       --yesno "Выберите действие:" 20 80
	        response=$?
		
		if [ $response -eq 0 ]; then
			subject_menu
		else
			show_max_min	
		fi

		dialog --title "Вернуться в главное меню" \
		       --yes-label "Да, я хочу вернуться в главное меню" \
		       --no-label "Нет" \
		       --yesno "Хотите выбрать другое действие?" 20 80
       		if [ $? -ne 0 ]; then
      			clear
 			exit 0
		fi
	done
}

main_menu
