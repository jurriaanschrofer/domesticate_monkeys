
require "domesticate_monkeys/version"

module DomesticateMonkeys

  Root    = File.expand_path('../', __dir__)
  MainApp = Root + "/lib/domesticate_monkeys/boot/main_app.rb"

  autoload :Track,    "domesticate_monkeys/constants/track"
  autoload :View,     "domesticate_monkeys/constants/view"
  autoload :Snapshot, "domesticate_monkeys/constants/snapshot"
  autoload :Report,   "domesticate_monkeys/constants/report"

  require "domesticate_monkeys/initializers/global_variables"
  require "domesticate_monkeys/initializers/module" 

end