function newPos = moveRob(oldPos, vel, steer, dt, wheelbase) 
% The function piTopi is required.
newPos(1) = oldPos(1) + vel * dt * cos(steer + oldPos(3)); 
newPos(2) = oldPos(2) + vel * dt * sin(steer + oldPos(3));
newPos(3) = oldPos(3) + vel * dt * sin(steer) / wheelbase;
newPos(3) = piTopi(newPos(3));
newPos    = newPos';


