import express, { Express } from "express";
import dotenv from "dotenv";
import winston from "winston";
import { healthz } from "./route/healthz";

dotenv.config();

export function runAPIServer(logger: winston.Logger): void {
  const app: Express = express();
  const host = process.env.API_SERVER_HOST || "0.0.0.0";
  const port = Number(process.env.API_SERVER_PORT) || 3000;

  app.use("/healthz", healthz());

  app.listen(port, host, () => {
    logger.info({
      at: "Relayer#apiServer",
      message: `Relayer API server is running at http://${host}:${port}`,
    });
  });
}
