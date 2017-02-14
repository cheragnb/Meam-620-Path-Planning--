function tests = collide_test
tests = functiontests(localfunctions);
end

function assertNoCollision(testcase, map, points)
c = collide(map, points);
verifyEqual(testcase, size(points, 1), length(c(:)));
verifyFalse(testcase, any(c));
end

function assertCollision(testcase, map, points)
c = collide(map, points);
verifyTrue(testcase, isvector(c));
verifyEqual(testcase, size(points, 1), length(c(:)));
verifyTrue(testcase, all(c));
end

% function testMap1(testcase)
% map = load_map('testmap.txt', 1 ,1 ,0);
% 
% valid = [1.5 1.5 1; 
%          2 2 1;]; 
%          
% collision = [0 0 0; 
%              10 0.75 0;
%              0.25 0.25 0];
% assertNoCollision(testcase, map, valid);
% assertCollision(testcase, map, collision);
% end


function testMap1(testcase)
map = load_map('map0.txt', 0.2, 0.5, 0.2);

valid = [0.0  -1.0 2.0; 
         3.0  17.0 4.0; 
         0.0  -5.0 0.5];
collision = [0.0 2.0 1.0; 
             3.0 18.5 4.5];
assertNoCollision(testcase, map, valid);
assertCollision(testcase, map, collision);
end

