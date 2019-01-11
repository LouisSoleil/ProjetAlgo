public struct TPartie : Partie, AttPartie {
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
    public var tableau : [TPiece]
    
    
    public init() {
        do{
            try! self.ko1 = TPiece(position : [1,1], nom : "Kodama")}
        catch {
        }
        do {
            try! self.ko2 = TPiece(position : [2,1], nom : "Kodama")}
        catch {
        }
        do {
            try! self.ki1 = TPiece(position : [0,2], nom : "Kitsune")}
        catch {
        }
        do{
            try! self.ki2 = TPiece(position : [3,0], nom : "Kitsune")}
        catch {
        }
        do{
            try! self.ta1 = TPiece(position : [0,0], nom : "Tanuki")}
        catch {
        }
        do{
            try! self.ta2 = TPiece(position : [3,2], nom : "Tanuki")}
        catch {
        }
        do{
            try! self.ku1 = TPiece(position : [0,1], nom : "Koropokkuru")}
        catch {
        }
        do{
            try! self.ku2 = TPiece(position : [3,1], nom : "Koropokkuru")}
        catch {
        }
        self.joueurA = 1 //Int(arc4random_uniform(UInt32(2)))+
        self.tableau = [self.ko1,self.ko2,self.ki1,self.ki2,self.ta1,self.ta2,self.ku1,self.ku2]
    }
    
    public func partieFini() -> Bool {
        var fin : Bool = false
        if self.ku1.proprietairePiece() == 2 || self.ku2.proprietairePiece() == 1 {
            return !fin
        }
        else if self.ko1.estPossibleMouvement(partie : self, position : self.ku1.positionPiece()!){
            return !fin
        }
        else if self.ko2.estPossibleMouvement(partie : self, position : self.ku1.positionPiece()!){
            return !fin
        }
        else if self.ki1.estPossibleMouvement(partie : self, position : self.ku1.positionPiece()!){
            return !fin
        }
        else if self.ki2.estPossibleMouvement(partie : self, position : self.ku1.positionPiece()!){
            return !fin
        }
        else if self.ta1.estPossibleMouvement(partie : self, position : self.ku1.positionPiece()!){
            return !fin
        }
        else if self.ta2.estPossibleMouvement(partie : self, position : self.ku1.positionPiece()!){
            return !fin
        }
        else if self.ku2.estPossibleMouvement(partie : self, position : self.ku1.positionPiece()!){
            return !fin
        }
        else if self.ko1.estPossibleMouvement(partie : self, position : self.ku2.positionPiece()!){
            return !fin
        }
        else if self.ko2.estPossibleMouvement(partie : self, position : self.ku2.positionPiece()!){
            return !fin
        }
        else if self.ki1.estPossibleMouvement(partie : self, position : self.ku2.positionPiece()!){
            return !fin
        }
        else if self.ki2.estPossibleMouvement(partie : self, position : self.ku2.positionPiece()!){
            return !fin
        }
        else if self.ta1.estPossibleMouvement(partie : self, position : self.ku2.positionPiece()!){
            return !fin
        }
        else if self.ta2.estPossibleMouvement(partie : self, position : self.ku2.positionPiece()!){
            return !fin
        }
        else if self.ku1.estPossibleMouvement(partie : self, position : self.ku2.positionPiece()!){
            return !fin
        }
        else {
            return fin
        }
    }
    
    public func joueurActif() -> Int{
        if self.joueurA == 1 {
            return 1
        }
        else {
            return 2
        }
    }
    
    public mutating func changerTour() {
        if self.joueurActif()==1{
            self.joueurA = 2
        }
        else {
            self.joueurA = 1
        }
    }
    
    public func pieceAPosition(pos : [Int]) -> TPiece?{
        if let position = self.ko1.positionPiece(){
            if self.ko1.positionPiece()! == pos {
                return self.ko1
            }
        }
        if let position = self.ko2.positionPiece(){
            if self.ko2.positionPiece()! == pos {
                return self.ko2
            }
         }
        if let position = self.ki1.positionPiece(){
            if self.ki1.positionPiece()! == pos{
                return self.ki1
            }
         }
        if let position = self.ki2.positionPiece(){
            if self.ki2.positionPiece()! == pos{
                return self.ki2
            }
         }
        if let position = self.ta1.positionPiece(){
            if self.ta1.positionPiece()! == pos{
                return self.ta1
            } 
        }
        if let position = self.ta2.positionPiece(){
            if self.ta2.positionPiece()! == pos{
                return self.ta2
            } 
        }
        if let position = self.ku1.positionPiece(){
            if self.ku1.positionPiece()! == pos{
                return self.ku1
            } 
        }
        if let position = self.ku2.positionPiece(){
            if self.ku2.positionPiece()! == pos{
                return self.ku2
            } 
        }
        return nil
    }
    
    func Est_libre(pos : [Int]) -> Bool{
        return self.pieceAPosition(pos : pos) == nil
    }
    
    public func pieceJIT(joueur : Int) -> TPieceJIT{
        return TPieceJIT(joueur : joueur, partie : self)
    }
    
    public func makeIT() -> ItTotalPieceIT{
        return ItTotalPieceIT (partie : self)
    }
    
    public func derniereLigne(joueur : Int) -> Int{
        if joueur == 1 {
            return 3
        }
        else {
            return 0
        }
    }
    
    public mutating func gagner(joueur :Int){
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
