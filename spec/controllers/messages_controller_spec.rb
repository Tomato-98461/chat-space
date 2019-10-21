require 'rails_helper'

RSpec.describe MessagesController, type: :controller do
  let(:group) { create(:group) }
  let(:user) { create(:user) }
  let(:params) { { group_id: group.id, user_id: user.id, message: attributes_for(:message) } }

  describe '#index' do

    context 'log in' do
      before do
        login user
        get :index, params: { group_id: group.id }
      end

      it "ビューの取得" do
        expect(assigns(:message)).to be_a_new(Message)
      end
    

      it '@groupインスタンスがある' do
        expect(assigns(:group)).to eq group
      end

      it 'ビューはindexであるか' do
        expect(response).to render_template :index
      end

      context 'can save' do
        subject {
          post :create,
          params: params
        }

        it '投稿したメッセージが保存できてるか' do
          expect{ subject }.to change(Message, :count).by(1)
        end

        it '投稿に関する画面(現在のグループ)に遷移しているか' do
          subject
          expect(response).to redirect_to(group_messages_path(group))
        end
      end
    end
  end


  context 'not log in' do
    before do
      get :index, params: { group_id: group.id }
    end

    it 'ログインしてない場合の画面か' do
      expect(response).to redirect_to(new_user_session_path)
    end

    it 'ログインせずにcreateしようとした場合はログインしてない場合の画面か' do
      post :create, params: params
      expect(response).to redirect_to(new_user_session_path)
    end
  end
end