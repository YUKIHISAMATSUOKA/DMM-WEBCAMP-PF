class AreasController < ApplicationController
  before_action :authenticate_customer!

  def index
    @areas = Area.all
  end

  def new
    @area = Area.new
    @areas = Area.all
  end

  def edit
    @area = Area.find(params[:id])
  end

  def create
    @areas = Area.all
    @area = Area.new(area_params)
    if @area.save
      flash[:notice] = "作成しました"
      redirect_to areas_path
    else
      render 'new'
    end
  end

  def update
    @area = Area.find(params[:id])
    if @area.update(area_params)
      redirect_to areas_path
    else
      render 'edit'
    end
  end

  def destroy
    @area = Area.find(params[:id])
    @area.destroy
    flash[:alert] = "削除しました"
    redirect_to areas_path
  end

  private

  def area_params
    params.require(:area).permit(:name)
  end


end
