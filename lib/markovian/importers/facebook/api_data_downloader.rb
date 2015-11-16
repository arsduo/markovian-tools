require 'markovian/tools/facebook_config'
require 'json'

module Markovian
  module Importers
    module Facebook
      class ApiDataDownloader
        attr_reader :destination_filename, :debug
        def initialize(destination_filename, debug: false)
          @destination_filename = destination_filename
          @debug = debug
          @page = nil
        end

        def read_from_api
          print "Reading from Facebook" if debug
          with_output_file do
            read_pages
          end
        end

        protected

        def read_pages
          while current_page = get_earlier_posts
            current_page.each do |post|
              output_file.puts(post.to_json)
            end
            print "." if debug
          end
          puts "done!" if debug
        end

        def get_earlier_posts
          @page = if @page
            @page.next_page
          else
            api.get_connection("me", "feed")
          end
        end

        def with_output_file
          begin
            # open up one copy of the file that we can use to write
            # it'll be closed afterward; another copy can be opened by the user if desired.
            yield
          ensure
            output_file.close
          end
        end

        def output_file
          @output_file ||= File.open(destination_filename, "w+")
        end

        def api
          Tools::FacebookConfig.new.facebook_client
        end
      end
    end
  end
end
