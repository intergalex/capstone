class HappeningsController < ApplicationController
  

  def index
    @happenings = Happening.all
  end
  
  def new

  end

  def create

  end

end
