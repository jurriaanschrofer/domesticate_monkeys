
module DomesticateMonkeys
  class Snapshot

    # The Snapshot class serves as a data storage, which contains, and compartmentalizes,
    # all current Track instances.

    # The Snapshot's data storage serves as a basis for other classes, such as View (which
    # provides insight into the data storage), Report (which provides aggregate information
    # about your application) and TrackExport (which generates a JSON file).

    attr_reader :all_tracks, :filtered_tracks, :multi_tracks

    def initialize
      @all_tracks      = $DOMESTICATE_MONKEYS_TRACKS
      @filtered_tracks = filter_no_methods
      @multi_tracks    = select_multi_tracks
    end

    def filter_no_methods
      @all_tracks.filter { _1.include?(".") || _1.include?("#") }
    end

    def select_multi_tracks
      multis = @filtered_tracks.select { |_method, track| track.count > 1 }
      sort_tracks(multis)
    end

    def sort_tracks(tracks)
      sorted_array = tracks.sort_by   { |_method, track| -track.count }
      sorted_hash  = sorted_array.map { |_method, track| { _method => track } }.inject(&:merge)
    end

    def inspect
      # Overwrite default behaviour, which returns – and thus often prints –
      # the values of the object's set instance variables, which is enormous
      # in the case of @all_tracks and @multi_tracks. 
      to_s
    end

  end
end