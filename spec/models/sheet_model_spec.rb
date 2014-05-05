require 'spec_helper'

describe Sheet do

  context "database schema" do
    it { should have_db_column(:name).of_type(:string)
                                     .with_options(null: false, unique: true) }
    it { should have_db_column(:title).of_type(:string)
                                      .with_options(null: false) }
    it { should have_db_column(:text).of_type(:text)
                                     .with_options(null: false) }
    it { should have_db_column(:p_id).of_type(:integer) }
    it { should have_db_index(:p_id) }
  end

  context "model attributes" do
    it { should respond_to(:name) }
    it { should respond_to(:title) }
    it { should respond_to(:text) }
    it { should respond_to(:p_id) }
  end

  context "validations" do
    it { should validate_presence_of(:name) }

    it { should allow_value("name_1", "имя_1").for(:name) }
    it { should_not allow_value("name.1", "name-1").for(:name) }

    it { should validate_uniqueness_of(:name) }

    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:text) }


    it { should validate_numericality_of(:p_id)
               .only_integer
               .is_greater_than(0) do |m|
           m.allow_blank = true
         end }
  end

  context "associations" do
    it { should belong_to(:parent)
               .class_name('Sheet')
               .with_foreign_key(:p_id) }
               #.include(:parent) }
    it { should have_many(:children)
               .class_name('Sheet')
               .with_foreign_key(:p_id) }
               # .include(:parent, :children) }
  end

  context "#parent_names" do

    it "for main" do
      sheet1 = create(:sheet, p_id: nil)

      expect(sheet1.parent_names).to eq([])

      sheet1.parent_names.should_not eq(nil)
      sheet1.parent_names.should_not eq([sheet1.name])
    end

    it "for child" do
      sheet1 = create(:sheet, p_id: nil)
      sheet11 = create(:sheet, p_id: sheet1.id)
      sheet111 = create(:sheet, p_id: sheet11.id)

      expect(sheet111.parent_names).to eq([sheet1.name, sheet11.name])

      sheet111.parent_names.should_not eq(nil)
      sheet111.parent_names.should_not eq([sheet1.name, sheet11.name, sheet111.name])
    end

  end

  context "#to_param" do

    it "for main" do
      sheet1 = create(:sheet, p_id: nil)

      expect(sheet1.to_param).to eq("#{sheet1.name}")

      sheet1.to_param.should_not eq(nil)
    end

    it "for child" do
      sheet1 = create(:sheet, p_id: nil)
      sheet11 = create(:sheet, p_id: sheet1.id)
      sheet111 = create(:sheet, p_id: sheet11.id)

      expect(sheet111.to_param).to eq("#{sheet1.name}/#{sheet11.name}/#{sheet111.name}")

      sheet1.to_param.should_not eq(nil)
      sheet1.to_param.should_not eq("#{sheet1.name}/#{sheet11.name}")
    end

  end

  context "#sanitize_text" do
    it "should includes" do
      sheet1 = create(:sheet, text: '**строка_string** \\\\строка_string\\\\ ((link якорь_anchor))', p_id: nil)

      st = sheet1.sanitize_text

      st.should =~ /(?:<b>)([\s\S]+?)(?:<\/b>)/m
      st.should =~ /(?:<i>)([\s\S]+?)(?:<\/i>)/m
      st.should =~ /(?:<a href=)([\s\S]+?)(>)([\s\S]+?)(?:<\/a>)/
    end

    it "shouldn't includes" do
      sheet1 = create(:sheet, text: '**строка_string** <br> <br
                                   > //строка_string// <hr> < hr  > ((link якорь_anchor))', p_id: nil)

      st = sheet1.sanitize_text

      st.should_not include("<br>")
      st.should_not include("<hr>")
    end
  end

  it "#transformation" do
      sheet1 = create(:sheet, text: '**строка_string** \\\\строка_string\\\\ ((link якорь_anchor))', p_id: nil)

      tr = sheet1.transformation

      tr.should include("<b>")
      tr.should include("</b>")
      tr.should include("<i>")
      tr.should include("</b>")
      tr.should include("<a href=")
      tr.should include("</a>")
    end

  it ".all_cache" do
    sheet1 = create(:sheet, p_id: nil)
    sheet11 = create(:sheet, p_id: sheet1.id)
    sheet2 = create(:sheet, p_id: nil)

    expect(Sheet.all_cache).to eq([sheet1, sheet2])
  end

  it ".one_cache" do
    sheet1 = create(:sheet, p_id: nil)
    sheet11 = create(:sheet, p_id: sheet1.id)
    sheet2 = create(:sheet, p_id: nil)

    expect(Sheet.one_cache(sheet11.name)).to eq(sheet11)
  end

end