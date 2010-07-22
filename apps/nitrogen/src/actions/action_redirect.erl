% Nitrogen Web Framework for Erlang
% Copyright (c) 2008-2010 Rusty Klophaus
% See MIT-LICENSE for licensing information.

-module (action_redirect).
-include_lib ("wf.hrl").
-compile(export_all).

render_action(Record) ->
    DestinationUrl = Record#redirect.url,
    wf:f("window.location=\"~s\";", [wf:js_escape(DestinationUrl)]).

redirect(Url) ->
    redirect(Url, []).

redirect(BaseUrl, QueryParams) ->
    Url = BaseUrl ++ wf:query_encode(QueryParams),
    wf:wire(#redirect { url=Url }),
    wf:f("<script>window.location=\"~s\";</script>", [wf:js_escape(Url)]).

redirect_to_login(LoginUrl) ->
    redirect_to_login(LoginUrl, []).

redirect_to_login(LoginUrl, QueryParams) ->
    % Assemble the original
    Request = wf_context:request_bridge(),
    OriginalURI = Request:uri(),
    PickledURI = wf:pickle(OriginalURI),
    ExtParams = [{"x", wf:to_list(PickledURI)}] ++ QueryParams,
    redirect(LoginUrl, ExtParams).

redirect_from_login(DefaultUrl) ->
    redirect_from_login(DefaultUrl, []).

redirect_from_login(DefaultUrl, DefaultParams) ->
    PickledURI = wf:q(x),
    case wf:depickle(PickledURI) of
        undefined -> redirect(DefaultUrl, DefaultParams);
        Other -> redirect(Other)
    end.
