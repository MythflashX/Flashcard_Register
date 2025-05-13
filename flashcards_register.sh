#!/bin/bash

clear
echo -e "\033[0;32m"
echo "______________________"
echo "  FLASHCARD REGISTER  "
echo "______________________"
echo "                 @Mytx"

echo ""
echo " - op[T]ions -"

# Configuration
dir="/home/mytx/onyx_saves/flashcards";
cards=("java" "python" "c++" "crafting_interpreters" "capture_the_flag")
keys=("j" "p" "cpp" "craft" "ctf")

# Option Menu
echo ""
echo "s:show | q:quit | r ?:remove a line | vim: edit with text editor"
echo "search ?:search words | nocase ?:search words (case insensitive)"
echo "search_all ?:search words on every cards"
echo "sort:sorted view | sync: update the cards on github"
echo "help: peek instructions"
echo ""
echo ""

echo " - ca[R]ds - "
echo ""
size=${#cards[@]}
for ((i=0; i<size; i++))
do
  echo -n ${keys[i]}':['${cards[i]}"] "
  if (( i % 2 != 0)); then
    echo ""
  fi
done
echo ""
echo ""

echo -n "OwO ~ "  # I couldn't think of anything more cringier than this
read option

# Select Card File
for ((i=0; i<size; i++))
do
  if [ "$option" == "${keys[i]}" ]; then
    selected_card="${cards[i]}";
    echo "Selected Card: [ "$selected_card" ]"
    break
  fi
  if [ $i -eq $((size - 1)) ]; then
    echo "Invalid Card!"
    exit
  fi
done


# Process Flashcard
while [ true ]; do
  echo -n "OwO ~ "  # I couldn't think of anything more cringier than this
  read prompt arg

  if [ "$prompt" == "q" ]; then
    exit
  elif [ "$prompt" == "help" ]; then
    echo "Available commands:"
    echo "  s  : Show the flashcard contents"
    echo "  q  : Quit the program"
    echo "  r ?: Remove a line by providing a line number"
    echo "  vim  : Edit the card with text editor"
    echo "  clr  : Clear terminal screen"
    echo "  sort : View the flashcards in sorted order Or Sort it"
    echo "  search ?: Search for a word in the flashcard"
    echo "  nocase ?: Search for a word in the flashcard (Case Insensitive)"
    echo "  search_all ?: Search for a word in every flashcards"
    echo "  Once card is selected, Just Enter Topics to register"
  elif [ "$prompt" == "sync" ]; then
    echo "Working On It!"
  elif [ "$prompt" == "clr" ]; then
    clear
  elif [ "$prompt" == "s" ]; then
    bat "$dir"/"${selected_card}.txt"     # I know i said no dependency but please install bat or else you can use cat..but bat is objectively better
    #cat $dir/"${selected_card}.txt"    # use this line if u don't like or have bat
  elif [ "$prompt" == "vim" ]; then
    vim "$dir"/"${selected_card}.txt"     # I know i said no dependency but please install bat or else you can use cat..but bat is objectively better
  elif [ "$prompt" == "r" ]; then
    if [ -n "$arg" ]; then
      sed -i "${arg}d" "$dir"/"${selected_card}.txt"
    else
      echo "Please provide a line to delete [r line_number]"
    fi
  elif [ "$prompt" == "sort" ]; then
    sort "$dir"/"${selected_card}.txt"
    echo ""
    echo "Are you sure about sorting the entries? (Y/n)"
    read prompt
    if [ "$prompt" == "Y" ]; then
      sort "$dir"/"${selected_card}.txt" -o "$dir"/"${selected_card}.txt"
    fi
  elif [ "$prompt" == "search" ]; then
    if [ -n "$arg" ]; then
      grep "$arg" "$dir"/"${selected_card}.txt"
    else
      echo "Please provide a search term! [search term]"
    fi
  elif [ "$prompt" == "nocase" ]; then
    if [ -n "$arg" ]; then
      cat "$dir"/"${selected_card}.txt" | tr 'A-Z' 'a-z' | grep "$(echo "$arg" | tr 'A-Z' 'a-z')"
    else
      echo "Please provide a search term! [nocase term]"
    fi
  elif [ "$prompt" == "search_all" ]; then
    if [ -n "$arg" ]; then
      cat "$dir"/*.txt | tr 'A-Z' 'a-z' | grep "$(echo "$arg" | tr 'A-Z' 'a-z')"
    else
      echo "Please provide a search term! [search_all term]"
    fi
  else
    echo -n "$prompt" >> $dir/"${selected_card}.txt"
    echo " $arg" >> $dir/"${selected_card}.txt"
  fi
done

echo ""
echo ""
