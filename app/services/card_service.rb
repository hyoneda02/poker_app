
class CardService

  def self.result(cards)

    card_array = cards.split(" ")
    #スートと数字の組み合わせを一つずつ配列に入れる

      result = ""
      suit_array = []
      num_array = []
      uniq_array = []

    (0...card_array.length).each { |i|
      #0から5回繰り返す
      suit_array.push(card_array[i][0])
      #スートだけの配列を作る
      num_array.push(card_array[i][1..2].to_i)
      #数字だけの配列を作る
    }
    #.map使えそうだけどどっちの方が良いか？

      first_suit = suit_array[0]
      first_suit_array = [first_suit, first_suit, first_suit, first_suit, first_suit]
      #0番目のスートを5つ配列に入れる

      first_number = num_array.sort[0]
      step_num_array = [first_number]
      #一番最小さい数字を配列に入れておく
      (0..card_array.length-2).each { |i|
        #0から4回繰り返す
        first_number += 1
        step_num_array.push(first_number)
        #一番小さい数字から一つずつ増える数字を配列に入れる
      }


    if first_suit_array == suit_array
      #スートが全て同じとき
      if step_num_array == num_array.sort
        #数字が連続していたとき
        result = 'ストレートフラッシュ'
        return result
      else
        #数字がバラバラなとき
        result = 'フラッシュ'
        return result
      end
    end

      if first_suit_array != suit_array
        #スートが全て同じではないとき
        if step_num_array == num_array.sort
          #数字が連続していたとき
          result = 'ストレート'
          return result
        end
      end

      if first_suit_array != suit_array
        #スートが全て同じではないとき
        if num_array.uniq.size == 2
          #重複を消して、数字が2パターンであるとき
          if num_array.count(num_array[0]) == 2 || num_array.count(num_array[0]) == 3
            #2枚と3枚の分かれ方をしたとき
            result = 'フルハウス'
            return result
          else
            #1枚と4枚の分かれ方をしたとき
            result = 'フォー・オブ・ア・カインド'
            return result
          end
        end
      end

      if first_suit_array != suit_array
        #スートが全て同じではないとき
        if num_array.uniq.size == 3
          #重複を消して、数字が3パターンであるとき
          (0..num_array.length-1).each { |i|
            uniq_array.push(num_array.count(num_array.uniq[i]))
          }
          if uniq_array.include?(3)
            #3枚、1枚、1枚の分かれ方をしたとき
            result = 'スリー・オブ・ア・カインド'
            return result
          else
            #2枚、2枚、1枚の分かれ方をしたとき
            result = 'ツーペア'
            return result
          end
        end
      end

      if first_suit_array != suit_array
        #スートが全て同じではないとき
        if num_array.uniq.size == 4
          #重複を消して、数字が4パターンであるとき
          result = 'ワンペア'
          return result
        elsif num_array.uniq.size == 5
          #重複がないとき
          result = 'ハイカード'
          return result
        end
      end
  end
end



