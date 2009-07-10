class TrackTransformer
  include Transformers::Base

  def self.matches?(subject)
    subject.class == Track
  end
end