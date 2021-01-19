require 'rails_helper'

describe PokerApi, type: :request do
  describe 'api' do

    context '正常なリクエストのとき' do
     let(:params){{cards: ["H1 H13 H12 H11 H10", "H9 C9 S9 H2 C2", "C13 D12 C11 H8 H7"]}}
      it '正常なレスポンスか' do
        expect(response).to  be_successful
      end
      it '201レスポンスが返ってくるか' do
        post '/v1/poker', params: params
        expect(response).to have_http_status "201"
      end
     #errormessageは何も入ってないのか？
    end
  end

  describe '#result' do
    before {post '/v1/poker', params: cards}

    context `ストレートフラッシュのとき`do
      let(:cards){"C7 C6 C5 C4 C3"}
        it 'ストレートフラッシュ' do
          expect(CardService.result(cards)).to eq "ストレートフラッシュ"
        end
    end

    context `フォー・オブ・ア・カインドのとき`do
      let(:cards){"C10 D10 H10 S10 D5"}
        it 'フォー・オブ・ア・カインド' do
         expect(CardService.result(cards)).to eq "フォー・オブ・ア・カインド"
       end
    end

    context `フルハウスのとき`do
      let(:cards){"S10 H10 D10 S4 D4"}
        it 'フルハウス' do
          expect(CardService.result(cards)).to eq "フルハウス"
        end
    end

    context `フラッシュのとき`do
      let(:cards){"H1 H12 H10 H5 H3"}
        it 'フラッシュ' do
         expect(CardService.result(cards)).to eq "フラッシュ"
        end
    end

    context `ストレートのとき`do
      let(:cards){"S8 S7 H6 H5 S4"}
        it 'ストレート' do
         expect(CardService.result(cards)).to eq "ストレート"
        end
    end

    context `スリー・オブ・ア・カインドのとき`do
      let(:cards){"S12 C12 D12 S5 C3"}
        it 'スリー・オブ・ア・カインド' do
         expect(CardService.result(cards)).to eq "スリー・オブ・ア・カインド"
       end
    end

    context `ツーペアのとき`do
      let(:cards){"H13 D13 C2 D2 H11"}
        it 'ツーペア' do
          expect(CardService.result(cards)).to eq "ツーペア"
        end
    end

    context `ワンペアのとき`do
      let(:cards){"C10 S10 S6 H4 H2"}
        it 'ワンペア' do
         expect(CardService.result(cards)).to eq "ワンペア"
         end
    end

    context `ハイカードのとき`do
      let(:cards){"D1 D10 S9 C5 C4"}
        it 'ハイカード' do
          expect(CardService.result(cards)).to eq "ハイカード"
        end
    end
  end

  describe '#judge' do
    let(:params){{hands: ["ストレートフラッシュ", "フルハウス", "ハイカード"]}}
    it 'best判定が正常になされること' do
         expect(CardJudge.judge(hands)).to eq [0]
       end
  end


  describe 'api' do
    context '異常なリクエストのとき' do
      let(:params){{cards: ["H51 H13 H12 H11 H10", "H9 C9 S9 H2 C2", "C13 D12 C11 H8 H7"]}}
        it '正常なレスポンスか' do
          expect(response).to  be_successful
        end
        it '201レスポンスが返ってくること' do
          post '/v1/poker', params: params
          expect(response).to have_http_status "201"
        end
      #errormessageが表示されるのか？
    end
  end

  describe 'api' do
    let(:params){{c:[]}}
      it '400レスポンスが返ってくること' do
        post '/v1/poker', params: params
        expect(response).to have_http_status "400"
      end
  end
end