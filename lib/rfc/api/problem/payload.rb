# frozen_string_literal: true

require "json"
require "rack/utils"
require "rexml"

module RFC
  module API
    module Problem
      PRIMARY_KEYS = %i[title type status detail instance].freeze

      # Models the problem details response payload.
      Payload = Data.define(*PRIMARY_KEYS, :extensions) do
        def self.for **attributes
          status = attributes.delete(:status).then { Rack::Utils.status_code it if it }
          title = attributes.delete(:title).then { it || Rack::Utils::HTTP_STATUS_CODES[status] }

          new title:, status:, **attributes
        end

        def self.from_json body
          attributes = JSON body, symbolize_names: true
          extensions = attributes.reject { |key| PRIMARY_KEYS.include? key }

          self.for(**attributes.slice(*PRIMARY_KEYS), extensions:)
        end

        # :reek:TooManyStatements
        def self.from_xml body, deserializer: XML::Deserializer
          elements = REXML::Document.new(body).root.elements

          attributes = elements.each_with_object({extensions: {}}) do |element, collection|
            name = element.name.to_sym
            text = element.text

            case name
              when *PRIMARY_KEYS then collection[name] = text
              else collection[:extensions].merge! deserializer.call(element)
            end
          end

          self.for(**attributes)
        end

        def initialize title: nil,
                       type: nil,
                       status: nil,
                       detail: nil,
                       instance: nil,
                       extensions: nil
          super title: title || Rack::Utils::HTTP_STATUS_CODES[status],
                type: type || "about:blank",
                status:,
                detail:,
                instance:,
                extensions: extensions || {}
        end

        def add_extension name, value
          extensions[name] = value
          self
        end

        def extension?(name) = extensions.key? name

        def to_h = {type:, title:, status:, detail:, instance:, **extensions}.compact

        def to_json(*) = to_h.to_json(*)

        # :reek:TooManyStatements
        # :reek:FeatureEnvy
        def to_xml serializer: XML::Serializer, **options
          document = REXML::Document.new
          document.add REXML::XMLDecl.new("1.0", "UTF-8")

          problem = REXML::Element.new("problem").add_namespace("urn:ietf:rfc:7807")
          document.add problem

          to_h.each { |name, value| serializer.call name, value, problem }

          "".dup.tap { document.write(**options, output: it) }
        end
      end
    end
  end
end
