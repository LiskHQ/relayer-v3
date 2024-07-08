import express, { Request, Response } from "express";

export function healthz(): express.Router {
  const router = express.Router({});
  router.get("/", (_req: Request, res: Response) => {
    const healthCheckParams = {
      uptime: process.uptime(),
      message: "OK",
      timestamp: Date.now(),
    };
    try {
      res.send(healthCheckParams);
    } catch (error) {
      healthCheckParams.message = (error as unknown as Error).message;
      res.status(503).send(healthCheckParams);
    }
  });

  return router;
}
