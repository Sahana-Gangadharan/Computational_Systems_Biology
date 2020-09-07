function[] = hw2_2()
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
    edge_list
    ctr
    
    for i =1:3
        for j = 1:3
            edge_list(ctr,:)=[i,i+j];
            ctr=ctr+1;
        end
    end
    for i =100:-1:98
        edge_list(ctr,:)=[1,i];
        ctr=ctr+1;
    end
    edge_list(ctr,:)=[2,1];
    ctr=ctr+1;
    
    for i = 100:-1:99
        edge_list(ctr,:)=[2,i];
        ctr=ctr+1;
    end
    
    edge_list(ctr,:)=[3,100];
    ctr=ctr+1;
    for i =1:2
        edge_list(ctr,:)=[3,i];
        ctr=ctr+1;
    end
    
    for i =4:97
        for j = -3:3
            if j~=0
                edge_list(ctr,:)=[i,i+j];
                ctr=ctr+1;
            end
        end
    end
    
    for i =98:100
        for j = -3:-1
            edge_list(ctr,:)=[i,i+j];
            ctr=ctr+1;
        end
    end
    for i =1:3
        edge_list(ctr,:)=[100,i];
        ctr=ctr+1;
    end
    edge_list(ctr,:)=[99,100];
    ctr=ctr+1;
    for i = 1:2
        edge_list(ctr,:)=[99,i];
        ctr=ctr+1;
    end
    for i =99:100
        edge_list(ctr,:)=[98,i];
        ctr=ctr+1;
    end
    edge_list(ctr,:)=[98,1];
    
end