
protocol TotalPieceIT : IteratorProtocol{
    
    associatedtype TPiece
    associatedtype TPartie


    //crée un iterateur avec toutes les pieces de la partie
    init(partie : TPartie)
    
    //Iterator Next : parcourt toutes les pieces de la partie : renvoit la piece courante et passe a la piece suivante
    mutating func next()->TPiece?
}

struct ItTotalPieceIT : TotalPieceIT {
    
    internal var pieces : [TPiece]
    internal var courant : TPiece?
    
    init(partie : TPartie){
        self.pieces = [partie.ko1, partie.ko2, partie.ki1, partie.ki2, partie.ta1, partie.ta2, partie.ku1, partie.ku2]
        self.courant = partie.ko1
    }
    
    mutating func next()->TPiece?{
        if !self.courant == nil{
            var t = true
            var i = 0
            while t {
                if i == 7{
                    self.courant = nil
                    t = false
                }
                else if self.courant == self.pieces[i] {
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
