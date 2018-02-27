RSpec.shared_examples "an error on create" do |resource, field|
  it { expect( response ).to render_template( :new ) }

  it { expect( controller ).to set_flash[ :alert ].
    to( I18n.t( 'errors.messages.not_saved.one', resource: resource ))}

  it 'should have an error message for the invalid field' do
    expect( assigns[:user].errors ).to include(field)  
  end
end





