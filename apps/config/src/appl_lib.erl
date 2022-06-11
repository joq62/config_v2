-module(appl_lib).

-export([
	
	 get/2,
	 %% Support
	 all_files/0,
	 all_filenames/0,
	 all_info/0
	]).


-define(DirSpecs,"application_info_specs").


%% --------------------------------------------------------------------
%% Function: available_hosts()
%% Description: Based on hosts.config file checks which hosts are avaible
%% Returns: List({HostId,Ip,SshPort,Uid,Pwd}
%% --------------------------------------------------------------------
all_filenames()->
    {ok,Files}=file:list_dir(?DirSpecs),
    [Filename||Filename<-Files,
	       ".spec"=:=filename:extension(Filename)].

all_files()->
    [filename:join(?DirSpecs,Filename)||Filename<-all_filenames()].
all_info()->
    L1=[file:consult(DeplFile)||DeplFile<-all_files()],
%    io:format(" L1 ~p~n",[L1]),
    [Info||{ok,Info}<-L1].


%find(DeplId)->
    %% --------------------------------------------------------------------
%% Function: available_hosts()
%% Description: Based on hosts.config file checks which hosts are avaible
%% Returns: List({HostId,Ip,SshPort,Uid,Pwd}
%% --------------------------------------------------------------------
get(Key,DeplFileName)->
    Reply=case get_info(DeplFileName) of
	      {error,Reason}->
		  {error,Reason};
	      {ok,Info}->
		  {Key,Value}=lists:keyfind(Key,1,Info),
		  Value
	  end,
    Reply.		      

%% --------------------------------------------------------------------
%% Function: available_hosts()
%% Description: Based on hosts.config file checks which hosts are avaible
%% Returns: List({HostId,Ip,SshPort,Uid,Pwd}
%% --------------------------------------------------------------------
get_info(DeplFileName)->
    Reply=case [file:consult(DeplFile)||DeplFile<-all_files(),
					DeplFileName=:=filename:basename(DeplFile)] of
	      []->
		  {error,[eexists,DeplFileName]};
	      [{ok,Info}]->
		  {ok,Info}
	  end,
    Reply.
	   

    
