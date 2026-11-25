import Foundation

print("==========================================")
print("     TESTS DU SYSTÈME DE BIBLIOTHÈQUE     ")
print("==========================================\n")

// ==========================================
// 1. Initialisation de la bibliothèque
// ==========================================
let bibliotheque = Bibliotheque()

let livre1 = LivrePapier(titre: "Le Petit Prince", auteur: "Antoine de Saint-Exupéry", estDisponible: true, nombrePages: 96)
let livre2 = LivreNumerique(titre: "Swift pour les Débutants", auteur: "Jean Dupont", estDisponible: true, tailleFichierMo: 15)
let livre3 = Livre(titre: "1984", auteur: "George Orwell", estDisponible: true)
let livre4 = LivrePapier(titre: "Les Misérables", auteur: "Victor Hugo", estDisponible: true, nombrePages: 1488)
let livre5 = LivreNumerique(titre: "Clean Code", auteur: "Robert C. Martin", estDisponible: true, tailleFichierMo: 8)

bibliotheque.ajouterLivre(livre1)
bibliotheque.ajouterLivre(livre2)
bibliotheque.ajouterLivre(livre3)
bibliotheque.ajouterLivre(livre4)
bibliotheque.ajouterLivre(livre5)

// ==========================================
// 2. Test du Polymorphisme et Affichage Catalogue
// ==========================================
print("\n--- TEST 1 : Affichage du catalogue complet (Polymorphisme) ---")
bibliotheque.afficherCatalogue()

// ==========================================
// 3. Test de Recherche de livres
// ==========================================
print("\n--- TEST 2 : Recherche de livres ---")
print("Recherche existante (avec minuscules) :")
if let livreTrouve = bibliotheque.rechercherLivre(titre: "le petit prince") {
    print(" -> Trouvé ! Auteur : \(livreTrouve.getAuteur())")
}

print("Recherche inexistante :")
let livreInconnu = bibliotheque.rechercherLivre(titre: "Livre Inexistant")
if livreInconnu == nil {
    print(" -> Résultat conforme : le livre n'a pas été trouvé.")
}

// ==========================================
// 4. Test d'Emprunts et Retours Standards
// ==========================================
print("\n--- TEST 3 : Emprunts et Retours normaux ---")
let alice = Adherent(nom: "Alice")
print("Adhérent : \(alice.getNom())")

alice.emprunterLivre(livre1) // Alice emprunte "Le Petit Prince"
alice.afficherEmprunts()

print("\nTentative de réemprunter le même livre par Bob :")
let bob = Adherent(nom: "Bob")
bob.emprunterLivre(livre1) // Doit échouer car indisponible

print("\nAlice retourne le livre :")
alice.retournerLivre(livre1)
alice.afficherEmprunts()

print("\nBob peut maintenant l'emprunter :")
bob.emprunterLivre(livre1)
bob.afficherEmprunts()

// ==========================================
// 5. Test Contrainte : Max 3 emprunts par adhérent
// ==========================================
print("\n--- TEST 4 : Limite maximale de 3 livres par adhérent ---")
let charlie = Adherent(nom: "Charlie")

print("Emprunt 1 :")
charlie.emprunterLivre(livre2)
print("Emprunt 2 :")
charlie.emprunterLivre(livre3)
print("Emprunt 3 :")
charlie.emprunterLivre(livre4)

print("\nTentative d'un 4ème emprunt (doit être refusé) :")
charlie.emprunterLivre(livre5)

print("\nÉtat des emprunts de Charlie :")
charlie.afficherEmprunts()

// ==========================================
// 6. Test Retour d'un livre non emprunté
// ==========================================
print("\n--- TEST 5 : Tentative de retourner un livre non emprunté ---")
// Charlie essaie de retourner livre1 (qui est chez Bob)
charlie.retournerLivre(livre1)

// ==========================================
// 7. Test des Getters / Setters et Encapsulation
// ==========================================
print("\n--- TEST 6 : Getters / Setters et validation ---")
print("Titre initial : \(livre5.getTitre())")
livre5.setTitre("Clean Architecture")
print("Nouveau titre après setter : \(livre5.getTitre())")

print("Taille initiale en Mo : \(livre5.getTailleFichierMo()) Mo")
livre5.setTailleFichierMo(-5) // Test de validation : valeur négative refusée
livre5.setTailleFichierMo(12) // Valeur valide
print("Nouvelle taille valide : \(livre5.getTailleFichierMo()) Mo")

print("\n==========================================")
print("           FIN DE TOUS LES TESTS          ")
print("==========================================")
