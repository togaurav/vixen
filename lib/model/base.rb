require File.join(File.dirname(__FILE__), '..', 'bridge')
require File.join(File.dirname(__FILE__), '..', 'constants')

module Vixen::Model; end

class Vixen::Model::Base
  extend Vixen::Constants
  include Vixen::Constants

  attr_reader :handle

  def initialize(handle)
    @handle = handle

    ObjectSpace.define_finalizer( self, self.class.finalize(handle) )
  end

  def self.finalize(handle)
    proc do
      Vixen::Bridge.destroy(handle)
    end
  end

  def get_string_property(property_id)
    Vixen::Bridge.get_string_property handle, property_id
  end
end
