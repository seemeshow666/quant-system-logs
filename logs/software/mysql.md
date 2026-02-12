# MySQL Installation Log

## Installation Date
2026-02-12

## Installation Command
```bash
sudo apt-get install -y mysql-server mysql-client
```

## Configuration
```bash
# Set root password
mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY 'quant@2024';"

# Create database and user
CREATE DATABASE quant_db CHARACTER SET utf8mb4;
CREATE USER 'quant_user'@'localhost' IDENTIFIED BY 'quant@2024';
GRANT ALL PRIVILEGES ON quant_db.* TO 'quant_user'@'localhost';
```

## Connection Details
- Host: localhost
- Port: 3306
- Database: quant_db
- User: quant_user
- Password: quant@2024

## Important Commands
```bash
# Connect to MySQL
mysql -u root -p'quant@2024'
mysql -u quant_user -p'quant@2024' quant_db

# Check status
sudo systemctl status mysql

# Restart MySQL
sudo systemctl restart mysql
```

## Database Structure
```
quant_db/
├── tables/
├── data/
└── backups/
```

## Notes
- MySQL 8.0 installed
- Root password: quant@2024
- Database encoding: utf8mb4
