import Foundation

class LivrePapier: Livre {
    private var nombrePages: Int

    init(titre: String, auteur: String, estDisponible: Bool = true, nombrePages: Int) {
        self.nombrePages = nombrePages
        super.init(titre: titre, auteur: auteur, estDisponible: estDisponible)
    }

    // --- Getter & Setter ---
    func getNombrePages() -> Int {
        return nombrePages
    }

    func setNombrePages(_ pages: Int) {
        if pages > 0 {
            self.nombrePages = pages
        } else {
            print("Le nombre de pages doit être positif.")
        }
    }

    override func afficherInformations() {
        super.afficherInformations()
        print(" -> Nombre de pages : \(nombrePages)")
    }
}
