From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RFC PATCH RT] rwsem: The return of multi-reader PI rwsems
Date: Mon, 14 Apr 2014 09:34:19 -0400
Message-ID: <20140414093419.14d750fa@gandalf.local.home>
References: <20140409151922.5fa5d999@gandalf.local.home>
	<20140414095554.GB731@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Mike Galbraith <umgwanakikbuti@gmail.com>,
	"Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
	Paul Gortmaker <paul.gortmaker@windriver.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <williams@redhat.com>,
	Frederic Weisbecker <fweisbec@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>
To: Ingo Molnar <mingo@kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from cdptpa-outbound-snat.email.rr.com ([107.14.166.232]:18827 "EHLO
	cdptpa-oedge-vip.email.rr.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754209AbaDNNeW (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 14 Apr 2014 09:34:22 -0400
In-Reply-To: <20140414095554.GB731@gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Mon, 14 Apr 2014 11:55:54 +0200
Ingo Molnar <mingo@kernel.org> wrote:

> > Index: linux-rt.git/kernel/rtmutex.c  
> 
> Side note: could you please in general include diffstats with such 
> patches, especially since you seem to be exporting it from a Git repo?

Sure, I'll try to remember to add them. I do my work in a git repo and
then do:

git diff > mypatch.patch
quilt import mypatch.patch
patch -p1 -R < mypatch.patch
rm mypatch.patch

and then I pull patches/mypatch.patch into my email to do the RFC.

> 
> Newfangled patch summaries like:
> 
>  include/linux/rtmutex.h  |   29 ++
>  include/linux/rwsem_rt.h |    8 
>  include/linux/sched.h    |   20 +
>  kernel/fork.c            |   20 +
>  kernel/futex.c           |    2 
>  kernel/rt.c              |   27 +
>  kernel/rtmutex.c         |  645 +++++++++++++++++++++++++++++++++++++++++++++--
>  kernel/rtmutex_common.h  |   19 +
>  kernel/sysctl.c          |   13 
>  9 files changed, 753 insertions(+), 30 deletions(-)
> 
> Really give a useful bird's eye view of forest Fangorn, before 
> straying into it!

diffstat patches/mypatch.patch should also give the same. Hmm, I wonder
if quilt has any commands to do this for me?

Thanks,

-- Steve
