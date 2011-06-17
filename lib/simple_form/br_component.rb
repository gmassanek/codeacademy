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
      def input_html_classes
        [input_type]
      end
      def initialize(builder, attribute_name, column, input_type, options = {})
         @builder            = builder
         @attribute_name     = attribute_name
         @column             = column
         @input_type         = input_type
         @reflection         = options.delete(:reflection)
         @options            = options
         @input_html_options = html_options_for(:input, input_html_classes).tap do |o|
           #o[:required]  = true if has_required? # Don't make this conditional on HTML5 here, because we want the CSS class to be set
           o[:disabled]  = true if disabled?
           o[:autofocus] = true if has_autofocus? && SimpleForm.html5
         end
      end
    end
    class StringInput < Base
      def input_html_classes
        if string?
          super << 'text'
        else
          super.unshift("string")
        end
      end
    end
  end
end
