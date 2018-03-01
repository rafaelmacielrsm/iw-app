require 'rails_helper'
require 'shared_examples/a_date_field_validation'

RSpec.describe DietProgress, type: :model do 
  let( :diet_progress_object ) { FactoryBot.build :diet_progress }
  
  describe 'attributes' do
    it { expect( subject ).to respond_to( :weighing_date ) }
    it { expect( subject ).to respond_to( :weight ) }
    it { expect( subject ).to respond_to( :diet ) }    
  end  

  describe 'associations' do
    it { expect( subject ).to belong_to( :diet ) }    
  end

  describe 'validations' do
    it "should validate that :user is required" do
      expect( diet_progress_object ).to validate_presence_of( :diet ).
      with_message( :required )
    end

    it { expect( diet_progress_object ).to validate_presence_of( :weight ) }
    it { expect( diet_progress_object ).to validate_numericality_of( :weight ).
      only_integer }

    include_examples "a date field validation", :weighing_date do
      let(:valid_date_string) { ( Date.today + 10.days ).to_s }
      let(:invalid_string) { 'invalid' }
    end
  end
end
