class PlansController < ApplicationController
before_action  :set_plan, only: [:show]

  def new
    @plan = Plan.new
    @plan.captured_images.build
  end

  def index
    @plans = Plan.all
  end

  def create
    plan = Plan.new(create_plan_params)
    plan.save
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

  private

    def create_plan_params
      params.require(:plan).permit(
        :title,
        :shop_name,
        :contents,
        :place,
        :closing_date_month,
        :closing_date_day,
        :registration_fee,
        captured_images_attributes: [:content, :status, :order, :plan_id]
      )
    end

    def set_plan
      @plan = Plan.find(params[:id])
    end
end
