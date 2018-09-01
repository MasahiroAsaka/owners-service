class OrdersController < ApplicationController
before_action  :set_plan, only: [:select_cources]
before_action  :login_check, only: [:select_cources_2]

  def select_cources
  end

  def select_cources_2
  end

  def purchase_cvs
  end

  def purchase_credit_card
  end

  def confirming
  end

  def login_check
    unless owner_signed_in?
      redirect_to new_owner_session_path
    end
  end

  private
  def set_plan
    @plan = Plan.find(params[:id])
  end

end
