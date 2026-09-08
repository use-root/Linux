#!/usr/bin/bash

catalog_dir=("Web" "Scripts" "Images" "Documents")
current_dir=$(pwd)
current_dir_files=($(ls | awk -F'.' '{print $2}' | uniq -u))

add_personal_dirs() {
	echo -e "\n[+] Enter the name of your dirs that you want to create: "
	read directories
	if [ -z "$directories" ]; then
		echo -e "The string is empty :("
		exit 1
	fi
	catalog_dir+=("$directories")
	echo -e "\n ${catalog_dir[@]}"
}

ask_personal_dirs() {
	echo -e "\n[+] Look, This are the directories for default"
	echo -e "[->] ${catalog_dir[@]}"
	echo -e "[+] Tell me what directories you need"
	echo -e "\n[+] Are you want to add your personal dirs here ? (Y/N): "
	read option
	if [ -z $option ]; then
		echo -e "\n[!] Estas de broma?, chao"
		exit 127
	fi

	if [ $option == "yes" ]; then
		add_personal_dirs
	else
		exit 1
	fi

}

# Web: js, html, css
# Imagese: png, jpg, ...
# Documents: pdf , word....

count_of_each_file() {
	declare -A directories

	for ext in ${current_dir_files[*]}; do
		if [ $ext == "js" ] || [ $ext == "html" ] || [ $ext == "css" ]; then
			if [ ! -d "./Web/" ]; then
				$(mkdir Web)
			fi
			$(mv {*.js,*.html,*.css} ./Web/ 2>/dev/null)
		fi
		if [ $ext == "jpg" ] || [ $ext == "png" ] || [ $ext == "jpeg" ]; then
			if [ ! -d "./Images/" ]; then
				$(mkdir Images)
			fi
			$(mv {*.jpg,*.png,*.jpeg} ./Images/ 2>/dev/null)
		fi

		if [ $ext == "pdf" ] || [ $ext == "word" ] || [ $ext == "xlsx" ]; then
			if [ ! -d "./Documents/" ]; then
				$(mkdir Documents)
			fi
			$(mv {*.pdf,*.xlsx,*.word} ./Documents/ 2>/dev/null)
		fi
	done
}

main() {
	#ask_personal_dirs
	count_of_each_file
}

main
