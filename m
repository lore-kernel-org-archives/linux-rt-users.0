From: Tom Zanussi <tom.zanussi@linux.intel.com>
Subject: Re: [PATCH v7 22/37] tracing: Add variable reference handling to
 hist triggers
Date: Mon, 11 Dec 2017 11:53:10 -0600
Message-ID: <1513014790.4353.7.camel@tzanussi-mobl.amr.corp.intel.com>
References: <cover.1512593081.git.tom.zanussi@linux.intel.com>
         <7b23f5933ef730ffea398f97c00b675179609b9f.1512593081.git.tom.zanussi@linux.intel.com>
         <20171211151712.GA20788@danjae.aot.lge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: rostedt@goodmis.org, tglx@linutronix.de, mhiramat@kernel.org,
        vedang.patel@intel.com, bigeasy@linutronix.de,
        joel.opensrc@gmail.com, joelaf@google.com,
        mathieu.desnoyers@efficios.com, baohong.liu@intel.com,
        rajvi.jingar@intel.com, julia@ni.com, fengguang.wu@intel.com,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
        kernel-team@lge.com
To: Namhyung Kim <namhyung@kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:15046 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750707AbdLKRxO (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 11 Dec 2017 12:53:14 -0500
In-Reply-To: <20171211151712.GA20788@danjae.aot.lge.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi Namhyung,

On Tue, 2017-12-12 at 00:17 +0900, Namhyung Kim wrote:
> Hi Tom,
> 
> On Wed, Dec 06, 2017 at 04:38:03PM -0600, Tom Zanussi wrote:
> > Add the necessary infrastructure to allow the variables defined on one
> > event to be referenced in another.  This allows variables set by a
> > previous event to be referenced and used in expressions combining the
> > variable values saved by that previous event and the event fields of
> > the current event.  For example, here's how a latency can be
> > calculated and saved into yet another variable named 'wakeup_lat':
> > 
> >     # echo 'hist:keys=pid,prio:ts0=common_timestamp ...
> >     # echo 'hist:keys=next_pid:wakeup_lat=common_timestamp-$ts0 ...
> > 
> > In the first event, the event's timetamp is saved into the variable
> > ts0.  In the next line, ts0 is subtracted from the second event's
> > timestamp to produce the latency.
> > 
> > Further users of variable references will be described in subsequent
> > patches, such as for instance how the 'wakeup_lat' variable above can
> > be displayed in a latency histogram.
> > 
> > Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
> > ---
> 
> [SNIP]
> > @@ -313,10 +529,150 @@ static struct hist_field *find_var(struct hist_trigger_data *hist_data,
> >  	return NULL;
> >  }
> >  
> > +static struct trace_event_file *find_var_file(struct trace_array *tr,
> > +					      char *system,
> > +					      char *event_name,
> > +					      char *var_name)
> > +{
> > +	struct hist_trigger_data *var_hist_data;
> > +	struct hist_var_data *var_data;
> > +	struct trace_event_call *call;
> > +	struct trace_event_file *file, *found = NULL;
> > +	const char *name;
> > +
> > +	list_for_each_entry(var_data, &tr->hist_vars, list) {
> > +		var_hist_data = var_data->hist_data;
> > +		file = var_hist_data->event_file;
> > +		if (file == found)
> > +			continue;
> > +		call = file->event_call;
> > +		name = trace_event_name(call);
> > +
> > +		if (!system || !event_name) {
> > +			if (find_var(var_hist_data, file, var_name)) {
> 
> Is find_var() really needed?  I guess find_var_field() could do the
> job with lower overhead..
> 
> > +				if (found) {
> > +					return NULL;
> > +				}
> > +
> > +				found = file;
> > +			}
> > +			continue;
> > +		}
> > +
> > +		if (strcmp(event_name, name) != 0)
> > +			continue;
> > +		if (strcmp(system, call->class->system) != 0)
> > +			continue;
> 
> Also it doesn't need to iterate the loop when system and event name is
> given.  Please see below
> 
> 
> > +
> > +		found = file;
> > +		break;
> > +	}
> > +
> > +	return found;
> > +}
> 
> 
> How about this?
> 
> find_var_file()
> {
> 	if (system)
> 		return find_event_file(tr, system, event);
> 
> 	list_for_each_entry(var_data, &tr->hist_vars, list) {
> 		var_hist_data = var_data->hist_data;
> 		file = var_hist_data->event_file;
> 		if (file == found)
> 			continue;
> 
> 		if (find_var_field(var_hist_data, var_name)) {
> 			if (found)
> 				return NULL;
> 			
> 			found = file;
> 		}
> 	}
> }
> 
> 

Nice improvement, have incorporated it, thanks!

Tom



