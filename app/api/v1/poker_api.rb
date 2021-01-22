module V1
  class PokerAPI < Grape::API
    version 'v1', using: :path
    format :json
    resource :poker do
      params do
        requires :cards, message: "のパラメーターが不正です"
      end

      desc '役判定ロジック'
      post do
        response = {}
        result = []
        error = []
        normal_card_list = []
        error_card_list = []
        hand_list = []
        error_list = []

        params[:cards].each do |card|
          if CardValidator.check_validate(card).empty?
            # もしバリデクリアしてたら役名判定ロジックへ進む
            normal_card_list << card
            hand_list << CardService.result(card)
          else
            error_msg = ""
            error_card_list << card
            CardValidator.check_validate(card).each { | error| error_msg += error }
            error_list << error_msg
          end
        end

        best_list = CardJudge.judge(hand_list)

        normal_card_list.each_with_index do |cards, i|
          result_hash = {
            'card' => cards,
            'hand' => hand_list[i],
            'best' => best_list.include?(i)
          }

           if result_hash.has_value?(true)
             result.unshift(result_hash)
           else
             result.push(result_hash)
           end
        end

        error_card_list.each_with_index do |cards, i|
          error_hash = {
            'card' => cards,
            'mag' => error_list[i]
          }
          error.push(error_hash)
        end

        response[:result] = result
        response[:error] = error

        response
      end
    end
  end
end
