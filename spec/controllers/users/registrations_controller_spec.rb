require 'rails_helper'
require 'shared_examples/an_error_on_create'

RSpec.describe Users::RegistrationsController, type: :controller do
  let(:user_params) { FactoryBot.attributes_for( :user ) }

  describe 'POST #create' do
    context 'when a valid user data is received' do
      before{
        @request.env["devise.mapping"] = Devise.mappings[ :user ]
        post( :create, params: { user: user_params })
      }


      it 'should create the user accordingly' do
        expect( User.last.email ).to eq( user_params[ :email ] )
      end

      it { expect( response ).to redirect_to( profile_path ) }

      it { expect( controller ).to set_flash[ :notice ].
        to( I18n.t( 'devise.registrations.signed_up' ))}

      it 'should set the newly created user as the current user' do
        expect( subject.current_user.email ).to eq( user_params[:email] )
      end
    end
    
    context 'when a invalid user data is received' do
      let( :user_with_errors ) { FactoryBot.attributes_for(:user, email: "invalid") }

      before do
        @request.env["devise.mapping"] = Devise.mappings[ :user ]
        post :create, params: { user: user_with_errors }
      end

      include_examples 'an error on create', User, :email
    end

    context 'when an email already in use is received in the params' do
      let(:created_user) { FactoryBot.create :user }
      before do
        created_user        
        @request.env["devise.mapping"] = Devise.mappings[ :user ]
        post :create, params: { 
            user: FactoryBot.attributes_for( :user, email: created_user.email ) }
      end

      include_examples 'an error on create', User, :email
    end
  end
end
