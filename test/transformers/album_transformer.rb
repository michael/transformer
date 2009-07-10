class AlbumTransformer
  include Transformers::Base

  def self.matches?(subject)
    subject.class == Album
  end
end