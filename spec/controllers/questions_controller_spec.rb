require 'spec_helper'

describe QuestionsController do
  let!(:user) { create(:user) }
 
  before do
    warden.set_user user
  end

  describe "GET #index" do
    it "assigns a new Question to @question" do
      get :index
      expect(assigns(:question)).to be_a_new(Question)
    end

    context "when there are unsolved questions" do

      it "populates an array of questions" do 
        question_1 = create(:question)
        question_2 = create(:question)
        
        get :index
        expect(assigns(:questions)).to match_array [question_1, question_2]
      end
    end
  end

  describe "GET #show" do
    before :each do
      @question = create(:question)
      get :show, id: @question 
    end
    
    it "assigns the requested question to @question" do
      expect(assigns(:question)).to eq @question
    end

    it "assigns a new Answer to @answer" do
      expect(assigns(:answer)).to be_a_new(Answer)
    end

    it "renders the :show template" do
      expect(response).to render_template(:show)
    end
  end

  describe "GET #edit" do
    before :each do
      @question = create(:question, user: user)
      get :edit, id: @question
    end

    it "assigns the requested question to @question" do
      expect(assigns(:question)).to eq @question
    end

    it "renders the :edit template" do
      expect(response).to render_template(:edit)
    end
  end

  describe "GET #your_questions" do
    before :each do
      create(:question)
      @question = create(:question, user: user)
      get :your_questions
    end

    it "populates an array of the current user's questions" do
      expect(assigns(:questions)).to match_array [@question]
    end
  end
  
  describe "GET #search" do
    before :each do
      create(:question)
      @question = create(:question, body: "Is this real life?")
      get :search, keyword: "real life"
    end

    it "populates an array of questions that match the keyword" do
      expect(assigns(:questions)).to match_array [@question]
    end
  end

  describe "POST #create" do
    context "with valid data" do
      it "saves the new question" do
        expect{ post :create, question: attributes_for(:question) }.to change(Question, :count).by(1)
      end

      it "redirects to the question detail" do
        post :create, question: attributes_for(:question)
        expect(response).to redirect_to Question.last
      end
    end

    context "with invalid data" do
      it "doesn't save the question" do
        expect{ post :create, question: attributes_for(:invalid_question) }.to_not change(Question, :count)
      end

      it "renders the :index template" do
        post :create, question: attributes_for(:invalid_question)
        expect(response).to render_template :index
      end
    end
  end
  
  describe "PUT #update" do
    before :each do
      @question = create(:question, body: "Lorem ipsum dolor?", user: user)
    end

    it "locates the request question" do
      put :update, id: @question, question: attributes_for(:question)
      expect(assigns(:question)).to eq(@question)
    end

    context "with valida data" do
      before :each do
        put :update, id: @question, question: { body: "Lorem ipsum dolor sit amet?" }
      end

      it "changes question's attributes" do
        @question.reload
        expect(@question.body).to eq("Lorem ipsum dolor sit amet?")
      end

      it "redirets to the question detail" do
        expect(response).to redirect_to @question
      end
    end

    context "with invalid data" do
      before :each do
        put :update, id: @question, question: attributes_for(:invalid_question)
      end

      it "doesn't change question's attributes" do
        @question.reload
        expect(@question.body).to_not eq(nil)
      end

      it "renders the :edit template" do
        expect(response).to render_template :edit
      end
    end
  end
end
