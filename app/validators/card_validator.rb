class CardValidator

  CARD_NUMBER = 5
  # 手札の枚数を定義する
  CHECK_SUIT_AND_NUMBER = /^[S|D|H|C](1[0-3]|[1-9])$/
  # トランプのカードパターンを定義する

  def self.check_validate(cards)

    card_array = cards.split(' ')
    check_error = []

    # ①カードの枚数と1つの半角スペースを含むかチェック
    if card_array.length != CARD_NUMBER || cards.include?('  ')
      check_error << "5つのカード指定文字を半角スペース区切りで入力してください。（例：S1 H3 D9 C13 S11）"
      return check_error
    end

    # ②カードの重複がないかチェック
    if card_array.size != card_array.uniq.size
      check_error << "カードが重複しています。"
      return check_error
    end

    # ③指定の文字で構成されているかチェック
    card_array.each_with_index do |card, i|
      check_error << "#{i + 1}番目のカード指定文字が不正です(#{card})" if !card.match(CHECK_SUIT_AND_NUMBER)
      # 不正のある文字を指摘する
    end
    check_error << "半角英字大文字のスート(S,H,D,C)と数字(1〜13)の組み合わせでカードを指定してください。" if check_error.any?
    # 不正な文字があったら、適切な組み合わせを提示する
    check_error
  end
end
