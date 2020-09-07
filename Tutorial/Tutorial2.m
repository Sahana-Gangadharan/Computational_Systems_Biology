function[] = Tutorial2(edge_list)
    if min(edge_list,[],'all')==0
        nnodes=max(edge_list,[],'all')+1;
    else
        nnodes=max(edge_list,[],'all');
    end
    fprintf('Total number of nodes in the network =');
    disp(nnodes);
    fprintf('Total number of edges in the network =');
    disp(length(edge_list));
    
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
   
    %fprintf('Adjacency matrix =\n');
    %disp(A);
    
    degree = sum(A);
    %fprintf('Degree of this network =\n');
    %disp(degree);
    
    fprintf('Min and Max degree are =');
    disp(min(degree));
    disp(max(degree));
    mean(degree)
    %Degree distribution is plotted
    figure;
    plot(degree);
    title('Degree distribution');
    
    %Average degree
    avg_degree = (sum(degree))/nnodes;
    fprintf('Average degree of this network =');
    disp(avg_degree);
    
    %Density
    density=length(edge_list)/nchoosek(nnodes,2);
    fprintf('Density of this network =');
    disp(density);
    
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
    
    figure;
    plot(cc);
    title('Clustering coefficient vs nodes');
    
    %Assortativity
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
    hh=hh/length(edge_list);
    ll=ll/length(edge_list);
    hl=hl/length(edge_list);
    
    assort_matrix = [ll,hl;hl,hh];
    tr=trace(assort_matrix);
    sum_assort=sum(assort_matrix,'all');
    
    assortativity = (tr - sum_assort^2)/(1-sum_assort^2);
    fprintf('The assortativity of this network is =');
    disp(assortativity);
    
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
    fprintf('Plotting correlation between edges\n');
    
    corrcoef(L,R)
    %Printing the graph itself
    G = graph(A);
    figure;
    plot(G);
end
    