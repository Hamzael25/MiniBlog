.PHONY: all start build up down docker_compose_up docker_compose_down reset clean prune

COMPOSE_FILE = docker-compose.yml

# --------------------------------------------------
# Cible par défaut : démarrage de l'environnement
# --------------------------------------------------

all: start

# --------------------------------------------------
# Démarrage de l'environnement + build
# --------------------------------------------------

start: build docker_compose_up

build:
	@echo "[...] Build des images Docker en cours..."
	@docker compose -f $(COMPOSE_FILE) build && \
		echo "[✅] Build des images Docker terminé" || \
		echo "[❌] Échec du build des images Docker"

# --------------------------------------------------
# Démarrage de l'environnement sans build
# --------------------------------------------------

up: docker_compose_up

docker_compose_up:
	@echo "[...] Lancement des conteneurs en cours..."
	@docker compose -f $(COMPOSE_FILE) up -d && \
		echo "[✅] Conteneurs lancés" || \
		echo "[❌] Échec du lancement des conteneurs"

# --------------------------------------------------
# Arrêt simple des conteneurs
# --------------------------------------------------

down: docker_compose_down

docker_compose_down:
	@echo "[...] Arrêt des conteneurs en cours..."
	@docker compose -f $(COMPOSE_FILE) down && \
		echo "[✅] Conteneurs arrétés" || \
		echo "[❌] Échec de l'arrêt des conteneurs"

# --------------------------------------------------
# Arrêt et suppression des conteneurs + images + volumes
# --------------------------------------------------

clean:
	@echo "[...] Arrêt et suppression des conteneurs/images/volumes en cours..."
	@docker compose -f $(COMPOSE_FILE) down --volumes --remove-orphans --rmi all && \
		echo "[✅] Conteneurs, images et volumes supprimés" || \
		echo "[❌] Échec de la suppression des conteneurs"

# --------------------------------------------------
# Relance de l'environnement après nettoyage complet
# --------------------------------------------------

reset: clean build up

# --------------------------------------------------
# Prune Docker : suppression des objets inutilisés
# --------------------------------------------------

prune:
	@echo "[...] Pruning du système Docker en cours..."
	@docker system prune --all --force && docker volume prune --force && docker network prune --force && \
		echo "[✅] Prune Docker effectué" || \
		echo "[❌] Échec du Prune Docker"

# --------------------------------------------------
# RE : Arrêt et relance des conteneurs
# --------------------------------------------------

re:
	@docker compose -f $(COMPOSE_FILE) down --volumes --remove-orphans
	@docker compose -f $(COMPOSE_FILE) up -d && \
		echo "[✅] Arrêt et relance des conteneurs effectués" || \
		echo "[❌] Échec du relancement des conteneurs"
