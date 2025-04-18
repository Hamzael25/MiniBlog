# 📝 Mini Blog — Express.js · PostgreSQL · Docker

Mini projet de blog simple utilisant **Node.js**, **Express**, **PostgreSQL** et **EJS** comme moteur de templates.  
L’ensemble est entièrement **dockerisé** et géré par un **Makefile** pour un lancement rapide et sans prise de tête.

---

## 🚀 Lancer le projet en 2 commandes

```bash
git clone https://github.com/Hamzael25/MiniBlog.git
cd MiniBlog
make up
```

⮐️ Rendez-vous sur : [http://localhost:3000](http://localhost:3000)

---

## 💠 Commandes utiles (`Makefile`)

| Commande        | Action                                                  |
|----------------|---------------------------------------------------------|
| `make up`       | Démarre les conteneurs (sans rebuild)                  |
| `make start`    | Build + up (à utiliser au premier lancement)           |
| `make down`     | Arrête les conteneurs                                  |
| `make clean`    | Supprime conteneurs, volumes, images                   |
| `make reset`    | Nettoyage complet, rebuild, puis redémarrage           |
| `make re`       | Redémarrage rapide (down puis up)                      |
| `make prune`    | Nettoyage global Docker (objets non utilisés)          |

