import { RelayerConfig } from "../src/relayer/RelayerConfig";

// Example run:
// ts-node ./scripts/validateConfig.ts

export async function run(): Promise<void> {
  console.log("Validating config");

  const env: NodeJS.ProcessEnv = {
    RELAYER_TOKENS:
      '["0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2", "0x6033F7f88332B8db6ad452B7C6D5bB643990aE3f", "0xdAC17F958D2ee523a2206206994597C13D831ec7"]',
    MIN_DEPOSIT_CONFIRMATIONS:
      '{"5000": { "1": 5, "1135": 10 }, "2000": { "1": 4, "1135": 10 }, "100": { "1": 3, "1135": 10 } }',
    RELAYER_ORIGIN_CHAINS: JSON.stringify([1, 1135]),
    RELAYER_DESTINATION_CHAINS: JSON.stringify([1, 1135]),
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
