json.id         pin.id
json.latlng     [pin.location.x, pin.location.y]
json.context    pin.context
json.image_url  pin.image_url
json.author     pin.user.slice(:id, :name)
json.created_at pin.created_at
