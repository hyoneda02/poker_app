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
        hand_list = []

        params[:cards].each do |card|
          card_valid = CardValidator.check_validate(card)
          # バリデーションチェックをする
          if card_valid.present?
            # エラーメッセージがある場合
            error_hash = {
              'card' => card,
              'msg' => card_valid
            }
            error.push(error_hash)
          else
            # エラーメッセージがない場合
            card_hand = CardService.result(card)
            hand_list << card_hand
            # best判定のために配列に詰める
            result_hash = {
              'card' => card,
              'hand' => card_hand
            }
            result.push(result_hash)
          end
        end

        best_hand = CardService.best_card_judge(hand_list)
        # ベスト判定ロジックを呼び出す

        result.each do |result_hash|
          if best_hand == result_hash['hand']
            # ベストと判定されたハンドと任意のハンドを照らし合わせる
            result_hash.store('best', true)
          else
            result_hash.store('best', false)
          end
        end

        response[:result] = result
        response[:error] = error

        response
      end
    end
  end
end
