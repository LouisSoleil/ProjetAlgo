import FinalType

func testInit() throws{
	var p : TPartie = TPartie()
    //demarrerPartie() fait appel au init() de Piece
    if let piece : TPiece? = p.pieceAPosition(pos : [0,1])!{
		print("Koropokkuru créé en position [0,1]")
	}
	else{
		print("Problème de création de la pièce")
	}
	do{
        try TPiece(position : [1,-3], nom : "Tanuki")
		print("Problème")
	}
	catch{
	print("position non-valide")
	}
	/*do{
        try TPiece(position : [0,1], nom : "Tanuki")
		print("Problème")
	}
	catch{
	print("position déjà occupée")
	}
    on ne le test pas car fait a la création(changement de spécif) Problème que le type se refère tout seul
    */
}

func testTypePiece(){
    var p : TPartie = TPartie()
    var pi : TPiece = p.pieceAPosition(pos : [0,1])!
	if let str : String?=pi.typePiece(){
		print("pi est de type \(str)")
	}
	else{
		print("Problème")
	}
}

func testPositionPiece(){
    var p : TPartie = TPartie()
    var pi1 : TPiece? = p.pieceAPosition(pos : [0,1])
    var pi2 : TPiece? = p.pieceAPosition(pos : [2,0])
    if let piece1 = pi1!.positionPiece(){
        print("\(pi1!.typePiece()) est en position \(piece1)")
    }
    else{
        print("Problème : pièce non trouvée")
    }
    /*if let piece2 = pi2.positionPiece(){
        print("Erreur : il ne devrait pas y avoir de pièce à cette position")
    }
    else{
        print("Il n'y a pas de pièce à cette position")
    }
    On ne peut pas appeler .positionPiece d'un "nil"
    */
}

func testProprietairePiece(){
    var p : TPartie = TPartie()
    var pi1 : TPiece = p.pieceAPosition(pos : [0,1])!
    //pi1 est le Koropokkuru du joueur 1
    var pi2 : TPiece = p.pieceAPosition(pos : [3,1])!
    //pi2 est le Koroppokuru du joueur 2
    if let piece1 : Int?=pi1.proprietairePiece(){
        print("la pièce \(pi1.typePiece) appartient au joueur \(piece1)")
    }
    else{
        print("Problème")
    }
    if let piece2 : Int?=pi2.proprietairePiece(){
        print("la pièce \(pi2.typePiece) appartient au joueur \(piece2)")
    }
    else{
        print("Problème")
    }
    
}

func testEstPossibleMouvement(){
    var p : TPartie = TPartie()
    var pi1 : TPiece = p.pieceAPosition(pos : [0,1])!
    if (pi1.estPossibleMouvement(partie : p, position : [1,2])){
        print("le mouvement est possible")
    }
    else{
        print("Problème : le mouvement devrait être possible")
    }
    if (pi1.estPossibleMouvement(partie : p, position : [1,1])){
        print("Problème : Le mouvement ne devrait pas être possible")
    }
    else{
        print("Mouvement impossible : Une pièce se toruve déjà sur cette case")
    }
    if (pi1.estPossibleMouvement(partie : p, position : [1,-1])){
        print("Problème : La case ne devrait pas exister")
    }
    else{
        print("Mouvement impossible : la case n'existe pas")
    }
    if (pi1.estPossibleMouvement(partie : p, position : [1,-1,0])){
        print("Problème : La case ne devrait pas exister")
    }
    else{
        print("Mouvement impossible : la case n'existe pas")
    }

}

func testDeplacerPiece() throws{
    var p : TPartie = TPartie()
    var pi1 : TPiece = p.pieceAPosition(pos : [0,1])!
    if var p2 : TPartie?=try pi1.deplacerPiece(partie : p, nouvellePos : [1,0]){
        print("la pièce a été déplacée")
    }
    else{
        print("Problème : la pièce aurait dû être déplacée")
    }
    do{
        try pi1.deplacerPiece(partie : p, nouvellePos : [1,1])
        print("Problème : Une pièce aurait dû bloquer le déplacement")
    }
    catch{
        print("position déjà occupée")
    }
    do{
        try pi1.deplacerPiece(partie : p, nouvellePos : [1,-1])
        print("Problème : La case n'existe pas")
    }
    catch{
        print("position inexistante")
    }
    var par : TPartie = TPartie()
    var pie1 : TPiece = par.pieceAPosition(pos : [0,1])!
    do{
        try pie1.deplacerPiece(partie : par, nouvellePos : [2,0])
        print("Problème : Le mouvement ne correspond pas à la pièce")
    }
    catch{
        print("Mouvement impossible")
    }

    
}

func testEstDansReserve(){
    var p : TPartie = TPartie()
    var pi1 : TPiece = p.pieceAPosition(pos : [0,1])!
    if pi1.estDansReserve(){
        print("Problème : La pièce ne devrait pas être en réserve")
    }
    else{
        print("la pièce n'est pas en réserve")
    }
}
