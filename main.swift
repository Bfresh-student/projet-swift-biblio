import Foundation

// --- Utilitaires de saisie ---
func lireTexte(_ message: String) -> String {
    print(message, terminator: "")
    fflush(stdout)
    return readLine()?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
}

func lireTexteNonVide(_ message: String) -> String {
    while true {
        let saisie = lireTexte(message)
        if !saisie.isEmpty {
            return saisie
        }
        print("Saisie vide. Veuillez réessayer.")
    }
}

func lireEntierPositif(_ message: String) -> Int {
    while true {
        let saisie = lireTexte(message)
        if let valeur = Int(saisie), valeur > 0 {
            return valeur
        }
        print("Veuillez entrer un nombre entier strictement positif.")
    }
}

func choisirAdherent(_ adherents: [Adherent]) -> Adherent? {
    if adherents.isEmpty {
        print("Aucun adhérent enregistré. Veuillez d'abord en créer un.")
        return nil
    }
    print("\nListe des adhérents :")
    for (index, adherent) in adherents.enumerated() {
        print("  \(index + 1). \(adherent.getNom()) (\(adherent.getLivresEmpruntes().count)/3 emprunts)")
    }
    let saisie = lireTexte("Choisissez un numéro d'adhérent (ou Entrée pour annuler) : ")
    if saisie.isEmpty { return nil }
    if let index = Int(saisie), index >= 1, index <= adherents.count {
        return adherents[index - 1]
    }
    print("Sélection invalide.")
    return nil
}

// --- Actions du menu ---
func ajouterLivreInteractif(_ bibliotheque: Bibliotheque) {
    print("\nType de livre à ajouter :")
    print("  1. Livre standard")
    print("  2. Livre papier")
    print("  3. Livre numérique")
    let type = lireTexte("Votre choix : ")

    guard ["1", "2", "3"].contains(type) else {
        print("Type de livre invalide.")
        return
    }

    let titre = lireTexteNonVide("Titre : ")
    let auteur = lireTexteNonVide("Auteur : ")

    switch type {
    case "1":
        bibliotheque.ajouterLivre(Livre(titre: titre, auteur: auteur))
    case "2":
        let pages = lireEntierPositif("Nombre de pages : ")
        bibliotheque.ajouterLivre(LivrePapier(titre: titre, auteur: auteur, nombrePages: pages))
    case "3":
        let taille = lireEntierPositif("Taille du fichier (Mo) : ")
        bibliotheque.ajouterLivre(LivreNumerique(titre: titre, auteur: auteur, tailleFichierMo: taille))
    default:
        break
    }
}

func rechercherLivreInteractif(_ bibliotheque: Bibliotheque) {
    let titre = lireTexteNonVide("\nTitre du livre à rechercher : ")
    if let livre = bibliotheque.rechercherLivre(titre: titre) {
        print("Livre trouvé :")
        livre.afficherInformations()
    }
}

func creerAdherentInteractif(_ adherents: inout [Adherent]) {
    let nom = lireTexteNonVide("\nNom du nouvel adhérent : ")
    if adherents.contains(where: { $0.getNom().lowercased() == nom.lowercased() }) {
        print("Un adhérent nommé \"\(nom)\" existe déjà.")
        return
    }
    adherents.append(Adherent(nom: nom))
    print("Adhérent \"\(nom)\" créé avec succès.")
}

func emprunterLivreInteractif(_ bibliotheque: Bibliotheque, _ adherents: [Adherent]) {
    guard let adherent = choisirAdherent(adherents) else { return }
    let titre = lireTexteNonVide("Titre du livre à emprunter : ")
    if let livre = bibliotheque.rechercherLivre(titre: titre) {
        adherent.emprunterLivre(livre)
    }
}

func retournerLivreInteractif(_ bibliotheque: Bibliotheque, _ adherents: [Adherent]) {
    guard let adherent = choisirAdherent(adherents) else { return }
    adherent.afficherEmprunts()
    if adherent.getLivresEmpruntes().isEmpty { return }
    let titre = lireTexteNonVide("Titre du livre à retourner : ")
    if let livre = bibliotheque.rechercherLivre(titre: titre) {
        adherent.retournerLivre(livre)
    }
}

func afficherEmpruntsInteractif(_ adherents: [Adherent]) {
    guard let adherent = choisirAdherent(adherents) else { return }
    print("")
    adherent.afficherEmprunts()
}

// --- Initialisation des données ---
let bibliotheque = Bibliotheque()
bibliotheque.ajouterLivre(LivrePapier(titre: "Le Petit Prince", auteur: "Antoine de Saint-Exupéry", nombrePages: 96))
bibliotheque.ajouterLivre(LivreNumerique(titre: "Swift pour les Débutants", auteur: "Jean Dupont", tailleFichierMo: 15))
bibliotheque.ajouterLivre(Livre(titre: "1984", auteur: "George Orwell"))
bibliotheque.ajouterLivre(LivrePapier(titre: "Les Misérables", auteur: "Victor Hugo", nombrePages: 1488))
bibliotheque.ajouterLivre(LivreNumerique(titre: "Clean Code", auteur: "Robert C. Martin", tailleFichierMo: 8))

var adherents: [Adherent] = [
    Adherent(nom: "Alice"),
    Adherent(nom: "Bob"),
    Adherent(nom: "Charlie")
]

// --- Boucle interactive principale ---
print("\n==========================================")
print("   GESTIONNAIRE DE BIBLIOTHÈQUE ")
print("==========================================")

var continuer = true
while continuer {
    print("""

    --- MENU PRINCIPAL ---
    1. Afficher le catalogue
    2. Rechercher un livre
    3. Ajouter un livre
    4. Créer un adhérent
    5. Emprunter un livre
    6. Retourner un livre
    7. Afficher les emprunts d'un adhérent
    0. Quitter
    """)

    let choix = lireTexte("Votre choix : ")

    switch choix {
    case "1":
        print("")
        bibliotheque.afficherCatalogue()
    case "2":
        rechercherLivreInteractif(bibliotheque)
    case "3":
        ajouterLivreInteractif(bibliotheque)
    case "4":
        creerAdherentInteractif(&adherents)
    case "5":
        emprunterLivreInteractif(bibliotheque, adherents)
    case "6":
        retournerLivreInteractif(bibliotheque, adherents)
    case "7":
        afficherEmpruntsInteractif(adherents)
    case "0":
        continuer = false
        print("Au revoir !")
    default:
        print("Choix invalide. Veuillez entrer un chiffre entre 0 et 7.")
    }
}
