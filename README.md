Questo è un gioco sviluppato in godot scritto prevalentemente in gdscript, l'obiettivo è un gioco rogue like, stile slay the spire, dove la mappa viene generata casualmente ad ogni partita, riempiendola di nodi che hanno funzionalità proprie in base al tipo di nodo

- Il gioco carica le risorse tramite L'asset loader presente nel branch manifestbuilder ( nome da cambiare, l'idea iniziale era catalogare i percorsi delle risorse in un json )
- il gioco genera degli oggetti della mappa, che ereditano la logica da un padre ma ognuno dei figli implementa il proprio menù tramite un dictionary[String, Funzione]
