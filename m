From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v3 0/7] tracing: Hist trigger snapshot and onchange
 additions
Date: Thu, 9 Aug 2018 10:47:11 -0400
Message-ID: <20180809104711.7962b340@gandalf.local.home>
References: <cover.1533753152.git.tom.zanussi@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: tglx@linutronix.de, mhiramat@kernel.org, namhyung@kernel.org,
        vedang.patel@intel.com, bigeasy@linutronix.de,
        joel@joelfernandes.org, mathieu.desnoyers@efficios.com,
        julia@ni.com, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org
To: Tom Zanussi <zanussi@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1533753152.git.tom.zanussi@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Thu,  9 Aug 2018 09:34:10 -0500
Tom Zanussi <zanussi@kernel.org> wrote:

> From: Tom Zanussi <tom.zanussi@linux.intel.com>
> 
> Hi,
> 
> This is v3 of the hist trigger snapshot and onchange additions
> patchset.  It's rebased on top of the latest ftrace/core and adds a
> few fixes to some handler/action problems I noticed while testing.

Hi Tom,

How ready is this? I'm still dealing with the fallout of the preempt
irqs tracepoint updates, and trying to get that stable before pushing
to linux-next. Are you confident that these are solid enough to pull in
this late before the merge window opens? Or should I ignore them until
the merge window closes and push this for the following release?

Thanks!

-- Steve
