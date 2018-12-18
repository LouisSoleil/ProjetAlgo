
protocol TotalPieceIT : IteratorProtocol{
    
    associatedtype Piece

    //crée un iterateur avec toutes les pieces de la partie
    init()
    
    //Iterator Next : parcourt toutes les pieces de la partie : renvoit la piece courante et passe a la piece suivante
    mutating func next()->Piece?
}
