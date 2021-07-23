-- 'main parameters'
root = getRootElement()
player = getLocalPlayer()
vehicle = nil


-- 'round value'
function roundValue(value)
    local var = math.floor((value) + 0.5)
    return var
end