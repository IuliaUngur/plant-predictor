# access to the statistical routines in R package
require 'rinruby'
# R.eval 'options(warn = -1)' # suppress R warnings

#
# FSelector: a Ruby gem for feature selection and ranking
#
module FSelector
  # module version
  VERSION = '1.4.0'
end

#
# include necessary files
#
# read and write file, supported formats include CSV, LibSVM and WEKA files
require_relative "fselector/fileio.rb"
# extend Array and String class
require_relative "fselector/util.rb"
# check data consistency
require_relative "fselector/consistency.rb"
# entropy-related functions
require_relative "fselector/entropy.rb"
# normalization for continuous data
require_relative "fselector/normalizer.rb"
# discretization for continuous data
require_relative "fselector/discretizer.rb"
# replace missing values
require_relative "fselector/replace_missing_values.rb"

require_relative "fselector/base.rb"
require_relative "fselector/base_discrete.rb"
require_relative "fselector/InformationGain.rb"

require_relative "fselector/ensemble.rb"
