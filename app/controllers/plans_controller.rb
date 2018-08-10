class PlansController < ApplicationController

  def new
    @plan = Plan.new
  end

  def index
  end

  def show
  end

  def pay
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]

    charge = Payjp::Charge.create(
      :amount => 10000,
      :card => params[:token],
      :currency => 'jpy',
    )
  end

end
