function [G,iwp]= compSteer(x, wp, iwp, G,dt)
maxG   = 30*pi/180; % radians, maximum steering angle (-MAXG < g < MAXG)
rateG  = 20*pi/180; % rad/s, maximum rate of change in steer angle
minD   = 0.5;
cwp    = wp(:,iwp);
d2     = (cwp(1)-x(1))^2 + (cwp(2)-x(2))^2;
if d2 < minD^2
    iwp= iwp+1; % switch to next
    if iwp > size(wp,2) % reached final waypoint, flag and return
        iwp = 0;
        return;
    end    
    cwp = wp(:,iwp); % next waypoint
end

% compute change in G to point towards current waypoint
deltaG = piTopi(atan2(cwp(2)-x(2), cwp(1)-x(1)) - x(3) - G);

% limit rate
maxDelta = rateG*dt;
if abs(deltaG) > maxDelta
    deltaG = sign(deltaG)*maxDelta;
end

% limit angle
G = G+deltaG;
if abs(G) > maxG
    G = sign(G)*maxG;
end