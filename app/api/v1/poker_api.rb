module V1
  class PokerAPI < Grape::API
    version 'v1', using: :path
    format :json
    resource :poker do
      params do
        requires :cards, message: "のパラメーターが不正です"
      end

      desc "役判定ロジック"
      post do
        response = {}
        result = []
        error = []
        normal_card_list = []
        error_card_list = []
        hand_list = []
        error_list = []

        params[:cards].each do |card|
          card_valid = CardValidator.check_validate(card)

          if card_valid.empty?
            # もしバリデクリアしてたら役名判定ロジックへ進む
            normal_card_list << card
            # ①cardを入れる
            hand_list << CardService.result(card)
            # ②役名判定結果を入れる
          else
            error_card_list << card
            # ①cardを入れる
            error_msg = ''
            card_valid.each { |error| error_msg += error }
            error_list << error_msg
            # ②エラーメッセージを入れる
          end
        end

        best_list = CardService.best_card_judge(hand_list)
        # ベスト判定をする

        # 以下、エラーがないとき
        normal_card_list.each_with_index do |card, i|
          result_hash = {
            'card' => card,
            'hand' => hand_list[i],
            'best' => best_list.include?(i)
          }
           if result_hash.has_value?(true)
             result.unshift(result_hash)
           else
             result.push(result_hash)
           end
        end

        # 以下、エラーに引っかかったとき
        error_card_list.each_with_index do |card, i|
          error_hash = {
            'card' => card,
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
