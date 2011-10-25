module MyApp

  class Key

    def self.create(object1, object2)
      return nil unless object1 and object2
      return nil if object1.id == object2.id
      if object1.id < object2.id
        return "#{object1.id}:#{object2.id}"
      else
        return "#{object2.id}:#{object1.id}"
      end
    end

  end

end
