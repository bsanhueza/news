require "sinatra"
require "sinatra/reloader"
require "httparty"
def view(template); erb template.to_sym; end

get "/" do
    # Benjamin Sanhueza's KIEI project

    ### Get the weather
    # Rapallo, Italy
    lat = 44.347950
    long = 9.233965

    units = "metric" # or metric, whatever you like
    key_weather = "6b22a15f6b47182ed9894d808faa8b9a" # replace this with your real OpenWeather API key
    exclude = "minutely,hourly"

    # construct the URL to get the API data (https://openweathermap.org/api/one-call-api)
    url_weather = "https://api.openweathermap.org/data/2.5/onecall?lat=#{lat}&lon=#{long}&units=#{units}&exclude=#{exclude}&appid=#{key_weather}"
    puts url_weather

    # make the call
    @forecast = HTTParty.get(url_weather).parsed_response.to_hash

    ### Get the news
    # Italy
    @country = "it"

    key_news = "27a5e9aef4e14d9ea81ae4510796042c"
    
    # construct the URL to get the API data (https://openweathermap.org/api/one-call-api)
    url_news = "https://newsapi.org/v2/top-headlines?country=#{@country}&apiKey=#{key_news}"

    # make the call
    @news = HTTParty.get(url_news).parsed_response.to_hash
    @news_to_display = 12

    # date
    time = Time.new

    wkday = ["Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday"]
    mon = ["January","February","March","April","May","June","July","August","September","October","November","December"]

    @weekday = wkday[time.wday]
    @month = mon[time.month]
    @weeknum = time.day
    @year = time.year

    view 'news'
end
