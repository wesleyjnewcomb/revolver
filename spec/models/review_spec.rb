require 'rails_helper'

RSpec.describe Review, type: :model do
  it { should belong_to(:album) }
  it { should belong_to(:user) }

  it { should have_valid(:rating).when(7) }
  it { should_not have_valid(:rating).when(0) }
  it { should_not have_valid(:rating).when(11) }
  it { should_not have_valid(:rating).when(nil) }

  describe "#score" do
    before(:each) do
      @review = FactoryGirl.create(:review)
      @votes = FactoryGirl.create_list(:vote, 10, review: @review)
    end

    it "should return an integer" do
      expect(@review.score).to be_a(Fixnum)
    end

    it "should accurately sum the value of the review's votes" do
      sum = 0
      @votes.each { |vote| sum += vote.value }

      expect(@review.score).to eq(sum)
    end

    it "should ignore votes for other reviews" do
      @other_votes = FactoryGirl.create_list(:vote, 5)
      sum = 0
      @votes.each { |vote| sum += vote.value }

      expect(@review.score).to eq(sum)
    end
  end
end
