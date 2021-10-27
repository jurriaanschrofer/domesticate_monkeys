require "pry"

class Module

  # We can keep track of all methods through the two patches below, which are
  # provided by ruby as useful callbacks.

  # In order to track as much methods and redefinitions as possible, and thus
  # giving the best representation of your application's method defining
  # process, we should initialize all tracker relevant classes AND the below
  # callbacks as early on in the initialization process as possible.

  # Although 'the earlier, the better' does definitely apply, this should, in
  # any case, happen BEFORE the initialization of Rails and all other gems.
  # The reason being that we can only track redefinitions of methods defined in
  # gems, such as Rails, if we first are able to built a Track for that method's
  # orignal definition.

  def method_added(_method)
    unbound_method = self.instance_method(_method)
    DomesticateMonkeys::Track.add(unbound_method, :instance)
  end

  def self.singleton_method_added(_method)
    unbound_method = self.method(_method)
    DomesticateMonkeys::Track.add(unbound_method, :singleton)
  end

end