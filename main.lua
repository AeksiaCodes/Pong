local vector = require("vector")
ding = love.audio.newSource("ding.wav", "static")
hit = love.audio.newSource("tennis.wav", "static")

function dist(ax, ay, bx, by)
  return math.sqrt((ax-bx)^2+(ay-by)^2)
end
function love.load()
  w, h = 1280, 720
  leftx, lefty = w*(1/25), h*(1/2)
  rightx, righty = w*(24/25), h*(1/2)
  rightscore, leftscore = 0, 0
  ballx, bally = w*.5, h*.5
  balldir = vector.random()
  balldir:norm()
  speed = 1
  -- 0: stationary
  -- 1: up
  -- 2: down
  -- 3: left
  -- 4: right
  dir = 0
  love.keyboard.setKeyRepeat(true)
  love.window.setMode(love.window.toPixels(w), love.window.toPixels(h))
end



function love.resize(width, height)
  end

function sleep(s)
  local ntime = os.clock() + s
  repeat until os.clock() > ntime
end


function love.draw(dt)
  love.graphics.setColor(1, 1, 1)
  ballx = ballx + (balldir.x * speed)
  bally = bally + (balldir.y * speed)
    love.graphics.ellipse("fill", ballx, bally, 7, 7)

    love.graphics.rectangle("fill", leftx - 2, lefty -2, 7, 50)
    love.graphics.rectangle("fill", rightx - 2, righty -2, 7, 50)
    if lefty >= h - 50 then
      lefty = lefty - 112
    elseif lefty <= 50 then
      lefty = lefty + 1
    end
    
    if righty >= h - 50 then
      righty = righty - 1
    elseif righty <= 50 then
      righty = righty + 1
    end
    
    love.graphics.print(rightscore, 320, 50, 0, 2, 2)
    love.graphics.print(leftscore, 960, 50, 0, 2, 2)
    
    if bally >= h then
      balldir.y = balldir.y * -1
    elseif bally <= 0  then
          balldir.y = balldir.y * -1
    end
    
    if ballx <= w*(1/25) then
      if dist(ballx, bally, leftx, lefty) >= 30 then
         ballx, bally = w*.5, h*.5
       balldir = vector.random()
       balldir:norm()
       leftscore = leftscore + 1
       speed = speed + 0.05
       ding:play()
      else 
      balldir.x = balldir.x * -1
      hit:play()
      end
    end
    
    if ballx >= w*(24/25) then
      if dist(ballx, bally, rightx, righty) >= 30 then
      ballx, bally = w*.5, h*.5
       balldir = vector.random()
       balldir:norm()
       rightscore = rightscore + 1
       speed = speed + 0.05
       ding:play()
      else 
       balldir.x = balldir.x * -1
       hit:play()
      end
    end
end


function love.keypressed(key, scancode, isrepeat)
  if key == "w" then
       lefty = lefty - 25
  end
  if key == "s" then
      lefty = lefty + 25
  end
  if key == 'up' then
    righty = righty - 25
  end
  if key == 'down' then
    righty = righty + 25
  end
  if key == "escape" then
    love.event.quit()
  end
end

