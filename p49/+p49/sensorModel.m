function z = sensorModel(x, sensorPos)
    z = atan((x(3)-sensorPos(2))/(x(1)-sensorPos(1)));
    if (x(1) - sensorPos(1)) < 0
        z =  z + pi;
    end
end

