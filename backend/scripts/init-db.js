const sql = require("mssql");
require("dotenv").config();

const config = {
  server: process.env.DB_SERVER,
  user: process.env.DB_USER,
  password: process.env.DB_PASSWORD,
  port: parseInt(process.env.DB_PORT),
  options: {
    encrypt: process.env.DB_ENCRYPT === "true",
    trustServerCertificate: process.env.DB_TRUST_SERVER_CERTIFICATE === "true",
    connectionTimeout: 30000,
    requestTimeout: 30000,
  },
};

async function initializeDatabase() {
  try {
    // Connect without specifying database
    console.log("Connecting to SQL Server...");
    const pool = await sql.connect(config);

    // Create database if it doesn't exist
    console.log("Creating database if it doesn't exist...");
    await pool.request().query(`
      IF NOT EXISTS (SELECT * FROM sys.databases WHERE name = '${process.env.DB_DATABASE}')
      BEGIN
        CREATE DATABASE ${process.env.DB_DATABASE}
      END
    `);

    // Close connection and reconnect to the specific database
    await pool.close();

    // Reconnect with database specified
    const dbConfig = { ...config, database: process.env.DB_DATABASE };
    const dbPool = await sql.connect(dbConfig);

    // Create table if it doesn't exist
    console.log("Creating PRODUCTS table if it doesn't exist...");
    await dbPool.request().query(`
      IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='PRODUCTS' AND xtype='U')
      BEGIN
        CREATE TABLE PRODUCTS (
          PRODUCTID INT PRIMARY KEY IDENTITY(1,1),
          PRODUCTNAME NVARCHAR(100) NOT NULL,
          PRICE DECIMAL(10, 2) NOT NULL,
          STOCK INT NOT NULL
        )
      END
    `);

    // Check if table has data, if not insert sample data
    const result = await dbPool
      .request()
      .query("SELECT COUNT(*) as count FROM PRODUCTS");
    if (result.recordset[0].count === 0) {
      console.log("Inserting sample data...");
      await dbPool.request().query(`
        INSERT INTO PRODUCTS (PRODUCTNAME, PRICE, STOCK) VALUES
        ('iPhone 14', 999.99, 50),
        ('Samsung Galaxy S23', 899.99, 30),
        ('MacBook Pro', 1999.99, 15),
        ('Dell XPS 13', 1299.99, 25),
        ('AirPods Pro', 249.99, 100)
      `);
    }

    console.log("Database initialization completed successfully!");
    await dbPool.close();
  } catch (error) {
    console.error("Database initialization failed:", error);
    process.exit(1);
  }
}

initializeDatabase();
