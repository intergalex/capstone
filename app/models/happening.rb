class Happening

  attr_reader :description, :name, :address, :group_name, :start_time, :formatted_time, :url, :source, :lat, :lon

  # ////
  # MAYBE WILL NEED LATER
  # :how_to_find_us, :event_url,
  # :venue_name, :status
  # ////

  def initialize(hash, source)
    @source = source
    if source == "meetup"
      @name = hash["name"]
      @description = hash["description"]
      if @address 
        @address = hash["venue"]["address_1"]
      end
      @start_time = hash["time"]
      @formatted_time = human_time  
      @group_name = hash["group"]["name"]
      @lat = hash["venue"]["lat"] if hash["venue"]
      @lon = hash["venue"]["lon"] if hash["venue"]
      @url = hash["event_url"]

    elsif source == "eventbrite"
      @name = hash["name"]["text"]
      @description = hash["description"]["html"]
      @address = hash["venue"]["address_1"]
      
      @start_time = hash["start"]["local"]
      @formatted_time = human_time  
      @end_time = hash["end"]["local"]

      @lat = hash["venue"]["latitude"]
      @lon = hash["venue"]["longitude"]

      @url = hash["url"]

    elsif source == "clearPath"
      @name = hash["eventName"]
      if @description
        @description = hash["eventDetails"]
      end
      @address = hash["location"]
      @start_time = hash["eventStartDate"]
      @formatted_time = human_time
      @end_time = hash["eventEndDate"]
      # @latlon = 
    end 
  end 

  def self.all
    meetup_array = Unirest.get("https://api.meetup.com/2/open_events.json?key=#{ENV['MEETUP_API_KEY']}&and_text=true&limited_events=true&text=politics&city=Chicago&state=IL&country=us&time=-0d,3d", :headers => {"Accept" => "application/json"}).body["results"] 

    # eventbrite_array = Unirest.get("https://www.eventbriteapi.com/v3/events/search/?venue.city=Chicago&categories=111%2C+112%2C+113&token=#{ENV['EVENTBRITE_API_KEY']}&start_date.range_end=2015-04-14T18%3A52%3A53Z", :headers => {"Accept" => "application/json"}).body["events"]

    clearPath_array = Unirest.get("http://api1.chicagopolice.org/clearpath/api/1.0/communityCalendar/events?offset=10&order=asc&sort=eventStartDate&eventStartDate=#{Time.now.strftime('%m-%d-%Y')}", :headers => {"Accept" => "application/json"}).body

    # chiPubLib_array = Unirest.get("https://chipublib.bibliocommons.com/events/events/rss/all")

    @happenings = []
      meetup_array.each do |meetup_hash|
        @happenings << Happening.new(meetup_hash, "meetup")
      end
      # eventbrite_array.each do |eventbrite_hash|
      #   @happenings << Happening.new(eventbrite_hash, "eventbrite")
      # end
      clearPath_array.each do |clearPath_hash|
        @happenings << Happening.new(clearPath_hash, "clearPath")
      end
      @happenings.sort! do |a,b|  
        DateTime.parse(a.formatted_time) <=> DateTime.parse(b.formatted_time)
      end
    return @happenings
  end

  def human_time
    if @source == "meetup"
      miliseconds = @start_time
      seconds = miliseconds/1000
      Time.at(seconds).strftime("%b %e %Y %l:%m %p")
    elsif @source == "eventbrite"
      DateTime.parse(@start_time).strftime("%b %e %Y %l:%m %p")
    elsif @source == "clearPath"
      DateTime.parse(@start_time).strftime("%b %e %Y %l:%m %p")
    end
  end



  # def self.find(id)
 



end


