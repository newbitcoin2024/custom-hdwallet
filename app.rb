require 'sinatra/base'
require 'json'

require_relative 'lib/peatio/hdwallet/address'
require_relative 'lib/peatio/hdwallet/transaction'

class HDWalletApp < Sinatra::Base
  set :bind, '0.0.0.0'
  set :port, 8080

  before do
    content_type :json
  end

  # Endpoint pour créer une nouvelle adresse ETH
  post '/create_address' do
    addr = HDWallet::Address.generate
    addr.to_json
  end

  # Endpoint pour simuler l'envoi d'une transaction ETH
  post '/send_transaction' do
    body = JSON.parse(request.body.read)
    txid = HDWallet::Transaction.send(body["to"], body["amount"], body["private_key"])
    { txid: txid }.to_json
  end

  run! if app_file == $0
end
