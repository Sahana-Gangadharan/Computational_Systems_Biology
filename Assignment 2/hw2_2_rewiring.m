function[Bg,B] = hw2_2_rewiring(A,p)
    %Through matlab bgl functions, the number of edges and nodes in the
    %netwrok A is first gotten.
    nA = num_vertices(A);
    nE = numedges(A);
    %e is the edge list of network A. Will be in a table format with two columns - NodeTable and Edgeweight.
    e = A.Edges;
    %Converting the NodeTable into an edge_list = eA
    eA = e(:,1);
    eA = eA{:,:};
    
    Adj = zeros(nA,nA);
    %Based on input probability, edges are rewired. Algorithm is explained
    %in the PDF attached.
    for i = 1:nE
        x = rand();
        if x<p
            n = neighbors(A,eA(i,1));
            available=[1:100];
            available(eA(i,1))=[];
            ai = randi(99);
            a = available(ai);
            binary = ismember(a,n);
            if binary == 0
                eA(i,2) = a;
            else
                eA(i,:) = [eA(i,1),eA(i,2)];
            end
        else
            eA(i,:) = [eA(i,1),eA(i,2)];
        end
        %The changes in eA are incorporated back into the network A
        for k= 1:length(eA)
            a = eA(k,1);
            b = eA(k,2);
            Adj(a,b)=1;
            Adj(b,a)=1;
        end
        A = graph(Adj);
        
    end
    
    nodes = nA;
    %Converting rewired network A = network B to an adjacency matrix
    B = zeros(nodes,nodes);
    for i= 1:length(eA)
        a = eA(i,1);
        b = eA(i,2);
        B(a,b)=1;
        B(b,a)=1;
    end
    Bg = graph(B);
end
    
    