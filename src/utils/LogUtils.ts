// Fix to console log in single line, and add error message to log.
import winston from "winston";
import { createNewLogger, createConsoleTransport } from "@uma/logger";

const transports = process.env.DEBUG_LOG === "true" ? [createConsoleTransport()] : [new winston.transports.Console()];
const config = process.env.DEBUG_LOG === "true" ? {} : { createConsoleTransport: false };

export const Logger = createNewLogger(transports, config);

export type DefaultLogLevels = "debug" | "info" | "warn" | "error";
