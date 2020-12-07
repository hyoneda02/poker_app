# coding: utf-8

class HomeController < ApplicationController

  def poker
    poker = { name: "mori", type: "animal"}
    render json: poker
  end

  def show
    #render text: "card = #{params[:dest]}, hand = #{params[:num]}"
    #上なくてもいけそう。
  end

  def new
    name = "John"
    puts name
    #@card = HomeController.find(params[:id])
  end


  def home
    request = {`card` => `H1 H13 H12 H11 H10`, `hand` => `Straight Frash`}
   render :json => request
  end

  end

