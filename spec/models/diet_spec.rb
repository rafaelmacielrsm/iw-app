require 'rails_helper'

RSpec.describe Diet, type: :model do
  let( :user ) { FactoryBot.create :user }
  let( :diet_object ) { FactoryBot.build :diet, user: user }

  describe "attributes" do
    it { expect( subject ).to respond_to( :user_id ) }
    it { expect( subject ).to respond_to( :starting_date ) }
    it { expect( subject ).to respond_to( :ending_date ) }
    it { expect( subject ).to respond_to( :weight_goal ) }
    it { expect( subject ).to respond_to( :current_weight ) }
  end
  
  describe "associations" do
    let( :diet_record ) { FactoryBot.create :diet, user: user }

    it { expect( subject ).to belong_to( :user ) }

    it 'should be able to access the user through the association' do
      expect( diet_record.user ).to be( user )
    end
  end

  describe "validations" do
    let(:valid_date_string) { ( Date.today + 10.days ).to_s }
    
    it "should validate that :user is required" do
      expect( diet_object ).to validate_presence_of( :user ).
        with_message( :required )
    end

    it { expect( diet_object ).to validate_presence_of( :starting_date ) }

    it 'should allow :ending_date to be a valid date string' do
      should allow_value( valid_date_string ).for( :ending_date )
    end

    it 'should not allow :endind_date to be a invalid date string' do
      should_not allow_value( 'invalid' ).for( :ending_date ).
        with_message( 'is not a valid date' )
    end
    
    it 'should not allow :ending_date to be an empty value' do
      should_not allow_value( '' ).for( :ending_date ).
        with_message( "can't be blank" )
    end
     
    it { expect( diet_object ).to validate_presence_of( :weight_goal ) }
    it { expect( diet_object ).to validate_numericality_of( :weight_goal ).
      only_integer.is_greater_than(0) }
      
    it { expect( diet_object ).to validate_presence_of( :current_weight ) }        
    it { expect( diet_object ).to validate_numericality_of( :current_weight ).
      only_integer.is_greater_than(0) }
  end
end
