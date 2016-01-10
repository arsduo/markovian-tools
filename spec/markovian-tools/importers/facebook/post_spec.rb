require 'spec_helper'

module Markovian
  module Importers
    module Facebook
      RSpec.describe Post do
        # data is defined below cause it's crazy long
        let(:post) { Post.new(data)  }

        describe "#interesting_texts" do
          it "returns the interesting texts and comments" do
            expect(post.interesting_texts).to eq([
              "There's a bubble tea/coffee place near me that's open (relatively) late! Major win. — at Furama in Chicago, IL",
              "Whoops, that's not Furama. Accidentally picked the wrong place."
            ])
          end

          it "gets interesting text if there are no comments" do
            data["comments"]["data"] = []
            expect(post.interesting_texts).to eq([
              "There's a bubble tea/coffee place near me that's open (relatively) late! Major win. — at Furama in Chicago, IL"
            ])
          end
        end

        let(:data) {
          {
            "id"=>"2905623_10100721279601720",
            "from"=>{"name"=>"Alex Koppel", "id"=>"2905623"},
            "message"=>
            "There's a bubble tea/coffee place near me that's open (relatively) late! Major win. — at Furama in Chicago, IL",
              "picture"=>
            "https://external.xx.fbcdn.net/safe_image.php?d=AQC5dbqEj-iRzzFK&w=130&h=130&url=https%3A%2F%2Firs2.4sqi.net%2Fimg%2Fgeneral%2F1200x630%2F55285194_I0PnYRUEMVnyV3DAPEsp6apIAQA4t8xp10ik9Eu9c9U.jpg&cfs=1",
              "link"=>
            "https://www.swarmapp.com/arsduo/checkin/56491dde498e6a5664e8ccd6?s=l12NsGn6_tR4iW8VlqhvsyDiD4c&ref=fb&source=openGraph",
              "name"=>"Furama",
              "caption"=>"www.swarmapp.com",
              "description"=>"Chinese Restaurant in Chicago, IL",
              "icon"=>"https://www.facebook.com/images/icons/post.gif",
              "actions"=>
            [{"name"=>"Comment",
              "link"=>"https://www.facebook.com/2905623/posts/10100721279601720"},
              {"name"=>"Like",
               "link"=>"https://www.facebook.com/2905623/posts/10100721279601720"}],
               "privacy"=>
            {"value"=>"ALL_FRIENDS",
             "description"=>"Your friends",
             "friends"=>"",
             "allow"=>"",
             "deny"=>""},
             "type"=>"link",
             "status_type"=>"shared_story",
             "application"=>
            {"category"=>"Utilities",
             "link"=>"https://www.facebook.com/games/getswarm/?fbs=-1",
             "name"=>"Swarm",
             "namespace"=>"getswarm",
             "id"=>"638478102868791"},
             "created_time"=>"2015-11-16T00:05:53+0000",
             "updated_time"=>"2015-11-16T00:28:08+0000",
             "is_hidden"=>false,
             "subscribed"=>true,
             "is_expired"=>false,
             "likes"=>
            {"data"=>
             [{"id"=>"10100495431772580", "name"=>"Tucker Bennett"},
              {"id"=>"10101019123999133", "name"=>"Ryan Tamares"}],
             "paging"=>
             {"cursors"=>
              {"after"=>"MTAxMDEwMTkxMjM5OTkxMzM=",
               "before"=>"MTAxMDA0OTU0MzE3NzI1ODA="}}
            },
            "comments"=>
              {"data"=>
                 [{"id"=>"10100721279601720_10100721281188540",
                 "from"=>{"name"=>"Ryan Tamares", "id"=>"10101019123999133"},
                 "message"=>"yassssss",
                 "can_remove"=>false,
                 "created_time"=>"2015-11-16T00:10:42+0000",
                 "like_count"=>0,
                 "user_likes"=>false},
                 {"id"=>"10100721279601720_10100721282535840",
                  "from"=>{"name"=>"Alex Koppel", "id"=>"2905623"},
                  "message"=>
               "Whoops, that's not Furama. Accidentally picked the wrong place.",
                 "can_remove"=>false,
                 "created_time"=>"2015-11-16T00:14:26+0000",
                 "like_count"=>0,
                 "user_likes"=>false},
                 {"id"=>"10100721279601720_10100721287785320",
                  "from"=>{"name"=>"Tucker Bennett", "id"=>"10100495431772580"},
                  "message"=>"bubble tea ftw!",
                  "can_remove"=>false,
                  "created_time"=>"2015-11-16T00:28:08+0000",
                  "like_count"=>1,
                  "user_likes"=>true}],
              }
          }
        }
      end
    end
  end
end
