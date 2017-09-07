From: Tom Zanussi <tom.zanussi@linux.intel.com>
Subject: Re: [PATCH v2 20/40] tracing: Add simple expression support to hist
 triggers
Date: Thu, 07 Sep 2017 12:01:17 -0500
Message-ID: <1504803677.13310.9.camel@tzanussi-mobl.amr.corp.intel.com>
References: <cover.1504642143.git.tom.zanussi@linux.intel.com>
         <b0c1989f7aaf866dd48e9347bb0f3db92150a3ed.1504642143.git.tom.zanussi@linux.intel.com>
         <20170907124605.01f0025a@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: tglx@linutronix.de, mhiramat@kernel.org, namhyung@kernel.org,
        vedang.patel@intel.com, bigeasy@linutronix.de,
        joel.opensrc@gmail.com, joelaf@google.com,
        mathieu.desnoyers@efficios.com, baohong.liu@intel.com,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170907124605.01f0025a@gandalf.local.home>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Thu, 2017-09-07 at 12:46 -0400, Steven Rostedt wrote:
> On Tue,  5 Sep 2017 16:57:32 -0500
> Tom Zanussi <tom.zanussi@linux.intel.com> wrote:
> 
> >  #define DEFINE_HIST_FIELD_FN(type)					\
> >  	static u64 hist_field_##type(struct hist_field *hist_field,	\
> >  				     void *event,			\
> > @@ -148,6 +192,7 @@ enum hist_field_flags {
> >  	HIST_FIELD_FL_TIMESTAMP_USECS	= 2048,
> >  	HIST_FIELD_FL_VAR		= 4096,
> >  	HIST_FIELD_FL_VAR_ONLY		= 8192,
> > +	HIST_FIELD_FL_EXPR		= 16384,
> 
> When numbers get this big, I'm a fan of:
> 
> 	HIST_FIELD_FL_TIMESTAMP_USECS	= (1 << 11),
> 	HIST_FIELD_FL_VAR		= (1 << 12),
> 	HIST_FIELD_FL_VAR_ONLY		= (1 << 13),
> 	HIST_FIELD_FL_EXPR		= (1 << 14),
> 
> It makes it much easier to debug with printk()s and also know how many
> bits you are actually using.
> 
> >  };
> >  
> >  struct var_defs {
> > @@ -218,6 +263,8 @@ static const char *hist_field_name(struct hist_field *field,
> >  		field_name = hist_field_name(field->operands[0], ++level);
> >  	else if (field->flags & HIST_FIELD_FL_TIMESTAMP)
> >  		field_name = "$common_timestamp";
> > +	else if (field->flags & HIST_FIELD_FL_EXPR)
> > +		field_name = field->name;
> >  
> >  	if (field_name == NULL)
> >  		field_name = "";
> > @@ -441,6 +488,115 @@ static void hist_trigger_elt_comm_init(struct tracing_map_elt *elt)
> >  	.elt_init	= hist_trigger_elt_comm_init,
> >  };
> >  
> > +static const char *get_hist_field_flags(struct hist_field *hist_field)
> > +{
> > +	const char *flags_str = NULL;
> > +
> > +	if (hist_field->flags & HIST_FIELD_FL_HEX)
> > +		flags_str = "hex";
> > +	else if (hist_field->flags & HIST_FIELD_FL_SYM)
> > +		flags_str = "sym";
> > +	else if (hist_field->flags & HIST_FIELD_FL_SYM_OFFSET)
> > +		flags_str = "sym-offset";
> > +	else if (hist_field->flags & HIST_FIELD_FL_EXECNAME)
> > +		flags_str = "execname";
> > +	else if (hist_field->flags & HIST_FIELD_FL_SYSCALL)
> > +		flags_str = "syscall";
> > +	else if (hist_field->flags & HIST_FIELD_FL_LOG2)
> > +		flags_str = "log2";
> > +	else if (hist_field->flags & HIST_FIELD_FL_TIMESTAMP_USECS)
> > +		flags_str = "usecs";
> > +
> > +	return flags_str;
> > +}
> 
> Also, can you make the moving of the code a separate patch before this
> patch. It makes git blame and such nicer.
> 

Sure, will do as well as the above..

Tom
