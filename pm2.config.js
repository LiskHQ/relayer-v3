module.exports = {
    apps : [{
      name: "mainent-across-relayer",
      script: "SEND_RELAYS=true yarn relay --wallet awskms --keys 'relayerKey'",
      autorestart: true,  // Automatically restart app if it crashes
      env: {
        NODE_ENV: "production",
      }
    }, {
      name: "testnet-across-relayer",  // A name for your application
      script: "SEND_RELAYS=true yarn relay --wallet awskms --keys 'relayerKey'",  // The script file to launch the app
      autorestart: true,  // Automatically restart app if it crashes
      env: {
        NODE_ENV: "development",
      }
    }, {
      name: "testnet-across-relayer-simulated",  // A name for your application
      script: "SEND_RELAYS=false yarn relay --wallet awskms --keys 'relayerKey'",
      autorestart: true,  // Automatically restart app if it crashes
      env: {
        NODE_ENV: "development",
      }
    }]
  };
  