
class CardService

  def self.result(cards)

    result = ""

    card_array = cards.split(" ")
    #スートと数字の組み合わせを一つずつ配列に入れる

      suit_array = []
      num_array = []
      uniq_array = []

    (0...card_array.length).each { |i|
      suit_array.push(card_array[i][0])
      #suite_array = ["S", "S", "S", "S", "S"]
      num_array.push(card_array[i][1..2].to_i)
      #num_array = [1, 2, 3, 4, 5]
    }

    firstSuit = suit_array[0]
    firstSuit_array = [firstSuit, firstSuit, firstSuit, firstSuit, firstSuit]
    firstNumber = num_array.sort[0]

      new_num_array = [firstNumber]
      #new_num_array = [1]

      (0..card_array.length-2).each do |i|
        firstNumber += 1
        new_num_array.push(firstNumber)
        #new_num_array = [1, 2, 3, 4, 5]
      end

    (1...card_array.length).each { |i|
      if firstSuit_array != suit_array
        #最初のスートを繰り返した配列とリクエストそのままのスートの配列が等しいとき
        if new_num_array == num_array.sort
          #数字が連続していたとき
          result = 'ストレート'
        elsif num_array.uniq.size == 2
          if num_array.count(num_array[0]) == 2 || num_array.count(num_array[0]) == 3
            result = 'フルハウス'
            #　==2or3にする方法募集中
          else
            result = 'フォー・オブ・ア・カインド'
          end
        elsif num_array.uniq.size == 3
          (0..num_array.length - 1).each { |i|
            uniq_array.push(num_array.count(num_array.uniq[i]))
          }
          if uniq_array.include?(3)
            result = 'スリー・オブ・ア・カインド'
          else
            result = 'ツーペア'
          end
        elsif num_array.uniq.size == 4
          result = 'ワンペア'
        else
          result = 'ハイカード'
        end
      end

      if firstSuit_array == suit_array
        #最初のスートと他のスートが同じマークのとき
        if new_num_array == num_array.sort
          #数字が連続していたとき
          result = 'ストレートフラッシュ'
        else
          #数字がバラバラなとき
          result = 'フラッシュ'
        end
      end
    }
      result

  end

end



