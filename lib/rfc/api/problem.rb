# frozen_string_literal: true

require "rfc/api/problem/payload"
require "rfc/api/problem/xml/deserializer"
require "rfc/api/problem/xml/serializer"

module RFC
  module API
    # Main namespace.
    module Problem
      MEDIA_TYPE_JSON = "application/problem+json"
      MEDIA_TYPE_XML = "application/problem+xml"
      TYPES = %i[json xml].freeze

      def self.[](**) = Payload.for(**)

      def self.new(**) = Payload.for(**)

      def self.from_json(...) = Payload.from_json(...)

      def self.from_xml(...) = Payload.from_xml(...)

      def self.media_type_for key, types: TYPES
        types.include?(key) ? const_get("MEDIA_TYPE_#{key.upcase}") : ""
      end
    end
  end
end
