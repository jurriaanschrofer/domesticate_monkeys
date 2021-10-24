
module DomesticateMonkeys
  class View

    attr_reader :snapshot

    def initialize(snapshot = nil)
      @snapshot = snapshot || Snapshot.new
    end

    def all(path_filter = nil)
      tracks = @snapshot.multi_tracks
      tracks = filter_tracks_by_path(tracks, path_filter) if path_filter

      tracks.values.each { |track| track.print }

      # Return nil in order to avoid a lengthy print of the @snapshot.
      return nil
    end

    def app
      app_class = Rails.application.class
      
      # Support both the new Module#module_parent and the deprecated Module#parent methods (Rails 6.1)
      top_class = app_class.respond_to?(:module_parent) ? app_class.module_parent : app_class.parent

      app_name = top_class.name.snakecase
      all(app_name)
    end

    private

    def filter_tracks_by_path(tracks, path_filter)
      tracks.select do |_method, track|
        track.sources.any? { |source| source.snakecase.include?(path_filter.snakecase) }
      end
    end

  end
end