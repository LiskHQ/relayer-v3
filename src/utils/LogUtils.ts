// Fix to console log in single line, and add error message to log.
import winston from "winston";
import { createNewLogger, createConsoleTransport } from "@uma/logger";

const transports = process.env.DEBUG_LOG === "true" ? [createConsoleTransport()] : [new winston.transports.Console()];

export const Logger = createNewLogger(transports, { createConsoleTransport: false });

export type DefaultLogLevels = "debug" | "info" | "warn" | "error";
