class Customer::AreasController < ApplicationController
  before_action :authenticate_customer!

  def index
    @areas = Area.all
    @shops = Shop.all

    @area1_shops = Shop.where(area_id: '1').limit(2).order(" created_at DESC ")
    @area2_shops = Shop.where(area_id: '2')
    @area3_shops = Shop.where(area_id: '3')
    @area4_shops = Shop.where(area_id: '4')
    @area5_shops = Shop.where(area_id: '5')
    @area6_shops = Shop.where(area_id: '6')
    @area7_shops = Shop.where(area_id: '7')
    @area8_shops = Shop.where(area_id: '8')
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

  def area1
    @areas = Area.all
    @shops = Shop.all
    @shops = Shop.where(area_id: '1')
  end
  def area2
    @areas = Area.all
    @shops = Shop.all
    @shops = Shop.where(area_id: '2')
  end
  def area3
    @areas = Area.all
    @shops = Shop.all
    @shops = Shop.where(area_id: '3')
  end
  def area4
    @areas = Area.all
    @shops = Shop.all
    @shops = Shop.where(area_id: '4')
  end
  def area5
    @areas = Area.all
    @shops = Shop.all
    @shops = Shop.where(area_id: '5')
  end
  def area6
    @areas = Area.all
    @shops = Shop.all
    @shops = Shop.where(area_id: '6')
  end
  def area7
    @areas = Area.all
    @shops = Shop.all
    @shops = Shop.where(area_id: '7')
  end
  def area8
    @areas = Area.all
    @shops = Shop.all
    @shops = Shop.where(area_id: '8')
  end

  private

  def area_params
    params.require(:area).permit(:name)
  end


end
