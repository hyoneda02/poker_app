require 'rails_helper'

describe CardValidator do
  describe '#check_validate' do
    let(:cards){"S1 S2 S3 S4"}
    it '入力枚数不正（少）' do
      expect(CardValidator.check_validate(cards)).to eq ["5つのカード指定文字を半角スペース区切りで入力してください。（例：S1 H3 D9 C13 S11）"]
    end
  end

  describe '#check_validate' do
    let(:cards){"S1 S2 S3 S4 S5 S6"}
    it '入力枚数不正（多）' do
      expect(CardValidator.check_validate(cards)).to eq ["5つのカード指定文字を半角スペース区切りで入力してください。（例：S1 H3 D9 C13 S11）"]
    end
  end

  describe '#check_validate' do
    let(:cards){"S1S2S3S4S5"}
    it '入力形式不正（半角スペースなし）' do
      expect(CardValidator.check_validate(cards)).to eq ["5つのカード指定文字を半角スペース区切りで入力してください。（例：S1 H3 D9 C13 S11）"]
    end
  end

  describe '#check_validate' do
    let(:cards){"S1　S2　S3　S4　S5"}
    it '入力形式不正（全角スペース）' do
      expect(CardValidator.check_validate(cards)).to eq ["5つのカード指定文字を半角スペース区切りで入力してください。（例：S1 H3 D9 C13 S11）"]
    end
  end

  describe '#check_validate' do
    let(:cards){"S1 S2 S3 S4 S4"}
    it 'カード重複' do
      expect(CardValidator.check_validate(cards)).to eq ["カードが重複しています。"]
    end
  end

  describe '#check_validate' do
    let(:cards){"F1 S2 S3 S4 S5"}
    it '入力内容不正（suit指定範囲外）' do
      expect(CardValidator.check_validate(cards)).to eq ["1番目のカード指定文字が不正です(F1)",
                                                         "半角英字大文字のスート(S,H,D,C)と数字(1〜13)の組み合わせでカードを指定してください。"]
    end
  end

  describe '#check_validate' do
    let(:cards){"s1 S2 S3 S4 S5"}
    it '入力内容不正（suit小文字）' do
      expect(CardValidator.check_validate(cards)).to eq ["1番目のカード指定文字が不正です(s1)",
                                                         "半角英字大文字のスート(S,H,D,C)と数字(1〜13)の組み合わせでカードを指定してください。"]
    end
  end

  describe '#check_validate' do
    let(:cards){"Ｓ1 S2 S3 S4 S5"}
    it '入力内容不正（suit全角）' do
      expect(CardValidator.check_validate(cards)).to eq ["1番目のカード指定文字が不正です(Ｓ1)",
                                                         "半角英字大文字のスート(S,H,D,C)と数字(1〜13)の組み合わせでカードを指定してください。"]
    end
  end

  describe '#check_validate' do
    let(:cards){"S51 S2 S3 S4 S5"}
    it '入力内容不正（number指定範囲外）' do
      expect(CardValidator.check_validate(cards)).to eq ["1番目のカード指定文字が不正です(S51)",
                                                         "半角英字大文字のスート(S,H,D,C)と数字(1〜13)の組み合わせでカードを指定してください。"]
    end
  end

  describe '#check_validate' do
    let(:cards){"S１ S2 S3 S4 S5"}
    it '入力内容不正（number全角）' do
      expect(CardValidator.check_validate(cards)).to eq ["1番目のカード指定文字が不正です(S１)",
                                                         "半角英字大文字のスート(S,H,D,C)と数字(1〜13)の組み合わせでカードを指定してください。"]
    end
  end
end