function[] = hw2_1()
    %edge_list is loaded from the system
    edge_list = load('G:\Textbook-Sem6\Computational Systems Biology\bn\ENZYMES8.edges');
    
    if min(edge_list,[],'all')==0
        nnodes=max(edge_list,[],'all')+1;
    else
        nnodes=max(edge_list,[],'all');
    end
    %To give a basic overview of the network
    fprintf('Total number of nodes in the chosen network = ');
    disp(nnodes);
    fprintf('Total number of edges in the chosen network = ');
    disp(length(edge_list));
    
    %Constructing the adjacency matrix
    A = zeros(nnodes,nnodes);
    if min(edge_list,[],'all')==0
        for i= 1:length(edge_list)
            a = edge_list(i,1)+1;
            b = edge_list(i,2)+1;
            A(a,b)=1;
            A(b,a)=1;
        end
    else
        for i= 1:length(edge_list)
            a = edge_list(i,1);
            b = edge_list(i,2);
            A(a,b)=1;
            A(b,a)=1;
        end
    end
    
    %Calculating degree for all nodes
    degree = sum(A); %Sums along columns
    
    %Assortativity
    avg_degree = (sum(degree))/nnodes;
    threshold = floor(avg_degree);
    hh=0;
    ll=0;
    hl=0;
    
    for i = 1:nnodes
        for j = i:nnodes
            if degree(i)>threshold && degree(j)>threshold
                if A(i,j)==1
                    hh = hh+1;
                end
            else
                if degree(i)<threshold && degree(j)<threshold
                    if A(i,j)==1
                        ll = ll+1;
                    end
                else
                    if A(i,j)==1
                        hl = hl+1;
                    end
                end
            end
        end
    end
    %Normalized with respect to number of edges
    
    hh=hh/length(edge_list);
    ll=ll/length(edge_list);
    hl=hl/length(edge_list);
    
    assort_matrix = [ll,hl;hl,hh];
    tr=trace(assort_matrix);
    sum_assort=sum(assort_matrix,'all');
    
    assortativity = (tr - sum_assort^2)/(1-sum_assort^2);
    fprintf('The assortativity of this network, as computed between edges based on the formula given by NewMan =');
    disp(assortativity);
    
    %Assortativity through Pearson Correlation coefficient.
    L = zeros(length(edge_list),1);
    R = zeros(length(edge_list),1);
    
    if min(edge_list,[],'all')==0
        for i = 1:length(edge_list)
            L(i)= degree(edge_list(i,1)+1);
            R(i)= degree(edge_list(i,2)+1);
        end
    else
        for i = 1:length(edge_list)
            L(i)= degree(edge_list(i,1));
            R(i)= degree(edge_list(i,2));
        end
    end
    LR = L;
    RL = R;
    for i = 1:length(edge_list)
        LR(length(edge_list)+i)=R(i);
        RL(length(edge_list)+i)=L(i);
    end
    
    as = corrcoef(LR,RL);
    %variable as will be a 2*2 matrix where diagonal elements are always 1.0 and the
    %coefficient value is the off-diagonal element.
    fprintf('Assortativity/Correlation between degree of edges =');
    disp(as(1,2));
    
    %Degree distribution is plotted
    figure;
    histogram(degree);
    title('Degree distribution');
    xlabel('Degrees');
    ylabel('Number of occurances of that degree');
    
    %Clustering coefficient
    cc=zeros(nnodes,1);
    for i = 1:nnodes
        edge_n=0;
        neighbors=A(i,:);
        l = sum(neighbors~=0);
        for j = 1:length(neighbors)
            for k = j+1:length(neighbors)
                if neighbors(j)==1 && neighbors(k)==1
                    if A(j,k)==1
                        edge_n=edge_n+1;
                    end
                end
            end
        end
        if l<2
            cc(i)=0;
        else
            tedge_n=nchoosek(l,2);
            cc(i)=edge_n/tedge_n;
        end
    end
    %Plotting CC(k) vs k
    figure;
    histogram(cc);
    title('Clustering coefficient distribution');
    xlabel('Clustering coefficient of each node');
    ylabel('Frequency of CC');
end
    