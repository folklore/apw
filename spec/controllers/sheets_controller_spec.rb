require 'spec_helper'

describe SheetsController do

  describe "ApplicationController .get_sheets" do
    it "loads all of the main sheets into @sheets" do
      sheet1, sheet2 = create(:main_sheet), create(:main_sheet)
      sheet3 = create(:sheet, p_id: sheet1.id)
      get :index

      expect(assigns(:sheets)).to match_array([sheet1, sheet2])
    end
  end

  describe "GET #index" do
    it "returns http success with an HTTP 200 status code" do
      get :index
      expect(response).to be_success
      expect(response.status).to eq(200)
    end

    it "renders the index template" do
      get :index
      expect(response).to render_template("index")
    end
  end

  describe "GET #show" do
    it "returns http success with an HTTP 200 status code" do
      sheet1 = create(:main_sheet)
      get 'show', id: sheet1.name
      
      response.should be_success
      expect(response.status).to eq(200)
      response.should render_template :show
    end

    it "returns http success with an HTTP 200 status code" do
      sheet1, sheet2 = create(:main_sheet), create(:main_sheet)
      get 'show', id: sheet1.name

      expect(assigns(:sheet)).to eq(sheet1)
    end

    it "should respond with a 404" do
      sheet = build(:main_sheet)
      get 'show', id: sheet
      response.should render_template 'sheets/404'
      response.response_code.should == 404
    end
  end

  describe "GET #new" do
    it "returns http success with an HTTP 200 status code" do
      get 'new'
      response.should be_success
      expect(response.status).to eq(200)
    end
  end

  describe "POST #create" do
    context "with valid attributes" do
      it "creates a new sheet" do
        expect{
          post :create, sheet: attributes_for(:main_sheet)
        }.to change(Sheet, :count).by(1)
      end
      
      it "redirects to the new sheet" do
        post :create, sheet: attributes_for(:main_sheet)
        response.should redirect_to Sheet.last
      end
    end
    
    context "with invalid attributes" do
      it "does not save the new sheet" do
        expect{
          post :create, sheet: attributes_for(:main_sheet, name: nil)
        }.to_not change(Sheet, :count)
      end
      
      it "re-renders the new method" do
        post :create, sheet: attributes_for(:main_sheet, name: nil)
        response.should render_template :new
      end
    end
  end

  describe "GET #edit" do
    it "returns http success with an HTTP 200 status code" do
      sheet = create(:main_sheet)
      get 'edit', id: sheet
      response.should be_success
      expect(response.status).to eq(200)
    end

    it "should respond with a 404" do
      sheet = build(:main_sheet)
      get 'edit', id: sheet
      response.should render_template 'sheets/404'
      response.response_code.should == 404
    end
  end

  describe 'PUT update' do
    before :each do
      @sheet = create(:main_sheet, name: "name", title: "title", text: "text")
    end

    context "valid attributes" do
      it "located the requested @sheet" do
        put :update, id: @sheet.id, sheet: attributes_for(:main_sheet)
        assigns(:sheet).should eq(@sheet)
      end
    
      it "changes @sheet's attributes" do
        put :update, id: @sheet.id,
                     sheet: attributes_for(:main_sheet, name: "name2",
                                                        title: "title2",
                                                        text: "text2")
        @sheet.reload
        @sheet.name.should eq("name2")
        @sheet.title.should eq("title2")
        @sheet.text.should eq("text2")
      end
    
      it "redirects to the updated sheet" do
        put :update, id: @sheet.id, sheet: attributes_for(:main_sheet)
        @sheet.reload
        response.should redirect_to @sheet
      end
    end
    
    context "invalid attributes" do
      it "locates the requested @sheet" do
        put :update, id: @sheet.id, sheet: attributes_for(:main_sheet, name: nil)
        assigns(:sheet).should eq(@sheet)
      end
      
      it "does not change @sheet's attributes" do
        put :update, id: @sheet.id, 
                     sheet: attributes_for(:sheet, name: "name1",
                                                   title: nil,
                                                   text: "text1")
        @sheet.reload
        @sheet.name.should_not eq("name1")
        @sheet.title.should_not eq(nil)
        @sheet.text.should_not eq("text1")
      end
      
      it "re-renders the edit method" do
        put :update, id: @sheet.id, sheet: attributes_for(:main_sheet, name: nil)
        response.should render_template :edit
      end
    end
  end

end