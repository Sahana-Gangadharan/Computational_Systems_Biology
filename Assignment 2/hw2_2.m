function[] = hw2_2(p)
    edge_list=zeros(300,2);
    ctr=1;
    
    %Creating symmetric network for the given degree distribution in the
    %question.
    for i =1:97
        for j = 1:3
            edge_list(ctr,:)=[i,i+j];
            ctr=ctr+1;
        end
    end
    for i =1:2
        edge_list(ctr,:)=[98,98+i];
        ctr=ctr+1;
    end
    edge_list(ctr,:)=[98,1];
    ctr=ctr+1;
    edge_list(ctr,:)=[99,100];
    ctr=ctr+1;
    for i=1:2
        edge_list(ctr,:)=[99,i];
        ctr=ctr+1;
    end
    for i=1:3
        edge_list(ctr,:)=[100,i];
        ctr=ctr+1;
    end
    
    nodes = 100;
    %Converting network A to an adjacency matrix
    A = zeros(nodes,nodes);
    for i= 1:length(edge_list)
        a = edge_list(i,1);
        b = edge_list(i,2);
        A(a,b)=1;
        A(b,a)=1;
    end
    Ag = graph(A);
    
    %The Rewiring function is called. Bg is the modified network Ag. B is the adjacency matrix of Network B.
    [Bg,B] = hw2_2_rewiring(Ag,p); 
    
    A_sparse = sparse(A);
    B_sparse = sparse(B);
    
    %Shortest paths in A
    spA =all_shortest_paths(A_sparse);
    fprintf(size(spA));
    spB =all_shortest_paths(B_sparse);
    
    %Diameter of the networks
    dA = max(max(spA));
    dB = max(max(spB));
    fprintf('Diameter of Network A =');
    disp(dA);
    fprintf('Diameter of Network B =');
    disp(dB);
    
    %Characteristic path length of the networks
    L_A = sum(spA(:))/(100*99);
    L_B = sum(spB(:))/(100*99);
    
    fprintf('The characteristic path length of A =');
    disp(L_A);
    fprintf('The characteristic path length of B =');
    disp(L_B);
    
    %Global clustering coefficient of the networks
    A_cc = mean(clustering_coefficients(A_sparse));
    B_cc = mean(clustering_coefficients(B_sparse));
    
    fprintf('The Global clustering coefficient of A =');
    disp(A_cc);
    fprintf('The Global clustering coefficient of B =');
    disp(B_cc);
    
    %Degree distribution of the networks.
    A_degree = sum(A);
    B_degree = sum(B);

    figure;
    histogram(A_degree);
    title('Degree distribution of network A');
    xlabel('Degrees');
    ylabel('Number of occurances of that degree');
    figure;
    histogram(B_degree);
    title('Degree distribution of network B');
    xlabel('Degrees');
    ylabel('Number of occurances of that degree');
    
    %For refernce, both the networks are also plotted.
    figure;
    plot(Ag);
    title('Network A');
    figure;
    plot(Bg);
    title('Network B');
    
end
    
    
    