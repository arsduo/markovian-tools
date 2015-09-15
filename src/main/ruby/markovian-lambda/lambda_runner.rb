require 'markovian/lambda'
require 'java'

java_package 'markovian-lambda'

java_import 'com.amazonaws.services.lambda.runtime.Context'
java_import 'com.amazonaws.services.lambda.runtime.LambdaLogger'

module LambdaRunner
  java_signature 'String handler(Map eventData, Context context)'
  # If the gods of srand so decree, post a tweet in response to a quarter-hourly ping.
  def handler(event_data, context)
    # We want to post a little more frequently than once a day, so we use a threshold
    # corresponding to 4 pings an hour, success roughly every 23 hours.
    logger = context.getLogger
    logger.log("In message!")
    logger.log("Received event data #{event_data.inspect}")
    threshold = 1/(23 * 4).to_f
    random_value = rand
    logger.log("Threshold: #{threshold} rand: #{random_value}")

    if rand < threshold
      importer = Markovian::Importers::Twitter::CsvImporter.new(File.join(Markovian::Lambda.root, "data/tweets.csv"))
      corpus = importer.corpus
      tweeter = Markovian::Lambda::Tweeter.new(corpus)
      tweet = tweeter.tweet!
      logger.log("Tweeted #{tweet.id}")
    end
  end
end
