class OrdersController < ApplicationController
before_action  :set_plan, only: [:select_course, :input, :confirm, :purchase]
before_action  :login_check, only: [:input]
# before_action  :set_order, only: [:confirm]
# before_action  :set_order, only: [:confirm, :purchase]
# before_action  :set_address, only: [:purchase]

  def select_course
    @order = Order.new
  end

  def input
    @course_id_list    = params[:course_id_list].each_char.map(&:to_i)
    @course_count_list = params[:course_count_list].each_char.map(&:to_i)
    @sum_price         = params[:order][:sum]

    @addresses = Address.where("owner_id = '#{current_owner.id}' ")

    @order   = Order.new
    # @order.addresses.build
    @address_new = Address.new

  end

  def confirm
    @course_id_list    = params[:order][:course_id_list].gsub(/[^\d]/, "").each_char.map(&:to_i)
    @course_count_list = params[:order][:course_count_list].gsub(/[^\d]/, "").each_char.map(&:to_i)
    @sum_price         = params[:order][:sum]

    @name              = params[:address][:name]
    @zip_code_1        = params[:address][:zip_code_1]
    @zip_code_2        = params[:address][:zip_code_2]
    @state             = params[:address][:state]
    @address_1         = params[:address][:address_1]
    @address_2         = params[:address][:address_2]
    @tel               = params[:address][:tel]
    @owner_id          = params[:address][:owner_id]

    @order = Order.new(order_params)
    @address = Address.new(address_params)
    # @address.save
  end

  def purchase
    @sum_price         = params[:order][:sum]

    # @course_id_list    = params[:order][:course_id_list].gsub(/[^\d]/, "").each_char.map(&:to_i)
    # @course_count_list = params[:order][:course_count_list].gsub(/[^\d]/, "").each_char.map(&:to_i)
    # @sum_price         = params[:order][:sum]

    # @name              = params[:address][:name]
    # @zip_code_1        = params[:address][:zip_code_1]
    # @zip_code_2        = params[:address][:zip_code_2]
    # @state             = params[:address][:state]
    # @address_1         = params[:address][:address_1]
    # @address_2         = params[:address][:address_2]
    # @tel               = params[:address][:tel]
    # @owner_id          = params[:address][:owner_id]

    # @order = Order.new(order_params)
    # @address = Address.new(address_params)
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

    # def set_order
    #   @order = Order.where("owner_id = '#{current_owner.id}' ").last
    # end

    # def set_address
    #   @address = Address.where("owner_id = '#{current_owner.id}' ")
    # end

    def order_params
      params.require(:order).permit(
        :owner_id,
        :course_id_list,
        :course_count_list,
        :sum,
        :description
        # addresses_attributes:[
        #   :id
        #   :name,
        #   :zip_code_1,
        #   :zip_code_2,
        #   :state,
        #   :address_1,
        #   :address_2,
        #   :tel,
        #   :owner_id
        # ]
      )
    end

    def address_params
      params.require(:address).permit(
        :name,
        :zip_code_1,
        :zip_code_2,
        :state,
        :address_1,
        :address_2,
        :tel,
        :owner_id
      )
    end

end
