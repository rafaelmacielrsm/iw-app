require 'rails_helper'

RSpec.describe User, type: :model do

  it { expect( subject ).to respond_to( :name ) }
  it { expect( subject ).to validate_presence_of( :name ) }

 
end
