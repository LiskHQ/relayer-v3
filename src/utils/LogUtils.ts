// Modify from: https://github.com/UMAprotocol/protocol/blob/master/packages/logger/src/logger/ConsoleTransport.ts
// Fix to console log in single line, and add error message to log.
import winston from "winston";
import { createNewLogger } from "@uma/logger";
// This transport enables Winston logging to the console.
const { format } = winston;
const { combine, timestamp, colorize, printf } = format;

export function createConsoleTransport(): winston.transports.ConsoleTransportInstance {
  return new winston.transports.Console({
    handleExceptions: true,
    format: combine(
      // Adds timestamp.
      colorize(),
      timestamp(),
      printf((info) => {
        const { timestamp, level, error, ...args } = info;

        // This slice changes a timestamp formatting from `2020-03-25T10:50:57.168Z` -> `2020-03-25 10:50:57`
        const ts = timestamp.slice(0, 19).replace("T", " ");
        // Winston does not properly log Error objects like console.error() does, so this formatter will search for the Error object
        // in the "error" property of "info", and add the error stack to the log.
        // Discussion at https://github.com/winstonjs/winston/issues/1338.
        if (error) {
          args.errMsg = error;
        }
        const log = `${ts} [${level}]: ${Object.keys(args).length ? JSON.stringify(args) : ""}`;

        return log;
      })
    ),
  });
}

export const Logger = createNewLogger([createConsoleTransport()], { createConsoleTransport: false });

export type DefaultLogLevels = "debug" | "info" | "warn" | "error";
