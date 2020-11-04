--[[
    ScoreState Class
    Author: Colton Ogden
    cogden@cs50.harvard.edu

    A simple state used to display the player's score before they
    transition back into the play state. Transitioned to from the
    PlayState when they collide with a Pipe.
]]

ScoreState = Class{__includes = BaseState}
--[[
    When we enter the score state, we expect to receive the score
    from the play state so we know what to render to the State.
]]

function ScoreState:enter(params)
    self.score = params.score + 1
    self.bronze = love.graphics.newImage('medals/bronze.png')
    self.silver = love.graphics.newImage('medals/silver.png')
    self.gold = love.graphics.newImage('medals/gold.png')
end

function ScoreState:update(dt)
    -- go back to play if enter is pressed
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        gStateMachine:change('countdown')
    end
end

function ScoreState:render()
    -- simply render the score to the middle of the screen
    love.graphics.setFont(flappyFont)
    love.graphics.printf('Oof! You lost!', 0, 64, VIRTUAL_WIDTH, 'center')

    love.graphics.setFont(mediumFont)
    love.graphics.printf('Score: ' .. tostring(self.score - 1), 0, 100, VIRTUAL_WIDTH, 'center')
    if self.score - 1 < 10 then
        love.graphics.draw(self.bronze, VIRTUAL_WIDTH / 2 - 30 , 120)
    elseif self.score - 1 <= 15 then
        love.graphics.draw(self.silver, VIRTUAL_WIDTH / 2 - 30 , 120)
    elseif self.score - 1 >= 15 then
        love.graphics.draw(self.gold, VIRTUAL_WIDTH / 2 - 30 , 120)
    end
    love.graphics.printf('Press Enter to Play Again!', 0, 210, VIRTUAL_WIDTH, 'center')
end