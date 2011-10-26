module RelHelper

  class Sentences

    def self.populate(sentence, val1=nil, val2=nil)
      return sentence if (!val1 or !val2)
      sentence.sub("%1", val1).sub("%2", val2)
    end

    def self.has_space_holders?(sentence)
      !sentence.nil? && sentence.include?('%1') && sentence.include?('%2')
    end

    def self.valid_sentence?(sentence)
      has_space_holders?(sentence)
    end

  end

end
