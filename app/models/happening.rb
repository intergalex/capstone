class Happening

  attr_reader :description, :meetup_time, :name, :utc_offset, :maybe_rsvp_count, :how_to_find_us, :event_url, :yes_rsvp_count, :id, :status, :group_name, :venue_name, :zip, :country, :city, :address, :lon, :venue_id, :state, :lat

  def initialize(hash, source)
    if source == "meetup"
      @name = hash["name"]
      @description = hash["description"]
      @start_time = hash["time"]
      @duration = hash["duration"]
      @utc_offset = hash["utc_offset"]
      @status = hash["status"] || hash["statos"]
      
      @venue_id = hash["venue"]["id"]
      @venue_name = hash["venue"]["name"]
      @address = hash["venue"]["address_1"]
      @lon = hash["venue"]["lat"]
      @lat = hash["venue"]["lon"]

      @group_name = hash["group"]["name"]
      @group_id = hash["group"]["id"]

      @going = hash["yes_rsvp_count"]
      @might_go = hash["maybe_rsvp_count"]
      @how_to_find_us = hash["how_to_find_us"]
      @event_url = hash["event_url"]      
      @who = hash["group"]["who"]
      end

    elsif source == "eventbrite"
      @start_time = hash["start"]["local"]
      @end_time = hash["end"]["local"]
      @name = hash["name"]["text"]
      @description = hash["description"]["html"]
      @logo = hash["logo"]["url"]
      @status = hash["status"]
      @address = hash["venue"]["address_1"]
      @lon = hash["venue"]["longitude"]
      @lat = hash["venue"]["latitude"]
      @type = hash["format"]["name"]
      @cost = hash["ticket_classes"]["cost"]["value"]
      @free? = hash["ticket_classes"]["free"]
      @
      
    end

  end 

  def self.all
    meetup_array = Unirest.get("https://api.meetup.com/2/open_events.json?key=#{ENV['MEETUP_API_KEY']}&and_text=true&limited_events=true&text=politics&city=Chicago&state=IL&country=us&time=-1d,1m", :headers => {"Accept" => "application/json"}).body["results"]

    eventbrite_array = Unirest.get("https://www.eventbriteapi.com/v3/events/search/?venue.city=Chicago&categories=111%2C+112%2C+113&token=#{ENV['EVENTBRITE_API_KEY']}", :headers => {"Accept" => "application/json"}).body["events"]

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
    miliseconds = @meetup_time
    seconds = miliseconds/1000
    return Time.at(seconds).strftime("%A, %d %b %Y %l:%M %p")
  end

  # def self.find(id)
  #   happening_hash = Unirest.get("https://api.meetup.com/2/open_events.json?key=#{ENV['MEETUP_API_KEY']}&and_text=true&limited_events=true&text=politics&city=Chicago&state=IL&country=us&time=-1d,1m").body[0]
  #   return Happening.new(happening_hash)
  # end



end


