# -*- coding: utf-8 -*-
require 'net/http'

class Gyazz
  attr_reader :site
  attr_reader :wiki

  def initialize(wiki, site = 'gyazz.com')
    @wiki = wiki
    @site = site
  end

  def each
    # ページリストを処理とか
  end
end

class GyazzPage
  def initialize(gyazz,page)
    @gyazz = gyazz
    @page = page
  end

  def each
    site = @gyazz.site
    wiki = @gyazz.wiki
    Net::HTTP.start(site, 80) {|http|
      response = http.get("/#{wiki}/#{@page}/text")
      l = response.body
      if l then
        l.each { |line|
          yield(line)
        }
      end
    }
  end
end

if $0 == __FILE__ then
  gyazz = Gyazz.new('kdict')
  gyazzpage = GyazzPage.new(gyazz,'リスト')
  gyazzpage.each { |line|
    puts line
  }
end

