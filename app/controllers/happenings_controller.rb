class HappeningsController < ApplicationController
  

  def index
    @happenings = Happening.all
  end

  def show
    @happening = Happening.find(params[:id])

  end

  def new

  end

  def create

  end

end
