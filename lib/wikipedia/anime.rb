# -*- coding: utf-8 -*-

require 'wikipedia'
require 'wikipedia/anime/version'
require 'wikipedia/anime/character_parser'
require 'wikipedia/anime/seiyu_parser'

# Wikipedia APIの接続先をjaに変更します
Wikipedia.Configure do
  domain 'ja.wikipedia.org'
  path   'w/api.php'
end

# 日本語ページ用のコンテンツを取得するようcontentメソッドを上書きします
class Wikipedia::Page
  def content
    page['revisions'].first['*'] if page['revisions']
  end

  def is_disambiguation_pages
    categories.include?('Category:人名の曖昧さ回避') if categories
  end
end

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

module Wikipedia
  module Anime
  end
end
