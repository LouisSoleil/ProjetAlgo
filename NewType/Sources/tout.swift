struct ItTotalPieceIT {
    typealias SPiece = TPiece
    typealias SPartie = TPartie
    
    internal var pieces : [TPiece]
    internal var courant : TPiece?
    
    init(partie : TPartie){
        self.pieces = [partie.ko1, partie.ko2, partie.ki1, partie.ki2, partie.ta1, partie.ta2, partie.ku1, partie.ku2]
        self.courant = partie.ko1
    }
    
    mutating func next()->TPiece?{
        if let courant = self.courant{
            var t = true
            var i = 0
            while t {
                if i == 7{
                    self.courant = nil
                    t = false
                }
                else if self.courant!.nom == self.pieces[i].nom && self.courant!.joueur == self.pieces[i].joueur {//test si c'est la même pièce
                    self.courant = self.pieces[i+1]
                    t = false
                }
                else {
                    i += 1
                }
            }
        }
        return self.courant
    }
}
protocol AttPartie {
    associatedtype SItTotalPieceIT = TotalPieceIT
    associatedtype SPieceJIT = PieceJIT
    associatedtype SPiece = Piece
    
    // Renvoie la piece a cette position s'il y en a une, Vide sinon
    // pre : Il s'agit d'une position : pos[0] est la ligne, entre 0 et 3, pos[1] est la colonne, entre 0 et 2, il n'y a que 2 arguments (ligne et colonne)
    // post : La piece est la piece a la position entrée
    func pieceAPosition(pos : [Int]) -> SPiece?
    // Iterateur : Renvoie le type Iterateur avec toutes les pieces de la partie dedans, pour un for i in Partie
    func makeIT()->SItTotalPieceIT
    
    // Iterateur avec un parametre :
    // pre : Il s'agit d'un joueur : soit 1, soit 2
    // post : renvoie l'iterateur qui ne parcourera que les pieces du joueur en entrée
    func pieceJIT(joueur : Int)-> SPieceJIT

    
}
protocol Partie {
    
  
    // Crée une partie :
    // post : La partie contient
    //      2 joueurs : 1 et 2
    //      8 pieces (2 Kodama, 2 Kitsune, 2 Tanuki, 2 Kuropokkuru)  a leurs positions initiales (cf schema) et qui appartiennent au bon joueurs (1 et 2) Quand la partie est créée, elle n'est pas finie
    init()
    
    
    // Indique si la partie est finie(True) ou encore en cours (False)
    func partieFini()-> Bool
    
    // Indique quel est le joueur actif actuel
    // post : retourne soit 1, soit 2 en fonction que le joueur soit le joueur 1 ou 2
    func joueurActif() -> Int
    
    //Change le joueur actif : si c'etait le joueur 1, ça devient le joueur 2, et inversement
    mutating func changerTour()
    
        
    // Indique s'il y a une piece a cette position
    // pre : Il s'agit d'une position : pos[0] est la ligne, entre 0 et 3, pos[1] est la colonne, entre 0 et 2, il n'y a que 2 arguments (ligne et colonne)
    func Est_libre(pos : [Int])-> Bool
    
    
    // Renvoie la ligne considérée comme la derniere ligne du joueur en entrée
    // pre : Il s'agit d'un joueur : soit 1, soit 2
    // post : ligne d'arrivée / de promotion : celle d'en face du joueur en entrée => est soit 0, soit 3
    func derniereLigne(joueur : Int)-> Int
    
    // fait gagner la partie au joueur en entrée (change le resultat de partieFini a vrai)
    // pre : Il s'agit d'un joueur : soit 1, soit 2
    mutating func gagner(joueur : Int)
}



protocol Piece {

    associatedtype SPartie = Partie

 
    
    // Description : Crée une pièce
    // Données : Un tableau de 2 entiers [x,y] correspondant à la position initiale,(ligne, colonne) et une chaine de caractères correspondant au nom de la pièce, partie : Partie
    // Préconditions : x appartient à [0,3], y appartient à [0,2], [x,y] est une position inoccupée, le nom de la pièce appartient à {"Koropokkuru", "Tanuki", "Kitsune"} (si tu veut créer un kodama, créée un objet de type Kodama)
    // Résultat : Pièce créée à la position indiquée
    // Lance une erreur si la position est déjà occupée par une pièce ou si le nom de la pièce n'existe pas
    init(position : [Int], nom : String) throws
    
    //Description : Renvoie le type d'une pièce
    //Résultat : String, nom de la pièce
    //Post-conditions : Le résultat appartient à {Koropokkuru, Tanuki, Kitsune}
    func typePiece() -> String
    
    //Description : Renvoie la position d'une pièce
    //Résultat : [Int](2) : Position correspondant à la position de la pièce [ligne,colonne] si la pièce est sur le plateau, vide si la pièce est dans une des réserves
    func positionPiece()->[Int]?
    
    //Description : Renvoie le propriétaire d'une pièce
    // Résultat : Int : 1 si la pièce appartient au joueur 1; 2 si la pièce appartient au joueur 2
    //Post-conditions : Le résultat est soit 1, soit 2
    func proprietairePiece()->Int
    
    //Description : Détermine si le mouvement d'une pièce vers une position est possible
    //Données : partie : Partie, position : [Int](2) correspondant à la position vers laquelle la pièce doit être déplacée (la nouvelle position)
    //Préconditions : positionPiece(p)!=Vide
    //Résultat : Booléen, true si le mouvement correspond à la pièce, si la position existe et est inoccupée par une pièce du même joueur(le mouvement est possible si une piece adverse occupe la case),
    //       false sinon
    //       Si la pièce est un Koropokkuru, elle peut se déplacer d'une case dans tous les sens
    //       Si la pièce est un Tanuki, elle peut se déplacer d'une case en avant, en arrière, à droite ou à gauche
    //       Si la pièce est un Kitsune, elle peut se déplacer d'une case dans une des diagonales
    func estPossibleMouvement(partie : SPartie, position : [Int]) -> Bool
    
    //Description : Détermine si le parachutage d'une pièce vers une position est possible
    //Données :  partie : Partie, position : [Int](2) correspondant à la position vers laquelle la pièce doit être déplacée (la nouvelle position)
    //Préconditions : positionPiece(p)==Vide
    //Résultat : Booléen, true si le mouvement correspond à la pièce, si la position existe et est inoccupée
    //       false sinon
    func estParachutagePossible(partie : SPartie, position : [Int]) -> Bool
    
    //Description : Déplace une pièce vers une autre position
    //Données : nouvellePos : [Int](2)
    //Préconditions : positionPiece(p)!=Vide
    //Résultat : La même pièce avec une nouvelle position si le mouvement est possible
    // Lance une erreur si le mouvement n'est pas possible 
    // Si la piece arrive sur une piece adverse (c'est pour ça qu'on a besoin de la partie), on capture la piece adverse (la partie renvoyée est la partie aprés le deplacement)
    // Si on capture le Koropokkuru adverse, on gagne la partie
    mutating func deplacerPiece(partie : SPartie, nouvellePos : [Int]) throws -> SPartie
    
    //Description : Change le propriétaire d'une pièce et la place dans la réserve du nouveau propriétaire lorsque la pièce d'un joueur se pose sur la pièce d'un autre joueur
    //Préconditions : La position de p n'est pas Vide
    //Résultat : La même pièce, qui a un nouveau propriétaire(1 devient 2 ou 2 devient 1) et dont la position est Vide (la pièce est en réserve)
    // Lance une erreur si p est deja en réserve
    //Post-conditions : positionPiece(p)=Vide
    mutating func etreCapturee() throws
    
    // Description : Place une pièce de la réserve sur le plateau
    // Données :  partie : Partie, position : [Int](2), position où l'on souhaite placer la pièce
    // Préconditions : positionPiece(p)=Vide, (x,y) est une place inoccupée sur la partie
    // Résultat : La même pièce qui a désormais une position sur le plateau
    // Lance une erreur si la pièce n'est pas en réserve ou si la position est déjà occupée
    // Post-conditions : positionPiece(p)!=Vide
    mutating func parachuter(partie : SPartie, position : [Int]) throws -> SPartie
    
    
    //Description : Détermine si une pièce est dans la réserve
    //Résultat : Booléen, true si position(p)=Vide, false sinon
    func estDansReserve() -> Bool
    
}



protocol Kodama : Piece { // Apres recherche, les override se font dans les class (implementation) et pas dans les protocols

    //override toutes les fonctions qui sont aussi dans Piece
    
    //associatedType est deja dans Piece
    
    //Description : Crée un kodama qu n'est pas transofrmé
    //Données : position : [Int](2), partie : Partie
    //Préconditions : position est une position inoccupée sur la partie
    //Résultat : Kodama créé à la position correspondante
    //Post-conditions : position(k)!=Vide
    init(position : [Int], partie : SPartie)
    
    //Description : Renvoie le type d'une pièce
    //Résultat : String, nom de la pièce
    //Post-conditions : Le résultat appartient à {Kodama, Kodama Samurai}
    func typePiece() -> String
    
    //Description : Détermine si un Kodama peut se déplacer dvers une position
    //Données : nouvellePos : [Int](2), partie : Partie
    //Préconditions : positionPiece(kodama)!=vide
    //Résultat : Booleen, true si le mouvement est possible c'est à dire si le mouvement  correspond au Kodama, et si la case existe et est inoccupée,
    //       false sinon
    //       Un Kodama ne peut se déplacer que d'une case vers l'avant (vers la derniere ligne de son proprietaire),
    //       Un Kodama samuraï (transformé) peut se déplacer d'une case dans tous les sens sauf dans les diagonales arrières (vers l'opposé de la derniere ligne de son proprietaire)
    func estPossibleMouvement(nouvellePos : [Int], partie : Partie) -> Bool
    
    //Description : Déplace un Kodama vers une autre position, verifie si le kodama arrive a la derniere ligne de son proprietaire, et le transforme si c'est le cas
    //Données : nouvellePos : [Int](2), partie : Partie
    //Préconditions : positionPiece(k)!=Vide
    //Résultat : La même pièce avec une nouvelle position si le mouvement est possible
    // lance une erreur si le mouvement n'est pas possible
    mutating func deplacerPiece(partie : Partie, nouvellePos : [Int]) throws -> SPartie
    
    //Description : Change le propriétaire d'un Kodama et la place dans la réserve du nouveau propriétaire, en annulant sa transformation si le Kodama était samuraï (etait transformé)
    //Données : prop : Int
    //Préconditions : La position de k n'est pas Vide
    //Résultat : La même pièce, qui a un nouveau propriétaire, qui n'est pas transformée et dont la position est Vide (la pièce est en réserve), erreur si k est en réserve
    //Post-conditions : positionPiece(k)=Vide
    mutating func etreCapturee() throws
    
    //Description : Transforme un Kodama en Kodama samuraï lorsque le Kodama arrive sur la ligne correspondant  à la dernière ligne
    // du propriétaire
    //Préconditions : estTransforme(k)=False
    //Résultat : Affecte True à estTransforme(k), erreur si Kodama déjà transformé
    mutating func transformer() throws
    
    //Description : Détermine si un Kodama a été transformé ou non,
    //Résultat : Booléen, True si le Kodama est samuraï, False sinon
    func estTransforme()->Bool 

}


struct TPiece : Piece{
    
    typealias SPartie = TPartie
    
    internal var pos : [Int]?
    internal var nom : String
    internal var joueur : Int
    
    
    enum Erreur : Error {
        case mauvaisparametre
    }
    
    
    init(position : [Int], nom : String) throws {
        guard position.count == 2 && -1 < position[0] && position[0] < 4 && -1 < position[1] && position[1] < 3 else{
            throw Erreur.mauvaisparametre
        }
        guard nom == "Koropokkuru" || nom == "Tanuki" || nom == "Kitsune" else {throw Erreur.mauvaisparametre}
        
        self.pos = position
        self.nom = nom
        if position[0] == 0 || position[0] == 1 {
            self.joueur = 1
        }
        else {
            self.joueur = 2
        }
    }
    
    func typePiece() -> String{
        return self.nom
    }
    
    func positionPiece() -> [Int]?{
        return self.pos
    }
    
    func proprietairePiece()->Int{
        return self.joueur
    }
    
    func estPossibleMouvement(partie : TPartie, position : [Int]) -> Bool{
        if let positionPiece = partie.pieceAPosition(pos : position) {
            if (self.pos != nil) && (-1 < position[0]) && (position[0] < 4) && (-1 < position[1]) && (position[1] < 3) && (partie.pieceAPosition(pos : position)!.proprietairePiece() != self.proprietairePiece()){
                if self.nom == "Kitsune"{ //peu importe le joueur les diagonales de la piece seront les mêmes
                    return (self.pos![0]+1 == position[0] && self.pos![1]+1 == position[1]) || (self.pos![0]+1 == position[0] && self.pos![1]-1 == position[1]) || (self.pos![0]-1 == position[0] && self.pos![1]-1 == position[1]) || (self.pos![0]-1 == position[0] && self.pos![1]+1 == position[1])
                }
            }
            else if self.nom == "Tanuki"{ // pareil peu importe le joueur les cases drtoite/gauche et avant/arriere seront les mêmes
                return (self.pos![0]+1 == position[0] && self.pos![1] == position[1]) || (self.pos![0]-1 == position[0] && self.pos![1] == position[1]) || (self.pos![0] == position[0] && self.pos![1]-1 == position[1]) || (self.pos![0] == position[0] && self.pos![1]+1 == position[1])
            }
            else { // c'est un Koropokkuru
                return (self.pos![0]+1 == position[0] && self.pos![1]+1 == position[1]) || (self.pos![0]+1 == position[0] && self.pos![1]-1 == position[1]) || (self.pos![0]-1 == position[0] && self.pos![1]-1 == position[1]) || (self.pos![0]-1 == position[0] && self.pos![1]+1 == position[1]) || (self.pos![0]+1 == position[0] && self.pos![1] == position[1]) || (self.pos![0]-1 == position[0] && self.pos![1] == position[1]) || (self.pos![0] == position[0] && self.pos![1]-1 == position[1]) || (self.pos![0] == position[0] && self.pos![1]+1 == position[1])
            }
        }
        else{
            return false
        }
    }
    
    func estParachutagePossible(partie : TPartie, position : [Int]) -> Bool{
        if self.pos == nil && -1 < position[0] && position[0] < 4 && -1 < position[1] && position[1] < 3{
            if partie.pieceAPosition(pos : position) == nil {
                return true
            }
            else{
                return false
            }
        }
    }
    
    mutating func deplacerPiece(partie : TPartie, nouvellePos : [Int]) throws -> TPartie {
        guard self.pos != nil && self.estPossibleMouvement(partie : partie, position : nouvellePos) else{
            throw Erreur.mauvaisparametre
        }
        if partie.pieceAPosition(pos : nouvellePos) == nil{
            self.pos = nouvellePos
        }
        else{
            var piece = partie.pieceAPosition(pos : nouvellePos)!
            do{
                try piece.etreCapturee()}
            catch {
            }
            self.pos = nouvellePos
        }
        return partie
    }
    
    mutating func etreCapturee() throws{
        guard self.pos != nil else{
            throw Erreur.mauvaisparametre
        }
        if self.joueur == 1 {
            self.joueur = 2
        }
        else{
            self.joueur = 1
        }
        self.pos = nil
    }
    
    mutating func parachuter(partie : TPartie, position : [Int]) throws -> TPartie{
        guard self.pos != nil && self.estParachutagePossible(partie : partie, position : position) else{
            throw Erreur.mauvaisparametre
        }
        self.pos = position
        return partie
    }
    
    func estDansReserve() -> Bool {
        return self.pos == nil
    }
}

struct TKodama{
    internal var pos : [Int]?
    internal var nom : String = "Kodama"
    internal var joueur : Int
    internal var trans : Bool = false
    
    enum Erreur : Error {
        case mauvaisparametre
    }
    
    
    init(position : [Int]) throws {
        guard position.count == 2 && -1 < position[0] && position[0] < 4 && -1 < position[1] && position[1] < 3 else{
            throw Erreur.mauvaisparametre
        }
        self.pos = position
        if position[0] == 0 || position[0] == 1 {
            self.joueur = 1
        }
        else {
            self.joueur = 2
        }
    }
    func typePiece() -> String{
        return self.nom
    }
    
    func positionPiece() -> [Int]?{
        return self.pos
    }
    
    func proprietairePiece()->Int{
        return self.joueur
    }
    
    func estParachutagePossible(partie : TPartie, position : [Int]) -> Bool{
        if self.pos == nil && -1 < position[0] && position[0] < 4 && -1 < position[1] && position[1] < 3{
            if partie.pieceAPosition(pos : position) == nil {
                return true
            }
            else{
                return false
            }
        }
    }
    
    func estPossibleMouvement(partie : TPartie, position : [Int]) -> Bool{
        if self.pos != nil && -1 < position[0] && position[0] < 4 && -1 < position[1] && position[1] < 3 && partie.pieceAPosition(pos : position) == nil{
            if self.estTransforme(){
                if self.proprietairePiece() == 1 {
                    if (self.pos![0]+1 == position[0] && self.pos![1]+1 == position[1]) || (self.pos![0]+1 == position[0] && self.pos![1]-1 == position[1]) || (self.pos![0]+1 == position[0] && self.pos![1] == position[1]) || (self.pos![0]-1 == position[0] && self.pos![1] == position[1]) || (self.pos![0] == position[0] && self.pos![1]-1 == position[1]) || (self.pos![0] == position[0] && self.pos![1]+1 == position[1]) {
                        return true
                    }
                    else {
                        return false
                    }
                }
                else{
                    if (self.pos![0]-1 == position[0] && self.pos![1]+1 == position[1]) || (self.pos![0]-1 == position[0] && self.pos![1]-1 == position[1]) || (self.pos![0]+1 == position[0] && self.pos![1] == position[1]) || (self.pos![0]-1 == position[0] && self.pos![1] == position[1]) || (self.pos![0] == position[0] && self.pos![1]-1 == position[1]) || (self.pos![0] == position[0] && self.pos![1]+1 == position[1]) {
                        return true
                    }
                    else{
                        return false
                    }
                }
            }
            else { // Kodama samuraï
                if self.proprietairePiece() == 1 {
                    if self.pos![0]+1 == position[0] && self.pos![1] == position[1] {
                        return true
                    }
                    else {
                        return false
                    }
                }
                else{
                    if self.pos![0]-1 == position[0] && self.pos![1] == position[1] {
                        return true
                    }
                    else {
                        return false
                    }
                }
            }
        }
        else {
            return false
        }
    }
    
    
    
    mutating func deplacerPiece(partie : TPartie, nouvellePos : [Int]) throws -> TPartie{
        guard self.pos != nil && self.estPossibleMouvement(partie : partie, position : nouvellePos) else{
            throw Erreur.mauvaisparametre
        }
        self.pos = nouvellePos
        if self.proprietairePiece() == 1 && nouvellePos[0] == 3{
            self.trans = true
        }
        else if self.proprietairePiece() == 2 && nouvellePos[0] == 0{
            self.trans = true
        }
        return partie
    }
    
    
    mutating func etreCapturee() throws{
        guard self.pos != nil else{
            throw Erreur.mauvaisparametre
        }
        if self.joueur == 1 {
            self.joueur = 2
        }
        else{
            self.joueur = 1
        }
        self.pos = nil
        if self.estTransforme() {
            self.trans = false
        }
    }
    
    mutating func transformer() throws{
        guard !self.trans else{
            throw Erreur.mauvaisparametre
        }
        if self.proprietairePiece() == 1 && pos![0] == 3{
            self.trans = true
        }
        else if self.proprietairePiece() == 2 && pos![0] == 0{
            self.trans = true
        }
    }
    
    func estTransforme()->Bool {
        return self.trans
    }
    mutating func parachuter(partie : TPartie, position : [Int]) throws -> TPartie{
        guard self.pos != nil && self.estParachutagePossible(partie : partie, position : position) else{
            throw Erreur.mauvaisparametre
        }
        self.pos = position
        return partie
    }
    
    func estDansReserve() -> Bool {
        return self.pos == nil
    }
}
protocol PieceJIT : PPieceJIT {
    
}
protocol PPieceJIT : IteratorProtocol{
    
    associatedtype SPiece = Piece
    associatedtype SPartie = Partie
    
    // Crée l'iterateur avec les pieces du joueur en entrée
    //    pre : joueur == 1 ou joueur == 2 
    init(joueur : Int, partie : SPartie)
    
    // Iterator Next : parcourt les pieces du joueur en entrée : renvoit la piece courante et passe a la piece suivante
    mutating func next()->SPiece?
}
protocol TotalPieceIT : TTotalPieceIT {
    
}
protocol TTotalPieceIT : IteratorProtocol{
    
    associatedtype SPiece = Piece
    associatedtype SPartie = Partie


    //crée un iterateur avec toutes les pieces de la partie
    init(partie : SPartie)
    
    //Iterator Next : parcourt toutes les pieces de la partie : renvoit la piece courante et passe a la piece suivante
    mutating func next()->SPiece?
}
struct TPieceJIT{
    typealias SPartie = TPartie
    typealias SPiece = TPiece
    
    internal var pieces : [TPiece]
    internal var courant : TPiece?
    internal var pieceJ : [TPiece]
    
    init (joueur : Int, partie : TPartie) {
        var p : [TPiece] = [partie.ko1,partie.ko2,partie.ki1,partie.ki2,partie.ta1,partie.ta2,partie.ku1,partie.ku2]
        for i in p {
            if i.proprietairePiece() == joueur {
                self.pieces.append(i)
                self.courant = pieces[0]
            }
        }
    }
    
    mutating func next()->TPiece?{
        if let courant = self.courant{
            var t = true
            var i = 0
            while t {
                if i == 7{
                    self.courant = nil
                    t = false
                }
                else if self.courant!.nom == self.pieces[i].nom && self.courant!.joueur == self.pieces[i].joueur {
                    self.courant = self.pieces[i+1]
                    t = false
                }
                else {
                    i += 1
                }
            }
        }
        return self.courant
    }
}
struct TPartie : Partie, AttPartie {
    typealias SPiece = TPiece
    typealias SItTotalPieceIT = ItTotalPieceIT
    typealias SPieceJIT = TPieceJIT
    
    
    
    internal var ko1 : TPiece
    internal var ko2 : TPiece
    internal var ki1 : TPiece
    internal var ki2 : TPiece
    internal var ta1 : TPiece
    internal var ta2 : TPiece
    internal var ku1 : TPiece
    internal var ku2 : TPiece
    internal var joueurA : Int
    internal var tableau : [TPiece]
    
    
    init() {
        do{
            try self.ko1 = TPiece(position : [1,1], nom : "Kodoma")}
        catch {
        }
        do {
            try self.ko2 = TPiece(position : [2,1], nom : "Kodoma")}
        catch {
        }
        do {
            try self.ki1 = TPiece(position : [0,2], nom : "Kitsune")}
        catch {
        }
        do{
            try self.ki2 = TPiece(position : [3,0], nom : "Kitsune")}
        catch {
        }
        do{
            try self.ta1 = TPiece(position : [0,0], nom : "Tanuki")}
        catch {
        }
        do{
            try self.ta2 = TPiece(position : [3,3], nom : "Tanuki")}
        catch {
        }
        do{
            try self.ku1 = TPiece(position : [0,1], nom : "Kuropokkuru")}
        catch {
        }
        do{
            try self.ku2 = TPiece(position : [3,1], nom : "Kuropokkuru")}
        catch {
        }
        do{
            try self.joueurA = Int(arc4random_uniform(UInt32(2)))+1}
        catch {
        }
        self.tableau = [self.ko1,self.ko2,self.ki1,self.ki2,self.ta1,self.ta2,self.ku1,self.ku2]
    }
    
    func partieFini() -> Bool {
        var fin : Bool = false
        if ku1.proprietairePiece() == 2 || ku2.proprietairePiece() == 1 {
            return !fin
        }
        else if ko1.estPossibleMouvement(partie : self, position : ku1.positionPiece()!){
            return !fin
        }
        else if ko2.estPossibleMouvement(partie : self, position : ku1.positionPiece()!){
            return !fin
        }
        else if ki1.estPossibleMouvement(partie : self, position : ku1.positionPiece()!){
            return !fin
        }
        else if ki2.estPossibleMouvement(partie : self, position : ku1.positionPiece()!){
            return !fin
        }
        else if ta1.estPossibleMouvement(partie : self, position : ku1.positionPiece()!){
            return !fin
        }
        else if ta2.estPossibleMouvement(partie : self, position : ku1.positionPiece()!){
            return !fin
        }
        else if ku2.estPossibleMouvement(partie : self, position : ku1.positionPiece()!){
            return !fin
        }
        else if ko1.estPossibleMouvement(partie : self, position : ku2.positionPiece()!){
            return !fin
        }
        else if ko2.estPossibleMouvement(partie : self, position : ku2.positionPiece()!){
            return !fin
        }
        else if ki1.estPossibleMouvement(partie : self, position : ku2.positionPiece()!){
            return !fin
        }
        else if ki2.estPossibleMouvement(partie : self, position : ku2.positionPiece()!){
            return !fin
        }
        else if ta1.estPossibleMouvement(partie : self, position : ku2.positionPiece()!){
            return !fin
        }
        else if ta2.estPossibleMouvement(partie : self, position : ku2.positionPiece()!){
            return !fin
        }
        else if ku1.estPossibleMouvement(partie : self, position : ku2.positionPiece()!){
            return !fin
        }
    }
    
    func joueurActif() -> Int{
        if self.joueurA == 1 {
            return 1
        }
        else {
            return 2
        }
    }
    
    mutating func changerTour() {
        if self.joueurActif()==1{
            self.joueurA = 2
        }
        else {
            self.joueurA = 1
        }
    }
    
    func pieceAPosition(pos : [Int]) -> TPiece?{
        if let position = ko1.positionPiece(){
            if ko1.positionPiece()! == pos {
                return ko1
            }
        }
        else if let position = ko2.positionPiece(){
            if ko2.positionPiece()! == pos {
                return ko2
            }
        }
        else if let position = ki1.positionPiece(){
            if ki1.positionPiece()! == pos{
                return ki1
            }
        }
        else if let position = ki2.positionPiece(){
            if ki2.positionPiece()! == pos{
                return ki2
            }
        }
        else if let position = ta1.positionPiece(){
            if ta1.positionPiece()! == pos{
                return ta1
            }
        }
        else if let position = ta2.positionPiece(){
            if ta2.positionPiece()! == pos{
                return ta2
            }
        }
        else if let position = ku1.positionPiece(){
            if ku1.positionPiece()! == pos{
                return ku1
            }
        }
        else if let position = ku2.positionPiece(){
            if ku2.positionPiece()! == pos{
                return ku2
            }
        }
        else {
            return nil
        }
    }
    
    func Est_libre(pos : [Int]) -> Bool{
        return self.pieceAPosition(pos : pos) == nil
    }
    
    func pieceJIT(joueur : Int) -> TPieceJIT{
        return TPieceJIT(joueur : joueur, partie : self)
    }
    
    func makeIT() -> ItTotalPieceIT{
        return ItTotalPieceIT (partie : self)
    }
    
    func derniereLigne(joueur : Int) -> Int{
        if joueur == 1 {
            return 3
        }
        else {
            return 0
        }
    }
    
    mutating func gagner(joueur :Int){
        if joueur == 2 {
            print("le joueur 2 a gagné")
            self.partieFini()
        }
        else{
            print("le joueur 1 a gagné")
            self.partieFini()
        }
    }
}
