const express = require("express");
const os = require("os");

const app = express();
const PORT = 8080;

// Health check endpoint
app.get("/health", (req, res) => {
  res.status(200).json({
    status: "healthy",
    timestamp: new Date().toISOString(),
  });
});

// Main endpoint
app.get("/", (req, res) => {
  res.json({
    message: "Welcome to ECS Fargate Demo!",
    hostname: os.hostname(),
    platform: os.platform(),
    uptime: process.uptime(),
    timestamp: new Date().toISOString(),
  });
});

// Info endpoint
app.get("/info", (req, res) => {
  res.json({
    app: "ECS Fargate Node.js App",
    version: "1.0.0",
    environment: process.env.NODE_ENV || "production",
    container: os.hostname(),
  });
});

app.listen(PORT, "0.0.0.0", () => {
  console.log(`Server running on port ${PORT}`);
  console.log(`Health check available at /health`);
});
