const ProductModel = require("../models/productModel");

class ProductController {
  static async getAllProducts(req, res, next) {
    try {
      const products = await ProductModel.getAllProducts();
      res.status(200).json({
        success: true,
        data: products,
        message: "Product retrieved sucessfully",
      });
    } catch (error) {
      next(error);
    }
  }

  static async getProductById(req, res, next) {
    try {
      const { id } = req.params;
      if (!id || isNaN(id)) {
        return res.status(400).json({
          success: false,
          message: "Invalid Product ID",
        });
      }
      const product = await ProductModel.getProductById(parseInt(id));
      if (!product) {
        return res.status(404).json({
          success: false,
          message: "Product NOT FOUND",
        });
      }
      res.status(200).json({
        success: true,
        data: product,
        message: "Product is retrieved successfully",
      });
    } catch (error) {
      next(error);
    }
  }

  static async createProduct(req, res, next) {
    try {
      const { productName, price, stock } = req.body;
      if (!productName || !price || !stock == undefined) {
        return res.status(400).json({
          success: false,
          message: "Product name, price and stock are required",
        });
      }
      if (price <= 0 || stock < 0) {
        return res.status(400).json({
          success: false,
          message: "Price must be positive, Stock cannot be negative",
        });
      }

      const newProduct = await ProductModel.createProduct({
        productName,
        price: parseFloat(price),
        stock: parseInt(stock),
      });

      res.status(201).json({
        success: true,
        data: newProduct,
        message: "Proudct created successfully",
      });
    } catch (error) {
      next(error);
    }
  }

  static async updateProduct(req, res, next) {
    try {
      const { id } = req.params;
      const { productName, price, stock } = req.body;

      if (!id || isNaN(id)) {
        res.status(400).json({
          success: false,
          message: "Invalid product ID",
        });
      }

      if (!productName || !price || !stock == undefined) {
        res.status(400).json({
          success: false,
          message: " Product Name ,price and stock are required",
        });
      }
      if (price <= 0 || stock < 0) {
        return res.status(400).json({
          success: false,
          message: "Price must be positive, Stock cannot be negative",
        });
      }

      const existingProduct = await ProductModel.getProductById(parseInt(id));
      if (!existingProduct) {
        res.status(404).json({
          success: false,
          message: "Product NOT FOUND",
        });
      }

      const updateProduct = await ProductModel.updateProduct(parseInt(id), {
        productName,
        price: parseFloat(price),
        stock: parseInt(stock),
      });
      res.status(200).json({
        success: true,
        data: updateProduct,
        message: " Product is updated successfully",
      });
    } catch (error) {
      next(error);
    }
  }

  static async deleteProduct(req, res, next) {
    try {
      const { id } = req.params;
      if (!id || isNaN(id)) {
        return res.status(400).json({
          success: false,
          message: "Invalid product ID",
        });
      }

      const existingProduct = await ProductModel.getProductById(parseInt(id));
      if (!existingProduct) {
        return res.status(404).json({
          success: false,
          message: "Product not found",
        });
      }
      const deleted = await ProductModel.deleteProduct(parseInt(id));
      if (deleted) {
        res.status(200).json({
          success: true,
          message: "Product deleted successfully",
        });
      } else {
        res.status(500).json({
          success: false,
          message: "Failed to delete the product",
        });
      }
    } catch (error) {
      next(error);
    }
  }
}

module.exports = ProductController;