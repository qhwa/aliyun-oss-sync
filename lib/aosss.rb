require 'aosss/version.rb'
require 'aosss/sync.rb'

module Aosss

  class << self
    def pull( options )
      Sync.new( options ).pull
    end

    def push( options )
      Sync.new( options ).push
    end

    def sync( options )
      Sync.new( options ).sync
    end
  end

end
