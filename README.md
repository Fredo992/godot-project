Questo è un gioco sviluppato in godot scritto prevalentemente in gdscript, l'obiettivo è un gioco rogue like, stile slay the spire, dove la mappa viene generata casualmente ad ogni partita, riempiendola di nodi che hanno funzionalità proprie in base al tipo di nodo

Il gioco carica le risorse tramite L'asset loader presente nel branch manifestbuilder ( nome da cambiare, l'idea iniziale era catalogare i percorsi delle risorse in un json )
il gioco ha una gestione centralizzata dell'input tramite l'input manager, intercetta l'evento che lancia godot per poter implementare una logica centralizzata e poter gestire tutti i subscriber da 1 sola classe
il gioco usa l'ereditarietà per gestire le funzionalità delle singole entità
