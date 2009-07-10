require 'rubygems'
require 'pathname'
require 'extlib'
require 'haml'

module Transformers

  class TransformerNotFoundError < RuntimeError ; end
  class AmbiguousTransformerError < RuntimeError ; end
  class TemplateNotFoundError < RuntimeError ; end

  def self.registered_transformers
    @registered_transformers ||= []
  end

  def self.template_root
    if Object.const_defined?('Merb')
      Pathname(Merb.root) + 'app/templates'
    elsif Object.const_defined?('Rails')
      Pathname(Rails.root) + 'app/templates'
    else
      Pathname("templates").expand_path
    end
  end

  def self.transformer_root
    if Object.const_defined?('Merb')
      Pathname(Merb.root) + 'app/transformers'
    elsif Object.const_defined?('Rails')
      Pathname(Rails.root) + 'app/transformers'
    else
      Pathname("transformers").expand_path
    end
  end

  def self.create_transformer(subject)
    transformers = registered_transformers.select do |transformer|
      transformer.matches?(subject)
    end
    raise TransformerNotFoundError  if transformers.size == 0
    raise AmbiguousTransformerError if transformers.size > 1
    transformers.first.new(subject)
  end

  module Base

    def self.included(base)
      extend ClassMethods
      Transformers.registered_transformers << base
      attr_reader :subject
    end

    def transform
      Haml::Engine.new(template).render(self)
    end

    def initialize(subject)
      @subject = subject
    end

    def template
      begin
        File.read(template_path + template_name)
      rescue
        raise Transformers::TemplateNotFoundError
      end
    end

    def template_path
      Pathname(Transformers.template_root).expand_path
    end

    def template_name
      "#{Extlib::Inflection.underscore(Extlib::Inflection.demodulize(self.class.name))}.haml"
    end

    module ClassMethods
      # must be overridden
      def matches?(subject)
        raise NotImplementedError
      end
    end

  end # module Base
end # module Transformers
