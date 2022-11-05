#!/bin/bash

#Colours
green="\e[0;32m\033[1m"
end="\033[0m\e[0m"
red="\e[0;31m\033[1m"
blue="\e[0;34m\033[1m"
yellow="\e[0;33m\033[1m"
purple="\e[0;35m\033[1m"
turquoise="\e[0;36m\033[1m"
gray="\e[0;37m\033[1m"

function ctrl_c(){

  echo -e "\n${red}[!] Saliendo ...${end}"
  exit 1
}

trap ctrl_c INT

function helpPanel(){

  echo -e "\n${yellow}[i] ${end}${gray}Uso:${end}"
  echo -e "\t${purple}-f ${end}${gray} Indicar número de juegos${end}"
}

function rock_paper_scissors(){

  jugadas=$1
  juego_perdido=0
  puntos=0
  declare -a game_objects=("piedra" "papel" "tijera")
  
  echo -e "\n${yellow}[!] ${end}${gray}Opciones disponibles: ${end}${yellow}piedra${end}, ${purple}papel${end}, ${blue}tijera${end}"

  for jugada in $(seq 1 $jugadas); do

    random_number=$(($RANDOM % 3))
    random_object=${game_objects[$random_number]}

    echo -ne "\n${purple}[$jugada/$jugadas] ${end}${gray}Introduce tu jugada: ${end}" && read object

    if [ "$object" == "piedra" ]; then
      
      echo -e "\n${yellow}[+] ${end}${gray}Ha salido ${purple}$random_object${end}"
      if [ "$random_object" == "tijera" ]; then
   
        echo -e "${green}[✔] ¡Gánas!${end}"
        let puntos+=1
  
        echo -e "\n${yellow}[+] ${end}${blue}Puntos totales: $puntos${end}"
      elif [ "$random_object" == "$object" ]; then

        echo -e "${yellow}[-] ${end}${gray}¡Empate!${end}"
      else

        let juego_perdido+=1
        echo -e "${red}[✖] ¡Pierdes!${end}"
      fi
    elif [ "$object" == "papel" ]; then
      
      echo -e "\n${yellow}[+] ${end}${gray}Ha salido ${purple}$random_object${end}"
      if [ "$random_object" == "piedra" ]; then
   
        echo -e "${green}[✔] ¡Gánas!${end}"
        let puntos+=1
  
        echo -e "\n${yellow}[+] ${end}${blue}Puntos totales: $puntos${end}"
      elif [ "$random_object" == "$object" ]; then

        echo -e "${yellow}[-] ${end}${gray}¡Empate!${end}"
      else

        let juego_perdido+=1
        echo -e "${red}[✖] ¡Pierdes!${end}"
      fi
    elif [ "$object" == "tijera" ]; then
  
      echo -e "\n${yellow}[+] ${end}${gray}Ha salido ${purple}$random_object${end}"
      if [ "$random_object" == "papel" ]; then
   
        echo -e "${green}[✔] ¡Gánas!${end}"
        let puntos+=1
  
        echo -e "\n${yellow}[+] ${end}${blue}Puntos totales: $puntos${end}"
      elif [ "$random_object" == "$object" ]; then

        echo -e "${yellow}[-] ${end}${gray}¡Empate!${end}"
      else

        let juego_perdido+=1
        echo -e "${red}[✖] ¡Pierdes!${end}"
      fi
    else
      
      let juego_perdido+=1
      echo -e "\n${red}[!] Introduce un objecto valido. ¡Perdiste un juego!${end}"
      echo -e "${red}[!] Opciones disponibles: ${end}${yellow}piedra${end}, ${purple}papel${end}, ${blue}tijera${end}"
    fi
  done
  
  echo -e "\n${yellow}[+] ${end}${gray}${purple}$jugadas${end}${gray} jugadas terminadas${end}"
  echo -e "${yellow}[+] ${end}${purple}$juego_perdido ${end}${gray}juegos perdidos"
  echo -e "${yellow}[+] ${end}${blue}Puntos totales: $puntos${end}"

  echo -e "\n${green}[+] ¡Gracias por jugar!${end}"
}
  
declare -i parameter_counter=0

while getopts "j:" arg; do
  case $arg in
    
    j) jugadas="$OPTARG"; let parameter_counter+=1;;
  esac
done

if [ $parameter_counter == 0 ]; then

  helpPanel
elif [ $parameter_counter == 1 ]; then
  
  rock_paper_scissors "$jugadas"
else

  helpPanel
fi
