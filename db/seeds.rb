# Reset data
User.destroy_all
Team.destroy_all
Stock.destroy_all
Wallet.destroy_all
Transaction.destroy_all

# Seed Users
user1 = User.create(email: "test1@example.com", password: Digest::SHA256.hexdigest("password123"))
user2 = User.create(email: "test2@example.com", password: Digest::SHA256.hexdigest("password456"))

# Seed Teams
team1 = Team.create(name: "Team Alpha")
team2 = Team.create(name: "Team Beta")

# Seed Stocks
stock1 = Stock.create(symbol: "AAPL")
stock2 = Stock.create(symbol: "TSLA")

# Create Wallets
user1_wallet = Wallet.create(owner: user1)
user2_wallet = Wallet.create(owner: user2)
team1_wallet = Wallet.create(owner: team1)
team2_wallet = Wallet.create(owner: team2)
stock1_wallet = Wallet.create(owner: stock1)
stock2_wallet = Wallet.create(owner: stock2)

# Transactions for Users
Transaction.create(wallet: user1_wallet, amount: 1000, transaction_type: "credit")
Transaction.create(wallet: user2_wallet, amount: 500, transaction_type: "credit")
Transaction.create(wallet: user1_wallet, amount: -200, transaction_type: "debit")

# Transactions for Teams
Transaction.create(wallet: team1_wallet, amount: 2000, transaction_type: "credit")
Transaction.create(wallet: team2_wallet, amount: 1500, transaction_type: "credit")

# Transactions for Stocks
Transaction.create(wallet: stock1_wallet, amount: 3000, transaction_type: "credit")
Transaction.create(wallet: stock2_wallet, amount: 2500, transaction_type: "credit")

puts "Seeding complete!"
puts "User 1 Balance: #{user1_wallet.calculate_balance}"
puts "User 2 Balance: #{user2_wallet.calculate_balance}"
puts "Team 1 Balance: #{team1_wallet.calculate_balance}"
puts "Team 2 Balance: #{team2_wallet.calculate_balance}"
puts "Stock 1 Balance: #{stock1_wallet.calculate_balance}"
puts "Stock 2 Balance: #{stock2_wallet.calculate_balance}"
