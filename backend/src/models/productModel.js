const { getConnection, sql } = require("../config/database");

class ProductModel {
  static async getAllProducts() {
    try {
      const pool = await getConnection();
      const result = await pool
        .requst()
        .query("SELECT * FROM PRODUCTS ORDER BY PRODUCTID");
      return result.recordset;
    } catch (error) {
      throw new Error(`Error Fetching products: ${error.message}`);
    }
  }

  static async getProductById(id) {
    try {
      const pool = await getConnection();
      const result = await pool
        .request()
        .input("id", sql.Int, id)
        .query("SELECT * FROM PRODUCTS WHERE PRODUCTID = @ID");
      return result.recordset[0];
    } catch (error) {
      throw new Error(`Error Fetching product: ${error.message}`);
    }
  }

  static async createProduct(productData) {
    try {
      const { productName, price, stock } = productData;
      const pool = await getConnection();
      const result = await pool
        .request()
        .input("productName", sql.NVarChar(100), productName)
        .input("price", sql.Decimal(10, 2), price)
        .input("stock", sql.Int, stock).query(`
                        INSERT INTO PRODUCTS(PRODUCTNAME, PRICE, STOCK)
                        OUTPUT INSERTED.*
                        VALUES(@productName, @price, @stock)
                    `);
      return result.recordset[0];
    } catch (error) {
      throw new Error(`Error Creating Product ${error.message}`);
    }
  }

  static async updateProduct(id, productData) {
    try {
      const { productName, price, stock } = productData;
      const pool = await getConnection();
      const result = await request()
        .input("id", sql.Int, id)
        .input("productName", sql.NVarChar(100), productName)
        .input("price", sql.Decimal, price)
        .input("stock", sql.Int, stock).query(`
                UPDATE PRODUCTS
                SET PRODUCTNAME = @productName, PRICE = @price, STOCK = @stock
                OUTPUT INSERTED.*
                WHERE PRODUCTID = @id
            `);
      return result.recordset[0];
    } catch (error) {
      throw new Error(`Error updating product ${error.message}`);
    }
  }

  static async deleteProduct(id) {
    try {
      const pool = await getConnection();
      const result = await request()
        .input("id", sql.Int, id)
        .query("DELETE FROM PRODUCTS WHERE PRODUCTID = @id");
      return result.recordset[0] > 0;
    } catch (error) {
      throw new Error(`Error deleting product ${error.message}`);
    }
  }
}

module.exports = ProductModel;