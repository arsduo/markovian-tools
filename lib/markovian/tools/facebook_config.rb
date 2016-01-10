require 'koala'
require 'yaml'

module Markovian
  module Tools
    class FacebookConfig
      def facebook_client
        Koala::Facebook::API.new(facebook_credentials["access_token"])
      end

      def user_id
        facebook_credentials["user_id"]
      end

      protected

      def facebook_credentials
        @facebook_credentials ||= YAML.load_file(facebook_credential_file_path)
      end

      def facebook_credential_file_path
        File.join(Tools.root, "data/facebook_auth.yml")
      end
    end
  end
end

