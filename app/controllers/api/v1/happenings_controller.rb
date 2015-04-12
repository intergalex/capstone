class Api::V1::HappeningsController < ApplicationController

  def index 
    @happenings = Happening.all
  end

end