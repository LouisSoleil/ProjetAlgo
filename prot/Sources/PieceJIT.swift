
protocol PieceJIT : IteratorProtocol{
    
    associatedtype TPiece
    associatedtype TPartie
    
    // Crée l'iterateur avec les pieces du joueur en entrée
    //    pre : joueur == 1 ou joueur == 2 
    init(joueur : Int, partie : TPartie)
    
    // Iterator Next : parcourt les pieces du joueur en entrée : renvoit la piece courante et passe a la piece suivante
    mutating func next()->TPiece?
}

struct TPieceJIT : PieceJIT {
    
    internal var pieces : [TPiece]
    internal var courant : TPiece?
    internal var pieceJ : [Tpiece]
    
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
