nbNodes = 8;

visibilityGraph = NaN(nbNodes+2, nbNodes+2);
visibilityGraph(1,1) =0;visibilityGraph(1,2) =11;visibilityGraph(1,3) =10;
visibilityGraph(2,1) =11;visibilityGraph(2,3) =18;visibilityGraph(2,9) =11;
visibilityGraph(3,1) =10;visibilityGraph(3,2) =18;visibilityGraph(3,4) =11;visibilityGraph(3,5) =32;
visibilityGraph(4,3) =11;visibilityGraph(4,5) =22;visibilityGraph(4,8) =15;visibilityGraph(4,9) =18;
visibilityGraph(5,3) =32;visibilityGraph(5,4) =22;visibilityGraph(5,6) =11;visibilityGraph(5,8) =20;visibilityGraph(5,9) =37;
visibilityGraph(6,5) =11;visibilityGraph(6,7) =20;visibilityGraph(6,10) =10;
visibilityGraph(7,6) =20;visibilityGraph(7,8) =11;visibilityGraph(7,9) =31;visibilityGraph(7,10) =11;
visibilityGraph(8,4) =15;visibilityGraph(8,5) =20;visibilityGraph(8,7) =11;
visibilityGraph(9,2) =11;visibilityGraph(9,4) =18;visibilityGraph(9,5) =37;visibilityGraph(9,7) =31;
visibilityGraph(10,6) =10;visibilityGraph(10,7) =11;

[distanceToNode, parentOfNode] = dijkstra(nbNodes, visibilityGraph);