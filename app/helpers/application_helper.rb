# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

  def show_flash
    if flash[:error]
      return '<div class="error">' + flash[:error] + '</div>' 
    end
    return ""
  end

  def image_tag(str)
    '<img class="casting_cost_image" src="' + str + '"/>'
  end

  def render_colorless(str)
    '<span class="colorless_mana"><span class="circle">' + str.ljust(2).rjust(3).gsub(' ','&nbsp;') + '</span></span>'
  end
  def tap_symbol
    '<span class="tap_symbol"><span class="circle">&nbsp;T&nbsp;</span></span>'
  end
  def render_cost(text)
    return "" if text.nil?
    # Pull out strings denoted by '-' chars: -R-, -RRU-, -BB2-, -T-, etc.
    cost_strings = text.scan(/-\w+-/)
    result = text.clone
    for original_string in cost_strings
      # Get rid of our delimeters
      original_string.delete!('-') 

      # Loop through our tokens
      rendered_string = ""
      if original_string.to_i > 0
        rendered_string += render_colorless(original_string.to_i.to_s)
      end
      original_string.gsub(/\d/, '').each_char {|tok|
        # Alpha
        case tok.upcase
          when 'R'
            rendered_string += image_tag('/images/cards/casting_cost_red.png')
          when 'B'
            rendered_string += image_tag('/images/cards/casting_cost_black.png')
          when 'U'
            rendered_string += image_tag('/images/cards/casting_cost_blue.png')
          when 'G'
            rendered_string += image_tag('/images/cards/casting_cost_green.png')
          when 'W'
            rendered_string += image_tag('/images/cards/casting_cost_white.png')
          when 'T'
            rendered_string += tap_symbol
          when '0'
            rendered_string += ""
          else
            # Don't know? Leave as is
            rendered_string += "-#{tok}-"
        end
      }
      result.gsub!("-#{original_string}-", rendered_string)
    end
    result
  end

end
