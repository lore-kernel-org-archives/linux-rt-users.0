Return-Path: <SRS0=KoKX=4U=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F4B6C3F2C6
	for <linux-rt-users@archiver.kernel.org>; Tue,  3 Mar 2020 19:56:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29ECB2073B
	for <linux-rt-users@archiver.kernel.org>; Tue,  3 Mar 2020 19:56:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IrKz+r/C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731093AbgCCT4U (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 3 Mar 2020 14:56:20 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:55123 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1731074AbgCCT4U (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 3 Mar 2020 14:56:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583265379;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1qj8ZdJngAl1BYhYQ8Pb9xB95Ex95TcCgPbQcv0M/tM=;
        b=IrKz+r/Cw6rPK8MqKGQGEKKjsGpRHXuGywqDILR0R4WKI3nVuhmMjYHp3NtG443xdwZoS7
        hl/ZI9HhY/dSD0q1Upgq2AMzcePMcO4/jHpEMvArye43J6BYRO7x10WruoBDvn41RDRwBk
        tU7haV8jB1W8H0duDvs/7nCa/WU3oyM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-382-2UFrHnTtP1mOYL1rblVYZQ-1; Tue, 03 Mar 2020 14:56:16 -0500
X-MC-Unique: 2UFrHnTtP1mOYL1rblVYZQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CEEE4DBA5;
        Tue,  3 Mar 2020 19:56:13 +0000 (UTC)
Received: from ovpn-118-56.phx2.redhat.com (ovpn-118-56.phx2.redhat.com [10.3.118.56])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 04D7510016EB;
        Tue,  3 Mar 2020 19:56:11 +0000 (UTC)
Message-ID: <f9e97d7214906f7b34aa587b868071a6f673c69a.camel@redhat.com>
Subject: Re: [PATCH RT 21/23] sched: migrate_enable: Busy loop until the
 migration request is completed
From:   Scott Wood <swood@redhat.com>
To:     zanussi@kernel.org, LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Wagner <wagi@monom.org>
Date:   Tue, 03 Mar 2020 13:56:11 -0600
In-Reply-To: <fd4bda7ad49f46545a03424fd1327dff8a8b8171.1582814004.git.zanussi@kernel.org>
References: <cover.1582814004.git.zanussi@kernel.org>
         <fd4bda7ad49f46545a03424fd1327dff8a8b8171.1582814004.git.zanussi@kernel.org>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Thu, 2020-02-27 at 08:33 -0600, zanussi@kernel.org wrote:
> From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> 
> v4.14.170-rt75-rc2 stable review patch.
> If anyone has any objections, please let me know.
> 
> -----------
> 
> 
> [ Upstream commit 140d7f54a5fff02898d2ca9802b39548bf7455f1 ]
> 
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
> 
> Spin until the migration request has been processed if it was accepted.
> 
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Signed-off-by: Tom Zanussi <zanussi@kernel.org>
> ---
>  kernel/sched/core.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)

As I said in https://marc.info/?l=linux-rt-users&m=158258256415340&w=2 if
you take thhis you should take the followup 2dcd94b443c5dcbc ("sched:
migrate_enable: Use per-cpu cpu_stop_work")

-Scott


