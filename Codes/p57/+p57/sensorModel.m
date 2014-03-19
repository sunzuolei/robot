function z = sensorModel(x, sensorPos)
    z = [atan2( x(2)-sensorPos(2), x(1)-sensorPos(1) );
      sqrt( (x(2)-sensorPos(2))^2 + (x(1)-sensorPos(1))^2 )];
end

