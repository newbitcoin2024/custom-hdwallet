require 'sinatra'
require 'json'
require_relative 'lib/peatio/hdwallet/app'

# Désactiver complètement Rack::Protection
set :protection, false
disable :protection

# Écoute sur toutes les IP
set :bind, '0.0.0.0'
set :port, 8080

run Sinatra::Application
