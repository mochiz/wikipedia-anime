# module Wikipedia
#   module Anime
#     class PageRedirector
#       CHARACTERS_PAGE_TITLE_REGEXP = /{{.*登場人物}}/

#       def initialize(page)
#         @page = page
#       end

#       # Public: 登場人物ページヘのリダイレクトが必要か否かを返します
#       #
#       # Boolean を返します。
#       def should_redirect
#         parsed_castings.empty? && characters_page_title.length > 0
#       end

#       # Public: 登場人物ページのタイトルを返します
#       #
#       # String を返します。
#       def characters_page_title
#         return '' unless @content.match(CHARACTERS_PAGE_TITLE_REGEXP)
#         @content.match(CHARACTERS_PAGE_TITLE_REGEXP)[0].gsub(/{.*\|/, '').gsub('}}', '')
#       end
#     end
#   end
# end
