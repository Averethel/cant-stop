module Serializers
  class Base
    def self.serialize_collection(collection)
      collection.map{ |e| new(e).serialize }
    end
  end
end
