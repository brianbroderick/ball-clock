class Clock
  attr_accessor :min, :five_min, :hour, :twelfth_hour, :main_tray, :default_tray, :checks, :achieved_duplication
  attr_accessor :balls, :minutes

  def initialize(options)
    ### Set up the initial variables
    @balls = options[:b]
    @minutes = options[:m]
    @min = []; @five_min = []; @hour = []; @main_tray = []; @checks = 0; @achieved_duplication = false

    ### Create the initial main tray numbered N..1 Balls.
    ### Why N..1?  It simulates putting #1 first, then #2.
    ### The least recently used ball would then be #1.
    options[:b].to_i.downto(1).each {|b| @main_tray << b }

    ### Create a default array to compare against to determine if the pattern repeats
    @default_tray = @main_tray.dup
  end

  def self.process(options)
    c = Clock.new(options)
    if c.minutes.to_i > 0
      1.upto(c.minutes.to_i) { |n| c.add_minute }
      puts c.json_output
    else
      c.add_minute until c.achieved_duplication
      puts "#{c.balls.to_s} balls cycle after #{(c.checks/2).to_s} days."
    end
    #binding.pry
  end

  def add_minute
    @min.push @main_tray.pop
    add_five_minute if @min.length == 5
  end

  def add_five_minute
    @five_min.push @min.pop
    flush_track("min")
    add_hour if @five_min.length == 12
  end

  def add_hour
    @hour.push @five_min.pop
    flush_track("five_min")
    add_twelfth_hour if @hour.length == 12
  end

  def add_twelfth_hour
    @twelfth_hour = @hour.pop
    flush_track("hour")
    @main_tray.unshift(@twelfth_hour) #prepends @twelfth_hour to @main_tray
    @twelfth_hour = nil
    check_for_duplication
  end

  def check_for_duplication
    @checks += 1
    @achieved_duplication = true if @default_tray == @main_tray
    #
  end

  def flush_track(var)
    track = instance_variable_get("@#{var}")
    @main_tray = track + @main_tray
    instance_variable_set("@#{var}", [])
  end

  ### Keep the output DRY
  def output
    {"Min" => @min,
     "FiveMin" => @five_min,
     "Hour" => @hour,
     "Main" => @main_tray}
  end

  ### Output per requirement
  def json_output
    output.to_json
  end

  ### Output to debug easier
  def pretty_output
    JSON.pretty_generate(output)
  end
end