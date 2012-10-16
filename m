From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: Re: [ANNOUNCE] 3.6.1-rt2
Date: Tue, 16 Oct 2012 16:09:16 -0400
Message-ID: <CAP=VYLoHhtth2+BwQAsd7uyW8N+rJj6zznP9sNjczTj_0Uqk9w@mail.gmail.com>
References: <alpine.LFD.2.02.1210162037380.2811@ionos>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.LFD.2.02.1210162037380.2811@ionos>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Tue, Oct 16, 2012 at 2:41 PM, Thomas Gleixner <tglx@linutronix.de> wrote:
> Dear RT Folks,
>
> I'm pleased to announce the 3.6.1-rt2 release.
>
> Changes since 3.6.1-rt1:
>
>         * Picked up Pauls git friendly quilt queue

Which is a "linux-stable" like queue of patches stored in git.
So you can see what patches change, how the series file
changes and so on.  Like this for the latest rt2:

       new file:   crypto-make-core-static-and-init-scru-early.patch
       modified:   fix-rt-int3-x86_32-3.2-rt.patch
       modified:   futex-requeue-pi-fix.patch
       renamed:
hrtimer-add-missing-debug_activate-aid-was-re-announce-3-0-6-rt17.patch
-> hrtimer-add-missing-debug_activate-aid.patch
       modified:   latency-hist.patch
       modified:   oleg-signal-rt-fix.patch
       modified:   panic-disable-random-on-rt.patch
       modified:   ping-sysrq.patch
       new file:   rcu-tiny-solve-rt-mistery.patch
       modified:   series
       renamed:    softirq-preempt-fix-3-re.txt ->
softirq-preempt-fix-3-re.patch
       new file:   timer.c-fix-build-fail-for-RT_FULL.patch

http://git.kernel.org/?p=linux/kernel/git/paulg/3.6-rt-patches.git;a=summary

Paul.
--

>
>         * Compile fix for !RT_FULL (Paul Gortemaker)
>
>         * Crypto init order fix
>
>         * Tiny RCU fix which affects UP and is a long standing bug
>           affecting 3.2 and 3.4-rt as well.
>
> The delta patch against 3.6.1-rt1 is appended below and can be found here
>
>   http://www.kernel.org/pub/linux/kernel/projects/rt/3.6/incr/patch-3.6.1-rt1-rt2.patch.xz
>
> The RT patch against 3.6.1 can be found here:
>
>   http://www.kernel.org/pub/linux/kernel/projects/rt/3.6/patch-3.6.1-rt2.patch.xz
>
> The split quilt queue is available at:
>
>   http://www.kernel.org/pub/linux/kernel/projects/rt/3.6/patches-3.6.1-rt2.tar.xz
>
> Enjoy,
>
>         tglx
> --
> To unsubscribe from this list: send the line "unsubscribe linux-rt-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
