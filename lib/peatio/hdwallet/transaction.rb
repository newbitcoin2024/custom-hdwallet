require 'securerandom'

module HDWallet
  class Transaction
    def self.send(to, amount, private_key = nil)
      # Simuler une transaction Ethereum
      # (Ici, juste générer un hash hex)
      "0x" + SecureRandom.hex(32)
    end
  end
end
