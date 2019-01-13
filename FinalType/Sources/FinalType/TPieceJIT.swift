public struct TPieceJIT{
    typealias SPartie = TPartie
    typealias SPiece = TPiece
    
    internal var pieces : [TPiece] = []
    internal var courant : TPiece?
    
    init (joueur : Int, partie : TPartie) {
        var p : [TPiece] = [partie.ko1,partie.ko2,partie.ki1,partie.ki2,partie.ta1,partie.ta2,partie.ku1,partie.ku2]
        for i in p {
            if i.proprietairePiece() == joueur {
                self.pieces.append(i)
                self.courant = pieces[0]
            }
        }
    }
    
    public mutating func next()->TPiece?{
        if let courant = self.courant{
            var t : Bool = true
            var i : Int = 0
            var piece : TPiece = self.courant!
            while t {
                if i == self.pieces.count - 1{
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
            return piece
        }
        else{
            return nil
        }
    }
}
