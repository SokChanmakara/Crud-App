# CrudApp - Product Management System

A full-stack product management application built with Flutter frontend and Node.js/Express backend using Microsoft SQL Server database.

## 🏗️ **Architecture**

- **Frontend**: Flutter (Dart) with Riverpod state management
- **Backend**: Node.js with Express.js framework
- **Database**: Microsoft SQL Server (MSSQL)
- **API**: RESTful API with JSON responses

## 🛠️ **Prerequisites**

### **Backend Requirements**

- Node.js (v16 or higher)
- npm or yarn package manager
- Microsoft SQL Server (Local or Remote)
- SQL Server Management Studio (optional, for database management)
- Docker

### **Frontend Requirements**

- Flutter SDK (v3.0 or higher)
- Dart SDK (v2.17 or higher)
- Android Studio or VS Code with Flutter extensions
- Android device/emulator or iOS simulator

## ⚙️ **Setup Instructions**

### **1. Clone the Repository**

```bash
git clone <repository-url>
cd CrudApp
```

### **2. Backend Setup**

#### **Install Dependencies**

```bash
docker compose up -d
cd backend
npm install
```

#### **Environment Configuration**

Create a `.env` file in the backend directory:

```bash
cp .env.example .env
```

Edit the `.env` file with your database credentials:

```env
# Database Configuration
DB_SERVER=localhost
DB_DATABASE=CrudAppDB
DB_USER=your_username
DB_PASSWORD=your_password
DB_PORT=1433
DB_ENCRYPT=true
DB_TRUST_SERVER_CERTIFICATE=true

# Server Configuration
PORT=3000
NODE_ENV=development
```

#### **Database Initialization**

Initialize the database and create sample data:

```bash
npm run init-db
```

#### **Start Backend Server**

```bash
cd backend
npm start
```

The backend server will start on `http://localhost:3000`

### **3. Frontend Setup**

#### **Install Dependencies**

```bash
cd frontend
flutter pub get
```

#### **API Configuration**

The frontend is configured to connect to the backend API. The default API base URL is:

```
http://localhost:3000
```

If you need to change the API URL, update the base URL in:

```dart
// frontend/lib/core/network/api_client.dart
class ApiClient {
  static const String baseUrl = 'http://localhost:3000';
  // ...
}
```

#### **Run Frontend Application**

```bash
flutter run
```

Select your target device (Android emulator, iOS simulator, or physical device).

## 🚀 **Running the Application**

### **Development Mode**

1. **Start Backend** (Terminal 1):

```bash
cd backend
npm start
```

2. **Start Frontend** (Terminal 2):

```bash
cd frontend
flutter run
```

### **Production Mode**

#### **Backend Deployment**

```bash
cd backend
npm start
```

#### **Frontend Build**

```bash
cd frontend
flutter build apk --release  # For Android
flutter build ios --release  # For iOS
flutter build web           # For Web
```

## 📡 **API Endpoints**

### **Base URL**

```
http://localhost:3000
```

### **Available Endpoints**

| Method | Endpoint        | Description        |
| ------ | --------------- | ------------------ |
| GET    | `/products`     | Get all products   |
| GET    | `/products/:id` | Get product by ID  |
| POST   | `/products`     | Create new product |
| PUT    | `/products/:id` | Update product     |
| DELETE | `/products/:id` | Delete product     |

### **API Request/Response Examples**

#### **Get All Products**

```http
GET /products
Response: {
  "success": true,
  "data": [
    {
      "PRODUCTID": 1,
      "PRODUCTNAME": "iPhone 14",
      "PRICE": 999.99,
      "STOCK": 50
    }
  ],
  "message": "Products retrieved successfully"
}
```

#### **Create Product**

```http
POST /products
Content-Type: application/json

{
  "productName": "New Product",
  "price": 299.99,
  "stock": 25
}
```

## 🗄️ **Database Schema**

### **PRODUCTS Table**

```sql
CREATE TABLE PRODUCTS (
  PRODUCTID INT PRIMARY KEY IDENTITY(1,1),
  PRODUCTNAME NVARCHAR(100) NOT NULL,
  PRICE DECIMAL(10, 2) NOT NULL,
  STOCK INT NOT NULL
)
```

## 🎯 **Features**

### **Frontend Features**

- ✅ Product listing with search functionality
- ✅ Add new products with form validation
- ✅ Edit existing products
- ✅ Delete products with confirmation
- ✅ Real-time search with debouncing (300ms)
- ✅ Responsive design
- ✅ Loading states and error handling
- ✅ Pull-to-refresh functionality

### **Backend Features**

- ✅ RESTful API with proper HTTP status codes
- ✅ Input validation for all fields
- ✅ CORS enabled for Flutter frontend
- ✅ Error handling middleware
- ✅ Database connection pooling
- ✅ Environment configuration support

## 🧪 **Testing**

### **Backend Testing**

```bash
cd backend
npm test
```

### **API Testing with cURL**

```bash
# Get all products
curl http://localhost:3000/products

# Create a product
curl -X POST http://localhost:3000/products \
  -H "Content-Type: application/json" \
  -d '{"productName": "Test Product", "price": 99.99, "stock": 10}'
```

## 🐛 **Troubleshooting**

### **Common Backend Issues**

1. **Database Connection Failed**

   - Check SQL Server is running
   - Verify database credentials in `.env`
   - Ensure database exists (run `npm run init-db`)

2. **Port Already in Use**
   - Change PORT in `.env` file
   - Kill existing process: `lsof -ti:3000 | xargs kill -9`

### **Common Frontend Issues**

1. **API Connection Failed**

   - Ensure backend server is running on `http://localhost:3000`
   - Check network permissions in Flutter app
   - Verify API base URL configuration

2. **Flutter Dependencies**
   - Run `flutter clean && flutter pub get`
   - Update Flutter SDK: `flutter upgrade`

## 📱 **Supported Platforms**

- ✅ Android (API 21+)
- ✅ iOS (iOS 11+)
- ✅ Web
- ✅ Windows (Desktop)
- ✅ macOS (Desktop)
- ✅ Linux (Desktop)

## 🔧 **Development Tools**

### **Recommended Extensions**

- Flutter (VS Code)
- Dart (VS Code)
- Thunder Client (API Testing)
- SQL Server (mssql)

### **Useful Commands**

```bash
# Backend
npm run dev          # Start with nodemon
npm run init-db      # Initialize database

# Frontend
flutter doctor       # Check Flutter installation
flutter clean        # Clean build cache
flutter pub get      # Install dependencies
flutter pub upgrade  # Upgrade dependencies
```

## 📞 **Support**

For issues and questions:

- Create an issue in the repository
- Check the troubleshooting section above
- Review Flutter and Node.js documentation
