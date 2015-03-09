require 'rails_helper'

include TestFactories

describe Vote  do
  describe "validations" do

    before do
      @up_vote = Vote.new(value: 1)
      @down_vote = Vote.new(value: -1)
      @invalid_vote = Vote.new(value: 5)
    end

    describe "up_vote#valid?" do
      it "only allows 1 or -1 as a value" do
        expect( @up_vote.valid? ).to eq(true)
      end
    end

    describe "down_vote#valid?" do
      it "only allows 1 or -1 as a value" do
        expect( @down_vote.valid?).to eq(true)
      end
    end

    describe "invalid_vote#valid?" do
      it "only allows 1 or -1 as a value" do
        expect( @invalid_vote.valid? ).to eq(false)
      end
    end

    describe 'after_save' do
      it "calls `Post#update_rank` after save" do
        post = associated_post
        vote = Vote.new(value: 1, post: post)
        expect(post).to receive(:update_rank)
        vote.save
      end
    end

  end
end