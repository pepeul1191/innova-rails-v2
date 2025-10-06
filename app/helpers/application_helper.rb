module ApplicationHelper
  def env(key)
    ENV[key.to_s]
  end
end
