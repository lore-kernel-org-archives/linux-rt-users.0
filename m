Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60A69C433EF
	for <linux-rt-users@archiver.kernel.org>; Sat, 25 Jun 2022 17:04:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233100AbiFYRE4 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Sat, 25 Jun 2022 13:04:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231153AbiFYREz (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Sat, 25 Jun 2022 13:04:55 -0400
Received: from out02.mta.xmission.com (out02.mta.xmission.com [166.70.13.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC06414020;
        Sat, 25 Jun 2022 10:04:54 -0700 (PDT)
Received: from in01.mta.xmission.com ([166.70.13.51]:41708)
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1o59DJ-008ljH-LL; Sat, 25 Jun 2022 11:04:53 -0600
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:57554 helo=email.froward.int.ebiederm.org.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1o59DI-009wBm-Ke; Sat, 25 Jun 2022 11:04:53 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Valentin Schneider <vschneid@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
        linux-rt-users@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Petr Mladek <pmladek@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Juri Lelli <jlelli@redhat.com>,
        "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vivek Goyal <vgoyal@redhat.com>
References: <20220620111520.1039685-1-vschneid@redhat.com>
Date:   Sat, 25 Jun 2022 12:04:46 -0500
In-Reply-To: <20220620111520.1039685-1-vschneid@redhat.com> (Valentin
        Schneider's message of "Mon, 20 Jun 2022 12:15:20 +0100")
Message-ID: <87r13c7jyp.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1o59DI-009wBm-Ke;;;mid=<87r13c7jyp.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=softfail
X-XM-AID: U2FsdGVkX18w4luJIoAO0o2bnltbvBhRK+Y2TiFzlm0=
X-SA-Exim-Connect-IP: 68.227.174.4
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH v2] panic, kexec: Make __crash_kexec() NMI safe
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Valentin Schneider <vschneid@redhat.com> writes:

> Attempting to get a crash dump out of a debug PREEMPT_RT kernel via an NMI
> panic() doesn't work. The cause of that lies in the PREEMPT_RT definition
> of mutex_trylock():
>
> 	if (IS_ENABLED(CONFIG_DEBUG_RT_MUTEXES) && WARN_ON_ONCE(!in_task()))
> 		return 0;
>
> This prevents an NMI panic() from executing the main body of
> __crash_kexec() which does the actual kexec into the kdump kernel.
> The warning and return are explained by:
>
>   6ce47fd961fa ("rtmutex: Warn if trylock is called from hard/softirq context")
>   [...]
>   The reasons for this are:
>
>       1) There is a potential deadlock in the slowpath
>
>       2) Another cpu which blocks on the rtmutex will boost the task
> 	 which allegedly locked the rtmutex, but that cannot work
> 	 because the hard/softirq context borrows the task context.
>
> Furthermore, grabbing the lock isn't NMI safe, so do away with it and
> use an atomic variable to serialize reads vs writes of
> kexec_crash_image.
>
> Tested by triggering NMI panics via:
>
>   $ echo 1 > /proc/sys/kernel/panic_on_unrecovered_nmi
>   $ echo 1 > /proc/sys/kernel/unknown_nmi_panic
>   $ echo 1 > /proc/sys/kernel/panic
>
>   $ ipmitool power diag
>
> Fixes: 6ce47fd961fa ("rtmutex: Warn if trylock is called from hard/softirq context")
> Signed-off-by: Valentin Schneider <vschneid@redhat.com>

I am not particularly fond of this patch as it adds more complexity than
is necessary to solve the problem.

Calling a spade a spade PREEMPT_RT's mutex_trylock implementation is
broken as it can not support the use cases of an ordinary mutex_trylock.
I have not seen (possibly I skimmed too quickly) anywhere in the
discussion why PREEMPT_RT is not being fixed.  Looking at the code
there is enough going on in try_to_take_rt_mutex that I can imagine
that some part of that code is not nmi safe.  So I can believe
PREEMPT_RT may be unfix-ably broken.


At this point I recommend going back to being ``unconventional'' with
the kexec locking and effectively reverting commit 8c5a1cf0ad3a ("kexec:
use a mutex for locking rather than xchg()").

That would also mean that we don't have to worry about the lockdep code
doing something weird in the future and breaking kexec.

Your change starting to is atomic_cmpxchng is most halfway to a revert
of commit 8c5a1cf0ad3a ("kexec: use a mutex for locking rather than
xchg()").  So we might as well go the whole way and just document that
the kexec on panic code can not use conventional kernel locking
primitives and has to dig deep and build it's own.  At which point it
makes no sense for the rest of the kexec code to use anything different.

Eric
