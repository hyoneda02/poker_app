
class CardService

  def self.result(cards)

    card_array = cards.split(" ")
    # 半角スペースで区切って、カードを配列に入れる
    suit_array = card_array.map {|card| card[0]}
    # スートだけの配列を作る
    num_array = card_array.map {|card| card[1..2].to_i}
    # 数字だけの配列を作る
    uniq_size = num_array.uniq.size
    # 重複がないときの数字のパターン数

    # 以下、役ごとの数字のパターン数と分かれ方を定義する
    full_house_four_of_a_kind_size = 2
    three_of_a_kind_two_pair_size = 3
    one_pair_size = 4
    high_card_size = 5
    full_house_pattern = 2
    full_house_pattern2 = 3

    first_suit_array = [suit_array[0]]*card_array.length
    # 0番目のスートを5つ配列に入れる：フラッシュの処理準備

    # 以下、ストレートの処理準備
    first_number = num_array.min
    step_num_array = [first_number]
    (1..card_array.length-1).each { |number| step_num_array.push(first_number += 1)}
    # 1番小さい数字から1ずつ増える数字を4回配列に入れる

    # 以下、[1,10,11,12,13]もストレートになるようにする処理準備
    min_num = 1
    max_num = 13
    straight_exception_array = [min_num]
    (1..num_array.length-1).each do |number|
      number += max_num-(num_array.length-1)
      straight_exception_array.push(number)
      # maxnumberから4引いて、+1を4回繰り返す
    end

    # 以下、役判定の条件文
      if first_suit_array == suit_array
        # スートが全て同じとき
        if step_num_array == num_array.sort || straight_exception_array == num_array.sort
          # 数字が連続していたとき
          return 'ストレートフラッシュ'
        else
          # 数字がバラバラなとき
          return 'フラッシュ'
        end
        # if文が長くなったので条件文は前に持ってきた
      end

      if first_suit_array != suit_array
        # スートが全て同じではないとき
        if step_num_array == num_array.sort || straight_exception_array == num_array.sort
          # 数字が連続していたとき
          return 'ストレート'
        end
      end

      if first_suit_array != suit_array
        # スートが全て同じではないとき
        if uniq_size == full_house_four_of_a_kind_size
          # 重複を消して、数字が2パターンであるとき
          if num_array.count(num_array[0]) == full_house_pattern || num_array.count(num_array[0]) == full_house_pattern2
            return 'フルハウス'
            # 2枚と3枚の分かれ方をしたとき
          else
            return 'フォー・オブ・ア・カインド'
            # 1枚と4枚の分かれ方をしたとき
          end
        end
      end

      if first_suit_array != suit_array
        # スートが全て同じではないとき
        if uniq_size == three_of_a_kind_two_pair_size
          # 重複を消して、数字が3パターンであるとき
          uniq_count_array = []
          (0..num_array.length-1).each_with_index do |uniq_number ,i|
            uniq_count_array.push(num_array.count(num_array.uniq[i]))
            # 重複されている数だけの配列を作る
          end
          return 'スリー・オブ・ア・カインド' if uniq_count_array.include?(3)
          # 3枚、1枚、1枚の分かれ方をしたとき
          return 'ツーペア'
          # 2枚、2枚、1枚の分かれ方をしたとき
        end
      end

      if first_suit_array != suit_array
        # スートが全て同じではないとき
        return 'ワンペア' if uniq_size == one_pair_size
        # 重複を消して、数字が4パターンであるとき
        'ハイカード' if uniq_size == high_card_size
        # 重複を消しても数字が5パターンであるとき
      end
  end
end



