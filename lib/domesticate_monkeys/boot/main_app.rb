
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
$BOOT_TIME = (boot_end.to_f - boot_start.to_f).round(3)

# Reset boot flag
$BOOTING_MAIN_APP = false