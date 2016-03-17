From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: RFC on fixing mutex spinning on owner
Date: Thu, 17 Mar 2016 12:16:11 +0100 (CET)
Message-ID: <alpine.DEB.2.11.1603171214530.3978@nanos>
References: <CAD=GYpbHjcsuQSnNPL4SCv-r=Me6oiH7dJ98a64udbakWLaUjQ@mail.gmail.com> <20160316233530.GA8731@kroah.com> <CAD=GYpZVGwfk8Y8WTQpdgdm5qgxjsi_gVrnOswuWitEbhaWPbw@mail.gmail.com> <20160316221751.71816309@grimm.local.home> <20160317073605.GM6344@twins.programming.kicks-ass.net>
 <20160317080526.GB6679@osadl.at> <20160317101823.GQ6344@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Nicholas Mc Guire <der.herr@hofr.at>,
	Steven Rostedt <rostedt@goodmis.org>,
	Joel Fernandes <agnel.joel@gmail.com>,
	Greg Kroah-Hartman <greg@kroah.com>,
	linux-rt-users@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	kernelnewbies <kernelnewbies@nl.linux.org>,
	Ingo Molnar <mingo@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:59631 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935760AbcCQLRp (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 17 Mar 2016 07:17:45 -0400
In-Reply-To: <20160317101823.GQ6344@twins.programming.kicks-ass.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Thu, 17 Mar 2016, Peter Zijlstra wrote:
> Also, maybe the tracer should measure the time from need_resched()
> getting true until the next preemption point, instead of the entire time
> preemption was disabled. Which would avoid the entire issue altogether.

Well, that only gives you the information on a actual preemption, but not
information about long preempt disabled regions which can cause a problem
eventually.

Thanks,

	tglx

