const sql = require('mssql');
require ('dotenv').config();

const config = {
    server: process.env.DB_SERVER,
    database: process.env.DB_DATABASE,
    user: process.env.DB_USER,
    password: process.env.DB_PASSWORD,
    port: parseInt(process.env.DB_PORT),
    options: {
        encrypt: process.env.DB_ENCRYPTn === 'true',
        trustServerCertificate: process.env.DB_TRUST_SERVER_CERTIFICATE === 'true',
        connectionTimeout: 30000,
        requestTimeout: 30000,
    },
    pool: {
        max: 10, 
        min: 0, 
        idleTimeoutMillis: 30000,
    }
};

let poolPromise = null;
const getConnection = async ()=>{
    try {
        if(!poolPromise){
            poolPromise = new sql.ConnectionPool(config).connect();
        }
        return await poolPromise;
    } catch (error) {
        console.error("Database connectio failed", error)
        throw error;
    }
};

const closeConnectionn = async () => {
    try {
        if(poolPromise){
            const pool = await poolPromise;
            await pool.close();
            poolPromise = null;
        }
    } catch (error) {
        console.error("Error closing database connection", error);
    }
};

module.exports = {
    sql, 
    getConnection,
    closeConnectionn
}