classdef Graph < handle
    properties
        m_poses
        m_edges
        m_drawer
        m_G
        m_n
        m_m
    end
    methods
        function this = Graph(G)
            triG = triu(G);
            triG = triG - diag(diag(triG));
            G = triG + triG';            
            n = size(G,1);
            pose = [rand(1,n);rand(1,n)];
            list = sparse(triG);
            [ii,jj] = find(list);
            m = size(ii,1);
            this.m_poses = pose;
            this.m_edges = [ii,jj];
            this.m_drawer = Drawer();
            this.m_n = n;
            this.m_m = m;
            this.Show();
            pause(1);
        end
        function Show(this)
            this.m_drawer.Reset();
            for i = 1:this.m_n
                p_i = this.m_poses(:,i);
                this.m_drawer.DrawNode(p_i);
                %text(p_i(1),p_i(2),num2str(i));
            end
            for i = 1:this.m_m
                pi = this.m_poses(:,this.m_edges(i,1));
                pj = this.m_poses(:,this.m_edges(i,2));
                this.m_drawer.DrawEdge(pi,pj);
            end
        end
        function star = GetStar(this,i)
            ids = 1:this.m_m;
            star = this.m_edges(i == this.m_edges(:,1),2);
        end
    end
end