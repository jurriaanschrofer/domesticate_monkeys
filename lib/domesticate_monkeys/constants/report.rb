
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

    def top_redefinitions(top_amount = 3)
      puts "Showing top #{top_amount} redefinitions:"
      tracks = @multi_tracks.first(top_amount).to_h.values
      tracks.each(&:print)
      nil
    end

    def boot_information
      plain_text   = "It took domesticate_monkeys #{$BOOT_TIME} seconds to analyse your application,"\
                     " which defined #{$DOMESTICATE_MONKEYS_COUNT} methods."
      colored_text = "\e[#{35}m#{plain_text}\e[0m"
      puts colored_text   
    end

    def inspect
      # Overwrite default behaviour, which returns – and thus often prints –
      # the values of the object's set instance variables, which is enormous
      # in the case of @all_tracks and @multi_tracks. 
      to_s
    end

  end
end