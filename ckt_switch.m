clc
clear all
close all

while true
    
    numSwitchingNodes = input('Enter the number of switching nodes (Enter 0 to exit): ');
 
    if numSwitchingNodes == 0
        disp('Exiting the program.');
        break; 
    end
  
    if numSwitchingNodes < 1
        disp('The number of switching nodes must be at least 1. Please try again.');
        continue; 
    end
    
    totalNodes = numSwitchingNodes + 2; 
 
    adjacencyMatrix = zeros(totalNodes);
    
    for i = 2:(totalNodes-1)
        randomNodes = randperm(totalNodes, randi([2, 4]));
        for j = randomNodes
            if j ~= i  
                adjacencyMatrix(i,j) = 1;
                adjacencyMatrix(j,i) = 1; 
            end
        end
    end
    
    % Ensure End system A is connected to at least one switching node
    adjacencyMatrix(1, 2) = 1; % Connect A to the first switching node
    adjacencyMatrix(2, 1) = 1;
    
    % Ensure End system B is connected to at least one switching node
    adjacencyMatrix(totalNodes, totalNodes-1) = 1; % Connect B to the last switching node
    adjacencyMatrix(totalNodes-1, totalNodes) = 1;
    
    % Create a graph object
    G = graph(adjacencyMatrix);
    
    % Find the shortest path between End System A and End System B
    pathAB = shortestpath(G, 1, totalNodes);
    
    % Plot the graph using a circular layout
    figure;
    p = plot(G, 'Layout', 'circle');
    
    highlight(p, 1, 'NodeColor', 'r', 'MarkerSize', 7); % End system A
    highlight(p, totalNodes, 'NodeColor', 'g', 'MarkerSize', 7); % End system B
    labelnode(p, 1, 'A'); 
    labelnode(p, totalNodes, 'B'); 
    
    highlight(p, pathAB, 'EdgeColor', 'r', 'LineWidth', 2); 
    
    title(['Circuit-Switched Network with ', num2str(numSwitchingNodes), ' Switching Nodes']);
    
    disp('Step 1: Connection Establishment');
    pause(2); 
    disp(['Connection Path: ', num2str(pathAB)]); 
    
    disp('Step 2: Data Transfer in Progress...');
    pause(2); 
    disp('Step 3: Disconnection');
    pause(2);
    
end
