
module DomesticateMonkeys
  class View

    attr_reader :snapshot

    def initialize(snapshot = nil)
      @snapshot = snapshot || Snapshot.new
    end

    def all(path_filter = nil)
      tracks = @snapshot.multi_tracks
      tracks = filter_tracks_by_path(tracks, path_filter) if path_filter

      tracks.values.each do |track|
        view_track(track)
      end

      # Return nil in order to avoid a lengthy print of the @snapshot.
      return nil
    end

    def app
      app_name = Rails.application.class.parent.name.snakecase
      all(app_name)
    end

    private

    def filter_tracks_by_path(tracks, path_filter)
      tracks.select do |_method, track|
        track.sources.any? { |source| source.snakecase.include?(path_filter.snakecase) }
      end
    end

    def view_track(track)
      view = <<~EOL
      
      #{track.count} definitions for: 
      #{track.method}
      #{track.sources.map.with_index { |source, i| "#{i}: #{source}"}.join("\n")}
      EOL

      puts view
    end

  end
end