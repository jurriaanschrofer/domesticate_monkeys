
module DomesticateMonkeys
  class View

    attr_reader :snapshot

    def initialize(snapshot = nil)
      @snapshot = snapshot || Snapshot.new
    end

    # parsed CLI option methods

    def all(path_filter = nil)
      tracks = @snapshot.multi_tracks
      tracks = filter_tracks_by_path(tracks, path_filter) if path_filter

      tracks.values.each { |track| track.print }

      # Return nil in order to avoid a lengthy print of the @snapshot.
      return nil
    end

    def app
      all(app_name)
    end

    def overview
      app_header = header_text("#{app_monkeys_count} Monkeys within our own application").red
      puts app_header
      app

      all_header = header_text("#{all_monkeys_count} Monkeys through the whole application, including third party software").yellow
      puts all_header
      all
    end

    private

    # Helper methods

    def filter_tracks_by_path(tracks, path_filter)
      tracks.select do |_method, track|
        track.sources.any? { |source| source.snakecase.include?(path_filter.snakecase) }
      end
    end

    def app_name
      app_class = Rails.application.class
      # Support both the new Module#module_parent and the deprecated Module#parent methods (Rails 6.1)
      top_class = app_class.respond_to?(:module_parent) ? app_class.module_parent : app_class.parent
      app_name  = top_class.name.snakecase
    end
    
    def app_monkeys_count
      filter_tracks_by_path(@snapshot.multi_tracks, app_name).count
    end

    def all_monkeys_count
      @snapshot.multi_tracks.count
    end

    def header_text(text)
      <<~EOL
        

        #-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#
        #{text}
        #-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#
      EOL
    end

  end
end