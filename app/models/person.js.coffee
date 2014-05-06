class @Person

  constructor: (attributes) ->
    @[key] = value for key, value of attributes
