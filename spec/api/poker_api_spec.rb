require 'rails_helper'

describe V1::PokerAPI, type: :request do
  describe 'api' do
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
    context 'リクエストの形式が異なるとき' do
      let(:params) { { c: [] } }
      it '400レスポンスが返ってくるか' do
        post '/v1/poker', params: params
        expect(response).to have_http_status "400"
      end
    end
  end

  describe '#result' do
    before { post '/v1/poker', params: params }
      context 'スートが同じで数字が連続しているとき' do
        let(:params) { { cards: ["C7 C6 C5 C4 C3"] } }
          it 'ストレートフラッシュと判定されるか' do
            res = ActiveSupport::JSON.decode(response.body)
            expect(res['result'][0]['hand']).to eq 'ストレートフラッシュ'
          end
      end

      context '同じ数字のカードが4枚含まれるとき' do
        let(:params) { { cards: ["C10 D10 H10 S10 D5"] } }
          it 'フォー・オブ・ア・カインドと判定されるか' do
            res = ActiveSupport::JSON.decode(response.body)
            expect(res['result'][0]['hand']).to eq 'フォー・オブ・ア・カインド'
         end
      end

      context '同じ数字のカード3枚と別の同じ数字のカード2枚のとき' do
        let(:params) { { cards: ["S10 H10 D10 S4 D4"] } }
          it 'フルハウスと判定されるか' do
            res = ActiveSupport::JSON.decode(response.body)
            expect(res['result'][0]['hand']).to eq 'フルハウス'
          end
      end

      context '同じスートのカード5枚のとき' do
        let(:params) { { cards: ["H1 H12 H10 H5 H3"] } }
          it 'フラッシュと判定されるか' do
            res = ActiveSupport::JSON.decode(response.body)
            expect(res['result'][0]['hand']).to eq 'フラッシュ'
          end
      end

      context '数字が連続しているとき' do
        let(:params) { { cards: ["S8 S7 H6 H5 S4"] } }
          it 'ストレートと判定されるか' do
            res = ActiveSupport::JSON.decode(response.body)
            expect(res['result'][0]['hand']).to eq 'ストレート'
          end
      end

      context '同じ数字のカード3枚と別々の数字のカード2枚のとき' do
        let(:params) { { cards: ["S12 C12 D12 S5 C3"] } }
          it 'スリー・オブ・ア・カインドと判定されるか' do
            res = ActiveSupport::JSON.decode(response.body)
            expect(res['result'][0]['hand']).to eq 'スリー・オブ・ア・カインド'
         end
      end

      context '同じ数字の2枚を2組と別のカード1枚のとき' do
        let(:params) { { cards: ["H13 D13 C2 D2 H11"] } }
          it 'ツーペアと判定されるか' do
            res = ActiveSupport::JSON.decode(response.body)
            expect(res['result'][0]['hand']).to eq 'ツーペア'
          end
      end

      context '同じ数字の2枚とそれぞれ異なったカード3枚のとき' do
        let(:params) { { cards: ["C10 S10 S6 H4 H2"] } }
          it 'ワンペアと判定されるか' do
            res = ActiveSupport::JSON.decode(response.body)
            expect(res['result'][0]['hand']).to eq 'ワンペア'
          end
      end

      context '全ての役が成立しないとき' do
        let(:params) { { cards: ["D1 D10 S9 C5 C4"] } }
          it 'ハイカードと判定されるか' do
            res = ActiveSupport::JSON.decode(response.body)
            expect(res['result'][0]['hand']).to eq 'ハイカード'
          end
      end
  end

  describe '#best_card_judge' do
    let(:params) { { cards: ["H1 H13 H12 H11 H10", "H9 C9 S9 H2 C2", "C13 D12 C11 H8 H7"] } }
      it '正常にbest判定がなされるか' do
        post '/v1/poker', params: params
        res = ActiveSupport::JSON.decode(response.body)
        expect(res['result'][0]['best']).to eq true
      end
  end
end
