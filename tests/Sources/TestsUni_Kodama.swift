func testCreerPieceK(){
    var p : Partie = Partie()
    //demarrerPartie() fait appel au init() de Kodama
    if let kodama = p.PieceAPosition(pos : [1,1]){
        print("Kodama créé en position [0,1], non transformé")
    }
    else{
        print("Problème de création du kodama")
    }
    do{
        try Kodama(position : [1,-3], partie :  p)
        print("Problème")
    }
    catch{
        print("position non-valide")
    }
    do{
        try Kodama(position : [0,1], partie : p)
        print("Problème")
    }
    catch{
        print("position déjà occupée")
    }
}


func testEstPossibleMouvementK(){
    var p : Partie = Partie()
    var k1 : Kodama = p.PieceAPosition(pos : [1,1])
    if k1.estPossibleMouvement(nouvellePos : [2,1]){
        print("Mouvement possible")
    }
    else{
        print("Problème : Le mouvement devrait être possible")
    }
    if k1.estPossibleMouvement(nouvellePos : [0,1]){
        print("Problème : le mouvement ne devrait pas être possible")
    }
    else{
        print("Le mouvement n'est pas possible")
    }
    if k1.estPossibleMouvement(nouvellePos : [-1,1]){
        print("Problème : le mouvement ne devrait pas être possible")
    }
    else{
        print("La case n'existe pas")
    }
    if (k1.estPossibleMouvement(partie : p, position : [1,-1,0])){
        print("Problème : La case ne devrait pas exister")
    }
    else{
        print("Mouvement impossible : la case n'existe pas")
    }
    
}

func testDeplacerPieceK(){
    var p : Partie = Partie()
    var k1 : Kodama = p.PieceAPosition(pos : [1,1])
    if let p2=k1.deplacerPiece(partie : p, nouvellePos : [2,1]){
        print("Le kodama a été déplacée")
    }
    else{
        print("Problème : le kodama aurait dû être déplacée")
    }
    do{
        try k1.deplacerPiece(partie : p, nouvellePos : [1,2])
        print("Problème : La pièce n'aurait pas dû effectuer le déplacement")
    }
    catch{
        print("Le déplacement ne correspond pas au type Kodama")
    }
    do{
        try k1.deplacerPiece(partie : p, nouvellePos : [1,-1])
        print("Problème : La case n'existe pas")
    }
    catch{
        print("position inexistante")
    }
    
}

func testEstTransformeK(){
    var p : Partie = Partie()
    var k1 : Kodama = p.PieceAPosition(pos : [1,1])
    if k1.estTransofrme{
        print("Problème : le Kodama ne devrait pas être samuraï)")
    }
    else{
        print("Le kodama n'est pas transformé")
    }
}


