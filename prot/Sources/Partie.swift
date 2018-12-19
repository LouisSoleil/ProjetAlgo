protocol Partie : Sequence {
    
    associatedtype TotalPieceIT : IteratorProtocol
    associatedtype PieceJIT : IteratorProtocol
    associatedtype Piece
    
    // Crée une partie :
    // post : La partie contient
    //		2 joueurs : 1 et 2
    // 		8 pieces (2 Kodama, 2 Kitsune, 2 Tanuki, 2 Kuropokkuru)  a leurs positions initiales (cf schema) et qui appartiennent au bon joueurs (1 et 2) Quand la partie est créée, elle n'est pas finie
    init()
    
    
    // Indique si la partie est finie(True) ou encore en cours (False)
    func PartieFini()-> Bool
    
    // Indique quel est le joueur actif actuel
    // post : retourne soit 1, soit 2 en fonction que le joueur soit le joueur 1 ou 2
    func joueurActif()->Int
    
    //Change le joueur actif : si c'etait le joueur 1, ça devient le joueur 2, et inversement
    mutating func changerTour()
    
    // Renvoie la piece a cette position s'il y en a une, Vide sinon
    // pre : Il s'agit d'une position : pos[0] est la ligne, entre 0 et 3, pos[1] est la colonne, entre 0 et 2, il n'y a que 2 arguments (ligne et colonne)
    // post : La piece est la piece a la position entrée
    func pieceAPosition(pos : [Int]) -> Piece?
    
    // Indique s'il y a une piece a cette position
    // pre : Il s'agit d'une position : pos[0] est la ligne, entre 0 et 3, pos[1] est la colonne, entre 0 et 2, il n'y a que 2 arguments (ligne et colonne)
    func EstLibre(pos : [Int])-> Bool
    
    // Iterateur : Renvoie le type Iterateur avec toutes les pieces de la partie dedans, pour un for i in Partie
    func makeIT()->TotalPieceIT
    
    // Iterateur avec un parametre :
    // pre : Il s'agit d'un joueur : soit 1, soit 2
    // post : renvoie l'iterateur qui ne parcourera que les pieces du joueur en entrée
    func pieceJIT(joueur : Int)-> PieceJIT
    
    // Renvoie la ligne considérée comme la derniere ligne du joueur en entrée
    // pre : Il s'agit d'un joueur : soit 1, soit 2
    // post : ligne d'arrivée / de promotion : celle d'en face du joueur en entrée => est soit 0, soit 3
    func derniereLigne(joueur : Int)-> Int
    
    // fait gagner la partie au joueur en entrée (change le resultat de partieFini a vrai)
    // pre : Il s'agit d'un joueur : soit 1, soit 2
    mutating func gagner(joueur : Int)
}
// structure de la partie : 


struct Partie {
    private var piece : Piece
    private var position : [Int]
    private var joueur : Int
    //private var pieces : [TPiece] =
    
    init(){
        var j1 : joueur = 1
        var j2 : joueur = 2
        var ko1 : piece = TPiece(position : [1,1], nom : Kodoma, partie : Self)
        var ko2 : piece = TPiece(position : [2,1], nom : Kodoma, partie : Self)
        var ki1 : piece = TPiece(position : [0,2], nom : Kitsune, partie : Self)
        var ki2 : piece = TPiece(position : [3,0], nom : Kitsune, partie : Self)
        var ta1 : piece = TPiece(position : [0,0], nom : Tanuki, partie : Self)
        var ta2 : piece = TPiece(position : [3,3], nom : Tanuki, partie : Self)
        var ku1 : piece = TPiece(position : [0,1], nom : Kuropokkuru, partie : Self)
        var ku2 : piece = TPiece(position : [3,1], nom : Kuropokkuru, partie : Self)
    }
    
    func PartieFini() -> Bool {
        var fin : Bool = false
        if ku1.proprietairePiece() == 2 || ku2.proprietairePiece() == 1 {
            return !fin
        }
        else if (self.joueurActif()==2 && ku1.positionPiece()[0] == 3){
            if changerTour() && (ku1.positionPiece()[0]) == 3{
                return !fin
            }
        }
        else if (self.joueurActif()==1 && ku2.positionPiece()[0] == 0){
            if changerTour() && (ku2.positionPiece()[0]) == 0{
                return !fin
            }
        }
    }
    
    mutating func joueurActif(){
        
    }
    
    mutating func changerTour() {
        if self.joueurActif()==1{
            return 2
        }
        else {
            return 1
        }
    }

    func pieceAPosition(pos : [Int]) -> Piece?{
        if ko1.positionPiece() == pos {
            return ko1
        }
        else if ko2.positionPiece() == pos {
            return ko2
        }
        else if ki1.positionPiece() == pos{
            return ki1
        }
        else if ki2.positionPiece() == pos{
            return ki2
        }
        else if ta1.positionPiece() == pos{
            return ta1
        }
        else if ta2.positionPiece() == pos{
            return ta2
        }
        else if ku1.positionPiece() == pos{
            return ku1
        }
        else if ku2.positionPiece() == pos{
            return ku2
        }
        else {
            return nil
        }
    }
    
    func Est_libre(pos : [Int]) -> Bool{
        return self.pieceAPosition(pos) == nil
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
        if ku1 == 2 {
            print("le joueur 2 a gagné")
            self.PartieFini()
        }
        if ku2 == 1 {
            print("le joueur 2 a gagné")
            self.PartieFini()
        }
    }
    
    func makeIT() -> TotalPieceIT{
        return TotalPieceIT(partie : self)
    }
    
    func pieceJIT(joueur : Int)-> PieceJIT{
        return pieceJIT(joueur, partie : self)
        }
        
}
