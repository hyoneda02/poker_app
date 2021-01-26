class CardsController < ApplicationController

  def show; end
  # フォーム入力のHTMLを表示させるだけ

  def judge_cards
    @cards = params[:cards]
    @error = CardValidator.check_validate(params[:cards])
    @result = CardService.result(params[:cards])  if @error.blank?

    render 'cards/show'
    # judge_cardsのHTMLに画面遷移させず、showのHTMLに誘導する
  end
end
