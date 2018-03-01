RSpec.shared_examples "a date field validation" do |field|
  it "should allow #{field} to be a valid date string" do
    should allow_value( valid_date_string ).for( field )
  end

  it "should not allow #{field} to be a invalid date string" do
    should_not allow_value( invalid_string ).for( field ).
      with_message( 'is not a valid date' )
  end
  
  it "should not allow #{field} to be an empty value" do
    should_not allow_value( '' ).for( field ).
      with_message( "can't be blank" )
  end
end