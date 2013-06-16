require 'spec_helper'

describe UsersController do
  describe "GET #new" do
    before :each do
      get :new      
    end

    it "assigns a new User to @user" do
      expect(assigns(:user)).to be_a_new(User)      
    end

    it "renders the :new template" do
      expect(response).to render_template :new
    end 
  end

  describe "POST #create" do
    context "with valid data" do
      before :each do
        post :create, user: attributes_for(:user)
      end

      it "saves the new user" do
        expect{ post :create, user: attributes_for(:user) }.to change(User, :count).by(1)
      end

      it "logs the new user" do
        expect(warden.user).not_to be_nil
      end

      it "redirects to the home page" do
        expect(response).to redirect_to(root_url)
      end
    end

    context "with invalid data" do
    
      it "doesn't save the user" do
        expect{ post :create, user: attributes_for(:invalid_user) }.to_not change(User, :count)
      end
    
      it "renders the :new template" do
        post :create, user: attributes_for(:invalid_user)
        expect(response).to render_template :new
      end
    end
  end
end
