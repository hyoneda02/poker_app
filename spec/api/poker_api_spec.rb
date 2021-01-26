require 'rails_helper'

describe V1::PokerAPI, type: :request do
  describe 'api' do
    context 'リクエストの形式が正常なとき' do
      let(:params) { { cards: [] } }
        it '201レスポンスが返ってくるか' do
          post '/v1/poker', params: params
          expect(response).to have_http_status "201"
        end
    end
    context '正常なリクエスト内容のとき' do
      let(:params) { { cards: ["H1 H13 H12 H11 H10", "H9 C9 S9 H2 C2", "C13 D12 C11 H8 H7"] } }
        it '正常なレスポンスか' do
          post '/v1/poker', params: params
          expect(response).to be_successful
        end
        it '201レスポンスが返ってくるか' do
          post '/v1/poker', params: params
          expect(response).to have_http_status "201"
        end
     # errormessageは何も入ってないかのテストも余力あればやる
    end

    context 'リクエストの形式が異なるとき' do
      let(:params) { { c: [] } }
        it '400レスポンスが返ってくるか' do
          post '/v1/poker', params: params
          expect(response).to have_http_status "400"
        end
    end
    context '異常なリクエスト内容のとき' do
      let(:params) { { cards: ["H51 H13 H12 H11 H10", "H9 C9 S9 H2 C2", "C13 D12 C11 H8 H7"] } }
        it '正常なレスポンスか' do
          post '/v1/poker', params: params
          expect(response).to be_successful
        end
        it '201レスポンスが返ってくるか' do
          post '/v1/poker', params: params
          expect(response).to have_http_status "201"
        end
    end
  end

  describe '#result' do
    before { post '/v1/poker', params: cards }
      context `ストレートフラッシュのとき`do
        let(:cards) { "C7 C6 C5 C4 C3" }
          it 'ストレートフラッシュと判定されるか' do
            expect(CardService.result(cards)).to eq "ストレートフラッシュ"
          end
      end

      context `フォー・オブ・ア・カインドのとき`do
        let(:cards) { "C10 D10 H10 S10 D5" }
          it 'フォー・オブ・ア・カインドと判定されるか' do
           expect(CardService.result(cards)).to eq "フォー・オブ・ア・カインド"
         end
      end

      context `フルハウスのとき`do
        let(:cards) { "S10 H10 D10 S4 D4" }
          it 'フルハウスと判定されるか' do
            expect(CardService.result(cards)).to eq "フルハウス"
          end
      end

      context `フラッシュのとき`do
        let(:cards) { "H1 H12 H10 H5 H3" }
          it 'フラッシュと判定されるか' do
           expect(CardService.result(cards)).to eq "フラッシュ"
          end
      end

      context `ストレートのとき`do
        let(:cards) { "S8 S7 H6 H5 S4" }
          it 'ストレートと判定されるか' do
           expect(CardService.result(cards)).to eq "ストレート"
          end
      end

      context `スリー・オブ・ア・カインドのとき`do
        let(:cards) { "S12 C12 D12 S5 C3" }
          it 'スリー・オブ・ア・カインドと判定されるか' do
           expect(CardService.result(cards)).to eq "スリー・オブ・ア・カインド"
         end
      end

      context `ツーペアのとき`do
        let(:cards) { "H13 D13 C2 D2 H11" }
          it 'ツーペアと判定されるか' do
            expect(CardService.result(cards)).to eq "ツーペア"
          end
      end

      context `ワンペアのとき`do
        let(:cards) { "C10 S10 S6 H4 H2" }
          it 'ワンペアと判定されるか' do
           expect(CardService.result(cards)).to eq "ワンペア"
           end
      end

      context `ハイカードのとき`do
        let(:cards) { "D1 D10 S9 C5 C4" }
          it 'ハイカードと判定されるか' do
            expect(CardService.result(cards)).to eq "ハイカード"
          end
      end
  end

  describe '#best_card_judge' do
    let(:params) { { hands: ["ストレートフラッシュ", "フルハウス", "ハイカード"] } }
      it '正常にbest判定がなされるか' do
        post '/v1/poker', params: params
        expect(response).to be_successful
      end
  end
end
