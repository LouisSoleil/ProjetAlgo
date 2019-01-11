import Foundation


print("Test Kodama :")
print() // saute une ligne

testCreerPieceK()
print()

testEstPossibleMouvementK()
print()

testDeplacerPieceK()
print()

testEstTransformeK()
print()

print("Test Partie")
print()


testInitPartieEtIteratorGlobal()
print()

testJoueurActifEtChangerTour()
print()

testPartieFiniEtGagnerPartie()
print()

testPieceAPositionEtEstLibre()
print()


print("Test Piece")
print()


do{
	try testInit()
}
catch{

}
print()

testTypePiece()
print()

testPositionPiece()
print()

testProprietairePiece()
print()

testEstPossibleMouvement()
print()

do{
	try testDeplacerPiece()
}
catch{

}
print()

testEstDansReserve()
print()
