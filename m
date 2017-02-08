From: Tom Zanussi <tom.zanussi@linux.intel.com>
Subject: Re: [RFC][PATCH 02/21] tracing: Reimplement log2
Date: Wed, 08 Feb 2017 14:25:08 -0600
Message-ID: <1486585508.2871.11.camel@tzanussi-mobl.amr.corp.intel.com>
References: <cover.1486569306.git.tom.zanussi@linux.intel.com>
         <b247aa8251fe3d92695d63ec974d82f80ee4e711.1486569306.git.tom.zanussi@linux.intel.com>
         <20170208151358.560a2c64@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: tglx@linutronix.de, mhiramat@kernel.org, namhyung@kernel.org,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170208151358.560a2c64@gandalf.local.home>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Wed, 2017-02-08 at 15:13 -0500, Steven Rostedt wrote:
> On Wed,  8 Feb 2017 11:24:58 -0600
> Tom Zanussi <tom.zanussi@linux.intel.com> wrote:
> 
> >  static void destroy_hist_field(struct hist_field *hist_field)
> >  {
> > +	unsigned int i;
> > +
> > +	if (!hist_field)
> > +		return;
> > +
> > +	for (i = 0; i < HIST_FIELD_OPERANDS_MAX; i++)
> > +		destroy_hist_field(hist_field->operands[i]);
> 
> Recursive functions get me really nervous. What limits it? Is this user
> defined? Perhaps we need to find a better way to handle this that's not
> recursive, or at least put in a hard limit of the amount it can recurse.
> 

It's limited by the expression depth, which shouldn't be more than 1
deep, but you're right, there should be an explicit limit check, just in
case - will add one.

Tom

> -- Steve
> 
> > +
> >  	kfree(hist_field);
> >  }
> >  
> > @@ -377,7 +393,10 @@ static struct hist_field *create_hist_field(struct ftrace_event_field *field,
> >  	}
> >  
> >  	if (flags & HIST_FIELD_FL_LOG2) {
> > +		unsigned long fl = flags & ~HIST_FIELD_FL_LOG2;
> >  		hist_field->fn = hist_field_log2;
> > +		hist_field->operands[0] = create_hist_field(field, fl);
> > +		hist_field->size = hist_field->operands[0]->size;
> >  		goto out;
> >  	}
> >  
> 
