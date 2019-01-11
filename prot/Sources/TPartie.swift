struct TPartie : Partie {
    typealias TPiece = TPiece
    typealias ItTotalPieceIT = ItTotalPieceIT
    typealias TPieceJIT = TPieceJIT
    
    
    
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
            try self.ko1 = TPiece(position : [1,1], nom : "Kodoma", partie : self)}
        catch {
        }
        do {
            try self.ko2 = TPiece(position : [2,1], nom : "Kodoma", partie : self)}
        catch {
        }
        do {
            try self.ki1 = TPiece(position : [0,2], nom : "Kitsune", partie : self)}
        catch {
        }
        do{
            try self.ki2 = TPiece(position : [3,0], nom : "Kitsune", partie : self)}
        catch {
        }
        do{
            try self.ta1 = TPiece(position : [0,0], nom : "Tanuki", partie : self)}
        catch {
        }
        do{
            try self.ta2 = TPiece(position : [3,3], nom : "Tanuki", partie : self)}
        catch {
        }
        do{
            try self.ku1 = TPiece(position : [0,1], nom : "Kuropokkuru", partie : self)}
        catch {
        }
        do{
            try self.ku2 = TPiece(position : [3,1], nom : "Kuropokkuru", partie : self)}
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
