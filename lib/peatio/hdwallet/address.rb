require 'securerandom'

module HDWallet
  class Address
    def self.generate
      # Génère une clé privée Ethereum (64 caractères hex)
      priv_key = SecureRandom.hex(32)
      # Génère une adresse Ethereum (0x + 40 caractères hex)
      address = "0x" + SecureRandom.hex(20)

      {
        address: address,
        private_key: priv_key
      }
    end
  end
end
