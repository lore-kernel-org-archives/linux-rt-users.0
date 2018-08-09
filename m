From: Tom Zanussi <zanussi@kernel.org>
Subject: Re: [PATCH v3 0/7] tracing: Hist trigger snapshot and onchange
 additions
Date: Thu, 09 Aug 2018 09:51:37 -0500
Message-ID: <1533826297.1918.2.camel@kernel.org>
References: <cover.1533753152.git.tom.zanussi@linux.intel.com>
         <20180809104711.7962b340@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: tglx@linutronix.de, mhiramat@kernel.org, namhyung@kernel.org,
        vedang.patel@intel.com, bigeasy@linutronix.de,
        joel@joelfernandes.org, mathieu.desnoyers@efficios.com,
        julia@ni.com, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180809104711.7962b340@gandalf.local.home>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hi Steve,

On Thu, 2018-08-09 at 10:47 -0400, Steven Rostedt wrote:
> On Thu,  9 Aug 2018 09:34:10 -0500
> Tom Zanussi <zanussi@kernel.org> wrote:
> 
> > From: Tom Zanussi <tom.zanussi@linux.intel.com>
> > 
> > Hi,
> > 
> > This is v3 of the hist trigger snapshot and onchange additions
> > patchset.  It's rebased on top of the latest ftrace/core and adds a
> > few fixes to some handler/action problems I noticed while testing.
> 
> Hi Tom,
> 
> How ready is this? I'm still dealing with the fallout of the preempt
> irqs tracepoint updates, and trying to get that stable before pushing
> to linux-next. Are you confident that these are solid enough to pull
> in
> this late before the merge window opens? Or should I ignore them
> until
> the merge window closes and push this for the following release?
> 

I wasn't really expecting they'd go into this merge window, so no
problem ignoring them until the next release..

Thanks,

Tom
