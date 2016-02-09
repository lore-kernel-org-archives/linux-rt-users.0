From: =?UTF-8?B?Sm/Dq2wgS3LDpGhlbWFubg==?= <jkraehemann@gmail.com>
Subject: Re: deterministic usage of JIFFIES and how to relocate the clock
Date: Tue, 9 Feb 2016 21:04:43 +0100
Message-ID: <CA+Owze7TnDU_XDec854-6wbsU8GZCzq0E+FpJombdT3KWrWKRQ@mail.gmail.com>
References: <CA+Owze7GnFYrpVMWSuPd=qXj8auf3fL-mPsZNPVMeP=FQtZsPg@mail.gmail.com>
	<CA+Owze7+=vMDaqX25OVQ6ZrRgGj9j2BZjEZt_GyG+9+6+6ELWA@mail.gmail.com>
	<20160204164411.GC3381@linutronix.de>
Reply-To: jkraehemann-guest@users.alioth.debian.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-yk0-f179.google.com ([209.85.160.179]:36584 "EHLO
	mail-yk0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932360AbcBIUEn convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 9 Feb 2016 15:04:43 -0500
Received: by mail-yk0-f179.google.com with SMTP id z7so104589165yka.3
        for <linux-rt-users@vger.kernel.org>; Tue, 09 Feb 2016 12:04:43 -0800 (PST)
In-Reply-To: <20160204164411.GC3381@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi

At my opinion I could do some optimization by controlling what gets
into the stack and at what time in program lifetime.

I'm doing a realtime sequencer in C.

http://gsequencer.org

Basically it does a lot of additions to calculate the audio data to
output to soundcard. I have a thread object that does 1000 cycles per
second.
That's why I'm talking about JIFFIES not related to the kernel ones.

Deterministic in this view of doing the job in time say within the
range of a mili-second. At bigger loads it takes may be 5 to 8 mili
seconds to do additive mixing.
What I want to do is to bypass the bottle-neck. Further I believe
there's much time wasted by loading or unloading a thread into CPU.

There might be at least 1 audio thread and 2 channel threads with a
simple setup but generally depends on how many sound sequencers you
have. For a basic band
with 5 instruments there are 15 threads, one gui thread, a main loop
and a thread pool serving non blocking functions. So you get quickly
more than 20 threads.

The problem is doing additive sound mixing and at my opinion how the
program gets loaded/unloaded into the stack. It eats much computing
time. So is there an
API to solve this issue to control the stack?

So far I have found pthread_yield() but I'm not happy with it.

Bests,
Jo=C3=ABl

On Thu, Feb 4, 2016 at 5:44 PM, Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
> * Jo=C3=ABl Kr=C3=A4hemann | 2016-01-24 09:40:33 [+0100]:
>
>>Hi
> Hi,
>
>>At my opinion I was thinking at a lower level than needed. The
> I couldn't parse the question in the previous mail.
>
>>application runs at least aside the kernel.
>
> aside the kernel? Like one CPU is for the kernel and the other for th=
e
> application?
>
>>Probably I want to control PC (program counter) and redeclare the
>>longjump function as macro. To gain control
>>over throughput rate and thus being able to grain loading and unloadi=
ng thread.
>
> maybe. But I still fail to understand what you attempt to do.
>
>>int sched_setaffinity(pid_t pid, size_t cpusetsize,
>>                             const cpu_set_t *mask);
>
> This one says which CPUs the task may run on.
>
>>void longjmp(jmp_buf env, int val);
>
> and this is unrelated to the previous one.
>
>>
>>cheers,
>>Jo=C3=ABl
>
> Sebastian
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
