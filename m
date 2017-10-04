From: Tom Zanussi <tom.zanussi@linux.intel.com>
Subject: Re: [PATCH v3 16/33] tracing: Generalize per-element hist trigger
 data
Date: Wed, 04 Oct 2017 14:22:26 -0500
Message-ID: <1507144946.14461.19.camel@tzanussi-mobl.amr.corp.intel.com>
References: <cover.1506105131.git.tom.zanussi@linux.intel.com>
         <18c12e2cd12243914d9cc98909c6720da084f3bd.1506105131.git.tom.zanussi@linux.intel.com>
         <20171004133414.4840c351@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: tglx@linutronix.de, mhiramat@kernel.org, namhyung@kernel.org,
        vedang.patel@intel.com, bigeasy@linutronix.de,
        joel.opensrc@gmail.com, joelaf@google.com,
        mathieu.desnoyers@efficios.com, baohong.liu@intel.com,
        rajvi.jingar@intel.com, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171004133414.4840c351@gandalf.local.home>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Wed, 2017-10-04 at 13:34 -0400, Steven Rostedt wrote:
> On Fri, 22 Sep 2017 14:59:56 -0500
> Tom Zanussi <tom.zanussi@linux.intel.com> wrote:
> 
> > @@ -1742,7 +1746,8 @@ static void hist_trigger_stacktrace_print(struct seq_file *m,
> >  			seq_printf(m, "%s: [%llx] %-55s", field_name,
> >  				   uval, str);
> >  		} else if (key_field->flags & HIST_FIELD_FL_EXECNAME) {
> > -			char *comm = elt->private_data;
> > +			struct hist_elt_data *elt_data = elt->private_data;
> 
> Weren't we going to add a "if (WARN_ON_ONCE(!elt_data)) return;" here?
> 

This I did miss, will update ;-)

Tom

> -- Steve
> 
> > +			char *comm = elt_data->comm;
> >  
> >  			uval = *(u64 *)(key + key_field->offset);
> >  			seq_printf(m, "%s: %-16s[%10llu]", field_name,
> > -- 
