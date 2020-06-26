require "nokogiri"

module RelatonIetf
  class XMLParser < RelatonBib::XMLParser
    class << self
      # def from_xml(xml)
      #   doc = Nokogiri::XML(xml)
      #   doc.remove_namespaces!
      #   ietfitem = doc.at("/bibitem|/bibdata")
      #   if ietfitem
      #     RelatonIetf::IetfBibliographicItem.new(item_data(ietfitem))
      #   elsif
      #     warn "[relato-ietf] can't find bibitem or bibdata element in the XML"
      #   end
      # end

      private

      # override RelatonBib::BibliographicItem.bib_item method
      # @param item_hash [Hash]
      # @return [RelatonIetf::IetfBibliographicItem]
      def bib_item(item_hash)
        IetfBibliographicItem.new item_hash
      end

      def item_data(ietfitem)
        data = super
        ext = ietfitem.at "./ext"
        return data unless ext

        data[:doctype] = ext.at("./doctype")&.text
        data
      end
    end
  end
end
