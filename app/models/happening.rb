class Happening

  attr_reader :description, :meetup_time, :name, :utc_offset, :maybe_rsvp_count, :how_to_find_us, :event_url, :yes_rsvp_count, :id, :status, :group_name, :venue_name, :zip, :country, :city, :address, :lon, :venue_id, :state, :lat

  def initialize(hash)
    @description = hash["description"]
    @meetup_time = hash["time"]
    @name = hash["name"]

    @utc_offset = hash["utc_offset"]
    @maybe_rsvp_count = hash["maybe_rsvp_count"]
    @how_to_find_us = hash["how_to_find_us"]
    @event_url = hash["event_url"]
    @yes_rsvp_count = hash["yes_rsvp_count"]
    @id = hash["id"]
    @status = hash["status"]

    @group_name = hash["group"]["name"]
    @group_id = hash["group"]["id"]
    @who = hash["group"]["who"]
    
    # @venue_name = hash["venue"]["name"]
    # @zip = hash["venue"]["zip"]
    # @country = hash["venue"]["country"]
    # @city = hash["venue"]["city"]
    # @address = hash["venue"]["address_1"]
    # @lon = hash["venue"]["lat"]
    # @venue_id = hash["venue"]["id"]
    # @state = hash["venue"]["state"]
    # @lat = hash["venue"]["lon"]

  end 

  def self.all
    happenings_array = Unirest.get("https://api.meetup.com/2/open_events.json?key=#{ENV['MEETUP_API_KEY']}&and_text=true&limited_events=true&text=politics&city=Chicago&state=IL&country=us&time=-1d,1m", :headers => {"Accept" => "application/json"}).body["results"]

    @happenings = []
    happenings_array.each do |happenings_hash|
      @happenings << Happening.new(happenings_hash)
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


