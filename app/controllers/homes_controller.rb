class HomesController < ApplicationController

  def top
    @shops = Shop.all
  end

  def about
  end

  def question
  end

end
