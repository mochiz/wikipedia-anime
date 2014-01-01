# -*- coding: utf-8 -*-

class Wikipedia::Client
  # 曖昧さ回避ページの場合に対応するようfindメソッドを上書きします
  def find(title, options = {})
    title = Wikipedia::Url.new(title).title if title.match(/^http/)
    page = Wikipedia::Page.new(request_page(title, options))
    while follow_redirects && page.redirect?
      page = Wikipedia::Page.new(request_page(page.redirect_title, options))
    end
    # 曖昧さ回避ページの場合は"（声優）"をつけたWikiページを検索します
    return find("#{title} (声優)") if page.disambiguation_pages?
    page
  end
end
