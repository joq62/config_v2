-module(deployment).

-export([
	 id_all/0,
	 vsn/1,
	 app_id/1,
	 app_vsns/1,
	 controller_nodes/1,
	 appl_to_deploy/1,
	 %% Support
	 all_files/0,
	 all_info/0
	]).


-define(DirSpecs,"deployment_info_specs").

%% --------------------------------------------------------------------
%% Function: available_hosts()
%% Description: Based on hosts.config file checks which hosts are avaible
%% Returns: List({HostId,Ip,SshPort,Uid,Pwd}
%% --------------------------------------------------------------------
appl_to_deploy(Controller)->
    AllInfoList=all_info(),
    ApplList=[{proplists:get_value(appl_id,L),
	       proplists:get_value(appl_vsn,L)}||L<-AllInfoList,
						 lists:member(Controller,proplists:get_value(nodes,L)) or
						     lists:member(all,proplists:get_value(nodes,L))],
    get_gitpath(ApplList,[]).
    
get_gitpath([],R)->
    R;
get_gitpath([{ApplId,ApplVsn}|T],Acc)->
    NewAcc=case apps:gitpath(ApplId) of
	       {ok,GitPath}->
		   [{ApplId,ApplVsn,GitPath}|Acc];
	       _->
		   Acc
	   end,
    get_gitpath(T,NewAcc).
 
%% --------------------------------------------------------------------
%% Function: available_hosts()
%% Description: Based on hosts.config file checks which hosts are avaible
%% Returns: List({HostId,Ip,SshPort,Uid,Pwd}
%% --------------------------------------------------------------------


id_all()->
    AllInfoList=all_info(),
    [proplists:get_value(deployment_id,L)||L<-AllInfoList].

%% --------------------------------------------------------------------
%% Function: available_hosts()
%% Description: Based on hosts.config file checks which hosts are avaible
%% Returns: List({HostId,Ip,SshPort,Uid,Pwd}
%% --------------------------------------------------------------------
vsn(DeplId)->
    AllInfoList=all_info(),
    InfoListResult=[L||L<-AllInfoList,
		 DeplId=:=proplists:get_value(deployment_id,L)],
    case InfoListResult of
	[]->
	    {error,[eexists,DeplId]};
	[InfoList]->
	    {ok,proplists:get_value(deployment_vsn,InfoList)}
    end.

%% --------------------------------------------------------------------
%% Function: available_hosts()
%% Description: Based on hosts.config file checks which hosts are avaible
%% Returns: List({HostId,Ip,SshPort,Uid,Pwd}
%% --------------------------------------------------------------------
app_id_vsn(DeplId)->
    AllInfoList=all_info(),
    InfoListResult=[L||L<-AllInfoList,
		       DeplId=:=proplists:get_value(deployment_id,L)],
    case InfoListResult of
	[]->
	    {error,[eexists,DeplId]};
	[InfoList]->
	    {ok,{proplists:get_value(appl_id,InfoList),
		 proplists:get_value(appl_vsn,InfoList)}}
    end.

app_id(DeplId)->
    AllInfoList=all_info(),
    InfoListResult=[L||L<-AllInfoList,
		 DeplId=:=proplists:get_value(deployment_id,L)],
    case InfoListResult of
	[]->
	    {error,[eexists,DeplId]};
	[InfoList]->
	    {ok,proplists:get_value(appl_id,InfoList)}
    end.
%% --------------------------------------------------------------------
%% Function: available_hosts()
%% Description: Based on hosts.config file checks which hosts are avaible
%% Returns: List({HostId,Ip,SshPort,Uid,Pwd}
%% --------------------------------------------------------------------
app_vsns(DeplId)->
    AllInfoList=all_info(),
    InfoListResult=[L||L<-AllInfoList,
		 DeplId=:=proplists:get_value(deployment_id,L)],
    case InfoListResult of
	[]->
	    {error,[eexists,DeplId]};
	[InfoList]->
	    {ok,proplists:get_value(appl_vsn,InfoList)}
    end.

%% --------------------------------------------------------------------
%% Function: available_hosts()
%% Description: Based on hosts.config file checks which hosts are avaible
%% Returns: List({HostId,Ip,SshPort,Uid,Pwd}
%% --------------------------------------------------------------------
controller_nodes(DeplId)->
    AllInfoList=all_info(),
    InfoListResult=[L||L<-AllInfoList,
		 DeplId=:=proplists:get_value(deployment_id,L)],
    case InfoListResult of
	[]->
	    {error,[eexists,DeplId]};
	[InfoList]->
	    {ok,proplists:get_value(nodes,InfoList)}
    end.


%% --------------------------------------------------------------------
%% Function: available_hosts()
%% Description: Based on hosts.config file checks which hosts are avaible
%% Returns: List({HostId,Ip,SshPort,Uid,Pwd}
%% --------------------------------------------------------------------
all_files()->
    {ok,Files}=file:list_dir(?DirSpecs),
    DeplFiles=[filename:join(?DirSpecs,Filename)||Filename<-Files,
							    ".depl"=:=filename:extension(Filename)],
    DeplFiles.    
all_info()->
    L1=[file:consult(DeplFile)||DeplFile<-all_files()],
%    io:format(" L1 ~p~n",[L1]),
    [Info||{ok,Info}<-L1].


%find(DeplId)->
    
    
