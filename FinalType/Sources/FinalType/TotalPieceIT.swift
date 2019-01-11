protocol TotalPieceIT : IteratorProtocol{
    
    associatedtype SPiece = Piece
    associatedtype SPartie = Partie


    //crée un iterateur avec toutes les pieces de la partie
    init(partie : SPartie)
    
    //Iterator Next : parcourt toutes les pieces de la partie : renvoit la piece courante et passe a la piece suivante
    mutating func next()->SPiece?
}
