class UserHappening < ActiveRecord::Base

  belongs_to :user 



  
  def human_time
    if @source == "meetup"
      miliseconds = @start_time
      seconds = miliseconds/1000
      Time.at(seconds).strftime("%b %e %Y %l:%m %p")
    elsif @source == "eventbrite"
      DateTime.parse(@start_time).strftime("%b %e %Y %l:%m %p")
    elsif @source == "clearPath"
      DateTime.parse(@start_time).strftime("%b %e %Y %l:%m %p")
    elsif @source == "database"
      @start_time
    end
  end
end
