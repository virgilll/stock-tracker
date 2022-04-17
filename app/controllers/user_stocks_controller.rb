class UserStocksController < ApplicationController

  def create
    stock = Stock.findin_db(params[:ticker])
    if stock.blank?
      stock = Stock.new_lookup(params[:ticker])
      stock.save
    end
    @user_stock = UserStock.create( user: current_user, stock: stock)
    flash[:notice] = "#{stock.name} added to portfolio!"
    redirect_to my_portfolio_path
  end
end
