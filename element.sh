#!/bin/bash

# element bash script

PSQL="psql -X --username=freecodecamp --dbname=periodic_table --tuples-only -c"

ARGUMENT=$1

if [[ -z $1 ]]
then
  echo "Please provide an element as an argument."
else

  #Check if input is a number
  if [[ ! $ARGUMENT =~ ^[0-9]+$  ]]
  then
    # Check if length is greater than two letters
    LEN=$(echo -n "$ARGUMENT" | wc -m)
    if [[ $LEN -gt 2 ]]
    then
      # get element info
      ELEMENT=$($PSQL "select * from elements inner join properties using(atomic_number) inner join types using(type_id) where name='$ARGUMENT'")
      # if element doesn't exist
      if [[ -z $ELEMENT ]]
      then
        echo "I could not find that element in the database."
      else
        echo "$ELEMENT" | while read BAR BAR NUM BAR SYM BAR NAME BAR MASS BAR MELT BAR BOIL BAR TYPE
        do
          echo "The element with atomic number $NUM is $NAME ($SYM). It's a $TYPE, with a mass of $MASS amu. $NAME has a melting point of $MELT celsius and a boiling point of $BOIL celsius."
        done
      fi
    else
      # get element info by atomic symbol
      ELEMENT=$($PSQL "select * from elements inner join properties using(atomic_number) inner join types using(type_id) where symbol='$ARGUMENT'")
      # if element doesn't exist
      if [[ -z $ELEMENT ]]
      then
        echo "I could not find that element in the database."
      else
        echo "$ELEMENT" | while read BAR BAR NUM BAR SYM BAR NAME BAR MASS BAR MELT BAR BOIL BAR TYPE
        do
          echo "The element with atomic number $NUM is $NAME ($SYM). It's a $TYPE, with a mass of $MASS amu. $NAME has a melting point of $MELT celsius and a boiling point of $BOIL celsius."
        done
      fi
    fi
  else
    # get element info by atomic number
    ELEMENT=$($PSQL "select * from elements inner join properties using(atomic_number) inner join types using(type_id) where atomic_number='$ARGUMENT'")
    # if element doesn't exist
    if [[ -z $ELEMENT ]]
    then
      echo "I could not find that element in the database."
    else
      echo "$ELEMENT" | while read BAR BAR NUM BAR SYM BAR NAME BAR MASS BAR MELT BAR BOIL BAR TYPE
      do
        echo "The element with atomic number $NUM is $NAME ($SYM). It's a $TYPE, with a mass of $MASS amu. $NAME has a melting point of $MELT celsius and a boiling point of $BOIL celsius."
      done
    fi
  fi

fi
