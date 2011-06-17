module SimpleForm
  module Components
    module Br
      def br
        '<br/>'
      end
    end
  end
  module Inputs
    class Base
      include SimpleForm::Components::Br
    end
  end
end
