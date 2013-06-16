require 'spec_helper'

describe AnswersController do
  before do
    @user = create(:user)
    warden.set_user @user 
  end
  
  describe "POST #create" do
    before :each do
      @question = create(:question, user: @user)
    end

    context "with valid data" do
      it "saves the answer" do
        expect{ post :create, question_id: @question, answer: attributes_for(:answer, question: @question) }.to change(Answer,:count).by(1)
      end

      it "redirects to @question detail" do
        post :create, question_id: @question, answer: attributes_for(:answer, question: @question)
        expect(response).to redirect_to @question
      end
    end

    context "with invalid data" do
      it" doesn't save the answer" do
        expect{ post :create, question_id: @question, answer: attributes_for(:invalid_answer, question: @question) }.to_not change(Answer, :count)
      end

      it "renders the 'questions/show' template" do
        post :create, question_id: @question, answer: attributes_for(:invalid_answer, question: @question)
        expect(response).to render_template('questions/show')
      end
    end
  end
end
