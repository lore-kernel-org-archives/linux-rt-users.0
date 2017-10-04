From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v3 25/33] tracing: Allow whitespace to surround hist
 trigger filter
Date: Wed, 4 Oct 2017 15:28:22 -0400
Message-ID: <20171004152822.060e3833@gandalf.local.home>
References: <cover.1506105131.git.tom.zanussi@linux.intel.com>
        <68a176facc91c86e90862f3e719c6bf57f505340.1506105131.git.tom.zanussi@linux.intel.com>
        <20171004141105.4f88f44f@gandalf.local.home>
        <1507143917.14461.8.camel@tzanussi-mobl.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: tglx@linutronix.de, mhiramat@kernel.org, namhyung@kernel.org,
        vedang.patel@intel.com, bigeasy@linutronix.de,
        joel.opensrc@gmail.com, joelaf@google.com,
        mathieu.desnoyers@efficios.com, baohong.liu@intel.com,
        rajvi.jingar@intel.com, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org
To: Tom Zanussi <tom.zanussi@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1507143917.14461.8.camel@tzanussi-mobl.amr.corp.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Wed, 04 Oct 2017 14:05:17 -0500
Tom Zanussi <tom.zanussi@linux.intel.com> wrote:

> Hi Steve,
> 
> On Wed, 2017-10-04 at 14:11 -0400, Steven Rostedt wrote:
> > On Fri, 22 Sep 2017 15:00:05 -0500
> > Tom Zanussi <tom.zanussi@linux.intel.com> wrote:
> >   
> > > The existing code only allows for one space before and after the 'if'
> > > specifying the filter for a hist trigger.  Add code to make that more
> > > permissive as far as whitespace goes.  Specifically, we want to allow
> > > spaces in the trigger itself now that we have additional syntax
> > > (onmatch/onmax) where spaces are more natural e.g. spaces after commas
> > > in param lists.
> > > 
> > 

> > 
> > I think you forgot to update this:
> >   
> 
> I was going to but on closer inspection realized the simpler form
> wouldn't accomplish the same thing - the problem this is trying to solve
> is to allow bits of whitespace within the trigger (because we now have
> function-like syntax, which should allow whitespace after commas for
> instance) and separating the trigger from the filter ('if').  So we
> explicitly search for 'if' with preceding whitespace, which strsep won't
> accomplish.
> 
> So while it may not be pretty, it accomplishes that, while the below
> won't (it would create a truncated trigger if there were e.g. commas
> followed by spaces).

OK, and I just noticed that you updated the changelog too, which sorta
describes what you are trying to say here.

-- Steve
