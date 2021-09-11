
module DomesticateMonkeys
  class Report

    attr_reader :snapshot, :all_tracks, :multi_tracks, :method_count, :redefined_method_count

    def initialize
      @snapshot     = Snapshot.new
      @all_tracks   = @snapshot.all_tracks
      @multi_tracks = @snapshot.multi_tracks

      @method_count           = @all_tracks.size
      @redefined_method_count = @multi_tracks.size
    end

    def overview
      puts "During boot we were able to track #{@method_count} methods, of which #{@redefined_method_count} were redefined."
      puts "You may inspect all redefined methods with View.new.multi_tracks or a filtered variant which only includes"\
           " methods defined in your application with View.new.app_tracks" 

    end

    def inspect
      # Overwrite default behaviour, which returns – and thus often prints –
      # the values of the object's set instance variables, which is enormous
      # in the case of @all_tracks and @multi_tracks. 
      to_s
    end

  end
end