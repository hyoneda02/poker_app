# coding: utf-8

class CardsController < ApplicationController

  attr_reader :card, :cards, :error

  def show

  end

  def judge_cards
    @cards = params[:cards]
    @error = CardValidator.check_validate(params[:cards])

    if @error.blank?
     @result = CardService.result(params[:cards])
    end

    render "cards/show"

  end
end


