-module(host).

-export([
	 id_all/0,
	 local_ip/1,
	 public_ip/1,
	 ssl_port/1,
	 uid/1,
	 passwd/1,
	 controller_node/1,
	 cookie/1,
	 application_config/1,
	 
	 %% Support
	 all_files/0,
	 all_info/0
	]).


-define(DirSpecs,"host_info_specs").

%% --------------------------------------------------------------------
%% Function: available_hosts()
%% Description: Based on hosts.config file checks which hosts are avaible
%% Returns: List({HostId,Ip,SshPort,Uid,Pwd}
%% --------------------------------------------------------------------
id_all()->
    AllInfoList=all_info(),
    [proplists:get_value(hostname,L)||L<-AllInfoList].

%% --------------------------------------------------------------------
%% Function: available_hosts()
%% Description: Based on hosts.config file checks which hosts are avaible
%% Returns: List({HostId,Ip,SshPort,Uid,Pwd}
%% --------------------------------------------------------------------
local_ip(HostId)->
    AllInfoList=all_info(),
    InfoListResult=[L||L<-AllInfoList,
		 HostId=:=proplists:get_value(hostname,L)],
    case InfoListResult of
	[]->
	    {error,[eexists,HostId]};
	[InfoList]->
	    {ok,proplists:get_value(local_ip,InfoList)}
    end.
%% --------------------------------------------------------------------
%% Function: available_hosts()
%% Description: Based on hosts.config file checks which hosts are avaible
%% Returns: List({HostId,Ip,SshPort,Uid,Pwd}
%% --------------------------------------------------------------------
public_ip(HostId)->
    AllInfoList=all_info(),
    InfoListResult=[L||L<-AllInfoList,
		 HostId=:=proplists:get_value(hostname,L)],
    case InfoListResult of
	[]->
	    {error,[eexists,HostId]};
	[InfoList]->
	    {ok,proplists:get_value(public_ip,InfoList)}
    end.

%% --------------------------------------------------------------------
%% Function: available_hosts()
%% Description: Based on hosts.config file checks which hosts are avaible
%% Returns: List({HostId,Ip,SshPort,Uid,Pwd}
%% --------------------------------------------------------------------
ssl_port(HostId)->
    AllInfoList=all_info(),
    InfoListResult=[L||L<-AllInfoList,
		 HostId=:=proplists:get_value(hostname,L)],
    case InfoListResult of
	[]->
	    {error,[eexists,HostId]};
	[InfoList]->
	    {ok,proplists:get_value( ssl_port,InfoList)}
    end.
%% --------------------------------------------------------------------
%% Function: available_hosts()
%% Description: Based on hosts.config file checks which hosts are avaible
%% Returns: List({HostId,Ip,SshPort,Uid,Pwd}
%% --------------------------------------------------------------------
uid(HostId)->
    AllInfoList=all_info(),
    InfoListResult=[L||L<-AllInfoList,
		 HostId=:=proplists:get_value(hostname,L)],
    case InfoListResult of
	[]->
	    {error,[eexists,HostId]};
	[InfoList]->
	    {ok,proplists:get_value(uid,InfoList)}
    end.
%% --------------------------------------------------------------------
%% Function: available_hosts()
%% Description: Based on hosts.config file checks which hosts are avaible
%% Returns: List({HostId,Ip,SshPort,Uid,Pwd}
%% --------------------------------------------------------------------
passwd(HostId)->
    AllInfoList=all_info(),
    InfoListResult=[L||L<-AllInfoList,
		 HostId=:=proplists:get_value(hostname,L)],
    case InfoListResult of
	[]->
	    {error,[eexists,HostId]};
	[InfoList]->
	    {ok,proplists:get_value(passwd,InfoList)}
    end.

%% --------------------------------------------------------------------
%% Function: available_hosts()
%% Description: Based on hosts.config file checks which hosts are avaible
%% Returns: List({HostId,Ip,SshPort,Uid,Pwd}
%% --------------------------------------------------------------------
controller_node(HostId)->
    AllInfoList=all_info(),
    InfoListResult=[L||L<-AllInfoList,
		 HostId=:=proplists:get_value(hostname,L)],
    case InfoListResult of
	[]->
	    {error,[eexists,HostId]};
	[InfoList]->
	    {ok,proplists:get_value( controller_node,InfoList)}
    end.

%% --------------------------------------------------------------------
%% Function: available_hosts()
%% Description: Based on hosts.config file checks which hosts are avaible
%% Returns: List({HostId,Ip,SshPort,Uid,Pwd}
%% --------------------------------------------------------------------
cookie(HostId)->
    AllInfoList=all_info(),
    InfoListResult=[L||L<-AllInfoList,
		 HostId=:=proplists:get_value(hostname,L)],
    case InfoListResult of
	[]->
	    {error,[eexists,HostId]};
	[InfoList]->
	    {ok,proplists:get_value(cookie,InfoList)}
    end.

%% --------------------------------------------------------------------
%% Function: available_hosts()
%% Description: Based on hosts.config file checks which hosts are avaible
%% Returns: List({HostId,Ip,SshPort,Uid,Pwd}
%% --------------------------------------------------------------------
application_config(HostId)->
    AllInfoList=all_info(),
    InfoListResult=[L||L<-AllInfoList,
		 HostId=:=proplists:get_value(hostname,L)],
    case InfoListResult of
	[]->
	    {error,[eexists,HostId]};
	[InfoList]->
	    {ok,proplists:get_value(application_config,InfoList)}
    end.


%% --------------------------------------------------------------------
%% Function: available_hosts()
%% Description: Based on hosts.config file checks which hosts are avaible
%% Returns: List({HostId,Ip,SshPort,Uid,Pwd}
%% --------------------------------------------------------------------
all_files()->
    {ok,Files}=file:list_dir(?DirSpecs),
    DeplFiles=[filename:join(?DirSpecs,Filename)||Filename<-Files,
							    ".host"=:=filename:extension(Filename)],
    DeplFiles.    
all_info()->
    L1=[file:consult(DeplFile)||DeplFile<-all_files()],
%    io:format(" L1 ~p~n",[L1]),
    [Info||{ok,Info}<-L1].


%find(DeplId)->
    
    
