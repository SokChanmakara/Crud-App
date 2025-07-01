const express = require("express");
const cors = require("cors");
require("dotenv").config();

const productRoute = require("./src/routes/productRoutes");
const errorhandler = require("./src/middleware/errorHandler");
const { getConnection, closeConnection } = require("./src/config/database");

const app = express();
const PORT = process.env.PORT || 3000;

//Middleware
app.use(cors());
app.use(express.json());
app.use(express.urlencoded({ extends: true }));

//route
app.use("/products", productRoute);

app.use(errorhandler);

//404 handler
app.use((req, res) => {
  res.status(404).json({
    success: false,
    message: "Route Not Found",
  });
});

// Start server
const startServer = async () => {
  try {
    // Test database connection
    await getConnection();
    console.log("Database connected successfully");

    app.listen(PORT, () => {
      console.log(`Server is running on port ${PORT}`);
    });
  } catch (error) {
    console.error("Failed to start server:", error);
    process.exit(1);
  }
};

// Graceful shutdown
process.on("SIGINT", async () => {
  console.log("\nShutting down server...");
  await closeConnection();
  process.exit(0);
});

process.on("SIGTERM", async () => {
  console.log("\nShutting down server...");
  await closeConnection();
  process.exit(0);
});

startServer();
