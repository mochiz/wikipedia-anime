# -*- coding: utf-8 -*-

# 曖昧さ回避ページの場合に対応するようfindメソッドを上書きします
class Wikipedia::Client
  def find(title, options = {})
    title = Wikipedia::Url.new(title).title rescue title
    page = Wikipedia::Page.new(request_page(title, options))
    while follow_redirects and page.redirect?
      page = Wikipedia::Page.new(request_page(page.redirect_title, options))
    end
    # 曖昧さ回避ページの場合は"（声優）"をつけたWikiページを検索します
    return find("#{title} (声優)") if page.is_disambiguation_pages
    page
  end
end
