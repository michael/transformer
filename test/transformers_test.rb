require 'test_helper'

# models
class Resource
end

class Album < Resource
  attr_accessor :title, :artist
end

class Track < Resource
  attr_accessor :length, :title, :artist
end

class TransformersTest < Test::Unit::TestCase

  context "The Transformers module" do
    
    setup do
      @thriller = Album.new
      @thriller.title = "Thriller"
      @thriller.artist = "Michael Jackson"
      
      @confusion = Track.new
      @confusion.title = "Confusion"
      @confusion.artist = "New Order"
      @confusion.length = 5.18

      # additionally all transformers under ./transformers
      # are loaded via test_helper
    end
    
    should "automatically register transformers when Transformers::Base is included" do
      Transformers.should have(2).registered_transformers
      Transformers.registered_transformers.should include(AlbumTransformer)
      Transformers.registered_transformers.should include(TrackTransformer)
    end
    
    context "when creating new tranformer instances" do

      setup do
        @album_transformer = Transformers.create_transformer(@thriller)
        @track_transformer = Transformers.create_transformer(@confusion)
      end
      
      should "pick the right transformer" do
        @album_transformer.should be_kind_of(AlbumTransformer)
        @track_transformer.should be_kind_of(TrackTransformer)
      end
      
      should "choose the right template" do
        @album_transformer.template.should be_kind_of(String)
      end
      
      should "transform the template" do
        @album_transformer.transform.should =~ /Michael Jackson/
      end
      
      should "raise a TemplateNotFoundError if template doesn't exist" do
        lambda { @track_transformer.transform }.should raise_error(Transformers::TemplateNotFoundError)
      end

    end
  end
end
