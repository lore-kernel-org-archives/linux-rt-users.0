From: Tom Zanussi <tom.zanussi@linux.intel.com>
Subject: Re: [PATCH v2 21/40] tracing: Generalize per-element hist trigger
 data
Date: Thu, 07 Sep 2017 13:14:56 -0500
Message-ID: <1504808096.13310.12.camel@tzanussi-mobl.amr.corp.intel.com>
References: <cover.1504642143.git.tom.zanussi@linux.intel.com>
         <e37b733ce4a80b1b92873b95e035b44044bfcfe2.1504642143.git.tom.zanussi@linux.intel.com>
         <20170907135621.036d4b5a@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: tglx@linutronix.de, mhiramat@kernel.org, namhyung@kernel.org,
        vedang.patel@intel.com, bigeasy@linutronix.de,
        joel.opensrc@gmail.com, joelaf@google.com,
        mathieu.desnoyers@efficios.com, baohong.liu@intel.com,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:44581 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755781AbdIGSO6 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 7 Sep 2017 14:14:58 -0400
In-Reply-To: <20170907135621.036d4b5a@gandalf.local.home>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Thu, 2017-09-07 at 13:56 -0400, Steven Rostedt wrote:
> On Tue,  5 Sep 2017 16:57:33 -0500
> Tom Zanussi <tom.zanussi@linux.intel.com> wrote:
> 
[...]
> >  	hist_data->map = tracing_map_create(map_bits, hist_data->key_size,
> >  					    map_ops, hist_data);
> > @@ -1724,7 +1722,8 @@ static void hist_trigger_stacktrace_print(struct seq_file *m,
> >  			seq_printf(m, "%s: [%llx] %-55s", field_name,
> >  				   uval, str);
> >  		} else if (key_field->flags & HIST_FIELD_FL_EXECNAME) {
> > -			char *comm = elt->private_data;
> > +			struct hist_elt_data *elt_data = elt->private_data;
> 
> I wonder if we should have a return WARN_ON_ONCE(!elt_data); here just
> in case.
> 

Yeah, that makes sense, as do the other suggestions above, will update.

Thanks,

Tom 



