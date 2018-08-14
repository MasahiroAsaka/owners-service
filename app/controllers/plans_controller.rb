class PlansController < ApplicationController

  def new
    @plan = Plan.new
     @plan.captured_images.build
  end

  def index
  end

  def create
    plan = Plan.new(create_plan_params)
    binding.pry
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
        :text,
        :partner_message,
        :capacity,
        :place,
        :closing_date_month,
        :closing_date_day,
        :registration_fee,
        :content_of_service,
        :contract_period,
        :plan_schedule,
        :benefits,
        :etc,
        captured_images_attributes: [:content, :status, :order, :plan_id]
      )
    end

end
