From: Bernhard Landauer <oberon@manjaro.org>
Subject: Re: [ANNOUNCE] v4.16.7-rt1
Date: Wed, 9 May 2018 23:45:31 +0200
Message-ID: <2d6d2b49-07ce-7125-6086-91a4b6826f4f@manjaro.org>
References: <20180503162934.b2ly6jz4a5tydaag@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180503162934.b2ly6jz4a5tydaag@linutronix.de>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On 03/05/18 18:29, Sebastian Andrzej Siewior wrote:
> Dear RT folks!
>
> I'm pleased to announce the v4.16.7-rt1 patch set. 
>
> Changes since v4.14.39-rt28:
>
>   - Rebase to v4.16
>
>   - The queue went through a big cleanup and reordering, so the patches
>     which belong together are not scattered all over the place.
>
>     The sections at the front of the series are patches which are either
>     upstream already (4.17), queued in a maintainer tree for 4.18, posted
>     and under discussion or just ready to be posted.
>
>   - A large section covers the recent rework of the *_nort/*_rt()
>     wrappers. Instead of trying to argue them upstream they have been made
>     obsolete by refactoring the code in which they have been used. There
>     are a few hard to solve leftovers, but non of them should survive.
>
>   - The cpu_chill() related try-lock-loop in dcache has been replaced
>     with a rework avoiding the loop. The rework was joint work by Al
>     Viro and John Ogness.
>
>     There are still a few cpu_chill() instances which are going to be
>     tackled in the next weeks.
>
>   - The AT91 timer patches have been mostly replaced with the "TCB timer
>     driver" patches by Alexandre Belloni.
>
>   - The latest version of the latency tracer patches which is aimed for 4.18
>     has been incorporated.
>
> You can get this release via the git tree at:
>
>     git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v4.16.7-rt1
>
> The RT patch against v4.16.7 can be found here:
>
>     https://cdn.kernel.org/pub/linux/kernel/projects/rt/4.16/older/patch-4.16.7-rt1.patch.xz
>
> The split quilt queue is available at:
>
>     https://cdn.kernel.org/pub/linux/kernel/projects/rt/4.16/older/patches-4.16.7-rt1.tar.xz
>
> Sebastian
> --
> To unsubscribe from this list: send the line "unsubscribe linux-rt-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

When compiling 4.16.7-rt1 with gcc 8.1.0 I see tons of these warnings:

warning: objtool: mISDN_FsmEvent()+0x27: sibling call from callable
instruction with modified stack frame

Any ideas what to make of these?

regards
Bernhard
