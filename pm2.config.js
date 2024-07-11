module.exports = {
    apps : [{
      name: "mainent-across-relayer",
      script: "SEND_RELAYS=true yarn relay --wallet awskms --keys 'relayerKey'",
      autorestart: true,  // Automatically restart app if it crashes
      env: {
        NODE_ENV: "production",
      }
    }, {
      name: "testnet-across-relayer",
      script: "SEND_RELAYS=true yarn relay --wallet awskms --keys 'relayerKey'",
      autorestart: true,  // Automatically restart app if it crashes
      env: {
        NODE_ENV: "development",
      }
    }, {
      name: "testnet-across-relayer-simulated",  // It will not send any transactions and uses bogus passphrase for testing
      script: "MNEMONIC='job hedgehog wing decorate cup club hunt horn rude cancel bridge carry frog toss ugly' SEND_RELAYS=false yarn relay --wallet mnemonic",
      autorestart: true,  // Automatically restart app if it crashes
      env: {
        NODE_ENV: "development",
      }
    }]
  };
