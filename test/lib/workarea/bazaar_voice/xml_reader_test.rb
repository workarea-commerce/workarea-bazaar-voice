require "test_helper"

module Workarea
  module BazaarVoice
    class XmlReaderTest < Workarea::TestCase
      def test_each_requires_a_block
        assert_raises RuntimeError do
          Tempfile.open("temp") do |temp_file|
            xml_reader = XmlReader.new(file_path: temp_file, node: "Product")

            xml_reader.each
          end
        end
      end

      def test_each
        xml_reader = XmlReader.new(file_path: xml_file_path, node: "Product")

        assert_equal(4, xml_reader.count)
        assert_instance_of(Hash, xml_reader.first)
      end

      private

        def xml_file_path
          BazaarVoice::Engine.root.join("test/fixtures/bazaar_voice_xml/bv_test_ratings.xml.gz")
        end
    end
  end
end
