
class CardValidator

  def self.check_validate(check_cards)

    check_cards_array = check_cards.split(" ")
    check_error = []
    check_num_array = []

    if check_cards_array.length != 5
      check_error << "5つのカード指定文字を半角スペース区切りで入力してください。（例：S1 H3 D9 C13 S11）"
    end


    if check_cards_array.size != check_cards_array.uniq.size
      check_error << "カードが重複しています。"
      return check_error
    end

    (0...check_cards_array.length).each { |i|
      check_num_array.push(check_cards_array[i][1..2].to_i)
      unless check_cards_array[i].match(/^[S|D|H|C](1[0-3]|[1-9])$/)
        check_error << "#{i + 1}番目のカード指定文字が不正です(#{check_cards_array[i]})"
        check_error << "半角英字大文字のスート(S,H,D,C)と数字(1〜13)の組み合わせでカードを指定してください。"
      end
    }

    return check_error.uniq
    #join(separator = "\\n")

  end
end