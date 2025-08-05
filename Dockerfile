FROM ruby:3.2.3


# Installer dépendances système
RUN apt-get update && apt-get install -y \
    build-essential \
    libssl-dev \
    libpq-dev \
    git \
 && rm -rf /var/lib/apt/lists/*

# Créer un utilisateur app (optionnel mais propre)
RUN groupadd -r --gid 1000 app && useradd --system --create-home --home /home/app --shell /sbin/nologin --uid 1000 -g 1000 app

WORKDIR /home/app

# Copier Gemfile et installer les gems
COPY Gemfile ./
RUN gem install bundler && bundle install

# Copier le reste des fichiers
COPY . .

# Installer puma/rackup pour exécuter Sinatra proprement
RUN gem install puma rackup

# Exposer le port pour Docker
EXPOSE 8080

# Démarrer Sinatra sur 0.0.0.0:8080
CMD ["bundle", "exec", "ruby", "app.rb", "-o", "0.0.0.0", "-p", "8080"]

ENV ETH_NODE_URL=https://mainnet.infura.io/v3/506823d018754445af4d2595acb1f7b6
ENV ETH_WALLET_PASSWORD=motdepasse
