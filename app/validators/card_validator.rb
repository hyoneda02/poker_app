class CardValidator
  def self.check_validate(check_cards)

    cards = check_cards.split(" ")
    check_error = []

    if cards.length != 5 || check_cards.include?("  ")
      check_error << "5つのカード指定文字を半角スペース区切りで入力してください。（例：S1 H3 D9 C13 S11）"
      return check_error
    end

    if cards.size != cards.uniq.size
      check_error << "カードが重複しています。"
      return check_error
    end

    (0...cards.length).each do |i|
      if !cards[i].match(/^[S|D|H|C](1[0-3]|[1-9])$/)
        check_error << "#{i + 1}番目のカード指定文字が不正です(#{cards[i]})"
      end
    end

    check_error << "半角英字大文字のスート(S,H,D,C)と数字(1〜13)の組み合わせでカードを指定してください。" if check_error.any?

    check_error
  end
end