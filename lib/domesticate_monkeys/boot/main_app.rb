
# Set boot flag
$BOOTING_MAIN_APP = true

# Load required domesticate_monkeys framework
require 'bundler'

# Start boot time counter
boot_start = `date`

# Boot the main application
require './config/environment'

# Finalize boot time counter
boot_start = Time.parse(boot_start)
boot_end   = Time.now
boot_time  = (boot_end.to_f - boot_start.to_f).round(3)

# Print boot time
plain_text   = "It took domesticate_monkeys #{boot_time} seconds to analyse your application,"\
               " which defined #{$DOMESTICATE_MONKEYS_COUNT} methods."
colored_text = "\e[#{35}m#{plain_text}\e[0m"
puts colored_text

# Reset boot flag
$BOOTING_MAIN_APP = false