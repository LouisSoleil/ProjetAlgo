protocol AttPartie {
    associatedtype SItTotalPieceIT = TotalPieceIT
    associatedtype SPieceJIT = PieceJIT
    associatedtype SPiece = Piece
    associatedtype SKodoma = Kodama

    // Renvoie la piece a cette position s'il y en a une, Vide sinon
    // pre : Il s'agit d'une position : pos[0] est la ligne, entre 0 et 3, pos[1] est la colonne, entre 0 et 2, il n'y a que 2 arguments (ligne et colonne)
    // post : La piece est la piece a la position entrée
    func pieceAPosition(pos : [Int]) -> SPiece?
    // Iterateur : Renvoie le type Iterateur avec toutes les pieces de la partie dedans, pour un for i in Partie
    func makeIT()->SItTotalPieceIT

    // Iterateur avec un parametre :
    // pre : Il s'agit d'un joueur : soit 1, soit 2
    // post : renvoie l'iterateur qui ne parcourera que les pieces du joueur en entrée
    func pieceJIT(joueur : Int)-> SPieceJIT


}
protocol Partie {


    // Crée une partie :
    // post : La partie contient
    //      2 joueurs : 1 et 2
    //      8 pieces (2 Kodama, 2 Kitsune, 2 Tanuki, 2 Kuropokkuru)  a leurs positions initiales (cf schema) et qui appartiennent au bon joueurs (1 et 2) Quand la partie est créée, elle n'est pas finie
    init()


    // Indique si la partie est finie(True) ou encore en cours (False)
    func partieFini()-> Bool

    // Indique quel est le joueur actif actuel
    // post : retourne soit 1, soit 2 en fonction que le joueur soit le joueur 1 ou 2
    func joueurActif() -> Int

    //Change le joueur actif : si c'etait le joueur 1, ça devient le joueur 2, et inversement
    mutating func changerTour()


    // Indique s'il y a une piece a cette position
    // pre : Il s'agit d'une position : pos[0] est la ligne, entre 0 et 3, pos[1] est la colonne, entre 0 et 2, il n'y a que 2 arguments (ligne et colonne)
    func Est_libre(pos : [Int])-> Bool


    // Renvoie la ligne considérée comme la derniere ligne du joueur en entrée
    // pre : Il s'agit d'un joueur : soit 1, soit 2
    // post : ligne d'arrivée / de promotion : celle d'en face du joueur en entrée => est soit 0, soit 3
    func derniereLigne(joueur : Int)-> Int

    // fait gagner la partie au joueur en entrée (change le resultat de partieFini a vrai)
    // pre : Il s'agit d'un joueur : soit 1, soit 2
    mutating func gagner(joueur : Int)
}
