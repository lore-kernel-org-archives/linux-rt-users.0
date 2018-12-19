From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 3/7] tracing: Use var_refs[] for hist trigger reference
 checking
Date: Wed, 19 Dec 2018 10:36:47 -0500
Message-ID: <20181219103647.18c61a6a@gandalf.local.home>
References: <cover.1545161087.git.tom.zanussi@linux.intel.com>
        <becb9627fb09681960f26809961b832be9591048.1545161087.git.tom.zanussi@linux.intel.com>
        <20181219212224.968ee0ad61aada5a8a3f634f@kernel.org>
        <1545231703.4491.2.camel@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Masami Hiramatsu <mhiramat@kernel.org>, tglx@linutronix.de,
        namhyung@kernel.org, vedang.patel@intel.com, bigeasy@linutronix.de,
        joel@joelfernandes.org, mathieu.desnoyers@efficios.com,
        julia@ni.com, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org
To: Tom Zanussi <zanussi@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1545231703.4491.2.camel@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Wed, 19 Dec 2018 09:01:43 -0600
Tom Zanussi <zanussi@kernel.org> wrote:

> > > +	if (hist_field && hist_field->var.idx == var_idx &&
> > > +	    hist_field->var.hist_data == var_data)
> > > +		found = hist_field;
> > >  
> > >  	return found;  
> > 
> > It seems we don't need "found" var here. Just return hist_field or
> > NULL.
> >   
> 
> OK, will change these and resubmit shortly.

Tom,

If this is the only patch in the series that needs updating, can you
just reply to this patch with the v2 of 3/7? That is have a subject of:

[PATCH v2 3/7] tracing: Use var_refs[] for hist trigger reference checking

and reply to the [PATCH 3/7]


This isn't the normal way of updates, but I want to start taking this
patches in ASAP, and I figured this may be the easiest for both of us.

It's fine to send a v2 of the entire patch series (which other
maintainers require), so I'll leave it up to you.

If there's any other patch that needs changing, then a full v2 series
is required. But if this is the only change and you want to send just
this patch, then I'll take that as well.

-- Steve
