
module DomesticateMonkeys
  class Track

    # The Track class serves as the main class for tracking all method definitions:
    # each method, for each object, that gets defined during the initialization 
    # process, gets it's own track with a uniquely identifying key, such as:
    # 'Nokogiri.scrape', or: 'User#format_name'.

    # The Track instance keeps track of the amount of definitions, the chronological
    # sequence of the source of the definitions, and potentially other information
    # which we will deem valuable in the future.

    attr_accessor :method, :count, :sources

    class << self

      def add(unbound_method)
        
        name    = format_method_name(unbound_method)
        source  = read_method_source(unbound_method)
        return unless name && source

        # Find the existing track for the given method, or create a new track
        # if the given method is defined for the first time, through the 
        # default value of:
        #   $DOMESTICATE_MONKEYS_TRACKS ||= Hash.new(Track.new)

        # Also, duplicate the found / new record, in order to avoid the same
        # track being updated all the time and being assigned to all different 
        # keys.

        track = $DOMESTICATE_MONKEYS_TRACKS[name].dup
        track.add_source(name, source)
        
        rescue
          return
      end

      def format_method_name(unbound_method)
        
        # The formatted method name serves as the uniquely identifying key for
        # all operations, with a distinguishing '#' for instance methods and a
        # '.' for singleton methods.

        name = unbound_method.to_s

        return format_instance_method(name)  if name.include?('UnboundMethod')
        return format_singleton_method(name) if name.include?('Method')
        return name
      end

      def format_instance_method(name)
        name.slice(/(?<=#<UnboundMethod: )[^=]*/)
            .gsub(/\(.*\)/,'')
            .delete('>')
      end

      def format_singleton_method(name)
        name.slice(/(?<=#<Method: )[^=]*/)
            .gsub(/\(.*\)/,'')
            .delete('>')
      end

      def read_method_source(unbound_method)
        unbound_method.source_location&.join(':')
      end

    end

    def initialize
      @method  = nil
      @count   = 0
      @sources = []
    end

    def add_source(method_name, source)
      
      $DOMESTICATE_MONKEYS_COUNT += 1
      printf("\r   Methods defined: #{$DOMESTICATE_MONKEYS_COUNT}\r") if $BOOTING_MAIN_APP

      @method ||= method_name
      
      # Duplicate the retrieved self.sources, in order to avoid the instance variable
      # from hanging and being stacked with every new source – shared between multiple
      # instances.
      dupped_sources = @sources.dup

      # Only add a source to the sources variable if the method is being redefined, i.e.
      # being defined by source code that differs from the previously held definition.
      # If a file is being read for a second time, the method is technically defined again
      # but not redefined, since all behaviour is still the same. Therefore we should not
      # track such cases.
      dupped_sources << source unless dupped_sources.last == source

      # Update the tracker's state, and add it to our global $DOMESTICATE_MONKEYS_TRACKS dictionary afterwards. 
      @sources = dupped_sources
      @count   = dupped_sources.size

      $DOMESTICATE_MONKEYS_TRACKS[self.method] = self
    end

    def print
      view = <<~EOL
      
      #{@count} definitions for: 
      #{@method}
      #{@sources.map.with_index { |source, i| "#{i}: #{source}"}.join("\n")}
      EOL

      puts view
    end

  end
end