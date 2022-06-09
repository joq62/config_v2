%%% -------------------------------------------------------------------
%%% @author  : Joq Erlang
%%% @doc: : 
%%% Created :
%%% Node end point  
%%% Creates and deletes Pods
%%% 
%%% API-kube: Interface 
%%% Pod consits beams from all services, app and app and sup erl.
%%% The setup of envs is
%%% -------------------------------------------------------------------
-module(config_server).     
-behaviour(gen_server).

%% --------------------------------------------------------------------
%% Include files
%% --------------------------------------------------------------------


%% --------------------------------------------------------------------
-define(SERVER,?MODULE).
%% --------------------------------------------------------------------
%% Key Data structures
%% 
%% --------------------------------------------------------------------
-record(state, {}).



%% --------------------------------------------------------------------
%% Definitions 
%% --------------------------------------------------------------------

%% --------------------------------------------------------------------
%% Function: available_hosts()
%% Description: Based on hosts.config file checks which hosts are avaible
%% Returns: List({HostId,Ip,SshPort,Uid,Pwd}
%% --------------------------------------------------------------------

-export([ %application_info_specs
	  application_id_all/0,
	  application_vsn/1,
	  application_gitpath/1,
	  application_member/1,
	  application_member/2,
	 %% host_info_specs
	  host_id_all/0,
	  host_local_ip/1,
	  host_public_ip/1,
	  host_ssl_port/1,
	  host_uid/1,
	  host_passwd/1,
	  host_controller_node/1,
	  host_cookie/1,
	  host_application_config/1,
	 %% deployment_info_specs
	  deployment_appl_to_deploy/1,
	  deployment_id_all/0,
	  deployment_vsn/1,
	  deployment_app_id/1,
	  deployment_app_vsns/1,
	  deployment_controller_nodes/1
	]).

-export([
	 appl_start/1,
	 ping/0,
	 start/0,
	 stop/0
	]).

%% gen_server callbacks
-export([init/1, handle_call/3,handle_cast/2, handle_info/2, terminate/2, code_change/3]).


%% ====================================================================
%% External functions
%% ====================================================================
appl_start([])->
    application:start(config).
%%-----------------------------------------------------------------------

%%----------------------------------------------------------------------
%% Gen server functions
start()-> gen_server:start_link({local, ?SERVER}, ?SERVER, [], []).
stop()-> gen_server:call(?SERVER, {stop},infinity).


%% application_info_specs
application_id_all()->
    gen_server:call(?SERVER, {application_id_all},infinity).
application_vsn(AppId)->
    gen_server:call(?SERVER, {application_vsn,AppId},infinity).
application_gitpath(AppId)->
    gen_server:call(?SERVER, {application_gitpath,AppId},infinity).
application_member(AppId)->
    gen_server:call(?SERVER, {application_member,AppId},infinity).
application_member(AppId,Vsn)->
    gen_server:call(?SERVER, {application_member,AppId,Vsn},infinity).

%% host_info_specs
host_id_all()->
    gen_server:call(?SERVER, {host_id_all},infinity).
host_local_ip(HostName)->
    gen_server:call(?SERVER, {host_local_ip,HostName},infinity).
host_public_ip(HostName)->
    gen_server:call(?SERVER, {host_public_ip,HostName},infinity).
host_ssl_port(HostName)->
    gen_server:call(?SERVER, {host_ssl_port,HostName},infinity).
host_uid(HostName)->
    gen_server:call(?SERVER, {host_uid,HostName},infinity).
host_passwd(HostName)->
    gen_server:call(?SERVER, {host_passwd,HostName},infinity).
host_controller_node(HostName)->
    gen_server:call(?SERVER, {host_controller_node,HostName},infinity).
host_cookie(HostName)->
    gen_server:call(?SERVER, {host_cookie,HostName},infinity).
host_application_config(HostName)->
     gen_server:call(?SERVER, {host_application_config,HostName},infinity).

%% deployment_info_specs
deployment_id_all()->
    gen_server:call(?SERVER, {deployment_id_all},infinity).
deployment_vsn(DeplId)->
    gen_server:call(?SERVER, {deployment_vsn,DeplId},infinity).
deployment_app_id(DeplId)->
    gen_server:call(?SERVER, {deployment_app_id,DeplId},infinity).
deployment_app_vsns(DeplId)->
    gen_server:call(?SERVER, {deployment_app_vsns,DeplId},infinity).
deployment_controller_nodes(DeplId)->
    gen_server:call(?SERVER, {deployment_controller_nodes,DeplId},infinity).
deployment_appl_to_deploy(Controller)->
    gen_server:call(?SERVER, {deployment_appl_to_deploy,Controller},infinity).


%%---------------------------------------------------------------
-spec ping()-> {atom(),node(),module()}|{atom(),term()}.
%% 
%% @doc:check if service is running
%% @param: non
%% @returns:{pong,node,module}|{badrpc,Reason}
%%
ping()-> 
    gen_server:call(?SERVER, {ping},infinity).


%% ====================================================================
%% Server functions
%% ====================================================================

%% --------------------------------------------------------------------
%% Function: 
%% Description: Initiates the server
%% Returns: {ok, State}          |
%%          {ok, State, Timeout} |
%%          ignore               |
%%          {stop, Reason}
%
%% --------------------------------------------------------------------
init([]) ->
 
    {ok, #state{}}.
    
%% --------------------------------------------------------------------
%% Function: handle_call/3
%% Description: Handling call messages
%% Returns: {reply, Reply, State}          |
%%          {reply, Reply, State, Timeout} |
%%          {noreply, State}               |
%%          {noreply, State, Timeout}      |
%%          {stop, Reason, Reply, State}   | (terminate/2 is called)
%%          {stop, Reason, State}            (aterminate/2 is called)
%% --------------------------------------------------------------------

%%----------------- deployment_info_specs

handle_call({deployment_appl_to_deploy,Controller},_From,State) ->
    Reply=deployment:appl_to_deploy(Controller),
    {reply, Reply, State};

handle_call({deployment_id_all},_From,State) ->
    Reply=deployment:id_all(),
    {reply, Reply, State};

handle_call({deployment_vsn,DeplId},_From,State) ->
    Reply=deployment:vsn(DeplId),
    {reply, Reply, State};

handle_call({deployment_app_id,DeplId},_From,State) ->
    Reply=deployment:app_id(DeplId),
    {reply, Reply, State};

handle_call({deployment_app_vsns,DeplId},_From,State) ->
    Reply=deployment:app_vsns(DeplId),
    {reply, Reply, State};

handle_call({deployment_controller_nodes,DeplId},_From,State) ->
    Reply=deployment:controller_nodes(DeplId),
    {reply, Reply, State};


%%----------------- application_info_specs
handle_call({application_id_all},_From,State) ->
    Reply=apps:id_all(),
    {reply, Reply, State};

handle_call({application_vsn,AppId},_From,State) ->
    Reply=apps:vsn(AppId),
    {reply, Reply, State};

handle_call({application_gitpath,AppId},_From,State) ->
    Reply=apps:gitpath(AppId),
    {reply, Reply, State};

handle_call({application_member,AppId},_From,State) ->
    Reply=apps:member(AppId),
    {reply, Reply, State};

handle_call({application_member,AppId,Vsn},_From,State) ->
    Reply=apps:member(AppId,Vsn),
    {reply, Reply, State};

%%--------------- host_info_specs

handle_call({host_id_all},_From,State) ->
    Reply=host:id_all(),
    {reply, Reply, State};

handle_call({host_local_ip,HostName},_From,State) ->
    Reply=host:local_ip(HostName),
    {reply, Reply, State};

handle_call({host_public_ip,HostName},_From,State) ->
    Reply=host:public_ip(HostName),
    {reply, Reply, State};

handle_call({host_ssl_port,HostName},_From,State) ->
    Reply=host:ssl_port(HostName),
    {reply, Reply, State};

handle_call({host_uid,HostName},_From,State) ->
    Reply=host:uid(HostName),
    {reply, Reply, State};

handle_call({host_passwd,HostName},_From,State) ->
    Reply=host:passwd(HostName),
    {reply, Reply, State};

handle_call({host_controller_node,HostName},_From,State) ->
    Reply=host:controller_node(HostName),
    {reply, Reply, State};

handle_call({host_cookie,HostName},_From,State) ->
    Reply=host:cookie(HostName),
    {reply, Reply, State};

handle_call({host_application_config,HostName},_From,State) ->
    Reply=host:application_config(HostName),
    {reply, Reply, State};

handle_call({ping},_From,State) ->
    Reply=pong,
    {reply, Reply, State};

handle_call({stop}, _From, State) ->    
    {stop, normal, shutdown_ok, State};

handle_call(Request, From, State) ->
    Reply = {unmatched_signal,?MODULE,Request,From},
    {reply, Reply, State}.

%% --------------------------------------------------------------------
%% Function: handle_cast/2
%% Description: Handling cast messages
%% Returns: {noreply, State}          |
%%          {noreply, State, Timeout} |
%%          {stop, Reason, State}            (terminate/2 is called)
%% -------------------------------------------------------------------
    
handle_cast(Msg, State) ->
    io:format("unmatched match cast ~p~n",[{?MODULE,?LINE,Msg}]),
    {noreply, State}.

%% --------------------------------------------------------------------
%% Function: handle_info/2
%% Description: Handling all non call/cast messages
%% Returns: {noreply, State}          |
%%          {noreply, State, Timeout} |
%%          {stop, Reason, State}            (terminate/2 is called)
%% --------------------------------------------------------------------


handle_info({stop}, State) ->
    io:format("stop ~p~n",[{?MODULE,?LINE}]),
    exit(self(),normal),
    {noreply, State};

handle_info(Info, State) ->
    io:format("unmatched match info ~p~n",[{?MODULE,?LINE,Info}]),
    {noreply, State}.


%% --------------------------------------------------------------------
%% Function: terminate/2
%% Description: Shutdown the server
%% Returns: any (ignored by gen_server)
%% --------------------------------------------------------------------
terminate(_Reason, _State) ->
    ok.

%% --------------------------------------------------------------------
%% Func: code_change/3
%% Purpose: Convert process state when code is changed
%% Returns: {ok, NewState}
%% --------------------------------------------------------------------
code_change(_OldVsn, State, _Extra) ->
    {ok, State}.

%% --------------------------------------------------------------------
%%% Internal functions
%% --------------------------------------------------------------------
%% --------------------------------------------------------------------
%% Function: 
%% Description:
%% Returns: non
%% --------------------------------------------------------------------

%% --------------------------------------------------------------------
%% Internal functions
%% --------------------------------------------------------------------

%% --------------------------------------------------------------------
%% Function: 
%% Description:
%% Returns: non
%% --------------------------------------------------------------------
