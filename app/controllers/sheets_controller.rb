class SheetsController < ApplicationController
  before_action :get_sheet, only: [:show, :edit]

  def index
  end

  def show
  end

  def new
    if params.has_key?(:id)
      parent_sheet = get_sheet
      @sheet = parent_sheet.children.build
    else
      @sheet = Sheet.new
    end
  end

  def create
    @sheet = Sheet.new(sheet_params)
 
    if @sheet.save
      redirect_to @sheet, notice: 'ok'
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    @sheet = Sheet.where(id: params[:id]).first

    if @sheet.update(sheet_params)
      redirect_to @sheet, notice: 'ok'
    else
      render 'edit'
    end
  end

  private

    def get_sheet
      @sheet = Sheet.one_cache(params[:id])
    end

    def sheet_params
      params.require(:sheet)
            .permit(:name, :title, :text, :p_id)
    end
end