import Config

config :ex_gram,
  token: System.get_env("TELEGRAM_SCT")
config :redix,
  redis_url: System.get_env("REDIS_URL"),
  foods_redis_key: System.get_env("FOODS_REDIS_KEY")
