<<<<<<< HEAD:app/controllers/cards_controller.rb
class CardsController < ApplicationController
  before_action :authenticate_user!, only: [:show, :new, :create, :destroy]
  before_action :prepare_payjp, only: [:show, :new, :create, :destroy]
  before_action :header_menu,only: [:new,:show]
=======
module CardsActions
  extend ActiveSupport::Concern
>>>>>>> ma-kun92/master:app/controllers/concerns/cards_actions.rb

  def show
  end

  def new
    redirect_to action: :show if @card
  end

  def create
    token = params[:token]
    @customer.cards.create(card: token) if @customer.cards.count == 0
    redirect_to action: :show, notice: "カードが登録されました。"
  end

  def destroy
    @card.delete
    redirect_to action: :show, notice: "カード情報が削除されました。"
  end

  private
  def prepare_payjp
    gon.payjp_pk_key = ENV["PAYJP_PK_TEST"]
    Payjp.api_key = ENV["PAYJP_SK_TEST"]
    unless current_user.payjp_id
      current_user.payjp_id = Payjp::Customer.create(description: 'test').id
      current_user.save
    end
    @customer = Payjp::Customer.retrieve(current_user.payjp_id)
    @card = @customer.cards.retrieve(@customer.default_card) if @customer.cards.count > 0
  end

end
