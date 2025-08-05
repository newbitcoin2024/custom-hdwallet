require 'sinatra'
require 'json'
require 'rack/protection'
require_relative 'address'
require_relative 'transaction'

# Écoute sur toutes les interfaces
set :bind, '0.0.0.0'
set :port, 8080

# Désactiver complètement la protection pour dev/local
disable :protection

# Autoriser toutes les origines (CORS)
before do
  headers 'Access-Control-Allow-Origin' => '*',
          'Access-Control-Allow-Methods' => ['GET', 'POST', 'OPTIONS'],
          'Access-Control-Allow-Headers' => 'Content-Type'
end

# Endpoint pour générer une adresse
post '/create_address' do
  content_type :json
  addr = HDWallet::Address.generate
  { address: addr[:address], secret: addr[:private_key] }.to_json
end

# Endpoint pour envoyer une transaction
post '/send_transaction' do
  content_type :json
  body = JSON.parse(request.body.read)
  txid = HDWallet::Transaction.send(body["to"], body["amount"])
  { txid: txid }.to_json
end

# Endpoint de test/healthcheck
get '/api/v2/hdwallet' do
  content_type :json
  { status: 'ok', message: 'HDWallet API running' }.to_json
end

