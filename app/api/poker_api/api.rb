
module PokerApi

  class API < Grape::API

    rescue_from :all do |e|
      rack_response({message: "リクエストの構文が不正です", status: "400 Bad Request"}.to_json, 400)
    end


    version 'v1', using: :path
    format :json

    resource :poker do
      desc 'Judge_logic'
      post do
        response = {}
        result = []
        error = []
        normal_card_list = []
        error_card_list = []
        hand_list = []
        error_list = []

        params[:cards].each do |cards|

          if CardValidator.check_validate(cards).empty?
            #もしバリデクリアしてたら役名判定ロジックへ進む
            normal_card_list << cards
            hand_list << CardService.result(cards)
          else
            error_card_list << cards
            error_list << CardValidator.check_validate(cards)
          end

        end

          best_list = CardJudge.judge(hand_list)

        normal_card_list.each_with_index do |cards, index|
           result_hash = {
            'card' => cards,
            'hand' => hand_list[index],
            'best' => best_list.include?(index)
            }

             if result_hash.has_value?(true)
               result.unshift(result_hash)
             else
               result.push(result_hash)
             end
        end

        error_card_list.each_with_index do |cards, index|
            error_hash = {
             'card' => cards,
             'mag' => error_list[index]
              }
            error.push(error_hash)
        end

          response[:result] = result
          response[:error] = error
          return response
      end
    end
  end
end




