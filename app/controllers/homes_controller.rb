class HomesController < ApplicationController

  def top
    @shops = Shop.all
    @shop = Shop.where(status: "true").limit(4).order(" created_at DESC ")
  end

  def about
  end

  def question
  end

end
