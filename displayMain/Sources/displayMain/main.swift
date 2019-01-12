import Foundation
import FinalType

// Programme principal
var p : TPartie = TPartie()// init : Demarrer la partie

while !(p.partieFini()) {
    // affiche l'etat du jeu
    print("tour du joueur \(p.joueurActif())")
    var str : String = ""
    for i in 0...3 {
        for j in 0...2 {
            if let t = p.pieceAPosition(pos : [i,j]){
                str += t.typePiece()
            }else{
                str += " CASE VIDE "
            }
        }
        print(str)
        str=""
    }
    var str2 : String = ""
    for piece in p.tableau{ // utilise iterateur normal sur toutes les pieces
        if piece.estDansReserve(){
            if piece.proprietairePiece()==1{
                str+=piece.typePiece()
            }else{
                str2+=piece.typePiece()
            }
        }
    }
    print("Reserve J1 \n"+str+"\n Reserve J2 \n"+str2)

    // Choix de l'action du joueur

    var repV : Bool  = false
    var pChoisie : TPiece?
    var posChoisie : [Int]?


    while !repV {

        print("Joueur \(p.joueurActif()), choisis si tu (p)arachute ou (d)eplace une piece")

        if let entree = readLine(){
            if entree == "p"{
                //parachuter

                print("Choisis la piece a parachuter")

                // on parcourt les pieces de la reserve de JActif
                var it : TPieceJIT = p.pieceJIT(joueur : p.joueurActif())

                while let piece=it.next(){
                    while !repV{
                        if piece.estDansReserve(){
                            // Choix de la piece ou pas
                            print("Choisis un \(piece.typePiece()) ? y/n")
                            if let entree = readLine(){
                                if entree == "y"{// s'il choisi cette piece
                                    print("Choisis la ligne a parachuter")
                                    if let entree = readLine(){
                                        if let posLigne = Int(entree){
                                            print("Choisis la colonne a parachuter")

                                            if let entree = readLine(){
                                                if let posCol = Int(entree){
                                                    if piece.estParachutagePossible(partie : p, position : [posLigne,posCol]){
                                                        pChoisie = piece
                                                        posChoisie = [posLigne, posCol]
                                                        repV = true
                                                    }
                                                    else {
                                                        print("Il n'est pas possible de parachuter a cet endroit")
                                                    }
                                                }
                                                else{
                                                    print("Il fallait ecrire un entier!")
                                                }
                                            }

                                        }
                                        else{
                                            print("Il fallait ecrire un entier!")
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            } else if entree == "d" { // deplacer

                print("Choisis la piece a deplacer")

                // on parcourt les pieces de la reserve de JActif
                var it : TPieceJIT = p.pieceJIT(joueur : p.joueurActif())
                while let piece = it.next(){ // RAJOUTE : si on a rien deplacé on redemande au joueur ce qu'il veut faire
                    if repV{ // RAJOUTE : si on a deja deplacé une piece on ne doit plus pouvoir déplacer les autres
                        while let piece = it.next(){}
                    }
                    else{
                        var yorn : Bool = false
                        while !yorn{ 
                            if let pos = piece.positionPiece(){
                                // Choix de la piece ou pas
                                print("Deplacer le \(piece.typePiece()) placee a \(pos) ? y/n")
                                if let entree = readLine(){
                                    if entree == "y"{// s'il choisi cette piece
                                        print("Choisis la ligne d'arrivee du deplacement")
                                        if let entree = readLine(){
                                            if let posLigne = Int(entree){
                                                print("Choisis la colonne d'arrivee du deplacement")
                                                if let entree = readLine(){
                                                    if let posCol = Int(entree){
                                                        if piece.estPossibleMouvement(partie : p, position : [posLigne,posCol]){
                                                            pChoisie = piece
                                                            posChoisie = [posLigne, posCol]
                                                            yorn = true
                                                            repV = true
                                                            while let piece = it.next(){}
                                                        }
                                                        else {
                                                            print("Il n'est pas possible de deplacer cette piece a cet endroit")
                                                        }
                                                    }
                                                    else{
                                                        print("Il fallait ecrire un entier!")
                                                    }
                                                }
                                            }
                                            else{
                                                print("Il fallait ecrire un entier!")
                                            }
                                        }
                                    }
                                    else {
                                        yorn = true 
                                    }
                                }
                            }
                        }
                    }
                
                }
            } else {
                print("ecrit p pour parachuter ou d pour deplacer une piece du plateau")
            }
        } else { // si pas de readLine
            print("Ecrit quelque chose !")
        }
    } // si on arrive ici (on sort du while), pChoisie et posChoisie ont une valeur


    // Action principale du tour
    if var pChoisie = pChoisie{
        if let posChoisie = posChoisie{

            if !pChoisie.estDansReserve(){// si c'est un deplacement
                do {
                    try p = pChoisie.deplacerPiece(partie : &p, nouvellePos : posChoisie)}// on considere la capture comme un deplacement (on peut gagner la partie ici)
                catch {
                }
            }else{// si c'est un parachutage
                do {
                    try p = pChoisie.parachuter(partie : p, position : posChoisie)}
                catch{
                }
            }
        }
    }

    if p.partieFini(){

        print("Le joueur \(p.joueurActif()) gagne la partie")

    }


    p.changerTour() // change le joueur actif


    //Le joueur gagne si son roi est dans la derniere ligne au debut de son tour (s'il met son roi dans la derniere ligne et ne se fais pas manger)
    var it : TPieceJIT = p.pieceJIT(joueur : p.joueurActif())
    while let piece=it.next(){

        if let pos = piece.positionPiece(){

            if piece.typePiece() == "Kuropokkuru"{

                if pos[0] == p.derniereLigne(joueur : p.joueurActif()){
                    p.gagner(joueur : p.joueurActif())
                }
            }
        }
    }


    if p.partieFini(){

        print("Le joueur \(p.joueurActif()) gagne la partie")

    }

    // c'est mis a la fin du while pour ne pas refaire un tour en trop
}
