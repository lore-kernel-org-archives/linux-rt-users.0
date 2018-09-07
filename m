From: Julia Cartwright <julia@ni.com>
Subject: Re: [ANNOUNCE] Submit a topic for the RT Microconference at Linux
 Plumbers
Date: Fri, 7 Sep 2018 15:44:00 -0500
Message-ID: <20180907204400.GN8562@jcartwri.amer.corp.natinst.com>
References: <20180904132529.6ae7166e@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        contact@linuxplumbersconf.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Clark Williams <williams@redhat.com>,
        Daniel Wagner <wagi@monom.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Mark Brown <mark.brown@linaro.org>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Juri Lelli <juri.lelli@gmail.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Darren Hart <darren@dvhart.com>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180904132529.6ae7166e@gandalf.local.home>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hello all-

On Tue, Sep 04, 2018 at 01:25:29PM -0400, Steven Rostedt wrote:
> Hi RT folks!
>
> The call for proposals (CfP) is now open for the RT Microconference at
> Linux Plumbers in Vancouver, Canada. The topics we are looking at this
> year are:
>
>  - How will PREEMPT_RT be maintained (is it a subsystem?)
>
>  - Who will maintain it?
>
>  - How do we teach the rest of the kernel developers how not to break PREEMPT_RT?
>
>  - How do we catch when it breaks?
>
>  - What tools can we add into tools/ that other kernel developers can use to test and learn about PREEMPT_RT?
>
>  - What tests can we add into tools/testing/selftests?
>
>  - What kernel boot selftests can be added?
>
>  - How can we modify lockdep to catch problems that can break PREEMPT_RT?
>
>  - Discuss various types of failures that can happen with PREEMPT_RT that normally would not happen in the vanilla kernel.
>
>  - How do we handle stable backports?
>
>  - Interaction with Safety Critical domains?
>
>  - Interrupt threads are RT and are not protected by the RT Throttling.
>    How can we prevent interrupt thread starvation from a rogue RT task?
>
>  - How to determine if a kernel is booted with PREEMPT_RT enabled?
>
>  - librtpi: "solving" long-standing glibc pthread condvar internal lock inversion with a new implementation; motivations, technical details, etc.
>
>  - SCHED_DEADLINE - Lots of research has been made to various issues like CPU affinity, Bandwidth inheritance, cgroup support; but nothing has been done to the kernel. Let's make a commitment and push these ideas forward into mainline.
>
>  - How can we modify lockdep to catch problems that can break PREEMPT_RT?
>
>  - Discuss various types of failures that can happen with PREEMPT_RT that normally would not happen in the vanilla kernel.

There was some confusion as to whether or not a topic being listed above
automatically meant that it was to be included in the RT Microconference
agenda.

The answer is: NO.  If you would like to see a specific topic discussed,
either from this list or otherwise, you must submit it via the portal
listed below.  Only topics submitted to the portal will be considered
for the RT Microconference agenda.

Note also that submitting a topic will also mean that you will be
responsible for introducing the necessary context to the group to
facilitate further discussion.

> If you want to lead one of the above sessions, or if you have a new
> session you want to submit, please do so here:
>
>   https://linuxplumbersconf.org/event/2/abstracts/
>
> Set up an account, and then click "Submit new proposal".
>
> Fill out the "Title", "Content", select the "Authors" as the one leading
> the session (yourself), and then for "Track" select "RT MC Topics CfP".
> Select "Yes" to agree with the anti-harassment policy, and then hit
> Submit.

Thanks, and see you there!

   Julia
