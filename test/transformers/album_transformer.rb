class AlbumTransformer
  include Transformer::Base

  def self.matches?(subject)
    subject.class == Album
  end
end