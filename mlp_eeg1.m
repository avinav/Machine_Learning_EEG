% clear all;
% close all;
function mlp_eeg1(inp,po,flag3)
lp=0.0001;
hidunits=12;
inpunits=length(inp);
h1=zeros(1,hidunits);
h2=zeros(1,hidunits);
h3=zeros(1,hidunits);
op=zeros(1,5);
steps=0;
% % 
% if flag3==1
% wih1=zeros(hidunits,inpunits);
% wh1h2=zeros(hidunits,hidunits);
% wh2h3=zeros(hidunits,hidunits);
% wh3o=zeros(5,hidunits);
% bh1=zeros(1,hidunits);
% bh2=zeros(1,hidunits);
% bh3=zeros(1,hidunits);
% bop=zeros(1,5);
% 
% for i=1:hidunits
%     for j=1:inpunits
%         wih1(i,j)=rand(1);
%         if i<=5 && j<=hidunits
%             wh3o(i,j)=rand(1);
% %             bop(i)=rand(1);
%         end
%         if j<=hidunits
%             wh1h2(i,j)=rand(1);
%             wh2h3(i,j)=rand(1);
% %             bh1(j)=rand(1);
% %             bh2(j)=rand(1);
% %             bh3(j)=rand(1);
%         end
%     end
% end
% end
% 
if flag3>=1
    data=load('weightsfortrial.mat');
    wih1=data.wih1;
    wh1h2=data.wh1h2;
    wh2h3=data.wh2h3;
    wh3o=data.wh3o;

    bh1=data.bh1;
    bh2=data.bh2;
    bh3=data.bh3;
    bop=data.bop;

end
flag=1;
while ( flag <=1)
    %     if flag==1
    %         xxx=load('forward.mat');
    %         inp1=xxx.eeg;
    %         po=[1 0 0 0 0];
    %         
    %     
    %     else if flag==2
    %         xxx=load('backward.mat');
    %         inp1=xxx.eeg;
    %         po=[0 1 0 0 0];
    %         

    %     else if flag==3
    %         xxx=load('left.mat');
    %         inp1=xxx.eeg;
    %         po=[0 0 1 0 0];
    %         
    %     
    %     else if flag==4
    %         xxx=load('right.mat');
    %         inp1=xxx.eeg;
    %         po=[ 0 0 0 1 0];
    %         

    %     else if flag==5
    %         xxx=load('stop.mat');
    %         inp1=xxx.eeg;
    %         po=[0 0 0 0 1];
    %         
    %         end
    %         end
    %     end
    %     end
    %     end
    flag=flag+1;
    for iii=1:1
        op=[-1 -1 -1 -1 -1];

        h1=zeros(1,hidunits);
        h2=zeros(1,hidunits);
        h3=zeros(1,hidunits);    
        delop=po-op;
        while delop(1)~=0 || delop(2)~=0 || delop(3)~=0 || delop(4)~=0 || delop(5)~=0
            op=[-1 -1 -1 -1 -1];
            h1=zeros(1,hidunits);
            h2=zeros(1,hidunits);
            h3=zeros(1,hidunits);
            for i=1:hidunits
                for j=1:inpunits
                    h1(i)=h1(i)+wih1(i,j)*inp(j);
                end
                 if h1(i)<=bh1(i)
                     h1(i)=-1;
                 else
                     h1(i)=1;
                 end
            end

            for i=1:hidunits
                for j=1:hidunits
                    h2(i)=h2(i)+wh1h2(1,j)*h1(j);
                end
                 if h2(i)<=bh2(i)
                    h2(i)=-1;
                else
                    h2(i)=1;
                end
            end

            for i=1:hidunits
                for j=1:hidunits
                    h3(i)=h3(i)+wh2h3(1,j)*h2(j);
                end
                 if h3(i)<=bh3(i)
                    h3(i)=-1;
                else
                    h3(i)=1;
                end
            end

            for i=1:5
                for j=1:hidunits
                    op(i)=op(i)+wh3o(i,j)*h3(j);
                end
                 if op(i)<=bop(i)
                    op(i)=-1;
                else
                    op(i)=1;
                 end
            end

            delop=po-op;

            delh2=zeros(1,hidunits);
            delh3=zeros(1,hidunits);

            for i=1:5
                for j=1:hidunits
                    delh3(j)=delh3(j)+wh3o(i,j)*delop(i);
                end
            end


            for i=1:hidunits
                for j=1:hidunits
                    delh2(j)=delh2(j)+wh2h3(i,j)*delh3(i);
                end
            end

            delh1=zeros(1,hidunits);
            for i=1:hidunits
                for j=1:hidunits
                    delh1(j)=delh1(j)+wh1h2(i,j)*delh2(i);
                end
            end

            % if flag3==1 && steps==0
            %  save 'weightsforeeg1.mat' wih1 wh1h2 wh2h3 wh3o bh1 bh2 bop;   
            % end

            % 
            for i=1:hidunits
                if i<=5
                bop(i)=bop(i)-delop(i)*lp;
                end
                bh3(i)=bh3(i)-delh3(i)*lp;
                bh2(i)=bh2(i)-delh2(i)*lp;
                bh1(i)=bh1(i)-delh1(i)*lp;
            end

            for i=1:hidunits
                for j=1:inpunits
                    if j<=hidunits
                        wh1h2(i,j)=wh1h2(i,j)+lp*delh2(i)*h1(j);
                        wh2h3(i,j)=wh2h3(i,j)+lp*delh3(i)*h2(j);
                    end

                    if i<=5 && j<=hidunits
                        wh3o(i,j)=wh3o(i,j)+lp*delop(i)*h3(j);
                    end

                    wih1(i,j)=wih1(i,j)+lp*delh1(i)*inp(j);

                end
            end
            % if flag3==1 && steps==0
            %  save 'weightsforeeg2.mat' wih1 wh1h2 wh2h3 wh3o bh1 bh2 bop;   
            % end

            steps=steps+1;
        end


    end
end
% save 'weightsforeeg.mat' wih1 wh1h2 wh2h3 wh3o bh1 bh2 bh3 bop;
steps
% pause(3);

     save 'weightsfortrial.mat' wih1 wh1h2 wh2h3 wh3o bh1 bh2 bh3 bop;
