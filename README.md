# Gestionnaire de Bibliothèque (Swift)

Application console interactive développée en **Swift** permettant de gérer le catalogue d'une bibliothèque, ses adhérents et les emprunts/retours de livres (standards, papier et numériques).

---

## Structure du projet

| Fichier | Rôle |
| --- | --- |
| `main.swift` | Point d'entrée de l'application avec menu interactif en console |
| `Livre.swift` | Classe de base `Livre` (`titre`, `auteur`, `estDisponible`) et méthodes `emprunter()`, `retourner()`, `afficherInformations()` |
| `LivrePapier.swift` | Sous-classe `LivrePapier` héritant de `Livre`, ajoutant `nombrePages` (`> 0`) |
| `LivreNumerique.swift` | Sous-classe `LivreNumerique` héritant de `Livre`, ajoutant `tailleFichierMo` (`> 0`) |
| `Bibliotheque.swift` | Classe `Bibliotheque` gérant le `catalogue` (`[Livre]`) : ajout, affichage et recherche insensible à la casse |
| `Adherent.swift` | Classe `Adherent` gérant le `nom` et les `livresEmpruntes` (limite de 3 emprunts simultanés) |
| `document/diagramme_uml.drawio` | Diagramme de classes UML au format draw.io |
| `document/tests_screenshot.png` | Capture d'écran du scénario de tests complet |

---

## Prérequis et exécution

- **Compilateur Swift** (testé avec Swift 6.3.3 sous Windows)

### Compiler et lancer sous Windows (PowerShell)

```powershell
swiftc (Get-ChildItem *.swift).Name -o program.exe
.\program.exe
```

---

## Utilisation du menu interactif

Au démarrage, la bibliothèque est préchargée avec 5 livres (*Le Petit Prince*, *Swift pour les Débutants*, *1984*, *Les Misérables*, *Clean Code*) et 3 adhérents (*Alice*, *Bob*, *Charlie*).

```text
--- MENU PRINCIPAL ---
1. Afficher le catalogue
2. Rechercher un livre
3. Ajouter un livre
4. Créer un adhérent
5. Emprunter un livre
6. Retourner un livre
7. Afficher les emprunts d'un adhérent
0. Quitter
```

---

## Règles métier implémentées

- **Polymorphisme** : `LivrePapier` et `LivreNumerique` héritent de `Livre` et redéfinissent `afficherInformations()`.
- **Encapsulation et validation** : les propriétés sont `private` avec getters/setters ; `setNombrePages` et `setTailleFichierMo` refusent les valeurs négatives ou nulles (`<= 0`).
- **Disponibilité** : un livre déjà emprunté (`estDisponible == false`) ne peut pas être emprunté par un autre adhérent tant qu'il n'a pas été retourné.
- **Limite d'emprunt** : un `Adherent` peut emprunter au maximum **3 livres** simultanément.
- **Recherche** : `rechercherLivre(titre:)` effectue une comparaison insensible à la casse.
