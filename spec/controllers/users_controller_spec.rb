require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  describe "DELETE#destroy" do
    before(:each) do
      @user = FactoryGirl.create(:user)
      @reviews = FactoryGirl.create_list(:review, 3, user: @user)
      @user2 = FactoryGirl.create(:user)
      @reviews2 = FactoryGirl.create_list(:review, 3, user: @user2)
    end

    it "should destroy the given user instance" do
      expect(User.exists?(@user.id)).to eq true

      delete :destroy, params: { id: @user.id }

      expect(User.exists?(@user.id)).to eq false
    end

    it "should destroy all reviews belonging to the deleted user instance" do
      expect(Review.all).to include(*@reviews)

      delete :destroy, params: { id: @user.id }

      expect(Review.all).to_not include(*@reviews)
    end

    it "should only destroy the reviews for the given user" do
      expect(Review.all).to include(*@reviews, *@reviews2)

      delete :destroy, params: { id: @user.id }

      expect(Review.all).to include(*@reviews2)
    end
  end

end
