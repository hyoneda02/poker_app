require 'rails_helper'

describe CardService do
  describe '#result' do
    context 'ストレートフラッシュのとき' do
      let(:cards) { "C7 C6 C5 C4 C3" }
        it 'ストレートフラッシュと判定されるか' do
          expect(CardService.result(cards)).to eq "ストレートフラッシュ"
        end
    end
    context 'フォー・オブ・ア・カインドのとき' do
      let(:cards) { "C10 D10 H10 S10 D5" }
        it 'フォー・オブ・ア・カインドと判定されるか' do
          expect(CardService.result(cards)).to eq "フォー・オブ・ア・カインド"
        end
    end
    context 'フルハウスのとき' do
      let(:cards) { "S10 H10 D10 S4 D4" }
        it 'フルハウスと判定されるか' do
          expect(CardService.result(cards)).to eq "フルハウス"
        end
    end
    context 'フラッシュのとき' do
      let(:cards) { "H1 H12 H10 H5 H3" }
        it 'フラッシュと判定されるか' do
          expect(CardService.result(cards)).to eq "フラッシュ"
        end
    end
    context 'ストレートのとき' do
      let(:cards) { "S8 S7 H6 H5 S4" }
        it 'ストレートと判定されるか' do
          expect(CardService.result(cards)).to eq "ストレート"
        end
    end
    context 'スリー・オブ・ア・カインドのとき' do
      let(:cards) { "S12 C12 D12 S5 C3" }
        it 'スリー・オブ・ア・カインドと判定されるか' do
          expect(CardService.result(cards)).to eq "スリー・オブ・ア・カインド"
        end
    end
    context 'ツーペアのとき' do
      let(:cards) { "H13 D13 C2 D2 H11" }
        it 'ツーペアと判定されるか' do
          expect(CardService.result(cards)).to eq "ツーペア"
        end
    end
    context 'ワンペアのとき' do
      let(:cards) { "C10 S10 S6 H4 H2" }
        it 'ワンペアと判定されるか' do
          expect(CardService.result(cards)).to eq "ワンペア"
        end
    end
    context 'ハイカードのとき' do
      let(:cards) { "D1 D10 S9 C5 C4" }
        it 'ハイカードと判定されるか' do
          expect(CardService.result(cards)).to eq "ハイカード"
        end
    end
  end

  describe '#best_card_judge' do
    context '0番目のストレートフラッシュが一番強いとき' do
      let(:hands) { ["ストレートフラッシュ", "フルハウス", "ハイカード"] }
        it '0番目がbestだと判定されるか' do
          expect(CardService.best_card_judge(hands)).to eq [0]
        end
    end
    context '1番目のストレートフラッシュが一番強いとき' do
      let(:hands) { ["フルハウス", "ストレートフラッシュ", "ハイカード"] }
        it '1番目がbestだと判定されるか' do
          expect(CardService.best_card_judge(hands)).to eq [1]
        end
    end
    context '2番目のストレートフラッシュが一番強いとき' do
      let(:hands) { ["フルハウス", "ハイカード", "ストレートフラッシュ"] }
        it '2番目がbestだと判定されるか' do
          expect(CardService.best_card_judge(hands)).to eq [2]
        end
    end
  end
end
