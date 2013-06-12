function z = sensorModel(x, sensorPos)
    z = atan((x(2)-sensorPos(2))/(x(1)-sensorPos(1)));
    if (x(1) - sensorPos(1)) < 0
        z = piTopi( z + pi);
    end
end

