class OrdersController < ApplicationController
before_action  :set_plan, only: [:select_course, :input, :confirm]
before_action  :login_check, only: [:input]
# before_action  :set_order, only: [:input]

  def select_course
    @order = Order.new
  end

  def input
    @course_id_list    = params[:course_id_list].each_char.map(&:to_i)
    @course_count_list = params[:course_count_list].each_char.map(&:to_i)
    @order = Order.new(create_order_params)

    binding.pry

  end

  def confirm
    binding.pry
  end

  def purchase_cvs
  end

  def purchase_credit_card
  end

  def completion
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

    def create_order_params
      params.require(:order).permit(
        :owner_id,
        :course_id_list,
        :course_count_list
      )
    end

end
