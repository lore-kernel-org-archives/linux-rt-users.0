From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: Re: [ANNOUNCE] 3.14.64-rt67
Date: Tue, 15 Mar 2016 17:45:05 -0400
Message-ID: <CAP=VYLrokYVacxid7Cdytk+CmB4bu=vKuufeMLYtQr6PrvYe3g@mail.gmail.com>
References: <20160314114957.45d956d7@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	John Kacur <jkacur@redhat.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160314114957.45d956d7@gandalf.local.home>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Mon, Mar 14, 2016 at 11:49 AM, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> Dear RT Folks,
>
> 3.14 release on PI(E) Day!
>
> I'm pleased to announce the 3.14.64-rt67 stable release.

Testing this with what is largely a x86-64 defconfig but with RT_FULL,
I now see:

root@dell760-paul:~# dmesg|grep NOH
[    8.605854] NOHZ: local_softirq_pending 100
[    8.732677] NOHZ: local_softirq_pending 100
[    8.852729] NOHZ: local_softirq_pending 100
[    8.963964] NOHZ: local_softirq_pending 100
[    9.061892] NOHZ: local_softirq_pending 100
[    9.184921] NOHZ: local_softirq_pending 100
[    9.370958] NOHZ: local_softirq_pending 100
[    9.657811] NOHZ: local_softirq_pending 100
[    9.942631] NOHZ: local_softirq_pending 100
[   10.783710] NOHZ: local_softirq_pending 100
root@dell760-paul:~#

...early in boot (we cap them after ~10 msgs).

I think 100 is RCU if I did my bit counting properly; remind
me to submit a patch that uses the human readable names.

I had a good hunch which commit was responsible but I did
a check of it and the one directly underneath it to be sure,
and the latter boots w/o any pending messages.

git log --oneline  v3.14-rt ^v3.14.64
[...]
0a80a6849f19 latencyhist: disable jump-labels
a884ef48e1ca net: provide a way to delegate processing a softirq to ksoftirqd
780d7ca2fdb0 softirq: split timer softirqs out of ksoftirqd    <------
*** fail ***
13ad3a61e2c2 preempt-lazy: Add the lazy-preemption check to preempt_schedule()
d0bb90f40dbf net: move xmit_recursion to per-task variable on -RT
88f1b110f64d ptrace: don't open IRQs in ptrace_freeze_traced() too early
816f701e4c91 Linux 3.14.61-rt63

Have not investigated further yet; going to go test 3.10-rt since in
theory it should have the same issue; it has the same commit.
If it does, I'll follow up the announce for it with similar details.

Paul.
--

>
>
> This release is just an update to the new stable 3.14.64 version
> and no RT specific changes have been made.
>
>
> You can get this release via the git tree at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git
>
>   branch: v3.14-rt
>   Head SHA1: f1d2391d1c641f19c1e548c6daec89d53093291f
>
>
> Or to build 3.14.64-rt67 directly, the following patches should be applied:
>
>   http://www.kernel.org/pub/linux/kernel/v3.x/linux-3.14.tar.xz
>
>   http://www.kernel.org/pub/linux/kernel/v3.x/patch-3.14.64.xz
>
>   http://www.kernel.org/pub/linux/kernel/projects/rt/3.14/patch-3.14.64-rt67.patch.xz
>
>
>
>
> Enjoy,
>
> -- Steve
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-rt-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
