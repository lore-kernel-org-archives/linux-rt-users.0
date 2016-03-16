From: Josh Cartwright <joshc@ni.com>
Subject: Re: [ANNOUNCE] 3.14.64-rt67
Date: Wed, 16 Mar 2016 11:21:29 -0500
Message-ID: <20160316162129.GH28102@jcartwri.amer.corp.natinst.com>
References: <20160314114957.45d956d7@gandalf.local.home>
 <CAP=VYLrokYVacxid7Cdytk+CmB4bu=vKuufeMLYtQr6PrvYe3g@mail.gmail.com>
 <CAP=VYLrX5RPQ1_VTYZWC1JDq82=w8HDOjer3Jc4_kXmsLB-W8g@mail.gmail.com>
 <CAP=VYLq=vdBn2sDX57kUGqUAuLNSxh=fM3zEjQa_GgegAtGoOg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Steven Rostedt <rostedt@goodmis.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	John Kacur <jkacur@redhat.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAP=VYLq=vdBn2sDX57kUGqUAuLNSxh=fM3zEjQa_GgegAtGoOg@mail.gmail.com>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Tue, Mar 15, 2016 at 10:50:31PM -0400, Paul Gortmaker wrote:
> On Tue, Mar 15, 2016 at 7:25 PM, Paul Gortmaker
> <paul.gortmaker@windriver.com> wrote:
> > On Tue, Mar 15, 2016 at 5:45 PM, Paul Gortmaker
> > <paul.gortmaker@windriver.com> wrote:
> >> On Mon, Mar 14, 2016 at 11:49 AM, Steven Rostedt <rostedt@goodmis.org> wrote:
> >>>
> >>> Dear RT Folks,
> >>>
> >>> 3.14 release on PI(E) Day!
> >>>
> >>> I'm pleased to announce the 3.14.64-rt67 stable release.
> >>
> >> Testing this with what is largely a x86-64 defconfig but with RT_FULL,
> >> I now see:
> >>
> >> root@dell760-paul:~# dmesg|grep NOH
> >> [    8.605854] NOHZ: local_softirq_pending 100
> >> [    8.732677] NOHZ: local_softirq_pending 100
> >> [    8.852729] NOHZ: local_softirq_pending 100
> >> [    8.963964] NOHZ: local_softirq_pending 100
> >> [    9.061892] NOHZ: local_softirq_pending 100
> >> [    9.184921] NOHZ: local_softirq_pending 100
> >> [    9.370958] NOHZ: local_softirq_pending 100
> >> [    9.657811] NOHZ: local_softirq_pending 100
> >> [    9.942631] NOHZ: local_softirq_pending 100
> >> [   10.783710] NOHZ: local_softirq_pending 100
> >> root@dell760-paul:~#
> >>
> >> ...early in boot (we cap them after ~10 msgs).
> >>
> >> I think 100 is RCU if I did my bit counting properly; remind
> >> me to submit a patch that uses the human readable names.

As mentioned on IRC, 100 is HRTIMER_SOFTIRQ, which I think makes more
sense...at least it meshes better with the commit you identified as
being problematic.

> >>
> >> I had a good hunch which commit was responsible but I did
> >> a check of it and the one directly underneath it to be sure,
> >> and the latter boots w/o any pending messages.
> >>
> >> git log --oneline  v3.14-rt ^v3.14.64
> >> [...]
> >> 0a80a6849f19 latencyhist: disable jump-labels
> >> a884ef48e1ca net: provide a way to delegate processing a softirq to ksoftirqd
> >> 780d7ca2fdb0 softirq: split timer softirqs out of ksoftirqd    <------
> >> *** fail ***

Looking at the places where HRTIMER_SOFTIRQ is raised, it did look like
there is at least one case where a hrtimer started from process context
would cause HRTIMER_SOFTIRQ to be set pending, but the associated
ktimersoftirq/N not woken, which seems problematic.

  Josh

diff --git a/kernel/softirq.c b/kernel/softirq.c
index 7abfdab..d91f378 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -749,7 +749,7 @@ void raise_softirq_irqoff(unsigned int nr)
 	 *
 	 */
 	if (!current->softirq_nestcnt)
-		wakeup_softirqd();
+		wakeup_proper_softirq(nr);
 }
 
 static inline int ksoftirqd_softirq_pending(void)
