#!/bin/bash

WORKDIR=$1

while true; do
	subject=$(dialog --menu "Выберите предмет" 15 80 2 \
		"Пивоварение" 1 \
		"Уфология" 2 3>&1 1>&2 2>&3)

	if [[ $? -ne 0 ]]; then exit 0; fi

	SUBJECT_DIR="$WORKDIR/$subject"

	if [[ ! -d "$SUBJECT_DIR" ]]; then
		dialog --msgbox "Ошибка: Директория $SUBJECT_DIR не существует!" 10 40
		continue
	fi
	
	result=$(./back/find_perfect_tests.sh "$WORKDIR" "$subject")

	dialog --msgbox "$result" 20 80
done
