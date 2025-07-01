const errorHandler = (err, req, res, next) => {
  console.error("Error:", err);

  //Default Error
  let error = {
    success: false,
    message: err.message || "Internal Server Error",
    ...(process.env.NODE_ENV === "development" && { stack: err.stack }),
  };
  //SQL Server specific Error
  if (err.code) {
    switch (err.code) {
      case "ELOGIN":
        error.message = "Database authentication failed";
        res.status(500);
        break;
      case "ETIMEOUT":
        error.message = "Database connection timeout";
        res.status(504);
        break;
      case "EREQUEST":
        error.message = "Database request failed";
        res.status(400);
        break;
      default:
        res.status(500);
    }
  } else {
    res.status(err.statusCode || 500);
  }
  res.json(error);
};

module.exports = errorHandler;
