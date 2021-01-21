
class CardService

  def self.result(cards)

    card_array = cards.split(" ")
    #半角スペースで区切って、カードを配列に入れる
    suit_array = card_array.map {|card| card[0]}
    #スートだけの配列を作る
    num_array = card_array.map {|card| card[1..2].to_i}
    #数字だけの配列を作る

    first_suit_array = [suit_array[0]]*5
    #0番目のスートを5つ配列に入れる：フラッシュの準備

    first_number = num_array.sort[0]
    step_num_array = [first_number]
    (1..4).each { |first_number|
      first_number += 1
      step_num_array.push(first_number)
      #1番小さい数字から1ずつ増える数字を4回配列に入れる：ストレートの準備
    }

    #以下、役判定の条件文

      if first_suit_array == suit_array
        #スートが全て同じとき
        if step_num_array||[1,10,11,12,13]||[1,2,11,12,13]||[1,2,3,11,12,]||[1,2,3,4,13] == num_array.sort
          #数字が連続していたとき
          return 'ストレートフラッシュ'
        else
          #数字がバラバラなとき
          return 'フラッシュ'
        end
      end

      if first_suit_array != suit_array
        #スートが全て同じではないとき
        if step_num_array ||[1,10,11,12,13]||[1,2,11,12,13]||[1,2,3,11,12,]||[1,2,3,4,13] == num_array.sort
          #数字が連続していたとき
          return 'ストレート'
        end
      end

      if first_suit_array != suit_array
        #スートが全て同じではないとき
        if num_array.uniq.size == 2
          #重複を消して、数字が2パターンであるとき
          if num_array.count(num_array[0]) == 2 || 3
            #2枚と3枚の分かれ方をしたとき
            return 'フルハウス'
          else
            #1枚と4枚の分かれ方をしたとき
            return 'フォー・オブ・ア・カインド'
          end
        end
      end

      if first_suit_array != suit_array
        #スートが全て同じではないとき
        if num_array.uniq.size == 3
          #重複を消して、数字が3パターンであるとき
          uniq_array = []
          (0..num_array.length-1).each { |i|
            uniq_array.push(num_array.count(num_array.uniq[i]))
          }
          if uniq_array.include?(3)
            #3枚、1枚、1枚の分かれ方をしたとき
            return 'スリー・オブ・ア・カインド'
          else
            #2枚、2枚、1枚の分かれ方をしたとき
            return 'ツーペア'
          end
        end
      end

      if first_suit_array != suit_array
        #スートが全て同じではないとき
        if num_array.uniq.size == 4
          #重複を消して、数字が4パターンであるとき
          return 'ワンペア'
        elsif num_array.uniq.size == 5
          #重複がないとき
          return 'ハイカード'
        end
      end
  end
end



