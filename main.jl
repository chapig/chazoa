using GameZero

WIDTH = 600
HEIGHT = 600
BACKGROUND = colorant"white"
IDLE = 1 #INITIAL VALUE FOR IDLE ANIMATION
STEP = 1 #NUMBER OF CURRENT STEPS PERFORMED
VELOCITY = 0 
JUMP_ANIMATION = 0
LOOKING_AT = 0 # 0 REPRESENTS RIGHT AND 1 LEFT

witch = Actor("i.png") #DEFINE WITCH, GRABBING IMAGE
witch.pos = 100, 470 #POSITIONATE THE WITCH IN GIVEN COORDINATES

#play_music("Forest.ogg")


platform = Actor("pltf1") #DEFINE THE PLATFORM, GRABBING IMAGE
platform.pos = 100,530 #POSITIONING OF THE PLATFORM

function jump()
    global VELOCITY, JUMP_ANIMATION
    println("Saltó.")
end


function on_key_down(g::Game, key)
    global JUMP_ANIMATION, LOOKING_AT
    if key == Keys.SPACE
        JUMP_ANIMATION = 0
        jump() #THE JUMPING HASNT BEEN DONE PROPERLY SO IT DOES NOTHING
    end
end

function bring_back() #MAKE THE WITCH GO BACK TO THE WALL IF CROSSING THE WALL LIKE PORTALS
    if witch.left > 545
        witch.left = -92
    elseif witch.left < -92
        witch.left = 540
    end
end

function respawn()
    witch.pos = 100, 470 #RESPAWNS THE WITCH ON THE PLATFORM
end

function gravity() #IF THE WITCH IS NOT IN A PLATFORM, THE WITCH WILL FALL
    if !collide(platform, witch)
        witch.y += 6
    end

    if witch.y > 600
        respawn() #RESPAWNING ON THE PLATFORM
    end
end


function update(g::Game)

    bring_back()
    gravity()


    #####################
    #WALKING AND RUNNING#
    #####################

    global STEP, IDLE, VELOCITY, LOOKING_AT
    if g.keyboard.LCTRL && g.keyboard.D
        LOOKING_AT = 0
        VELOCITY = 0
        if VELOCITY < 50
            VELOCITY += 1
        end
        STEP += 1
        witch.image = "wr$(STEP).png"
        witch.x += 3
        witch.image = "wr$(STEP).png"
        if STEP == 18
            STEP = 1
        end
    elseif g.keyboard.LCTRL && g.keyboard.A
        LOOKING_AT = 1
        VELOCITY = 0
        if VELOCITY < 5
            VELOCITY += 1
        end
        STEP += 1
        witch.image = "wr$(STEP).png"
        witch.x -= 3
        witch.image = "wl$(STEP).png"
        if STEP == 18
            STEP = 1
        end
    elseif g.keyboard.A
        LOOKING_AT = 1
        VELOCITY += 2
        STEP += 1
        witch.image = "wl$(STEP).png"
        witch.x -= 2
        if STEP == 18
            STEP = 1
        end
    elseif g.keyboard.D
        LOOKING_AT = 0
        VELOCITY += 2
        STEP += 1
        witch.image = "wr$(STEP).png"
        witch.x += 2
        if STEP == 18
            STEP = 1
        end
    else

        ################
        #IDLE ANIMATION#
        ################
        
        LOOKING_AT = 2 #LOOKING AT CENTER

        IDLE += 0.35

        witch.image = "i$(round(Int, IDLE)).png"

        if round(Int, IDLE) == 18
            IDLE = 1
        end
        VELOCITY = 0

    end
end

function draw(g::Game)
    draw(witch)
    draw(platform)
end