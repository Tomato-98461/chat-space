require 'rails_helper'

describe Message, type: :model do
  describe '#create' do
    # 1. メッセージがあれば保存できる
    it "message post" do
      user = build(:user)
      group = build(:group)
      message = build(:message, image: nil)
      expect(message).to be_valid
    end

    # 2. 画像があれば保存できる
    it "image post" do
      user = build(:user)
      group = build(:group)
      message = build(:message, message: nil)
      expect(message).to be_valid
    end

    # 3. メッセージと画像があれば保存できる
    it "message and image post" do
      user = build(:user)
      group = build(:group)
      message = build(:message)
      expect(message).to be_valid
    end

    # 4. メッセージも画像も無いと保存できない
    it "not elements post" do
      user = build(:user)
      group = build(:group)
      message = build(:message, message: nil, image: nil)
      message.valid?
      expect(message.errors[:message]).to include("を入力してください")
    end

    # 5. group_idが無いと保存できない
    it "group not message post" do
      user = build(:user)
      group = build(:group)
      message = build(:message, group_id: nil)
      message.valid?
      expect(message.errors[:group]).to include("を入力してください")
    end

    # 6. user_idが無いと保存できない
    it "not message id post" do
      user = build(:user)
      group = build(:group)
      message = build(:message, user_id: nil)
      message.valid?
      expect(message.errors[:user]).to include("を入力してください")
    end

  end
end