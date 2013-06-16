require 'spec_helper'

describe SessionsController do
  let(:user) { create(:user) }

  describe "GET #new" do
    context "with invalid data" do

      it "set a error message" do
        post :create, session: { username: "aads", password: "Asda" }
        expect(flash.now[:error]).to_not be_nil
      end
    end
  end
  
  describe "POST #create" do
    before :each do
      post :create, session: { username: user.username, password: "password" }
    end

    it "authenticates an user" do
      expect(warden.user).to eq(user)
    end

    it "redirects to the home page" do
      expect(response).to redirect_to root_url
    end
  end

  describe "DELETE #destroy" do
    before :each do
      warden.set_user create(:user)
      post :destroy
    end
    
    it "logouts the current user" do
      expect(warden.user).to be_nil
    end
      
    it "redirects to the home page" do
      expect(response).to redirect_to root_url
    end
  end
end
