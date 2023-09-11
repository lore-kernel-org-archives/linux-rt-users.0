Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDEF4CA0ED4
	for <linux-rt-users@archiver.kernel.org>; Mon, 11 Sep 2023 22:35:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236271AbjIKW0N (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 11 Sep 2023 18:26:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238130AbjIKNlD (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 11 Sep 2023 09:41:03 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD1C0CD7
        for <linux-rt-users@vger.kernel.org>; Mon, 11 Sep 2023 06:40:57 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1694439655;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DsmufasYWd+v9Iv66FPL4IENQ4iSZ+3xqa3r8SiH6XI=;
        b=y4k5lEHR6mNfV4O/JzCY7oCx8Vu06GvmarFufDpc1yk818LoyQxoIgeqqIYEk7uuzD2RfL
        n0AAZRw+ad6mvS9JKTZZ33QBSxlNp4IGS1Y9mv9bH3/0VO1C6Fslb50GgSrV0sGHgUu3pV
        0C2BbaNVtaQyXmwBrdA2Yl+FPe3KbQ6JaLiUY87Y+XD9YY/OI5F2Mep2D77zIsLtZL0CaO
        2t0aXWNqWBLLJY5eLjrVWz3YTE98XC0HKDJJsNH8UtcJH+bEfw+V1Xiyq7DpwlSEDVRGPJ
        dWqowK9x3iux1qmvCxsSkmwoMUlM6A7Yx1w0W8lkwjrq7DmaoQurB7LdH4q0aw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1694439655;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DsmufasYWd+v9Iv66FPL4IENQ4iSZ+3xqa3r8SiH6XI=;
        b=2gM9L1YhQwk35SK5VFzghh+gp0Xp9cQ5QViUL1irpcXG8A6aGZNFTvwK2RY0E21XgKetEG
        n0rLFLMiI24LDOCg==
To:     Jan Kiszka <jan.kiszka@siemens.com>
Cc:     RT <linux-rt-users@vger.kernel.org>
Subject: Re: rtapp tracer
In-Reply-To: <e6ab093f-da42-487c-a546-08b3efdf0ca0@siemens.com>
References: <e6ab093f-da42-487c-a546-08b3efdf0ca0@siemens.com>
Date:   Mon, 11 Sep 2023 15:46:53 +0206
Message-ID: <87tts04yl6.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

--=-=-=
Content-Type: text/plain

Hi Jan,

On 2023-09-10, Jan Kiszka <jan.kiszka@siemens.com> wrote:
> is your rtapp tracer [1] somewhere publicly available already?

No. In fact, it does not yet exist at all. At EOSS2023 I presented a
proposal, mostly to get an initial reaction, feedback, and see if there
was interest from the RT community.

> And what's the status of this effort?

Right now I am dedicating my time towards finishing the printk work so
that we can get PREEMPT_RT mainline. I plan on working on an rtapp
tracer after that. If anyone else wants to start this work sooner, I am
happy to contribute where I can.

BTW, it is not yet clear if it should be a tracer or an RV monitor. In
the presentation [2] (starting at 50:15) you can hear Daniel's argument
for implementing this as an RV monitor instead.

In case you were interested in the bpftrace script I used as a
proof-of-concept, I have attached it to this email. For it to work I
used a Debian/bookworm system (12.0). The kernel package was
linux-image-6.1.0-9-rt-amd64 (6.1.27-1) and the bpftrace package was
version 0.17.0-1. However, in order for bpftrace to support kprobe
offsets, I needed to rebuild the bpftrace package with the extra
Build-Depends "libbfd-dev". As mentioned in the presentation, with any
other kernel binary, the proof-of-concept demo probably won't work.

Also be aware this was just a proof-of-concept. A real rtapp tracer will
need to catch many more cases (as I mentioned in the presentation).

John Ogness

[1] https://static.sched.com/hosted_files/eoss2023/27/Proposing%20a%20new%20tracer%20to%20monitor%20RT%20task%20behavior%20-%20John%20Ogness.pdf

[2] https://www.youtube.com/watch?v=E5cTgiHJKc0


--=-=-=
Content-Type: text/x-sh
Content-Disposition: attachment; filename=rtapp.bt

#!/usr/bin/bpftrace

kprobe:irq_thread+191
/curtask->prio < 99/
{
	// pre schedule()
	@allow_s_state[tid] = 1;
}

kprobe:irq_thread+196
/curtask->prio < 99/
{
	// post schedule()
	delete(@allow_s_state[tid]);
}

kprobe:smpboot_thread_fn+219
/curtask->prio < 99/
{
	// pre schedule()
	@allow_s_state[tid] = 1;
}

kprobe:smpboot_thread_fn+224
/curtask->prio < 99/
{
	// post schedule()
	delete(@allow_s_state[tid]);
}

kprobe:do_nanosleep
/curtask->prio < 99/
{
	@allow_s_state[tid] = 1;
}

kretprobe:do_nanosleep
/curtask->prio < 99/
{
	delete(@allow_s_state[tid]);
}

kprobe:futex_lock_pi
/curtask->prio < 99/
{
	@allow_s_state[tid] = 1;
}

kretprobe:futex_lock_pi
/curtask->prio < 99/
{
	delete(@allow_s_state[tid]);
}

tracepoint:sched:sched_switch
/args->prev_prio < 99 && nsecs > @starttime/
{
	if (!@ready) {
		@ready = 1;
		printf("Ready.\n");
	}

	// handle preempted run

	if (@schedout_r_state[args->next_pid]) {
		$val = @schedout_r_state[args->next_pid];
		printf("%lu: preempted run:     pid=%d prio=%d comm=%s nsecs=%ld\n", nsecs, args->next_pid, args->next_prio, args->next_comm, nsecs - $val);
		delete(@schedout_r_state[args->next_pid]);
	}

	if (args->prev_state == 0) {
		@schedout_r_state[args->prev_pid] = nsecs;
		return;
	}

	// handle sleeping

	if (args->prev_state != 1) {
		return;
	}

	if (@allow_s_state[args->prev_pid]) {
		delete(@allow_s_state[args->prev_pid]);
		return;
	}

	printf("%lu: sleeping:          pid=%d prio=%d comm=%s%s\n", nsecs, args->prev_pid, args->prev_prio, args->prev_comm, kstack);
	delete(@allow_s_state[args->prev_pid]);
}

tracepoint:exceptions:page_fault_kernel
/curtask->prio < 99/
{
	printf("%lu: kernel page fault: pid=%d prio=%d comm=%s%s\n", nsecs, tid, curtask->prio, curtask->comm, kstack);
}

tracepoint:exceptions:page_fault_user
/curtask->prio < 99/
{
	printf("%lu: user page fault:   pid=%d prio=%d comm=%s\n", nsecs, tid, curtask->prio, curtask->comm);
}

kprobe:do_futex
/curtask->prio < 99/
{
	$op = arg1 & 0x7f;
	if ($op == 0) {
		printf("%lu: non-PI futex wait:  pid=%d prio=%d comm=%s op=%d %s\n", nsecs, tid, curtask->prio, curtask->comm, $op, kstack);
	}
}

interval:s:600
{
	exit();
}

BEGIN
{
	@starttime = nsecs + 1000000000
}

END
{
	clear(@allow_s_state);
	clear(@schedout_r_state);
	clear(@starttime);
	clear(@ready);
}

--=-=-=--
