P = function(v)
  print(vim.inspect(v))
  return v
end

R = function(p)
  require('plenary.reload').reload_module(p)
  return require(p)
end

I = function(_)
  return nil
end
