require 'rails_helper'

RSpec.describe User, type: :model do
  subject { FactoryBot.create :user }
 
  it 'should have a uuid as identifier' do
    expect( subject.id ).to match(/[a-f\d]{8}-([a-f\d]{4}-){3}[a-f\d]{12}/)
  end

  it { expect( subject ).to respond_to( :name ) }
  it { expect( subject ).to respond_to( :email ) }
  it { expect( subject ).to respond_to( :password ) }
  it { expect( subject ).to respond_to( :encrypted_password ) }
  it { expect( subject ).to respond_to( :role ) }
  

  context "validations" do 
    it { expect( subject ).to validate_presence_of( :name ) }

    it { should allow_value( 'foo@bar.xyz' ).for( :email ) }
    it { should_not allow_value( 'foo@' ).for( :email ) }
    it { expect( subject ).to validate_uniqueness_of( :email ).case_insensitive }
    
    it { expect( subject ).to validate_presence_of( :password ) }
    it { expect( subject ).to validate_confirmation_of( :password ) }      
  end

  context "when the user is an admin" do
    let(:admin_user) { FactoryBot.create :user, :admin }

    it { expect( admin_user ).to be_an_admin }
    it { expect( admin_user ).not_to be_a_member }
  end

  context "when the user is a member" do
    let(:member) { FactoryBot.create :user }

    it { expect( member ).not_to be_an_admin }
    it { expect( member ).to be_a_member }
  end
end
