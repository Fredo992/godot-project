Questo è un gioco sviluppato in godot scritto in gdscript, l'obiettivo è un  rogue like, stile slay the spire, dove la mappa viene generata casualmente ad ogni partita, riempita di nodi cliccabili, il giocatore dovrà arrivare in cima alla mappa passando dal nodo attuale al nodo consecutivo, vincendo battaglie stile jrpg tattico, con l'esercitò che formerà man mano che il gioco prosegue in base alle sue scelte.
- Il gioco carica le risorse tramite L'asset loader, utilizza la ricorsione per iterare su tutte le cartelle del gioco e ne cataloga il percorso in una mappa dove la chiave è il nome della cartella
- gli oggetti della mappa generati ereditano la logica da un padre ed ognuno dei figli implementa il proprio menù tramite una mappa dove la chiave è l'azione e il valore è una funzione
  - il menù è istanziato al momento del click, farà parte di una cache in modo da poterne alloccare 1 solo in memoria e si riempe di bottoni in base al numero di elementi della mappa
- le statistiche sono un oggetto che ha al suo interno il valore base, il valore finale, una collection di modificatori, un segnale che viene lanciato ad ogni modifica
  - il valore base è il valore di partenza della statistica, per esempio forza = 10
  - la collection di modificatori saranno i potenziamenti e depotenziamenti del gioco, e sono divisi tra moltiplicatori e flat, per esempio +5 forza flat
  - il valore finale è il valore base ricalcolato in base ai vari modificatori della statistica, per esempio forza base 10 + 5 potenziamento flat = 15 valore finale
  - il segnale viene lanciato e tutti i subscribers di forza che dipendono dal valore di forza si aggiornano, fornendo tramite segnale il nuovo valore, per esempio, sollevare è uguale a forza * 2, il segnale manda il nuovo      valore 15, così da poter aggiornare il valore di sollevare che alla sua nascita ha sottoscritto al segnale di forza
- le abilità del gioco sono un oggetto che contiene una funzione generica che ha 3 argomenti, il tipo, il valore numerico, i bersagli colpiti
  - il tipo è un enum, definisce il tipo di bersagliamento dell'abilità, SINGLE, MULTI, GLOBAL
  - il valore numerico è di default 0
  - i bersagli colpiti sono una collection di Abstract Entity, il padre di tutte le entità del gioco
  quando un abilità viene implementata, va assegnata alla sua variabile effetto una funzione che comprende questi 3 argomenti, in modo da poter definire un abilità scrivendo una lambda expression di questo genere:
  (SINGLE, 0, ArrayDiBersagli) => ArrayDiBersagli[0].modificatoriForza.append(FLAT, -10); abilità che prende un bersaglio solo e aggiunge ai suoi modificatori della stat forza -10, un effetto negativo

ancora in sviluppo
