function[]= erdosRenyi(n,p)
    G= rand(n,n) >p; %Will make it boolean
    G = triu(G,1); %Randomly take only the upper traingular
    G = G + G'; %Forms the adjacency matrix, that is symmetric.
    
    A = graph(G); % graph(adj_matrix) gives a graph variable.
    plot(A)
    
    degree = sum(G);
    fprintf('Degree of this network = \n');
    disp(degree);
    
    avg_degree = (sum(degree))/n;
    fprintf('Average degree of this network = \n');
    disp(avg_degree);
end