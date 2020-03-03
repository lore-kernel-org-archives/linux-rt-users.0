Return-Path: <SRS0=KoKX=4U=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC589C3F2D1
	for <linux-rt-users@archiver.kernel.org>; Tue,  3 Mar 2020 21:19:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF15E2146E
	for <linux-rt-users@archiver.kernel.org>; Tue,  3 Mar 2020 21:19:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZVsuWy5C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732555AbgCCVTb (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 3 Mar 2020 16:19:31 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:57013 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1732551AbgCCVTb (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 3 Mar 2020 16:19:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583270370;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NLDA7toglCDQRpNnqhPatl4QeMuEcPW4UDhAve1m/gc=;
        b=ZVsuWy5CIKpSw+Chim9T1IHkjdq5+uwMz5HXhT/uwyXosI7ZoA0UOjTnRPaMLOVnTMlFcd
        r0BQMtONnmGygamGZdrlm7UQzl6zSyjiHbCypYNFTmd/mPwyFdOzq+aGXP1+hfrGWlf25r
        pn/WkfkiVGBozVo3GfNdnbYWZ4RPmmc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-351-rBTk2GVxMkmYIXAm35fiuQ-1; Tue, 03 Mar 2020 16:19:27 -0500
X-MC-Unique: rBTk2GVxMkmYIXAm35fiuQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 42C201922968;
        Tue,  3 Mar 2020 21:19:25 +0000 (UTC)
Received: from ovpn-118-56.phx2.redhat.com (ovpn-118-56.phx2.redhat.com [10.3.118.56])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E010C8D561;
        Tue,  3 Mar 2020 21:19:23 +0000 (UTC)
Message-ID: <f783406c0254a3b36ab1123402a7b2f26f6d5699.camel@redhat.com>
Subject: Re: [PATCH RT 21/23] sched: migrate_enable: Busy loop until the
 migration request is completed
From:   Scott Wood <swood@redhat.com>
To:     Tom Zanussi <zanussi@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Wagner <wagi@monom.org>
Date:   Tue, 03 Mar 2020 15:19:23 -0600
In-Reply-To: <1583267977.12738.53.camel@kernel.org>
References: <cover.1582814004.git.zanussi@kernel.org>
         <fd4bda7ad49f46545a03424fd1327dff8a8b8171.1582814004.git.zanussi@kernel.org>
         <f9e97d7214906f7b34aa587b868071a6f673c69a.camel@redhat.com>
         <1583267977.12738.53.camel@kernel.org>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Tue, 2020-03-03 at 14:39 -0600, Tom Zanussi wrote:
> Hi Scott,
> 
> On Tue, 2020-03-03 at 13:56 -0600, Scott Wood wrote:
> > On Thu, 2020-02-27 at 08:33 -0600, zanussi@kernel.org wrote:
> > > From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> > > 
> > > v4.14.170-rt75-rc2 stable review patch.
> > > If anyone has any objections, please let me know.
> > > 
> > > -----------
> > > 
> > > 
> > > [ Upstream commit 140d7f54a5fff02898d2ca9802b39548bf7455f1 ]
> > > 
> > > If user task changes the CPU affinity mask of a running task it
> > > will
> > > dispatch migration request if the current CPU is no longer allowed.
> > > This
> > > might happen shortly before a task enters a migrate_disable()
> > > section.
> > > Upon leaving the migrate_disable() section, the task will notice
> > > that
> > > the current CPU is no longer allowed and will will dispatch its own
> > > migration request to move it off the current CPU.
> > > While invoking __schedule() the first migration request will be
> > > processed and the task returns on the "new" CPU with "arg.done =
> > > 0". Its
> > > own migration request will be processed shortly after and will
> > > result in
> > > memory corruption if the stack memory, designed for request, was
> > > used
> > > otherwise in the meantime.
> > > 
> > > Spin until the migration request has been processed if it was
> > > accepted.
> > > 
> > > Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> > > Signed-off-by: Tom Zanussi <zanussi@kernel.org>
> > > ---
> > >  kernel/sched/core.c | 7 +++++--
> > >  1 file changed, 5 insertions(+), 2 deletions(-)
> > 
> > As I said in https://marc.info/?l=linux-rt-users&m=158258256415340&w=
> > 2 if
> > you take thhis you should take the followup 2dcd94b443c5dcbc ("sched:
> > migrate_enable: Use per-cpu cpu_stop_work")
> > 
> 
> Yes, I didn't forget about this, it's just that I can't apply this to
> 4.14-rt until 4.19-rt does, otherwise it will be seen as a regression
> to someone moving from 4.14-rt to 4.19-rt.
> 
> I will be keeping my eye out for when that happens and will apply it to
> the next backport release at that point.
> 
> Thanks for making sure it wasn't missed in any case.

Steven, any plans to merge that patch into 4.19-rt?

In the meantime, I guess it's a question of whether the bug fixed by patch
18/23 is worse than the (probably quite hard to hit) deadlock addressed by
2dcd94b443c5dcbc.

-Scott


