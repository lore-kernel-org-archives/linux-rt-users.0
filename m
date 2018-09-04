From: Steven Rostedt <rostedt@goodmis.org>
Subject: [ANNOUNCE] Submit a topic for the RT Microconference at Linux
 Plumbers
Date: Tue, 4 Sep 2018 13:25:29 -0400
Message-ID: <20180904132529.6ae7166e@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Julia Cartwright <julia@ni.com>,
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
To: linux-rt-users <linux-rt-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        contact@linuxplumbersconf.org
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hi RT folks!

The call for proposals (CfP) is now open for the RT Microconference at
Linux Plumbers in Vancouver, Canada. The topics we are looking at this
year are:

 - How will PREEMPT_RT be maintained (is it a subsystem?)

 - Who will maintain it?

 - How do we teach the rest of the kernel developers how not to break PREEMPT_RT?

 - How do we catch when it breaks?

 - What tools can we add into tools/ that other kernel developers can use to test and learn about PREEMPT_RT?

 - What tests can we add into tools/testing/selftests?

 - What kernel boot selftests can be added?

 - How can we modify lockdep to catch problems that can break PREEMPT_RT?

 - Discuss various types of failures that can happen with PREEMPT_RT that normally would not happen in the vanilla kernel.

 - How do we handle stable backports?

 - Interaction with Safety Critical domains?

 - Interrupt threads are RT and are not protected by the RT Throttling.
   How can we prevent interrupt thread starvation from a rogue RT task?

 - How to determine if a kernel is booted with PREEMPT_RT enabled?

 - librtpi: "solving" long-standing glibc pthread condvar internal lock inversion with a new implementation; motivations, technical details, etc.

 - SCHED_DEADLINE - Lots of research has been made to various issues like CPU affinity, Bandwidth inheritance, cgroup support; but nothing has been done to the kernel. Let's make a commitment and push these ideas forward into mainline.

 - How can we modify lockdep to catch problems that can break PREEMPT_RT?

 - Discuss various types of failures that can happen with PREEMPT_RT that normally would not happen in the vanilla kernel.

If you want to lead one of the above sessions, or if you have a new
session you want to submit, please do so here:

  https://linuxplumbersconf.org/event/2/abstracts/

Set up an account, and then click "Submit new proposal".

Fill out the "Title", "Content", select the "Authors" as the one leading
the session (yourself), and then for "Track" select "RT MC Topics CfP".
Select "Yes" to agree with the anti-harassment policy, and then hit
Submit.

The RT Microconference is only 4 hours (including breaks), thus we may
not be able to fit all the topics in. But if a session is not
submitted, then it will not have any chance of being on the agenda.

Looking forward to seeing you in Vancouver, Canada in November!

-- Steve
