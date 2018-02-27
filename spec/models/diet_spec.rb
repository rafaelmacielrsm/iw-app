require 'rails_helper'

RSpec.describe Diet, type: :model do
  let( :user ) { FactoryBot.create :user }
  subject { FactoryBot.create :diet, user: user }

  context "attributes" do
    it { expect( subject ).to respond_to( :user_id ) }
    it { expect( subject ).to respond_to( :starting_date ) }
    it { expect( subject ).to respond_to( :ending_date ) }
    it { expect( subject ).to respond_to( :weight_goal ) }
    it { expect( subject ).to respond_to( :current_weight ) }
  end
  
  context "associations" do
    it { expect( subject ).to belong_to( :user ) }

    it 'should be able to access the user through the association' do
      expect( subject.user ).to be( user )
    end
  end

  context "validations" do
    it "should validate that :user is required" do
      expect( subject ).to validate_presence_of( :user ).
        with_message( :required )
    end

    it { expect( subject ).to validate_presence_of( :starting_date ) }
    it { expect( subject ).to validate_presence_of( :ending_date ) }
    it { expect( subject ).to validate_presence_of( :weight_goal ) }
    it { expect( subject ).to validate_numericality_of( :weight_goal ).
      only_integer.is_greater_than(0) }
      
    it { expect( subject ).to validate_presence_of( :current_weight ) }        
    it { expect( subject ).to validate_numericality_of( :current_weight ).
      only_integer.is_greater_than(0) }
  end
end
