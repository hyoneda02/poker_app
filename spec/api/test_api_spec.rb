require 'rails_helper'

describe PokerApi, type: :request do
  describe 'api' do
    let(:params){{cards: ["H1 H13 H12 H11 H10", "H9 C9 S9 H2 C2", "C13 D12 C11 H8 H7"]}}
    it '正常なリクエストで正常なレスポンスか' do
      post '/v1/poker', params: params
      expect(response).to  be_successful
    end
    it '201レスポンスが返ってくるか' do
      post '/v1/poker', params: params
      expect(response).to have_http_status "201"
    end
  end

  describe 'api' do
    let(:params){{cards: ["H51 H13 H12 H11 H10", "H9 C9 S9 H2 C2", "C13 D12 C11 H8 H7"]}}
    it '異常なリクエストで正常なレスポンスか' do
      post '/v1/poker', params: params
      expect(response).to  be_successful
    end
    it '201レスポンスが返ってくること' do
      post '/v1/poker', params: params
      expect(response).to have_http_status "201"
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