class Stock < ApplicationRecord
  has_many :user_stocks
  has_many :users, through: :user_stocks

  validates :name, :ticker, presence: true

  def self.new_lookup(ticker_symbol)
    client = IEX::Api::Client.new(
      publishable_token: Rails.application.credentials.iex_find[:sandbox_api_key],
      endpoint: 'https://sandbox.iexapis.com/v1'
    )
    begin
      new(ticker: ticker_symbol, name: client.company(ticker_symbol).company_name, last_price: client.price(ticker_symbol))
    rescue => exception
      nil
    end
    # this is so that if anyone enters invalid ticker we make it equal to nil and then the controller sees that
    # and displays a message saying to enter valid ticker
  end

  def self.findin_db(ticker_symbol)
    where(ticker: ticker_symbol).first
  end
end
# user stocks is the database of users/stocks they track, so a stock can be on there
# many times, therefore it has many instances of user_stocks, has many users through this
