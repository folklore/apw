require "spec_helper"

describe SheetsController do
  describe "routing" do

    it "update_path() - sheets#update" do
      put("/name").should route_to("sheets#update", id: "name")
      patch("/name").should route_to("sheets#update", id: "name")
    end

    context "add_sheet_path() - sheets#new (add subsheet to sheet)" do
      it "without parent_names" do
        get("/name/add").should route_to("sheets#new", id: "name")
      end

      it "with parent_names" do
        get("/supsheet/supsheet/name/add").should route_to("sheets#new", id: "name", parent_names: "supsheet/supsheet")
      end
    end

    it "sheets_path - sheets#create" do
        post("/").should route_to("sheets#create")
    end

    it "new_sheet_path - sheets#new" do
      get("/add").should route_to("sheets#new") 
    end

    context "edit_sheet_path() - sheets#edit" do
      it "without parent_names" do
        get("/name/edit").should route_to("sheets#edit", id: "name")
      end

      it "with parent_names" do
        get("/supsheet/supsheet/name/edit").should route_to("sheets#edit", id: "name", parent_names: "supsheet/supsheet")
      end
    end

    context "sheet_path() - sheets#show" do
      it "without parent_names" do
        get("/name").should route_to("sheets#show", id: "name")
      end

      it "with parent_names" do
        get("/supsheet/supsheet/name").should route_to("sheets#show", id: "name", parent_names: "supsheet/supsheet")
      end
    end

    it "root_path - sheets#index" do
      get("/").should route_to("sheets#index")
    end

  end
end