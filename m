Return-Path: <SRS0=kQBB=2D=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16F01C43603
	for <linux-rt-users@archiver.kernel.org>; Fri, 13 Dec 2019 06:44:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9877214D8
	for <linux-rt-users@archiver.kernel.org>; Fri, 13 Dec 2019 06:44:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A+R1Eb+0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725913AbfLMGoa (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 13 Dec 2019 01:44:30 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:52096 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725793AbfLMGo3 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 13 Dec 2019 01:44:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576219468;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FSniXaU8d0X4ng5pUQdaI4FU5VEWvHsezQeckgr3lXI=;
        b=A+R1Eb+0Q9xbwbnpnScu1rORCE+JDPcNoKZWfwiHSs5EJc5UR726e0QE3UdY8TxVmpVdW+
        Qa1nyKDiUwA70V5r4BoT0QShe2wcf9bnvYhr2e07dmjAzJzYwMrTlqEzbV3nPWh6JEJnGm
        oHjej+IQHkvd00LNVkSExLWNRkgI3L4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-52--IuKHJLdMkOuetLA-hBeLA-1; Fri, 13 Dec 2019 01:44:25 -0500
X-MC-Unique: -IuKHJLdMkOuetLA-hBeLA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D8257593A3;
        Fri, 13 Dec 2019 06:44:23 +0000 (UTC)
Received: from ovpn-116-192.phx2.redhat.com (ovpn-116-192.phx2.redhat.com [10.3.116.192])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 510E019756;
        Fri, 13 Dec 2019 06:44:23 +0000 (UTC)
Message-ID: <30ab713901ef0e1f23c1ca387373788a4a73639f.camel@redhat.com>
Subject: Re: [PATCH RT] sched: migrate_enable: Busy loop until the migration
 request is completed
From:   Scott Wood <swood@redhat.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>
Date:   Fri, 13 Dec 2019 00:44:22 -0600
In-Reply-To: <20191212112717.2tzoqbe3xeknoyvs@linutronix.de>
References: <20191212112717.2tzoqbe3xeknoyvs@linutronix.de>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Thu, 2019-12-12 at 12:27 +0100, Sebastian Andrzej Siewior wrote:
> If user task changes the CPU affinity mask of a running task it will
> dispatch migration request if the current CPU is no longer allowed. This
> might happen shortly before a task enters a migrate_disable() section.
> Upon leaving the migrate_disable() section, the task will notice that
> the current CPU is no longer allowed and will will dispatch its own
> migration request to move it off the current CPU.
> While invoking __schedule() the first migration request will be
> processed and the task returns on the "new" CPU with "arg.done = 0". Its
> own migration request will be processed shortly after and will result in
> memory corruption if the stack memory, designed for request, was used
> otherwise in the meantime.

Ugh.

> Spin until the migration request has been processed if it was accepted.
> 
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  kernel/sched/core.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 8bea013b2baf5..5c7be96ca68c4 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -8227,7 +8227,7 @@ void migrate_enable(void)
>  
>  	WARN_ON(smp_processor_id() != cpu);
>  	if (!is_cpu_allowed(p, cpu)) {
> -		struct migration_arg arg = { p };
> +		struct migration_arg arg = { .task = p };
>  		struct cpu_stop_work work;
>  		struct rq_flags rf;
>  
> @@ -8239,7 +8239,10 @@ void migrate_enable(void)
>  		stop_one_cpu_nowait(task_cpu(p), migration_cpu_stop,
>  				    &arg, &work);
>  		__schedule(true);
> -		WARN_ON_ONCE(!arg.done && !work.disabled);
> +		if (!work.disabled) {
> +			while (!arg.done)
> +				cpu_relax();
> +		}

We should enable preemption while spinning -- besides the general badness
of spinning with it disabled, there could be deadlock scenarios if
multiple CPUs are spinning in such a loop.  Long term maybe have a way to
dequeue the no-longer-needed work instead of waiting.

-Scott

