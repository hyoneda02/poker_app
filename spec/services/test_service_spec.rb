require 'rails_helper'

describe CardService do

  describe 'POST #judge_cards' do
    let(:cards){"C7 C6 C5 C4 C3"}
    it 'ストレートフラッシュ' do
      expect(CardService.result(cards)).to eq "ストレートフラッシュ"
    end
  end

  describe 'POST #judge_cards' do
    let(:cards){"C10 D10 H10 S10 D5"}
    it 'フォー・オブ・ア・カインド' do
      expect(CardService.result(cards)).to eq "フォー・オブ・ア・カインド"
    end
  end

  describe 'POST #judge_cards' do
   let(:cards){"S10 H10 D10 S4 D4"}
      it 'フルハウス' do
        expect(CardService.result(cards)).to eq "フルハウス"
      end
  end

  describe 'POST #judge_cards' do
    let(:cards){"H1 H12 H10 H5 H3"}
    it 'フラッシュ' do
      expect(CardService.result(cards)).to eq "フラッシュ"
    end
  end

  describe 'POST #judge_cards' do
    let(:cards){"S8 S7 H6 H5 S4"}
    it 'ストレート' do
      expect(CardService.result(cards)).to eq "ストレート"
    end
  end

  describe 'POST #judge_cards' do
    let(:cards){"S12 C12 D12 S5 C3"}
    it 'スリー・オブ・ア・カインド' do
      expect(CardService.result(cards)).to eq "スリー・オブ・ア・カインド"
    end
  end

  describe 'POST #judge_cards' do
    let(:cards){"H13 D13 C2 D2 H11"}
    it 'ツーペア' do
      expect(CardService.result(cards)).to eq "ツーペア"
    end
  end

  describe 'POST #judge_cards' do
    let(:cards){"C10 S10 S6 H4 H2"}
    it 'ワンペア' do
      expect(CardService.result(cards)).to eq "ワンペア"
    end
  end

  describe 'POST #judge_cards' do
    let(:cards){"D1 D10 S9 C5 C4"}
    it 'ハイカード' do
      expect(CardService.result(cards)).to eq "ハイカード"
    end
  end

end