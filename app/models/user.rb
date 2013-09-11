class User < ActiveRecord::Base

  has_many :tweets

  def tweet(status)
    tweet = self.tweets.create!(:body => status)
    TweetWorker.perform_async(tweet.id)
  end
end
