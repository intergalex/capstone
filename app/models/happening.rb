class Happening

  attr_reader :description, :name, :address, :group_name 

  # ////
  # MAYBE WILL NEED LATER
  # :how_to_find_us, :event_url,
  # :venue_name, :status
  # ////

  def initialize(hash, source)
    if source == "meetup"
      @name = hash["name"]
      @description = hash["description"]
      if @address 
        @address = hash["venue"]["address_1"]
      end
      # Addtional stuff
      @group_name = hash["group"]["name"]
      @meetup_start_time = hash["time"]  

      # ////
      # SHOW PAGE INFO 
      # ---------------
      # @status = hash["status"]   
      # if @venue_name 
      #   @venue_name = hash["venue"]["name"]
      # end
      # @how_to_find_us = hash["how_to_find_us"]
      # @event_url = hash["event_url"]
      # @who = hash["group"]["who"]
      # ///

    elsif source == "eventbrite"
      @name = hash["name"]["text"]
      @description = hash["description"]["html"]
      @address = hash["venue"]["address_1"]
      
      @eventbrite_start_time = hash["start"]["local"]
      @eventbrite_end_time = hash["end"]["local"]

      # ADDITIONAL INFO
      # ----------------
      # @status = hash["status"]
      # @type = hash["format"]["name"]
      # if @cost
      #   @cost = hash["ticket_classes"]["cost"]["value"].to_i
      # end
      # @free = hash["ticket_classes"]["free"].to_i
    

      # elsif source == "clearPath"
      #   @name = 
      #   @description = 
      #   @address =
    end 
  end 

  def self.all
    meetup_array = Unirest.get("https://api.meetup.com/2/open_events.json?key=#{ENV['MEETUP_API_KEY']}&and_text=true&limited_events=true&text=politics&city=Chicago&state=IL&country=us&time=-1d,1w", :headers => {"Accept" => "application/json"}).body["results"]

    eventbrite_array = Unirest.get("https://www.eventbriteapi.com/v3/events/search/?venue.city=Chicago&categories=111%2C+112%2C+113&token=#{ENV['EVENTBRITE_API_KEY']}", :headers => {"Accept" => "application/json"}).body["events"]

    # clearPath_array = Unirest.get("http://api1.chicagopolice.org/clearpath/api/1.0/communityCalendar/events?offset=10&order=asc&sort=eventStartDate&eventStartDate=04-07-2015", :headers => {"Accept" => "application/json"}.body)

    @happenings = []
      meetup_array.each do |meetup_hash|
        @happenings << Happening.new(meetup_hash, "meetup")
      end
      eventbrite_array.each do |eventbrite_hash|
        @happenings << Happening.new(eventbrite_hash, "eventbrite")
      end

    return @happenings
  end


  def human_time
    if @meetup_start_time
      miliseconds = @meetup_start_time
      seconds = miliseconds/1000
      Time.at(seconds).strftime("%A, %d %b %Y %l:%M %p")
    elsif @eventbrite_start_time || @eventbrite_end_time
      @eventbrite_start_time.to_datetime
      @eventbrite_end_time.to_datetime
    end
  end

  # def self.find(id)
  #   happening_hash = Unirest.get("https://api.meetup.com/2/open_events.json?key=#{ENV['MEETUP_API_KEY']}&and_text=true&limited_events=true&text=politics&city=Chicago&state=IL&country=us&time=-1d,1m").body[0]
  #   return Happening.new(happening_hash)
  # end



end


