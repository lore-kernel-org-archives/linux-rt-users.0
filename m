From: Tom Zanussi <tom.zanussi@linux.intel.com>
Subject: Re: [PATCH v2 19/40] tracing: Account for variables in named
 trigger compatibility
Date: Thu, 07 Sep 2017 12:00:27 -0500
Message-ID: <1504803627.13310.8.camel@tzanussi-mobl.amr.corp.intel.com>
References: <cover.1504642143.git.tom.zanussi@linux.intel.com>
         <ee6b4ead2b42a2757254d447696f3c367e9cc49c.1504642143.git.tom.zanussi@linux.intel.com>
         <20170907124011.222b58a7@gandalf.local.home>
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
In-Reply-To: <20170907124011.222b58a7@gandalf.local.home>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Thu, 2017-09-07 at 12:40 -0400, Steven Rostedt wrote:
> On Tue,  5 Sep 2017 16:57:31 -0500
> Tom Zanussi <tom.zanussi@linux.intel.com> wrote:
> 
> > @@ -1786,6 +1786,12 @@ static bool hist_trigger_match(struct event_trigger_data *data,
> >  			return false;
> >  		if (key_field->is_signed != key_field_test->is_signed)
> >  			return false;
> > +		if ((key_field->var.name && !key_field_test->var.name) ||
> > +		    (!key_field->var.name && key_field_test->var.name))
> > +			return false;
> 
> Short cut:
> 
> 		if (!!key_field->var.name != !!key_field_test->var.name)
> 			return false;
> 

Nice!

> > +		if ((key_field->var.name && key_field_test->var.name) &&
> 
> Only need to test if key_field->var.name, as the previous if statement
> would exit out if key_field_test->var.name is false.
> 

OK, will change, thanks.

Tom
