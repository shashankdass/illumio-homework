require 'nokogiri'
require 'open-uri'

class ProtocolMap
    def get_protocol_map
        url = 'https://www.iana.org/assignments/protocol-numbers/protocol-numbers.xhtml'

        # Open the URL and read the HTML content
        html_content = URI.open(url)

        # Parse the HTML content with Nokogiri
        doc = Nokogiri::HTML(html_content)

        # Look for the table that contains the protocol numbers and names
        protocol_map = {}

        # Loop through each row in the table (excluding the header row)
        doc.css('table tbody tr').each do |row|
            # Extract the protocol number and protocol name from each row
            columns = row.css('td')

            if columns.length >= 3
                protocol_number = columns[0].text.strip.to_i
                protocol_name = columns[1].text.strip

                # Store the protocol number and name in the protocol_map hash
                protocol_map[protocol_number] = protocol_name
            end
        end
        protocol_map
    end
end