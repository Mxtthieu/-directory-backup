#!/bin/bash

cpt=0 # compteur de fichiers vus
cpts=0 # compteur de fichiers save
if [[ "$1" == "-h" ]]  # Option -h

then

save=$2                # Repertoire cible
rep=$save/."$save"_SAVE  # Sauvegarde cachee

else

  if [[ "$1" == "-b" ]]  # Option -b

  then

  save=$2               # Repertoire cible
  rep=$save/"$save"_SAVE  # Sauvegarde brute

  else # Aucune option

  save=$1               # Repertoire cible
  rep=$save/"$save"_SAVE  # Sauvegarde brute

  fi

fi

if [[ -e $rep ]]  # Si le repertoire sauvegarde existe
then 
  if [[ "$1" == "-b" ]] # Option -b supprime le dossier save pour le recreer
  then
    `rm -Rf $rep`
    `mkdir $rep`
  fi
else
  `mkdir $rep`
fi
  
for fichier in $save/*  # On parcourt tous les fichiers du repertoire entre en argument 
do
  
  if [[ -f "$fichier" ]] # Si le fichier est un fichier regulier 
  
  then 
  
    let cpt++ # + 1 fichier vu
    if [[ !( -e "$rep/$fichier" ) ]]  # Si le fichier n'existe pas dans le repertoire de sauvegarde
  
    then 
    
      taille="$(du $fichier |awk '{print $1}')" # taille en octect de $fichier
      # Pour remplir un fichier arbitrairement grand pour tester : 
      # dd if=/dev/zero of=/DossierTest/NomFichierTest bs=1KB count=100000
      if [[ "$taille" -ge "1024" ]] # Test si taille > 1 Mo
        then
	  echo "Le fichier $fichier fait plus d'1 Mo, validez vous la sauvegarde? (y/n)"
          read var
          if [[ "$var" == "y" ]]
          then 
            let cpts++ # + 1 fichier save
            `cp -p $fichier $rep` # On le copie
          else
	    echo "Fichier ignoré"
          fi
      else 
        let cpts++ # + 1 fichier save
        `cp -p $fichier $rep` # On le copie
      fi
    else
    
      if [[ `date -r $fichier` > `date -r $rep/$fichier` ]] # Si le fichier est plus recent que sa sauvegarde
      
      then
      
        let cpts++ # + 1 fichier save
	`cp -p $fichier $rep` #On le copie le nouveau fichier 
       	
      fi

    fi

  fi
  
done

echo "  $cpts fichiers ont ete sauvegardes"
echo "  $cpt fichiers ont ete vus"
