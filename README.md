Questo è un gioco sviluppato in godot scritto prevalentemente in gdscript, l'obiettivo è un gioco rogue like, stile slay the spire, dove la mappa viene generata casualmente ad ogni partita, riempiendola di nodi che hanno funzionalità proprie in base al tipo di nodo

- Il gioco carica le risorse tramite L'asset loader, utilizza la ricorsione per iterare su tutte le cartelle del gioco e ne cataloga il percorso in un dictionary[nome cartella, dictionary[nome file, percorso file]]
- il gioco genera degli oggetti della mappa, che ereditano la logica da un padre ma ognuno dei figli implementa il proprio menù tramite un dictionary[String, Funzione]
  - il menù è istanziato al momento del click, farà parte di una cache in modo da poterne alloccare 1 solo in memoria ed è dinamico, si riempe di bottoni in base al numero di record del dictionary
