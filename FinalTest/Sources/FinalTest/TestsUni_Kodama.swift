import FinalType

func testCreerPieceK(){
    var p : TPartie = TPartie()
    //demarrerPartie() fait appel au init() de Kodama
    if let kodama : TPiece? = p.pieceAPosition(pos : [1,1])!{
        print("Kodama créé en position [0,1], non transformé")
    }
    else{
        print("Problème de création du kodama")
    }
    do{
        try TPiece(position : [1,-3], nom : "Kodama")
        print("Problème")
    }
    catch{
        print("position non-valide")
    }
    /*do{ 
        try TPiece(position : [0,1], nom : "Kodama")
        print("Problème")
    }
    catch{
        print("position déjà occupée")
    }
    le Kodama ne sera jamais initialisé a cette endroit dans TPartie
    */
}


func testEstPossibleMouvementK(){
    var p : TPartie = TPartie()
    var k1 : TPiece = p.pieceAPosition(pos : [1,1])!
    if k1.estPossibleMouvement(partie : p, position : [2,1]){
        print("Mouvement possible")
    }
    else{
        print("Problème : Le mouvement devrait être possible")
    }
    if k1.estPossibleMouvement(partie : p, position : [0,1]){
        print("Problème : le mouvement ne devrait pas être possible")
    }
    else{
        print("Le mouvement n'est pas possible")
    }
    if k1.estPossibleMouvement(partie : p, position : [-1,1]){
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
    var p : TPartie = TPartie()
    var k1 : TPiece = p.pieceAPosition(pos : [1,1])!
    if let p2 : TPartie? = try! k1.deplacerPiece(partie : p, nouvellePos : [2,1]){
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
    var p : TPartie = TPartie()
    var k1 : TPiece = p.pieceAPosition(pos : [1,1])!
    if k1.estTransforme(){
        print("Problème : le Kodama ne devrait pas être samuraï)")
    }
    else{
        print("Le kodama n'est pas transformé")
    }
}


//testCreerPieceK()
// testEstPossibleMouvementK()

