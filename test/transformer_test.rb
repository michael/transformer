require 'test_helper'

# models
class Resource ; end

class Album < Resource
  attr_accessor :title, :artist
end

class Track < Resource
  attr_accessor :length, :title, :artist
end

class TransformerTest < Test::Unit::TestCase
  context "The Transformer Class" do
    
    setup do
      @thriller = Album.new
      @thriller.title = "Thriller"
      @thriller.artist = "Michael Jackson"
      
      @confusion = Track.new
      @confusion.title = "Confusion"
      @confusion.artist = "New Order"
      @confusion.length = 5.18
    end
    
    should "increment Transformer.registered_transformers for each defined transformer" do
      Transformer.should have(2).registered_transformers
    end
    
    should "pick the right transformer" do
      Transformer.create_transformer(@thriller).class.should == AlbumTransformer
      Transformer.create_transformer(@confusion).class.should == TrackTransformer
    end
    
    context "Tranformer instances" do
      setup do
        @album_transformer = Transformer.create_transformer(@thriller)
        @track_transformer = Transformer.create_transformer(@confusion)
      end
      
      should "be the right transformer" do
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
        lambda { @track_transformer.transform }.should raise_error(Transformer::TemplateNotFoundError)
      end
    end
  end
end
