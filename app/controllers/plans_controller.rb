class PlansController < ApplicationController

  def index
  end

  def show
  end

  def pay
    Payjp.api_key = 'sk_test_707a902033b10cc36168171e'

    charge = Payjp::Charge.create(
      :amount => 10000,
      :card => params[:token],
      :currency => 'jpy',
    )
  end

end
