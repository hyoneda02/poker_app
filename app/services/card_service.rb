
class CardService
  # 以下、役ごとに重複する数字を消したときのパターン数を定義する
  FULL_HOUSE_FOUR_OF_A_KIND_SIZE = 2
  THREE_OF_A_KIND_TWO_PAIR_SIZE = 3
  ONE_PAIR_SIZE = 4
  HIGH_CARD_SIZE = 5
  # 以下、フルハウスの数字の分かれ方を定義する
  FULL_HOUSE_PATTERN = [2, 3].freeze

  MIN_NUM = 1
  MAX_NUM = 13

  def self.result(cards)

    card_array = cards.split(' ')
    # 半角スペースで区切って、カードを配列に入れる
    suit_array = card_array.map { |card| card[0] }
    # スートだけの配列を作る
    num_array = card_array.map { |card| card[1..2].to_i }
    # 数字だけの配列を作る
    sorted_num_array = num_array.sort
    # 小さい順に並べる
    uniq_size = num_array.uniq.size
    # 重複がないときの数字のパターン数


    first_suit_array = [suit_array[0]] * card_array.length
    # 0番目のスートを5つ配列に入れる：フラッシュの処理準備

    # 以下、ストレートの処理準備
    first_number = num_array.min
    step_num_array = [first_number]
    (1..card_array.length - 1).each { |_number| step_num_array.push(first_number += 1) }
    # 1番小さい数字から1ずつ増える数字を4回配列に入れる

    # 以下、[1,10,11,12,13]もストレートになるようにする処理準備
    straight_exception_array = []
    MAX_NUM.downto(MAX_NUM - 3) { |number| straight_exception_array.unshift(number) }
    straight_exception_array.unshift(MIN_NUM)

    #straight_exception_array2 = []
    #(num_array.length - 1).downto(1) { |number| straight_exception_array2.push(MAX_NUM - number) }
    #print straight_exception_array2

    # 以下、スリー・オブ・ア・カインドの準備
    uniq_count_array = []
    (0..num_array.length - 1).each_with_index do |_uniq_number ,i|
      uniq_count_array.push(num_array.count(num_array.uniq[i]))
      # 重複されている数だけの配列を作る
    end

    # 以下、役判定の条件文

    if first_suit_array == suit_array
      # スートが全て同じとき
      if step_num_array == sorted_num_array || straight_exception_array == sorted_num_array
        # 数字が連続していたとき
        return 'ストレートフラッシュ'
      end
        # 数字がバラバラなとき
        return 'フラッシュ'
    else
      # スートが全て同じではないとき
      if step_num_array == sorted_num_array || straight_exception_array == sorted_num_array
        # 数字が連続していたとき
        return 'ストレート'
      end

      if uniq_size == FULL_HOUSE_FOUR_OF_A_KIND_SIZE
        # 重複を消して、数字が2パターンであるとき
        return 'フルハウス' if FULL_HOUSE_PATTERN.include?(num_array.count(num_array[0]))
        # 2枚と3枚の分かれ方をしたとき
        return 'フォー・オブ・ア・カインド'
        # 1枚と4枚の分かれ方をしたとき
      end

      if uniq_size == THREE_OF_A_KIND_TWO_PAIR_SIZE
        # 重複を消して、数字が3パターンであるとき
        return 'スリー・オブ・ア・カインド' if uniq_count_array.include?(3)
        # 3枚、1枚、1枚の分かれ方をしたとき
        return 'ツーペア'
        # 2枚、2枚、1枚の分かれ方をしたとき
      end

      return 'ワンペア' if uniq_size == ONE_PAIR_SIZE
      # 重複を消して、数字が4パターンであるとき
      'ハイカード' if uniq_size == HIGH_CARD_SIZE
      # 重複を消しても数字が5パターンであるとき
    end
  end

  # @params [Array] hands 役名の配列
  # @return [Array] 受け取った役の中で、一番強い役の番号（何番目のcardか）

  def self.best_card_judge(hands)

    score = {
      'ストレートフラッシュ' => 9,
      'フォー・オブ・ア・カインド' => 8,
      'フルハウス' => 7,
      'フラッシュ' => 6,
      'ストレート' => 5,
      'スリー・オブ・ア・カインド' => 4,
      'ツーペア' => 3,
      'ワンペア' => 2,
      'ハイカード' => 1
    }

    scores = hands.map { |hand| score[hand] }
    # handsの配列の各要素に対してscoreを当てはめた新しい配列scoresを作る
    best_card = score.key(scores.max)
    # maxscoreのvalueを持つ役名keyをbest_cardとする
    best_list = []

    hands.each_with_index { |hand, i| best_list << i if hand == best_card }
    # 役名同士を照らし合わせて何番目のhandがbestかを判定し、配列に入れる

    best_list

  end
end
