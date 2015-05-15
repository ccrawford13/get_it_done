require 'rails_helper'

RSpec.describe Item, type: :model do
  
  describe "Valid Todo Item" do

    it "has a valid factory" do
      expect( create(:item) ).to be_valid
    end

    it "is invalid without a todo_list" do
      expect( build(:item, todo_list: nil) ).not_to be_valid
    end

    it "is invalid without a title" do
      expect( build(:item, title: nil) ).not_to be_valid
    end

    it "is invalid with too short of a title" do
      expect( build(:item, title: "new") ).not_to be_valid
    end
  end

  describe "toggle completed status" do

    let(:item) { create(:item) }

    context "when completed == false" do

      it "sets completed to true" do
        expect{ item.toggle_completed_status }.to change{ item.completed }.from(false).to(true)
      end
    end

    context "when completed == true" do

      it "sets completed to false" do
        item.update_attributes(completed: true)
        expect{ item.toggle_completed_status }.to change{ item.completed }.from(true).to(false)
      end
    end
  end

  describe "#time_remaining" do

    let(:item) { create(:item) }

    it "calculates days remaining until deletion" do
      expect( item.days_remaining ).to eq(7)
    end
  end

end
