-module(apps).

-export([
	 id_all/0,
	 vsn/1,
	 gitpath/1,
	 %% Support
	 all_files/0,
	 all_info/0
	]).


-define(DirSpecs,"application_info_specs").

%% --------------------------------------------------------------------
%% Function: available_hosts()
%% Description: Based on hosts.config file checks which hosts are avaible
%% Returns: List({HostId,Ip,SshPort,Uid,Pwd}
%% --------------------------------------------------------------------
id_all()->
    AllInfoList=all_info(),
    [proplists:get_value(name,L)||L<-AllInfoList].

%% --------------------------------------------------------------------
%% Function: available_hosts()
%% Description: Based on hosts.config file checks which hosts are avaible
%% Returns: List({HostId,Ip,SshPort,Uid,Pwd}
%% --------------------------------------------------------------------
vsn(AppId)->
    AllInfoList=all_info(),
    InfoListResult=[L||L<-AllInfoList,
		 AppId=:=proplists:get_value(name,L)],
    case InfoListResult of
	[]->
	    {error,[eexists,AppId]};
	[InfoList]->
	    {ok,proplists:get_value(vsn,InfoList)}
    end.
%% --------------------------------------------------------------------
%% Function: available_hosts()
%% Description: Based on hosts.config file checks which hosts are avaible
%% Returns: List({HostId,Ip,SshPort,Uid,Pwd}
%% --------------------------------------------------------------------

gitpath(AppId)->
    AllInfoList=all_info(),
    InfoListResult=[L||L<-AllInfoList,
		 AppId=:=proplists:get_value(name,L)],
    case InfoListResult of
	[]->
	    {error,[eexists,AppId]};
	[InfoList]->
	    {ok,proplists:get_value(gitpath,InfoList)}
    end.

%% --------------------------------------------------------------------
%% Function: available_hosts()
%% Description: Based on hosts.config file checks which hosts are avaible
%% Returns: List({HostId,Ip,SshPort,Uid,Pwd}
%% --------------------------------------------------------------------
all_files()->
    {ok,Files}=file:list_dir(?DirSpecs),
    DeplFiles=[filename:join(?DirSpecs,Filename)||Filename<-Files,
							    ".spec"=:=filename:extension(Filename)],
    DeplFiles.    
all_info()->
    L1=[file:consult(DeplFile)||DeplFile<-all_files()],
%    io:format(" L1 ~p~n",[L1]),
    [Info||{ok,Info}<-L1].


%find(DeplId)->
    
    
