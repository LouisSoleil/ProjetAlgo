protocol Piece {
    
    associatedtype Partie : Sequence
    
    // Description : Crée une pièce
    // Données : Un tableau de 2 entiers [x,y] correspondant à la position initiale,(ligne, colonne) et une chaine de caractères correspondant au nom de la pièce, partie : Partie
    // Préconditions : x appartient à [0,3], y appartient à [0,2], [x,y] est une position inoccupée, le nom de la pièce appartient à {"Koropokkuru", "Tanuki", "Kitsune"} (si tu veut créer un kodama, créée un objet de type Kodama)
    // Résultat : Pièce créée à la position indiquée
    // Lance une erreur si la position est déjà occupée par une pièce ou si le nom de la pièce n'existe pas
    init(position : [Int], nom : String, partie : Partie) throws
    
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
    //	     false sinon
    //	     Si la pièce est un Koropokkuru, elle peut se déplacer d'une case dans tous les sens
    //	     Si la pièce est un Tanuki, elle peut se déplacer d'une case en avant, en arrière, à droite ou à gauche
    //	     Si la pièce est un Kitsune, elle peut se déplacer d'une case dans une des diagonales
    func estPossibleMouvement(partie : Partie, position : [Int]) -> Bool
    
    //Description : Détermine si le parachutage d'une pièce vers une position est possible
    //Données :  partie : Partie, position : [Int](2) correspondant à la position vers laquelle la pièce doit être déplacée (la nouvelle position)
    //Préconditions : positionPiece(p)==Vide
    //Résultat : Booléen, true si le mouvement correspond à la pièce, si la position existe et est inoccupée
    //	     false sinon
    func estParachutagePossible(partie : Partie, position : [Int]) -> Bool
    
    //Description : Déplace une pièce vers une autre position
    //Données : nouvellePos : [Int](2)
    //Préconditions : positionPiece(p)!=Vide
    //Résultat : La même pièce avec une nouvelle position si le mouvement est possible
    // Lance une erreur si le mouvement n'est pas possible 
    // Si la piece arrive sur une piece adverse (c'est pour ça qu'on a besoin de la partie), on capture la piece adverse (la partie renvoyée est la partie aprés le deplacement)
    // Si on capture le Koropokkuru adverse, on gagne la partie
    mutating func deplacerPiece(partie : Partie, nouvellePos : [Int]) throws -> Partie
    
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
    mutating func parachuter(partie : Partie, position : [Int]) throws -> Partie
    
    
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
    init(position : [Int], partie : Partie)
    
    //Description : Renvoie le type d'une pièce
    //Résultat : String, nom de la pièce
    //Post-conditions : Le résultat appartient à {Kodama, Kodama Samurai}
    func typePiece() -> String
    
    //Description : Détermine si un Kodama peut se déplacer dvers une position
    //Données : nouvellePos : [Int](2), partie : Partie
    //Préconditions : positionPiece(kodama)!=vide
    //Résultat : Booleen, true si le mouvement est possible c'est à dire si le mouvement  correspond au Kodama, et si la case existe et est inoccupée,
    // 	     false sinon
    //	     Un Kodama ne peut se déplacer que d'une case vers l'avant (vers la derniere ligne de son proprietaire),
    //       Un Kodama samuraï (transformé) peut se déplacer d'une case dans tous les sens sauf dans les diagonales arrières (vers l'opposé de la derniere ligne de son proprietaire)
    func estPossibleMouvement(nouvellePos : [Int], partie : Partie) -> Bool
    
    //Description : Déplace un Kodama vers une autre position, verifie si le kodama arrive a la derniere ligne de son proprietaire, et le transforme si c'est le cas
    //Données : nouvellePos : [Int](2), partie : Partie
    //Préconditions : positionPiece(k)!=Vide
    //Résultat : La même pièce avec une nouvelle position si le mouvement est possible
    // lance une erreur si le mouvement n'est pas possible
    mutating func deplacerPiece(partie : Partie, nouvellePos : [Int]) throws -> Partie
    
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

    internal var pos : [Int]?
    internal var nom : String
    internal var partie : TPartie
    internal var joueur : Int
    
    
    enum Erreur : Error {
        case mauvaisparametre
    }
    
    
    init(position : [Int], nom : String, partie : Partie) throws {
        guard position.count() == 2 && -1 < position[0] && position[0] < 4 && -1 < position[1] && position[1] < 3 && partie.EstLibre(pos : position)else{
            throw Erreur.mauvaisparametre
        }
        guard nom == "Koropokkuru" || nom == "Tanuki" || nom == "Kitsune" else {throw Erreur.mauvaisparametre}

        self.pos = position
        self.nom = nom
        self.partie = partie
        if position[0] == 0 || position[0] == 1 {
            self.joueur == 1
        }
        else {
            self.joueur == 2
        }
    }
    
    func typePiece() -> String{
        return self.nom
    }
    
    func positionPiece() -> [Int]?{
        return self.position
    }
    
    func proprietairePiece()->Int{
        return self.joueur
    }
    
    func estPossibleMouvement(partie : Partie, position : [Int]) -> Bool{
        if self.pos != nil && -1 < position[0] && position[0] < 4 && -1 < position[1] && position[1] < 3 && (partie.pieceAPosition(pos : position) == nil || partie.pieceAPosition(pos : position).proprietairePiece() != self.proprietairePiece()){
            if self.nom == "Kitsune"{ //peu importe le joueur les diagonales de la piece seront les mêmes
                if (self.pos[0]+1 == position[0] && self.pos[1]+1 == position[1]) || (self.pos[0]+1 == position[0] && self.pos[1]-1 == position[1]) || (self.pos[0]-1 == position[0] && self.pos[1]-1 == position[1]) || (self.pos[0]-1 == position[0] && self.pos[1]+1 == position[1]) {
                    return true
                }
                else {
                    return false
                }
            }
            else if self.nom == "Tanuki"{ // pareil peu importe le joueur les cases drtoite/gauche et avant/arriere seront les mêmes
                if (self.pos[0]+1 == position[0] && self.pos[1] == position[1]) || (self.pos[0]-1 == position[0] && self.pos[1] == position[1]) || (self.pos[0] == position[0] && self.pos[1]-1 == position[1]) || (self.pos[0] == position[0] && self.pos[1]+1 == position[1]) {
                    return true
                }
                else {
                    return false
                }
            }
            else { // c'est un Koropokkuru
                if (self.pos[0]+1 == position[0] && self.pos[1]+1 == position[1]) || (self.pos[0]+1 == position[0] && self.pos[1]-1 == position[1]) || (self.pos[0]-1 == position[0] && self.pos[1]-1 == position[1]) || (self.pos[0]-1 == position[0] && self.pos[1]+1 == position[1] || self.pos[0]+1 == position[0] && self.pos[1] == position[1]) || (self.pos[0]-1 == position[0] && self.pos[1] == position[1]) || (self.pos[0] == position[0] && self.pos[1]-1 == position[1]) || (self.pos[0] == position[0] && self.pos[1]+1 == position[1]) {
                    return true
                }
                else {
                    return false
                }
            }
        }
        else{
            return false
        }
    }
    
    func estParachutagePossible(partie : Partie, position : [Int]) -> Bool{
        if self.pos == nil && -1 < position[0] && position[0] < 4 && -1 < position[1] && position[1] < 3{
            if partie.pieceAPosition(pos : position) == nil {
                return true
            }
            else{
                return false
            }
        }
    }
    
    mutating func deplacerPiece(partie : Partie, nouvellePos : [Int]) throws -> Partie {
        guard self.pos != nil && self.estPossibleMouvement(partie : partie, position : nouvellePos) else{
            throw Erreur.mauvaisparametre
        }
        if partie.pieceAPosition(pos : position) == nil{
            self.pos = nouvellePos
        }
        else{
            partie.pieceAPosition(pos: position).etreCapturee()
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
    
    mutating func parachuter(partie : Partie, position : [Int]) throws -> Partie{
                guard self.pos != nil && self.estParachutagePossible(partie : partie, position : nouvellePos) else{
            throw Erreur.mauvaisparametre
        }
        self.pos = nouvellePos
        return partie
    }
    
    func estDansReserve() -> Bool {
        return self.pos == nil
    }
}

struct TKodama : TPiece {
    internal var pos : [Int]?
    internal var nom : String = "Kodama"
    internal var partie : TPartie
    internal var joueur : Int
    internal var trans : Bool = false


    init(position : [Int], partie : Partie) throws {
        guard position.count() == 2 && -1 < position[0] && position[0] < 4 && -1 < position[1] && position[1] < 3 && partie.EstLibre(pos : position)else{
            throw Erreur.mauvaisparametre
        }
        self.pos = position
        self.partie = partie
        if position[0] == 0 || position[0] == 1 {
            self.joueur == 1
        }
        else {
            self.joueur == 2
        }
    }

    func estPossibleMouvement(nouvellePos : [Int], partie : Partie) -> Bool{
        if self.pos != nil && -1 < position[0] && position[0] < 4 && -1 < position[1] && position[1] < 3 && partie.pieceAPosition(pos : position) == nil{
            if self.estTransforme(){
                if self.proprietairePiece() == 1 {
                    if (self.pos[0]+1 == position[0] && self.pos[1]+1 == position[1]) || (self.pos[0]+1 == position[0] && self.pos[1]-1 == position[1]) || (self.pos[0]+1 == position[0] && self.pos[1] == position[1]) || (self.pos[0]-1 == position[0] && self.pos[1] == position[1]) || (self.pos[0] == position[0] && self.pos[1]-1 == position[1]) || (self.pos[0] == position[0] && self.pos[1]+1 == position[1]) {
                        return true
                    }
                    else {
                        return false
                    }
                }
                else{
                    if (self.pos[0]-1 == position[0] && self.pos[1]+1 == position[1]) || (self.pos[0]-1 == position[0] && self.pos[1]-1 == position[1]) || self.pos[0]+1 == position[0] && self.pos[1] == position[1]) || (self.pos[0]-1 == position[0] && self.pos[1] == position[1]) || (self.pos[0] == position[0] && self.pos[1]-1 == position[1]) || (self.pos[0] == position[0] && self.pos[1]+1 == position[1]) {
                        return true
                    }
                    else{
                        return false
                    }
                }
            }
            else { // Kodama samuraï
                if self.proprietairePiece() == 1 {
                    if self.pos[0]+1 == position[0] && self.pos[1] == position[1] {
                        return true
                    }
                    else {
                        return false
                    }
                }
                else{
                    if self.pos[0]-1 == position[0] && self.pos[1] == position[1] {
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



    mutating func deplacerPiece(partie : Partie, nouvellePos : [Int]) throws -> Partie{
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
        if self.proprietairePiece() == 1 && nouvellePos[0] == 3{
            self.trans = true
        }
        else if self.proprietairePiece() == 2 && nouvellePos[0] == 0{
            self.trans = true
        }
    }

    func estTransforme()->Bool {
        return self.trans
    }

}














