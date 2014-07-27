stations = {
  { text = "Du hast den Spielplatz erreicht. Auf zum nächsten!", lat = 54.231842, lon = 10.267547 },
  { text = "Öffne das Tor und durch!", lat = 54.230777, lon = 10.270125 },
  { text = "Macht euch nicht dreckig im Sand!", lat = 54.228958, lon = 10.268408 },
  { text = "Gleich ist es geschafft.", lat = 54.233025, lon = 10.266010 },
  { text = "", lat = 54.232941, lon = 10.268682}
  }

geo.event.join(function(event)

    -- player_id als globale Variable sichern
    player_id = event.player_id
    stationId = 1;
    geo.feature.gps(player_id, true) -- activate GPS
   
    geo.ui.append(player_id, geo.widget.button{
        text = "Zum Starten hier drücken!";
        onClick = function(event)
            nextStation()
        end
    })
    
end)

function nextStation()

  local station = stations[stationId]
  
  geo.ui.clear(player_id)
  
  geo.ui.append(player_id, geo.widget.text("Finde die nächste Station!"))
  geo.ui.append(player_id, geo.widget.compass{
        target = { lat = station.lat, lon = station.lon };
        radius = 10;
        showControls = true;
        onInRange = function(event)
        
            geo.ui.append(player_id, geo.widget.text(station.text))
                
            stationId = stationId+1
        
            if (stationId <= #stations) then
              geo.ui.append(player_id, geo.widget.button{
                text = "Hier drücken!";
                onClick = function(event)
                  nextStation()
                end
              })
            else
              finish()
            end
        end        
    })  
end

function finish()

  geo.ui.clear(player_id)
  
  geo.ui.append(player_id, geo.widget.text("Bravo. Ziel erreicht."))
  
end