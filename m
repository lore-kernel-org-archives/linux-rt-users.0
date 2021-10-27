Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3777C433EF
	for <linux-rt-users@archiver.kernel.org>; Wed, 27 Oct 2021 16:58:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D2C6F60EDF
	for <linux-rt-users@archiver.kernel.org>; Wed, 27 Oct 2021 16:58:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239242AbhJ0RAe (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 27 Oct 2021 13:00:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237583AbhJ0RA3 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 27 Oct 2021 13:00:29 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D0FBC061570;
        Wed, 27 Oct 2021 09:58:04 -0700 (PDT)
Date:   Wed, 27 Oct 2021 18:58:00 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1635353881;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cQ1rB1AcjIVjMWPHP44TToPBwUXL1inO6k6sho8ftXg=;
        b=Hb5LaHZYOcGoYmxfrVfwP9krcNrHe2nacFIOhCbyChfRmlBvXtG/UVTjmmunVQmxVNEKLN
        QYBML3p0QyLAjFxD23Fq9LE6JD8o+jPwaaUWsS8i+Caqwe5ddy9ELeVyVAMY9qfIfKgRM8
        gs0Xd+0xdpVhDxrepIZVyriHv4JWfxxNVbqSsetTi2y7JYOvKnx8OSfEFuoewSwwYxL7nW
        12W8usrqAixbbKsL5+zQgw+hx/RZzog4Q9XPZIVfDs1sss0NTKR3DvdIT2fIcz31WdWFZ0
        1kKivL1iS4SE8ridiiXfAKneZ6VUOcLoTvGanzlhwzjqb+ZYz5rpoom0Z2KZ6A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1635353881;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cQ1rB1AcjIVjMWPHP44TToPBwUXL1inO6k6sho8ftXg=;
        b=bMfPOdinfNBQB7CNmuAdfUhCxe2w+G+0ilanxT6DgsidyxRyuO5sKOCiwiAc+sTASGw0w9
        nx8coU+Rl73gW+AA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Ronny Meeus <ronny.meeus@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Subject: Re: Unbounded priority inversion while assigning tasks into cgroups.
Message-ID: <20211027165800.md2gxbsku4avqjgt@linutronix.de>
References: <CAMJ=MEd9WuGA0MN+n0rGD6T+sgd=yciTmeEW9TjRjNXt+cF=qQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMJ=MEd9WuGA0MN+n0rGD6T+sgd=yciTmeEW9TjRjNXt+cF=qQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2021-10-25 11:43:52 [+0200], Ronny Meeus wrote:
> Hello
Hi,

> an unbounded priority inversion is observed when moving tasks into cgroups.
> In my case I'm using the cpu and cpuacct cgroups but the issue is
> independent of this.
> 
> Kernel version: 4.9.79
> CPU: Dual core Cavium Octeon (MIPS)
> Kernel configured with CONFIG_PREEMPT=y
> 
> I have a small application running at RT priority 92.
> Its job is to move high CPU consuming applications into a cgroup when
> the system is under high load.
> Under extreme load conditions (meaning a lot of script processing
> (process clone / exec / exit) and high application load), sometimes
> the application hangs for a long time (can be a couple of seconds but
> also hangs of 2 minutes are observed already).
> 
> Extending the kernel with traces (see below) showed that the
> root-cause of the blocking is the global rwsem
> "cgroup_threadgroup_rwsem".
> While adding a task into the cgroup (__cgroup_procs_write), the write
> lock is taken which will have to wait until all writers and readers
> have completed their critical section which can take very long.
> Especially since there are many of them running at a much lower
> priority and we have also applications running at medium priority
> running with a very high load.
> 
> As an initial attempt I tried applying the RT patch but this does not
> resolve the issue.
> 
> The second attempt was to replace the cgroup_threadgroup_rwsem by a
> rt_mutex (which offers priority inheritance).
> After this change the issue seems to be resolved.
> A disadvantage of this approach is that all accesses to the critical
> section are serialized on all cores (writes to assign tasks to cgroups
> and reads to create/exec/exit processes).
> 
> For the moment I do not see any other alternative to resolve this problem.
> Any advice on the right way forward would be appreciated.

From a looking at percpu_rw_semaphore implementation, no new readers are
allowed as long as there is a writer pending. The writer has
(unfortunately) to wait until all readers are out. But then I doubt that
this takes up to two minutes for all existing readers to leave the
critical section.
Looking at v4.9.84, at least the RT implementation of rw_semaphore
allows new readers if a writer is pending. So this could be culprit as
you would have to wait until all reader are gone and the writer needs to
grab the lock before another reader shows up. But then this shouldn't be
the case for the generic implementation and new reader should wait until
the writer got its chance.

> Best regards,
> Ronny

Sebastian
