//fichier avec toutes les class et le main

import Foundation
//import prot


struct TPartie {
    internal var ko1 : TPiece
    internal var ko2 : TPiece
    internal var ki1 : TPiece
    internal var ki2 : TPiece
    internal var ta1 : TPiece
    internal var ta2 : TPiece
    internal var ku1 : TPiece
    internal var ku2 : TPiece
    internal var joueurA : Int
    //private var pieces : [TPiece] =
    
    init(){
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
    }
    
    func PartieFini() -> Bool {
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
            self.PartieFini()
        }
        else{
            print("le joueur 1 a gagné")
            self.PartieFini()
        }
    }
}
    struct ItTotalPieceIT {
    
    internal var pieces : [TPiece]
    internal var courant : TPiece?
    
    init(partie : TPartie){
        self.pieces = [partie.ko1, partie.ko2, partie.ki1, partie.ki2, partie.ta1, partie.ta2, partie.ku1, partie.ku2]
        self.courant = partie.ko1
    }
    
    mutating func next()->TPiece?{
        if let courant = self.courant{
            var t = true
            var i = 0
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
        }
        return self.courant
    }
}
struct TPiece{

    internal var pos : [Int]?
    internal var nom : String
    internal var partie : TPartie
    internal var joueur : Int
    
    
    enum Erreur : Error {
        case mauvaisparametre
    }
    
    
    init(position : [Int], nom : String, partie : TPartie) throws {
        guard position.count == 2 && -1 < position[0] && position[0] < 4 && -1 < position[1] && position[1] < 3 && partie.Est_libre(pos : position)else{
            throw Erreur.mauvaisparametre
        }
        guard nom == "Koropokkuru" || nom == "Tanuki" || nom == "Kitsune" else {throw Erreur.mauvaisparametre}

        self.pos = position
        self.nom = nom
        self.partie = partie
        if position[0] == 0 || position[0] == 1 {
            self.joueur = 1
        }
        else {
            self.joueur = 2
        }
    }
    
    func typePiece() -> String{
        return self.nom
    }
    
    func positionPiece() -> [Int]?{
        return self.pos
    }
    
    func proprietairePiece()->Int{
        return self.joueur
    }
    
    func estPossibleMouvement(partie : TPartie, position : [Int]) -> Bool{
        if let positionPiece = partie.pieceAPosition(pos : position) {
            if (self.pos != nil) && (-1 < position[0]) && (position[0] < 4) && (-1 < position[1]) && (position[1] < 3) && (partie.pieceAPosition(pos : position)!.proprietairePiece() != self.proprietairePiece()){
                if self.nom == "Kitsune"{ //peu importe le joueur les diagonales de la piece seront les mêmes
                    return (self.pos![0]+1 == position[0] && self.pos![1]+1 == position[1]) || (self.pos![0]+1 == position[0] && self.pos![1]-1 == position[1]) || (self.pos![0]-1 == position[0] && self.pos![1]-1 == position[1]) || (self.pos![0]-1 == position[0] && self.pos![1]+1 == position[1])
                }
            }
            else if self.nom == "Tanuki"{ // pareil peu importe le joueur les cases drtoite/gauche et avant/arriere seront les mêmes
                return (self.pos![0]+1 == position[0] && self.pos![1] == position[1]) || (self.pos![0]-1 == position[0] && self.pos![1] == position[1]) || (self.pos![0] == position[0] && self.pos![1]-1 == position[1]) || (self.pos![0] == position[0] && self.pos![1]+1 == position[1])
            }
            else { // c'est un Koropokkuru
                return (self.pos![0]+1 == position[0] && self.pos![1]+1 == position[1]) || (self.pos![0]+1 == position[0] && self.pos![1]-1 == position[1]) || (self.pos![0]-1 == position[0] && self.pos![1]-1 == position[1]) || (self.pos![0]-1 == position[0] && self.pos![1]+1 == position[1]) || (self.pos![0]+1 == position[0] && self.pos![1] == position[1]) || (self.pos![0]-1 == position[0] && self.pos![1] == position[1]) || (self.pos![0] == position[0] && self.pos![1]-1 == position[1]) || (self.pos![0] == position[0] && self.pos![1]+1 == position[1])
            }
        }
        else{
            return false
        }
    }
    
    func estParachutagePossible(partie : TPartie, position : [Int]) -> Bool{
        if self.pos == nil && -1 < position[0] && position[0] < 4 && -1 < position[1] && position[1] < 3{
            if partie.pieceAPosition(pos : position) == nil {
                return true
            }
            else{
                return false
            }
        }
    }
    
    mutating func deplacerPiece(partie : TPartie, nouvellePos : [Int]) throws -> TPartie {
        guard self.pos != nil && self.estPossibleMouvement(partie : partie, position : nouvellePos) else{
            throw Erreur.mauvaisparametre
        }
        if partie.pieceAPosition(pos : nouvellePos) == nil{
            self.pos = nouvellePos
        }
        else{
            var piece = partie.pieceAPosition(pos : nouvellePos)!
            do{
                try piece.etreCapturee()}
            catch {
            }
            self.pos = nouvellePos
        }
        return partie
    }
    
    mutating func etreCapturee() throws{
        guard self.pos != nil else{
            throw Erreur.mauvaisparametre
        }
        if self.joueur == 1 {
            self.joueur = 2
        }
        else{
            self.joueur = 1
        }
        self.pos = nil
    }
    
    mutating func parachuter(partie : TPartie, position : [Int]) throws -> TPartie{
                guard self.pos != nil && self.estParachutagePossible(partie : partie, position : position) else{
            throw Erreur.mauvaisparametre
        }
        self.pos = position
        return partie
    }
    
    func estDansReserve() -> Bool {
        return self.pos == nil
    }
}

struct TKodama : TPiece {
    internal var pos : [Int]?
    internal var nom : String = "Kodama"
    internal var partie : TPartie
    internal var joueur : Int
    internal var trans : Bool = false

    enum Erreur : Error {
        case mauvaisparametre
    }


    init(position : [Int], partie : TPartie) throws {
        guard position.count == 2 && -1 < position[0] && position[0] < 4 && -1 < position[1] && position[1] < 3 && partie.Est_libre(pos : position)else{
            throw Erreur.mauvaisparametre
        }
        self.pos = position
        self.partie = partie
        if position[0] == 0 || position[0] == 1 {
            self.joueur = 1
        }
        else {
            self.joueur = 2
        }
    }

    func estPossibleMouvement(partie : TPartie, position : [Int]) -> Bool{
        if self.pos != nil && -1 < position[0] && position[0] < 4 && -1 < position[1] && position[1] < 3 && partie.pieceAPosition(pos : position) == nil{
            if self.estTransforme(){
                if self.proprietairePiece() == 1 {
                    if (self.pos![0]+1 == position[0] && self.pos![1]+1 == position[1]) || (self.pos![0]+1 == position[0] && self.pos![1]-1 == position[1]) || (self.pos![0]+1 == position[0] && self.pos![1] == position[1]) || (self.pos![0]-1 == position[0] && self.pos![1] == position[1]) || (self.pos![0] == position[0] && self.pos![1]-1 == position[1]) || (self.pos![0] == position[0] && self.pos![1]+1 == position[1]) {
                        return true
                    }
                    else {
                        return false
                    }
                }
                else{
                    if (self.pos![0]-1 == position[0] && self.pos![1]+1 == position[1]) || (self.pos![0]-1 == position[0] && self.pos![1]-1 == position[1]) || (self.pos![0]+1 == position[0] && self.pos![1] == position[1]) || (self.pos![0]-1 == position[0] && self.pos![1] == position[1]) || (self.pos![0] == position[0] && self.pos![1]-1 == position[1]) || (self.pos![0] == position[0] && self.pos![1]+1 == position[1]) {
                        return true
                    }
                    else{
                        return false
                    }
                }
            }
            else { // Kodama samuraï
                if self.proprietairePiece() == 1 {
                    if self.pos![0]+1 == position[0] && self.pos![1] == position[1] {
                        return true
                    }
                    else {
                        return false
                    }
                }
                else{
                    if self.pos![0]-1 == position[0] && self.pos![1] == position[1] {
                        return true
                    }
                    else {
                        return false
                    }
                }
            }
        }
        else {
            return false
        }
    }



    mutating func deplacerPiece(partie : TPartie, nouvellePos : [Int]) throws -> TPartie{
        guard self.pos != nil && self.estPossibleMouvement(partie : partie, position : nouvellePos) else{
            throw Erreur.mauvaisparametre
        }
        self.pos = nouvellePos
        if self.proprietairePiece() == 1 && nouvellePos[0] == 3{
            self.trans = true
        }
        else if self.proprietairePiece() == 2 && nouvellePos[0] == 0{
            self.trans = true
        }
        return partie
    }


    mutating func etreCapturee() throws{
        guard self.pos != nil else{
            throw Erreur.mauvaisparametre
        }
        if self.joueur == 1 {
            self.joueur = 2
        }
        else{
            self.joueur = 1
        }
        self.pos = nil
        if self.estTransforme() {
            self.trans = false
        }
    }

    mutating func transformer() throws{
        guard !self.trans else{
            throw Erreur.mauvaisparametre
        } 
        if self.proprietairePiece() == 1 && pos[0] == 3{
            self.trans = true
        }
        else if self.proprietairePiece() == 2 && pos[0] == 0{
            self.trans = true
        }
    }

    func estTransforme()->Bool {
        return self.trans
    }
}
struct TPieceJIT{
    
    internal var pieces : [TPiece]
    internal var courant : TPiece?
    internal var pieceJ : [TPiece]
    
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
        if let courant = self.courant{
            var t = true
            var i = 0
            while t {
                if i == 7{
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
        }
        return self.courant
    }
}

/*func main(){
    // Programme principal
    var p : TPartie = Partie() // init : Demarrer la partie
    
    
    while !(p.partieFinie()) {
        // affiche l'etat du jeu
        print("tour du joueur \(p.joueurActif())")
        var str : String = ""
        for i in 0...3 {
            for j in 0...2 {
                if let t = p.PieceAPosition(pos : [i,j]){
                    str += t.typePiece()
                }else{
                    str += " CASE VIDE "
                }
            }
            print(str)
            str=""
        }
        var str2 : String
        for piece in p{ // utilise iterateur normal sur toutes les pieces
            if piece.estDansReserve(){
                if piece.proprietaire()==1{
                    str+=piece.typePiece()
                }else{
                    str2+=piece.typePiece()
                }
            }
        }
        print("Reserve J1 \n"+str+"\n Reserve J2 \n"+str2)
        
        // Choix de l'action du joueur
        
        var repV : Bool  = false
        var pChoisie : TPiece?
        var posChoisie : [Int]?
        
        
        while !repV {
            
            print("Joueur \(p.joueurActif()), choisis si tu (p)arachute ou (d)eplace une piece")
            
            if let entree = readLine(){
                if entree == "p"{
                    //parachuter
                    
                    print("Choisis la piece a parachuter")
                    
                    // on parcourt les pieces de la reserve de JActif
                    var it : TPiecesJIT = p.piecesJIT(joueur : p.joueurActif())
                    
                    while let piece=it.next() && !repV{
                        if piece.estDansReserve(){
                            
                            // Choix de la piece ou pas
                            print("Choisis un \(piece.typePiece()) ? y/n")
                            if let entree = readLine(){
                                if entree == "y"{// s'il choisi cette piece
                                    print("Choisis la ligne a parachuter")
                                    if let entree = readLine(){
                                        if let posLigne = Int(entree){
                                            print("Choisis la colonne a parachuter")
                                            
                                            if let entree = readLine(){
                                                if let posCol = Int(entree){
                                                    if piece.estParachutagePossible(partie : p, position : [posLigne,posCol]){
                                                        
                                                        pChoisie = piece
                                                        posChoisie = [posLigne, posCol]
                                                        repV = true
                                                    } else {
                                                        print("Il n'est pas possible de parachuter a cet endroit")
                                                    }
                                                }else{
                                                    print("Il fallait ecrire un entier!")
                                                }
                                            }
                                            
                                        }else{
                                            print("Il fallait ecrire un entier!")
                                        }
                                    }
                                }
                            }
                        }
                    }
                    
                } else if entree == "d" { // deplacer
                    
                    print("Choisis la piece a deplacer")
                    
                    // on parcourt les pieces de la reserve de JActif
                    var it : TPiecesJIT = p.piecesJIT(joueur : p.joueurActif())
                    while let piece = it.next() && !repV{
                        if let pos = piece.position(){
                            
                            // Choix de la piece ou pas
                            print("Deplacer le \(piece.typePiece()) placee a \(pos) ? y/n")
                            if let entree = readLine(){
                                if entree == "y"{// s'il choisi cette piece
                                    print("Choisis la ligne d'arrivee du deplacement")
                                    if let entree = readLine(){
                                        if let posLigne = Int(entree){
                                            print("Choisis la colonne d'arrivee du deplacement")
                                            
                                            if let entree = readLine(){
                                                if let posCol = Int(entree){
                                                    if piece.estPossibleMouvement(partie : p, position : [posLigne,posCol]){
                                                        
                                                        pChoisie = piece
                                                        posChoisie = [posLigne, posCol]
                                                        repV = true
                                                    } else {
                                                        print("Il n'est pas possible de deplacer cette piece a cet endroit")
                                                    }
                                                }else{ 
                                                    print("Il fallait ecrire un entier!")
                                                }
                                            }
                                            
                                        }else{ 
                                            print("Il fallait ecrire un entier!")
                                        }
                                    }
                                }
                            }
                        }
                    }
                } else {
                    print("ecrit p pour parachuter ou d pour deplacer une piece du plateau")
                }
            } else { // si pas de readLine
                print("Ecrit quelque chose !")
            }
        } // si on arrive ici (on sort du while), pChoisie et posChoisie ont une valeur
        
        
        // Action principale du tour
        if let pChoisie = pChoisie{
            if let posChoisie = posChoisie{
                
                if !pChoisie.estDansReserve(){// si c'est un deplacement
                    p = pChoisie.deplacerPiece(partie : p, nouvellePos : posChoisie) // on considere la capture comme un deplacement (on peut gagner la partie ici)
                }else{// si c'est un parachutage
                    p = pChoisie.parachuter(partie : p, position : posChoisie)
                }
            }
        }
        
        if p.partieFinie(){
        
            print("Le joueur \(p.joueurActif()) gagne la partie")
            
        }
        
        
        p.changerTour() // change le joueur actif
        
        
        //Le joueur gagne si son roi est dans la derniere ligne au debut de son tour (s'il met son roi dans la derniere ligne et ne se fais pas manger)
        var it : TPiecesJIT = p.piecesJIT(joueur : p.joueurActif())
        while let piece=it.next(){
            
            if let pos = piece.position(){
                
                if piece.typePiece() == "Kuropokkuru"{
                    
                    if pos[0] == p.derniereLigne(joueur : p.joueurActif()){
                        p.gagner(joueur : p.joueurActif())
                    }
                }
            }
        }
        
        
        if p.partieFinie(){
            
            print("Le joueur \(p.joueurActif()) gagne la partie")
            
        }
        
        // c'est mis a la fin du while pour ne pas refaire un tour en trop
    }
}*/
