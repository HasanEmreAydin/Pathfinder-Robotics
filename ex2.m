% initialize the grid map
nbCells = 64;
gridMap = ones(sqrt(nbCells), sqrt(nbCells));

% place obstacles
gridMap(4,4) = 0;
gridMap(4,5) = 0;
gridMap(5,5) = 0;
gridMap(6,5) = 0;
obstaclePosition = [4 4; 4 5; 5 5; 6 5];

% place goal and start point
goalPosition = [2 7];
startPosition = [8 2];

% create heuristic map
heuristicMap = gridMap;
for l_row=1:size(heuristicMap,1)
	for l_col=1:size(heuristicMap,2)
		if (heuristicMap(l_row, l_col) ~=0)
			distanceToGoal = sqrt( (l_row-goalPosition(1))^2 + (l_col-goalPosition(2))^2);
			heuristicMap(l_row, l_col) = distanceToGoal;
		end
	end
end

% create a visited node map
visitedNodeMap = zeros(sqrt(nbCells), sqrt(nbCells));

% create a distance from start map
constantLargeDistance=10000;
distanceFromStartMap = constantLargeDistance*ones(sqrt(nbCells), sqrt(nbCells));

% create a cumulative distance map
cumulativeDistanceMap = nan(sqrt(nbCells), sqrt(nbCells));

% create a parent map
parentMap = zeros(sqrt(nbCells), sqrt(nbCells));

% plot the start, goal and obstacles
figure;
plot(goalPosition(2), sqrt(nbCells)-goalPosition(1),'r*'); hold on;
plot(startPosition(2), sqrt(nbCells)-startPosition(1),'g*'); hold on;
plot(obstaclePosition(:,2), sqrt(nbCells)-obstaclePosition(:,1));
xlim([0 sqrt(nbCells)])
ylim([0 sqrt(nbCells)])

% start the algorithm from the start point
currentPoint = startPosition;
unvisitedNodesRemain = true;

while(unvisitedNodesRemain)

	visitedNodeMap(currentPoint(1), currentPoint(2)) = 1;

	% computes the distance from start
	for l_row=-1:1
		for l_col=-1:1
			if ( (currentPoint(1)+l_row <= size(gridMap,1)) && (currentPoint(1)+l_row > 0) && (currentPoint(2)+l_col <= size(gridMap,2)) && (currentPoint(2)+l_col > 0))
				if (gridMap(currentPoint(1)+l_row, currentPoint(2)+l_col) ~=0)
					distanceFromStart = sqrt( (currentPoint(1)+l_row-startPosition(1))^2 + (currentPoint(2)+l_col-startPosition(2))^2);
					if (distanceFromStart < distanceFromStartMap(currentPoint(1)+l_row, currentPoint(2)+l_col))
						distanceFromStartMap(currentPoint(1)+l_row, currentPoint(2)+l_col)=distanceFromStart;
						parentMap(currentPoint(1)+l_row, currentPoint(2)+l_col) = (currentPoint(1)-1)*sqrt(nbCells)+currentPoint(2);
					end
					cumulativeDistanceMap(currentPoint(1)+l_row, currentPoint(2)+l_col) = heuristicMap(currentPoint(1)+l_row, currentPoint(2)+l_col) + distanceFromStartMap(currentPoint(1)+l_row, currentPoint(2)+l_col);
					
				end
			end
		end
	end

	% search for the next current point with lowest cumulative distance
	MinCumulativeDistance=10000;
	for l_row=1:size(cumulativeDistanceMap,1)
		for l_col=1:size(cumulativeDistanceMap,2)
			if (~isnan(cumulativeDistanceMap(l_row,l_col)))
				if (visitedNodeMap(l_row,l_col) == 0)
					if (cumulativeDistanceMap(l_row, l_col) < MinCumulativeDistance)
						MinCumulativeDistance= cumulativeDistanceMap(l_row, l_col);
						nextPoint = [l_row, l_col];
					end
				end
			end
		end
	end

	currentPoint =  nextPoint;
	
	if (currentPoint ==  goalPosition)
		unvisitedNodesRemain = false;
	end
	
	plot(currentPoint(:,2), sqrt(nbCells)-currentPoint(:,1), 'b+');
	pause(0.5)
end

currentPoint = goalPosition;
trajectoryIsInProgress = true;

while (trajectoryIsInProgress) 
	nextPoint = [fix(parentMap(currentPoint(1), currentPoint(2))/sqrt(nbCells))+1 mod(parentMap(currentPoint(1), currentPoint(2)),sqrt(nbCells))];
	plot([currentPoint(2) nextPoint(2)], [sqrt(nbCells)-currentPoint(1) sqrt(nbCells)-nextPoint(1)], 'r');
	
	if (nextPoint == startPosition)
		trajectoryIsInProgress = false;
	end
	
	currentPoint = nextPoint;
	pause(0.5)
end

