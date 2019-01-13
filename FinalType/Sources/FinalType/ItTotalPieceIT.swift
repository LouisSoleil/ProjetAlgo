public struct ItTotalPieceIT {
    typealias SPiece = TPiece
    typealias SPartie = TPartie
    
    internal var pieces : [TPiece]
    internal var courant : TPiece?
    
    init(partie : TPartie){
        self.pieces = [partie.ko1,partie.ko2,partie.ki1,partie.ki2,partie.ta1,partie.ta2,partie.ku1,partie.ku2]
        self.courant = partie.ko1
    }
    
    public mutating func next()->TPiece?{
        if let courant = self.courant{
            var t = true
            var i = 0
            var piece : TPiece = self.courant!
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
            return piece
        }
        return self.courant
    }
}
