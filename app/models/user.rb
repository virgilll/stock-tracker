class User < ApplicationRecord
  has_many :user_stocks
  has_many :stocks, through: :user_stocks
  has_many :friendships
  has_many :friends, through: :friendships
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def already_tracked?(ticker_symbol)
    stock = Stock.findin_db(ticker_symbol)
    # if stock already in database that means its being tracked so return true
    return false unless stock
    Stock.where(id: stock.id).exists?
    # check if stock is already in db, if not check if it is already in portfolio
  end
  # these methods are used to check if a stock can be added to portfolio

  def under_limit?
    stocks.count < 10
  end

  def can_track?(ticker_symbol)
    under_limit? && !already_tracked?(ticker_symbol)
    # method used to check the two conditions in which stock cannot be tracked
  end

  def full_name
    return "#{first_name} #{last_name}" if first_name || last_name
    "Anonymous"
  end
end
