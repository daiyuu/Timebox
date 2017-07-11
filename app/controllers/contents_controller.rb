class ContentsController < ApplicationController
  require 'nokogiri'
  require 'open-uri'
  require 'kconv'


  def index
    @contents = Content.order(created_at: :desc)
    @contents = @contents.page(params[:page]).per(100)
  end

  def search
    @contents = Content.search(params[:search])
    @contents = @contents.page(params[:page]).per(100)
    render :index
  end

  def crawl
    @contents = Content.all
    matome

    redirect_to profile_path
  end

  private
    def baseball
    doc = Nokogiri::HTML(open('https://baseballking.jp/'))
    7.times do |i|
      doc.xpath("//*[@id='main']/div[5]/div[1]/div/ul/li[#{i+1}]").each do |element|
        url = element.css('a').attr("href")
        title = element.css('a').text
        thumbnail = 'baseballKing_logo-11'
        category = 'sports'
        unless @contents.where(title: title).exists?
          content = Content.new(url: url, title: title, thumbnail: thumbnail, category: category)
          content.save
        end
      end
    end
  end

    def soccer
    doc = Nokogiri::HTML(open('https://www.soccer-king.jp/'))
    15.times do |i|
      doc.xpath("//*[@id='latest-tab-latest']/div[#{i+1}]").each do |element|
        url = element.css('a').attr("href")
        title = element.css('a').text
        thumbnail = 'apple-touch-icon-precomposed.png'
        category = 'sports'
        unless @contents.where(title: title).exists?
          content = Content.new(url: url, title: title, thumbnail: thumbnail, category: category)
          content.save
        end
      end
    end
  end

    def natalie
    doc = Nokogiri::HTML(open('http://natalie.mu/owarai'))
    30.times do |i|
      doc.xpath("//*[@id='NA_main']/div[2]/div[1]/section/div/ul/li[#{i+1}]").each do |element|
        url = 'http://natalie.mu' + element.css('a').attr("href")
        title = element.xpath("//*[@id='NA_main']/div[2]/div[1]/section/div/ul/li[#{i+1}]/a/dl/dt").text
        thumbnail = 'IztbfaBz.png'
        category = 'entertainment'
        unless @contents.where(title: title).exists?
          content = Content.new(url: url, title: title, thumbnail: thumbnail, category: category)
          content.save
        end
      end
    end
  end

    def mdpr
    doc = Nokogiri::HTML(open('https://mdpr.jp/topics/entertainment'))
    20.times do |i|
      doc.xpath("/html/body/div[1]/div[2]/div/main/section[1]/div[1]/ul/li[#{i+1}]").each do |element|
        url = 'https://mdpr.jp' + element.css('a').attr("href")
        title = element.xpath("/html/body/div[1]/div[2]/div/main/section[1]/div[1]/ul/li[#{i+1}]/a/div/p").text
        thumbnail = element.css('img').attr("src")
        category = 'entertainment'
        unless @contents.where(title: title).exists?
          content = Content.new(url: url, title: title, thumbnail: thumbnail, category: category)
          content.save
        end
      end
    end
  end

    def diamond
    doc = Nokogiri::HTML(open('http://diamond.jp/subcategory/%E6%94%BF%E6%B2%BB%E3%83%BB%E7%B5%8C%E6%B8%88'))
    6.times do |i|
      doc.xpath("//*[@id='main-column']/div[1]/article[#{i+1}]").each do |element|
        url = 'http://diamond.jp/' + element.css('a').attr("href")
        title = element.css('h3').text
        thumbnail = element.css('img').attr("src")
        category = 'society'
        unless @contents.where(title: title).exists?
          content = Content.new(url: url, title: title, thumbnail: thumbnail, category: category)
          content.save
        end
      end
    end
  end

    def diamond_2
    doc = Nokogiri::HTML(open('http://diamond.jp/subcategory/%E7%A4%BE%E4%BC%9A'))
    6.times do |i|
      doc.xpath("//*[@id='main-column']/div[1]/article[#{i+1}]").each do |element|
        url = 'http://diamond.jp/' + element.css('a').attr("href")
        title = element.css('h3').text
        thumbnail = element.css('img').attr("src")
        category = 'society'
        unless @contents.where(title: title).exists?
          content = Content.new(url: url, title: title, thumbnail: thumbnail, category: category)
          content.save
        end
      end
    end
    14.times do |i|
      doc.xpath("//*[@id='main-column']/div[2]/article[#{i+1}]").each do |element|
        url = 'http://diamond.jp/' + element.css('a').attr("href")
        title = element.css('h3').text
        thumbnail = element.css('img').attr("src")
        category = 'society'
        unless @contents.where(title: title).exists?
          content = Content.new(url: url, title: title, thumbnail: thumbnail, category: category)
          content.save
        end
      end
    end
  end

    def toyokeizai
    doc = Nokogiri::HTML(open('http://toyokeizai.net/'))
    9.times do |i|
      doc.xpath("//*[@id='top-news2']/ul/li[#{i+1}]").each do |element|
        element.xpath("//*[@id='top-news2']/ul/li[#{i+1}]/div[1]/span[2]").each do |craft|
          @url = 'http://toyokeizai.net' + craft.css('a').attr("href")
          @title = craft.css('a').text
        end
        element.xpath("//*[@id='top-news2']/ul/li[#{i+1}]/div[2]").each do |craft|
          @thumbnail = craft.css('img').attr("src")
        end
        category = 'society'
        unless @contents.where(title: @title).exists?
          content = Content.new(url: @url, title: @title, thumbnail: @thumbnail, category: category)
          content.save
        end
      end
    end
  end

    def itmedia
    doc = Nokogiri::HTML(open('http://www.itmedia.co.jp/'))
    2.times do |i|
      doc.xpath("//*[@id='colBoxTopStories']/div[1]/div[#{i+1}]").each do |element|
        url = element.css('a').attr("href")
        title = element.css('h3').text
        thumbnail = element.css('img').attr("src")
        category = 'tech'
        unless @contents.where(title: title).exists?
          content = Content.new(url: url, title: title, thumbnail: thumbnail, category: category)
          content.save
        end
      end
    end
    4.times do |i|
      doc.xpath("//*[@id='colBoxTopStories']/div[3]/div[#{i+1}]").each do |element|
        url = element.css('a').attr("href")
        title = element.css('h3').text
        thumbnail = element.css('img').attr("src")
        category = 'tech'
        unless @contents.where(title: title).exists?
          content = Content.new(url: url, title: title, thumbnail: thumbnail, category: category)
          content.save
        end
      end
    end
  end

    def gigazine
    doc = Nokogiri::HTML(open('http://gigazine.net/'))
    20.times do |i|
      doc.xpath("//*[@id='section']/div[2]/section[#{i+1}]").each do |element|
        url = element.css('a').attr("href")
        title = element.css('h2').text
        thumbnail = element.css('img').attr("src")
        category = 'tech'
        unless @contents.where(title: title).exists?
          content = Content.new(url: url, title: title, thumbnail: thumbnail, category: category)
          content.save
        end
      end
    end
  end

    def matome
    doc = Nokogiri::HTML(open('http://alfalfalfa.com/'))
    40.times do |i|
      doc.xpath("//*[@id='main_article_list']/li[#{i+1}]").each do |element|
        url = element.css('a').attr("href")
        title = element.css('h2').text
        thumbnail = element.css('img').attr("src")
        category = 'matome'
        unless @contents.where(title: title).exists?
          content = Content.new(url: url, title: title, thumbnail: thumbnail, category: category)
          content.save
        end
      end
    end
  end

    def crash
      @content = Content.first
      @content.destroy
    end

    def crasher
      Content.destroy_all
    end





end
