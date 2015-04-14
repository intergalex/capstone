class Api::V1::HappeningsController < ApplicationController

  def index 
    @happenings = Happening.all
  end

  def create
    @happening = UserHappening.new(:name => params[:name], :description => params[:description], :start_time => params[:human_time].to_i, :address => params[:address])
    if @happening.save

    else
        render json: { errors: @happening.errors.full_messages }, status: 422
    end
  end

end