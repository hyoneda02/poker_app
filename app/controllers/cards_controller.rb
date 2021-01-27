class CardsController < ApplicationController

  def judge_cards
    @cards = params[:cards]
    @error = CardValidator.check_validate(params[:cards])
    @result = CardService.result(params[:cards]) if @error.empty?
    render 'cards/show'
    # judge_cardsのHTMLに画面遷移させず、showのHTMLに誘導する
  end
end
