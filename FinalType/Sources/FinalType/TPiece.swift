
public struct TPiece : Piece{
    
    typealias SPartie = TPartie
    
    internal var pos : [Int]?
    internal var nom : String
    internal var joueur : Int
    internal var trans : Bool

    
    
    enum Erreur : Error {
        case mauvaisparametre
    }
    
    
    public init(position : [Int], nom : String) throws {
        guard position.count == 2 && -1 < position[0] && position[0] < 4 && -1 < position[1] && position[1] < 3 else{
            throw Erreur.mauvaisparametre
        }
        guard nom == "Koropokkuru" || nom == "Tanuki1" || nom == "Kitsune1" || nom == "Kodama1" || nom == "Tanuki2" || nom == "Kitsune2" || nom == "Kodama2"else {throw Erreur.mauvaisparametre}
        
        self.pos = position
        self.nom = nom
        if position[0] == 0 || position[0] == 1 {
            self.joueur = 1
        }
        else {
            self.joueur = 2
        }
        self.trans = false
    }
    
    public func typePiece() -> String{
        return self.nom
    }
    
    public func positionPiece() -> [Int]?{
        return self.pos
    }
    
    public func proprietairePiece()->Int{
        return self.joueur
    }
    
    public func estPossibleMouvement(partie : TPartie, position : [Int]) -> Bool{
        if var positionPiece = partie.pieceAPosition(pos : position) {
            if (self.pos != nil) && (-1 < position[0]) && (position[0] < 4) && (-1 < position[1]) && (position[1] < 3) && (partie.pieceAPosition(pos : position)!.proprietairePiece() != self.proprietairePiece()){
                if self.nom == "Kitsune1" || self.nom == "Kitsune2"{ //peu importe le joueur les diagonales de la piece seront les mêmes
                    return (self.pos![0]+1 == position[0] && self.pos![1]+1 == position[1]) || (self.pos![0]+1 == position[0] && self.pos![1]-1 == position[1]) || (self.pos![0]-1 == position[0] && self.pos![1]-1 == position[1]) || (self.pos![0]-1 == position[0] && self.pos![1]+1 == position[1])
                }
                else if self.nom == "Tanuki1" || self.nom == "Tanuki2"{ // pareil peu importe le joueur les cases drtoite/gauche et avant/arriere seront les mêmes
                    return (self.pos![0]+1 == position[0] && self.pos![1] == position[1]) || (self.pos![0]-1 == position[0] && self.pos![1] == position[1]) || (self.pos![0] == position[0] && self.pos![1]-1 == position[1]) || (self.pos![0] == position[0] && self.pos![1]+1 == position[1])
                }
                else if self.nom == "Kodama1" || self.nom == "Kodama2"{
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
                else { // c'est un Koropokkuru
                    return (self.pos![0]+1 == position[0] && self.pos![1]+1 == position[1]) || (self.pos![0]+1 == position[0] && self.pos![1]-1 == position[1]) || (self.pos![0]-1 == position[0] && self.pos![1]-1 == position[1]) || (self.pos![0]-1 == position[0] && self.pos![1]+1 == position[1]) || (self.pos![0]+1 == position[0] && self.pos![1] == position[1]) || (self.pos![0]-1 == position[0] && self.pos![1] == position[1]) || (self.pos![0] == position[0] && self.pos![1]-1 == position[1]) || (self.pos![0] == position[0] && self.pos![1]+1 == position[1])
                }
            }
            else{
                return false
            }
        }
        else{
            if (self.pos != nil) && (-1 < position[0]) && (position[0] < 4) && (-1 < position[1]) && (position[1] < 3){
                if self.nom == "Kitsune1" || self.nom == "Kitsune2"{ //peu importe le joueur les diagonales de la piece seront les mêmes
                    return (self.pos![0]+1 == position[0] && self.pos![1]+1 == position[1]) || (self.pos![0]+1 == position[0] && self.pos![1]-1 == position[1]) || (self.pos![0]-1 == position[0] && self.pos![1]-1 == position[1]) || (self.pos![0]-1 == position[0] && self.pos![1]+1 == position[1])
                }
                else if self.nom == "Tanuki1" || self.nom == "Tanuki2"{ // pareil peu importe le joueur les cases drtoite/gauche et avant/arriere seront les mêmes
                    return (self.pos![0]+1 == position[0] && self.pos![1] == position[1]) || (self.pos![0]-1 == position[0] && self.pos![1] == position[1]) || (self.pos![0] == position[0] && self.pos![1]-1 == position[1]) || (self.pos![0] == position[0] && self.pos![1]+1 == position[1])
                }
                else if self.nom == "Kodama1" || self.nom == "Kodama2"{
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
                else { // c'est un Koropokkuru
                    return (self.pos![0]+1 == position[0] && self.pos![1]+1 == position[1]) || (self.pos![0]+1 == position[0] && self.pos![1]-1 == position[1]) || (self.pos![0]-1 == position[0] && self.pos![1]-1 == position[1]) || (self.pos![0]-1 == position[0] && self.pos![1]+1 == position[1]) || (self.pos![0]+1 == position[0] && self.pos![1] == position[1]) || (self.pos![0]-1 == position[0] && self.pos![1] == position[1]) || (self.pos![0] == position[0] && self.pos![1]-1 == position[1]) || (self.pos![0] == position[0] && self.pos![1]+1 == position[1])
                }
            }
            else{
                return false
            }
        }
    }
    
    public func estParachutagePossible(partie : TPartie, position : [Int]) -> Bool{
        if self.pos == nil && -1 < position[0] && position[0] < 4 && -1 < position[1] && position[1] < 3{
            if partie.pieceAPosition(pos : position) == nil {
                return true
            }
            else{
                return false
            }
        }
        else {
            return false
        }
    }
    
    public mutating func deplacerPiece(partie : inout TPartie, nouvellePos : [Int]) throws -> TPartie {
        guard self.pos != nil && self.estPossibleMouvement(partie : partie, position : nouvellePos) else{
            throw Erreur.mauvaisparametre
        }
        if partie.pieceAPosition(pos : nouvellePos) == nil{
            self.pos = nouvellePos
        }
        else{
            var piece = partie.pieceAPosition(pos : nouvellePos)!
            if piece.nom == "Koropokkuru"{ // on fait gagner la partie au joueur actif
                partie.gagner(joueur : partie.joueurActif())
            }
            do{
                try piece.etreCapturee()}
            catch {
            }
            self.pos = nouvellePos
            if (self.nom == "Kodama1" || self.nom == "Kodama2") && self.proprietairePiece() == 1 && nouvellePos[0] == 3{
                self.trans = true
            }
            else if (self.nom == "Kodama1" || self.nom == "Kodama2") && self.proprietairePiece() == 2 && nouvellePos[0] == 0{
                self.trans = true
            }
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
        if self.nom == "Kodama1" || self.nom == "Kodama2"{
            if self.estTransforme() {
                self.trans = false
            }
        }
    }
    
    public mutating func parachuter(partie : TPartie, position : [Int]) throws -> TPartie{
        guard self.pos != nil && self.estParachutagePossible(partie : partie, position : position) else{
            throw Erreur.mauvaisparametre
        }
        self.pos = position
        return partie
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
    
    public func estTransforme()->Bool {
        return self.trans
    }
    
    public func estDansReserve() -> Bool {
        return self.pos == nil
    }

    public mutating func changerPosition(pos : [Int]){
        self.pos = pos
    }
}

/*struct TKodama{
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
 */