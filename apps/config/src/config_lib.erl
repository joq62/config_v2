-module(config_lib).

-compile(export_all).
%-export([
%	 update_appl_info_specs/0
%	]).


-define(AllHostNames,["c100","c200","c201","c202"]).
-define(ApplInfoSpecs,{"application_info_specs",".spec"}).
-define(HostInfoSpecs,{"host_info_specs",".host"}).




%% --------------------------------------------------------------------

%% --------------------------------------------------------------------
%% Function: available_hosts()
%% Description: Based on hosts.config file checks which hosts are avaible
%% Returns: List({HostId,Ip,SshPort,Uid,Pwd}
%% --------------------------------------------------------------------
update_appl_info_specs()->
    


    ok.
%% --------------------------------------------------------------------
%% Function: available_hosts()
%% Description: Based on hosts.config file checks which hosts are avaible
%% Returns: List({HostId,Ip,SshPort,Uid,Pwd}
%% --------------------------------------------------------------------
available_config_nodes()->
    NodeName=common:config_nodename(),
    Cookie=list_to_atom(common:config_cookie()),
    Nodes=[list_to_atom(NodeName++"@"++HostName)||HostName<-?AllHostNames],
    [erlang:set_cookie(Node,Cookie)||Node<-Nodes],
    [Node||Node<-Nodes,
	   pong=:=net_adm:ping(Node)].
    
    
    
    


%% --------------------------------------------------------------------
%% Function: available_hosts()
%% Description: Based on hosts.config file checks which hosts are avaible
%% Returns: List({HostId,Ip,SshPort,Uid,Pwd}
%% --------------------------------------------------------------------

