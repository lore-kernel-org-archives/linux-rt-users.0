From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: Re: [ANNOUNCE] 3.10.100-rt110
Date: Tue, 15 Mar 2016 18:34:31 -0400
Message-ID: <CAP=VYLpKB3s6AciJ9BtpOPp8x0zo8TAYfPcDjjzHT8sXcsBxtw@mail.gmail.com>
References: <20160314115113.2e3cee4d@gandalf.local.home>
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
In-Reply-To: <20160314115113.2e3cee4d@gandalf.local.home>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Mon, Mar 14, 2016 at 11:51 AM, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> Dear RT Folks,
>
> I'm pleased to announce the 3.10.100-rt110 stable release.
>
>
> This release is just an update to the new stable 3.10.100 version
> and no RT specific changes have been made.

So, this has the same issue that 3.14-rt has, and was introduced
before this stable-only merge here.  The 3.14-rt issue:

http://marc.info/?l=linux-rt-users&m=145807835003262&w=2

On 3.10-rt we see:

root@dell760-paul:~# dmesg|grep NOH
[    9.265871] NOHZ: local_softirq_pending 100
[    9.339352] NOHZ: local_softirq_pending 100
[    9.372003] NOHZ: local_softirq_pending 100
[    9.559732] NOHZ: local_softirq_pending 100
[    9.719857] NOHZ: local_softirq_pending 100
[   10.079615] NOHZ: local_softirq_pending 100
[   10.478729] NOHZ: local_softirq_pending 100
[   10.960753] NOHZ: local_softirq_pending 100
[   24.310811] NOHZ: local_softirq_pending 100
[   24.310919] NOHZ: local_softirq_pending 100
root@dell760-paul:~# cat /proc/version
Linux version 3.10.100-rt110-WR7.0.0.0_ovp (paul@yow-cube2) (gcc
version 5.2.1 20151010 (Ubuntu 5.2.1-22ubuntu2) ) #1 SMP PREEMPT RT
Tue Mar 15 17:57:
47 EDT 2016
root@dell760-paul:~#

...and the related commits are on v3.10-rt (fast fwd branch):

24a5c5d4e3a5 latencyhist: disable jump-labels
004f141ed3fc net: provide a way to delegate processing a softirq to ksoftirqd
569d1ba3b1d9 softirq: split timer softirqs out of ksoftirqd  <-- *fail*
141a4ed5a873 Linux 3.10.97-rt106
95c5358d0ee7 rtmutex: Have slowfn of rt_mutex_timed_fastlock() use enum

I'll give 4.1-rt a test tomorrow if I have a chance between meetings etc.

Paul.
--

>
>
> You can get this release via the git tree at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git
>
>   branch: v3.10-rt
>   Head SHA1: dfac2de1745d44804fdd4f14bc0217982b9c412b
>
>
> Or to build 3.10.100-rt110 directly, the following patches should be applied:
>
>   http://www.kernel.org/pub/linux/kernel/v3.x/linux-3.10.tar.xz
>
>   http://www.kernel.org/pub/linux/kernel/v3.x/patch-3.10.100.xz
>
>   http://www.kernel.org/pub/linux/kernel/projects/rt/3.10/patch-3.10.100-rt110.patch.xz
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
