func testInitPartieEtIteratorGlobal(){
    
    var p : Partie = Partie()
    var cmtp : Int = 0
    for piece in p{
        if let pos = piece.positon(){
            print("la piece \(piece.typePiece()) de Joueur \(piece.proprietaire()) est placée en \(pos)")
            cmtp += 1
        } else {
            print("la piece \(piece.typePiece()) de Joueur \(piece.Proprietaire()) est en reserve.\n C'est un probleme, elle n'est pas censé etre en reserve")
        }
    }
    if cmtp == 8 {
        print("a premiere vue, il n'y a pas de probleme")
    } else {
        print("test echoué : soit une initialisation ne se fait pas bien, soit l'iterateur ne parcourt pas toutes les pieces")
    }
}

func testJoueurActifEtChangerTour(){
    
    var p : Partie = Partie()
    let i : Int = p.joueurActif()
    if i == 1{
        print("Le joueur 1 a commencé la partie")
        p.changerTour()
        let j = p.joueurActif()
        if j == 2 {
            print("La joueur 2 est le suivant")
        } else {
            print("PROBLEME : changerTour est sensé changer le joueur actif")
        }
    }else if i == 2 {
        print("Le joueur 2 a commencé la partie")
        p.changerTour()
        let j = p.joueurActif()
        if j == 1 {
            print("La joueur 1 est le suivant")
        } else {
            print("PROBLEME : changerTour est sensé changer le joueur actif")
        }
    } else {
        print("PROBLEME : joueur actif est soit 1, soit 2")
    }
}

func testPartieFiniEtGagnerPartie(){
    
    var p : Partie = Partie()
    if p.partieFini(){
        print("Une partie juste créée n'est pas censée être déjà fini : PROBLEME")
    } else {
        print("Pas de souci")
        p.gagner(joueur : 1)
        if p.PartieFini(){
            print("Pas de souci")
        } else {
            print("Une partie gagnée est censée se finir : PROBLEME")
        }
    }
}

func testPieceAPositionEtEstLibre(){

    var p : Partie = Partie()
    
    if let piece = p.PieceAPosition([0,1]){
        print("Pas de souci : la piece \(piece.typePiece()) de Joueur \(piece.proprietaire()) est placée en [0,1]")
    } else {
        print("PROBLEME : il y a une piece a cette position")
    }
    
    if p.estlibre([1,0]){
        print("Pas de souci : La case [1,0] est bien libre")
    } else{
    
        print("PROBLEME : cette case [0,1] est censée etre libre")
    }

}
