import { RelayerConfig } from "../src/relayer/RelayerConfig";

// Example run:
// ts-node ./scripts/validateConfig.ts

export async function run(): Promise<void> {
  console.log("Validating config");

  const env: NodeJS.ProcessEnv = {
    MAX_RELAYER_DEPOSIT_LOOK_BACK: "1800",
    RELAYER_TOKENS:
      '["0x16B840bA01e2b05fc2268eAf6d18892a11EC29D6", "0xaA8E23Fb1079EA71e0a56F48a2aA51851D8433D0", "0xfFf9976782d46CC05630D1f6eBAb18b2324d6B14"]',
    MIN_DEPOSIT_CONFIRMATIONS:
      '{ "1000000": { "919": 1, "4202": 1, "80002": 1, "84532": 1, "421614": 1, "11155111": 1, "11155420": 1 } }',
    RELAYER_IGNORE_LIMITS: "true",
    RELAYER_ORIGIN_CHAINS: JSON.stringify([11155111, 4202]),
    RELAYER_DESTINATION_CHAINS: JSON.stringify([11155111, 4202]),
    HUB_CHAIN_ID: "11155111",
    SEND_REBALANCES: "true",
    RELAYER_EXTERNAL_INVENTORY_CONFIG: "config/mainnet/relayerExternalInventory.json",
  };
  new RelayerConfig(env);

  console.log("Config is valid");
}

if (require.main === module) {
  run()
    .then(async () => {
      // eslint-disable-next-line no-process-exit
      process.exit(0);
    })
    .catch(async (error) => {
      console.error("Process exited with", error);
      // eslint-disable-next-line no-process-exit
      process.exit(1);
    });
}
