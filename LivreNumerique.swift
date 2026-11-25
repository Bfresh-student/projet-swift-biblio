import Foundation

class LivreNumerique: Livre {
    private var tailleFichierMo: Int

    init(titre: String, auteur: String, estDisponible: Bool = true, tailleFichierMo: Int) {
        self.tailleFichierMo = tailleFichierMo
        super.init(titre: titre, auteur: auteur, estDisponible: estDisponible)
    }

    // --- Getter & Setter ---
    func getTailleFichierMo() -> Int {
        return tailleFichierMo
    }

    func setTailleFichierMo(_ taille: Int) {
        if taille > 0 {
            self.tailleFichierMo = taille
        } else {
            print("La taille du fichier doit être positive.")
        }
    }

    override func afficherInformations() {
        super.afficherInformations()
        print(" -> Taille du fichier : \(tailleFichierMo) Mo")
    }
}
