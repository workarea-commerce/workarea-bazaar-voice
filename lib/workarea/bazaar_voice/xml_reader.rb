module Workarea
  module BazaarVoice
    class XmlReader
      include Enumerable

      def initialize(file_path:, node:)
        @file_path = file_path
        @node      = node
      end

      # Opens the file and parses xml yield a hash created from the node
      # to the block
      #
      # @yieldparam [Hash] node_hash parsed hash from XML
      # @yield |node_hash|
      def each
        raise "No block given" unless block_given?
        # Using Zlib because its a gz file
        Zlib::GzipReader.open(@file_path) do |file|
          Nokogiri::XML::Reader(file).each do |current_node|
            next if current_node.name      != @node
            next if current_node.node_type != Nokogiri::XML::Reader::TYPE_ELEMENT
            next if current_node.outer_xml.nil?

            yield Hash.from_xml(current_node.outer_xml)[@node]
          end
        end
      end
    end
  end
end
