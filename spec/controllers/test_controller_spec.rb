require 'rails_helper'

describe CardsController, type: :controller do
  describe 'GET #show' do
    it '正常なレスポンスが返ってくること' do
      get :show
      expect(response).to be_successful
    end
    it '200レスポンスが返ってくること' do
      get :show
      expect(response).to have_http_status "200"
    end
    it 'フォーム画面を表示すること' do
      get :show
      expect(response).to render_template :show
    end
  end

  describe 'POST #show' do
    it '正常なレスポンスが返ってくること' do
      post :show
      expect(response).to be_successful
    end
    it '200レスポンスが返ってくること' do
      post :show
      expect(response).to have_http_status "200"
    end
    it 'フォーム画面と判定結果を表示すること' do
      post :show
      expect(response).to render_template :show
    end

    let(:params){{cards: "S1 S2 S3 S4 S5"}}
      it '正常なリクエストで正常なレスポンスか' do
        post :show, params: params
        expect(response).to be_successful
      end
      it '200レスポンスが返ってくるか' do
        post :show
       expect(response).to have_http_status "200"
      end

    let(:params){{cards: "S1 S2 S3 S4 S51"}}
      it '異常なリクエストで正常なレスポンスか' do
       post :show, params: params
        expect(response).to be_successful
      end
      it '200レスポンスが返ってくるか' do
        post :show
        expect(response).to have_http_status "200"
      end
  end
end

describe CardsController, type: :controller do
 describe 'POST #judge_cards' do
   let(:params){{cards: "S1 S2 S3 S4 S5"}}
      it '正常なリクエストで@cards呼び出しチェック' do
        post :judge_cards, params: params
        expect(assigns(:cards)).to eq "S1 S2 S3 S4 S5"
      end
      it '正常なリクエストで@result呼び出しチェック' do
        post :judge_cards, params: params
        expect(assigns(:result)).to eq "ストレートフラッシュ"
      end
      it '正常なリクエストで@error呼び出しチェック' do
        post :judge_cards, params: params
        expect(assigns(:error)).to eq []
      end

 end

 describe 'POST #judge_cards' do
   let(:params){{cards: "S1 S2 S3 S4"}}
      it '異常リクエスト@error入力制限メッセージ' do
         post :judge_cards, params: params
         expect(assigns(:error)).to eq ["5つのカード指定文字を半角スペース区切りで入力してください。（例：S1 H3 D9 C13 S11）"]
      end
 end

 describe 'POST #judge_cards' do
   let(:params){{cards: "S1 S2 S3 S4 S4"}}
   it '異常リクエスト@error重複メッセージ' do
     post :judge_cards, params: params
     expect(assigns(:error)).to eq ["カードが重複しています。"]
   end
 end

 describe 'POST #judge_cards' do
   let(:params){{cards: "S1 S2 S3 S4 S51"}}
   it '異常リクエスト@error組み合わせ不正メッセージ' do
     post :judge_cards, params: params
     expect(assigns(:error)).to eq ["5番目のカード指定文字が不正です(S51)", "半角英字大文字のスート(S,H,D,C)と数字(1〜13)の組み合わせでカードを指定してください。"]
   end
 end

end


