Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB04CC77B7F
	for <linux-rt-users@archiver.kernel.org>; Tue, 16 May 2023 14:11:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233864AbjEPOLi (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 16 May 2023 10:11:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233858AbjEPOLh (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 16 May 2023 10:11:37 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1E99525D;
        Tue, 16 May 2023 07:11:34 -0700 (PDT)
Date:   Tue, 16 May 2023 16:11:31 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1684246292;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=p2kJoaiY6sFc2XexA1NSIp8tkp+KMAr9FWBhMM10K8M=;
        b=riLXV+N5V8BdO+sfICU58zzviuCKe9WJxAYet3PjRWtiPOwFtgliU3sHxUi6l3baLUDeQA
        d2VLsy7KtIBhvNWVKC6KeYkpY1ApsJvTS49MTG3ler7Bcl/5uxUwZsXOlCSCbZdBwtXsYJ
        we3NjLMA59WE5KLa2Sj6G6vNMDt8DEfJH22mqdT239W8G+cmmBpeKhkppny1ol55kILooa
        M1m6NbgnsAjROIDn3M92M3fU3Ue2wKS+f2ht+lgTaGnowZ7TVuHwY6u/IUI2Zf/8vJUyyG
        5N06JKGdvT0wg613LkTa/3qHQjSnq8LAPKPyowbyqMeX2mYIBGE3PVojvwP9bw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1684246292;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=p2kJoaiY6sFc2XexA1NSIp8tkp+KMAr9FWBhMM10K8M=;
        b=GsSf85KlemRQc6no2AW5TCBPerki9GVIsRc+w9rsP2YAjhc78yfxiGKJXD8NJVD9LCL9Ev
        FziApyZgVfUG2cAg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Valentin Schneider <vschneid@redhat.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Juri Lelli <juri.lelli@redhat.com>
Subject: Re: [ANNOUNCE] v6.3.1-rt13
Message-ID: <20230516141131.fScCnP3q@linutronix.de>
References: <20230509164640.-aaZNrjH@linutronix.de>
 <xhsmhy1lwifi1.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xhsmhy1lwifi1.mognet@vschneid.remote.csb>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2023-05-10 12:37:42 [+0100], Valentin Schneider wrote:
> The ktimersd threads solved some priority inversion problem we were seeing,
> IIRC it looked something like so:
> - GP kthread is waiting on swait_event_idle_timeout_exclusive(...)
> - p0 (CFS NICE0) did spin_lock(L) then got throttled by CFS bandwidth
> - p1 (CFS NICE0) did local_bh_disable() + did spin_lock(L)
> 
> So p0 owns L, but cannot get bandwidth replenished since local softirqs are
> disabled, and the GP kthread can't be woken up by timeout to initiate
> boosting either.
> 
> Even if ksoftirqd has its priority tuned to ensure timers can be expired,
> the above never wakes ksoftirqd due to:
> 
> static inline bool should_wake_ksoftirqd(void)
> {
>         return !this_cpu_read(softirq_ctrl.cnt);
> }
> 
> on the other hand, ktimersd are woken up unconditionally, so in this
> scenario it gets to run and donate its priority via
> 
>   ksoftirqd_run_begin()
>   `\
>     local_lock(&softirq_ctrl.lock)
> 
> (note that this only solves the CFS bandwidth issue if ktimersd are FIFO or
> above, but they are spawned as FIFO1)
> 
> 
> TL;DR: for RT, I think we should also kill should_wake_ksoftirqd()

If I remember correctly this check was to avoid waking ksoftirqd because
softirqs are already handled. In this case the systems stalls until p0/1
makes some progress. Waking ksoftirqd makes sense if its scheduling
policy is elevated.

Now we need overloading strategy since the current idea is to solve it
by moving everything to ksoftirqd and letting it run at SCHED_OTHER.

Sebastian
