class JoinGameChannel < ApplicationCable::Channel
  def subscribed
    stream_from "join_game_channel"
    broadcast_users "join_game_channel", "updateUsers"
  end

  def receive(data)
    case data["kind"]
    
    when "joinGame"
      game = game_from_data(data)
      user = User.find(data["data"]["userId"])
      game.users << user
      broadcast_games "appearance_channel", "updateGames"
  end

  private

  def game_from_data(data)
    Game.includes(:actions).find(data["data"]["gameId"])
  end

  def lovely_string
    ADJECTIVES.sample + " " + NOUNS.sample
  end

  ADJECTIVES = [
    "autumn", "hidden", "bitter", "misty", "silent", "empty", "dry", "dark", "summer", "icy", "delicate", "quiet", "white", "cool", "spring", "winter", "patient", "twilight", "dawn", "crimson", "wispy", "weathered", "blue", "billowing", "broken", "cold", "damp", "falling", "frosty", "green", "long", "late", "lingering", "bold", "little", "mourning", "muddy", "old", "red", "rough", "still", "small", "sparkling", "throbbing", "shy", "wandering", "withered", "wild", "black", "young", "holy", "solitary", "fragrant", "aged", "snowy", "proud", "floral", "restless", "divine", "polished", "ancient", "purple", "lively", "nameless", "verklempt", "filipendulous", "friable", "gezellig", "aleatory", "novaturient", "capernoited", "cosmogyral", "foudroyant", "glacous", "solivagant", "arcadian", "incalescent", "nubivagant", "orotund", "aspectabund", "novitious", "gauche", "discombobulated", "numinous", "eonian"
  ]

  NOUNS = [
    "waterfall", "river", "breeze", "moon", "rain", "wind", "sea", "morning", "snow", "lake", "sunset", "pine", "shadow", "leaf", "dawn", "glitter", "forest", "hill", "cloud", "meadow", "sun", "glade", "bird", "brook", "butterfly", "bush", "dew", "dust", "field", "fire", "flower", "firefly", "feather", "grass", "haze", "mountain", "night", "pond", "darkness", "snowflake", "silence", "sound", "sky", "shape", "surf", "thunder", "violet", "water", "wildflower", "wave", "water", "resonance", "sun", "wood", "dream", "cherry", "tree", "fog", "frost", "voice", "paper", "frog", "smoke", "star", "snood", "aglet", "splat", "tact", "zugzwang", "carriwitchet", "noosphere", "pettifoggery", "quiddity", "kakistocracy", "holophrasis"
  ]
end
