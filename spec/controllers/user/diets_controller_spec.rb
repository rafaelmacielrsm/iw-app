require 'rails_helper'

RSpec.describe User::DietsController, type: :controller do
  let( :user ) { FactoryBot.create :user }  

  describe 'GET new' do
    context 'when no user is logged' do
      before { get :new }
      
      it { expect( response ).to redirect_to( new_user_session_path ) }
    end

    context 'when there is a logged user' do
      before do 
        sign_in user
        get :new 
      end
      
      it { expect( response ).to have_http_status( :ok ) }      
      it { expect( response ).to render_template( :new ) }
    end
  end
  
  describe 'POST create' do
    context 'when there is no logged user' do
      before { post :create }

      it { expect( response ).to redirect_to( new_user_session_path ) }
    end

    context 'when a valid is user is logged in' do
      let( :new_diet_hash ) { FactoryBot.attributes_for( :diet, user: user) }

      before do 
        sign_in user
        post :create, params: { diet: new_diet_hash }
      end

      it 'should create a new diet for the current user' do
        expect( Diet.last.user.id ).to eq( user.id )
      end 
      
      it { expect( controller ).to set_flash[ :notice ].
        to( "Diet created successfully" )}
        
      it { expect( response ).to redirect_to( user_profile_path ) }      
    end

    context 'when there are errors in the received data' do
      let( :diet_hash_with_error ) do 
        FactoryBot.attributes_for( :diet, user: user, ending_date: 'invalid' ) 
      end

      before do
        sign_in user
        post :create, params: { diet: diet_hash_with_error }
      end

      it { expect( controller ).to set_flash[ :alert ].
        to( "Diet could not be created" )}

      it { expect( response ).to render_template( :new )}
      it { expect( assigns[ :diet ].errors ).to include( :ending_date )}      
    end
  end
end
