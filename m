Return-Path: <SRS0=3N3c=R7=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02636C43381
	for <linux-rt-users@archiver.kernel.org>; Thu, 28 Mar 2019 10:17:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEF9020811
	for <linux-rt-users@archiver.kernel.org>; Thu, 28 Mar 2019 10:17:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726613AbfC1KRa convert rfc822-to-8bit (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 28 Mar 2019 06:17:30 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:52697 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726243AbfC1KRa (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 28 Mar 2019 06:17:30 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1h9S6A-0001wj-QL; Thu, 28 Mar 2019 11:17:26 +0100
Date:   Thu, 28 Mar 2019 11:17:26 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Juri Lelli <juri.lelli@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     linux-rt-users <linux-rt-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Clark Williams <williams@redhat.com>
Subject: Re: [RT WARNING] DEBUG_LOCKS_WARN_ON(rt_mutex_owner(lock) !=
 current) with fsfreeze (4.19.25-rt16)
Message-ID: <20190328101726.u2y7v46mo66i5aoi@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20190326093421.GA29508@localhost.localdomain>
User-Agent: NeoMutt/20180716
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2019-03-26 10:34:21 [+0100], Juri Lelli wrote:
> Hi,
Hi,

…
>  # for I in `seq 10`; do fsfreeze -f ./testmount; sleep 1; fsfreeze -u ./testmount; done
> 
>  ------------[ cut here ]------------
>  DEBUG_LOCKS_WARN_ON(rt_mutex_owner(lock) != current)
>  WARNING: CPU: 10 PID: 1226 at kernel/locking/rtmutex-debug.c:145 debug_rt_mutex_unlock+0x9b/0xb0
>  Modules linked in: xfs [...]
>  CPU: 10 PID: 1226 Comm: fsfreeze Not tainted 4.19.25-rt16 #2
>  Hardware name: LENOVO 30B6S2F900/1030, BIOS S01KT61A 09/28/2018
>  RIP: 0010:debug_rt_mutex_unlock+0x9b/0xb0
…
>   __rt_mutex_unlock+0x45/0x80
>   percpu_up_write+0x4b/0x60
>   thaw_super_locked+0xdb/0x110
…
> AFAIU, this is a legit warning, since
> 
>  fsfreeze -f ./testmount grabs rt_mutexes embedded into
>  sb->s_writers.rw_sem[SB_FREEZE_LEVELS] (rt-rwsem) as part of executing
>  sb_wait_write() (for each FREEZE_LEVEL) in freeze_super().
> 
>  We then return to userspace.
> 
>  fsfreeze -u ./testmount unlocks the rt_mutexes while doing
>  sb_freeze_unlock() in thaw_super_locked(). This is a different process
>  w.r.t. the one that did the freeze above.
> 
> I noticed that a very similar problem was fixed (for !rt rwsem) by
> 5a817641f68a ("locking/percpu-rwsem: Annotate rwsem ownership transfer
> by setting RWSEM_OWNER_UNKNOWN"). However, RT has of course to deal with
> PI, so I wonder if there is an easy fix for this problem.
> 
> Suggestions?

So we leave to userland with an acquired rtmutex. And lockdep doesn't
complain because lockdep_sb_freeze_release() /
lockdep_sb_freeze_acquire() informs that everything is okay.
I have no idea, PeterZ? The rwsem is not ownerless afaik.

> Thanks,
> 
> - Juri

Sebastian
