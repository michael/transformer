class TrackTransformer
  include Transformer::Base

  def self.matches?(subject)
    subject.class == Track
  end
end