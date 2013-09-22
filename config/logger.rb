# Logger config for development environment (and production for now)
  require 'log4r'
  

  # creating a new login logger obj by the name 
  # access this obj by calling Logg4r::Logger['name']
  logger = Log4r::Logger.new('login')

  # login logger outputter (filename & destination)
  file = Log4r::FileOutputter.new('login', :filename =>   "#{Rails.root}/log/login.log"  )

  # login logger formatter --> needs to be attached to the outputter
  format = Log4r::PatternFormatter.new(:pattern => "[%l] %d :: %m")

  # attaching format to the file outputter
  file.formatter = format

  # attaching file outputter to logger
  logger.add(file)

  # login logger log  level = info ( DO NOT CHANGE )
  logger.level = Log4r::INFO
