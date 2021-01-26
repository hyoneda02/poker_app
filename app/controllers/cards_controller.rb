class CardsController < ApplicationController

  def show; end

  def judge_cards
    @cards = params[:cards]
    @error = CardValidator.check_validate(params[:cards])
    @result = CardService.result(params[:cards])  if @error.blank?

    render 'cards/show'
  end
end
