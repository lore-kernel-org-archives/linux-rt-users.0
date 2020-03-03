Return-Path: <SRS0=KoKX=4U=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAA62C3F2D7
	for <linux-rt-users@archiver.kernel.org>; Tue,  3 Mar 2020 20:39:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81F4B20870
	for <linux-rt-users@archiver.kernel.org>; Tue,  3 Mar 2020 20:39:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583267983;
	bh=knYRWXGS61DRVFa5XZOhaWuesiDvSgsYGK32jWx2rnw=;
	h=Subject:From:To:Date:In-Reply-To:References:List-ID:From;
	b=NgCinl3cDsSIeBwv++9P5vfqJw0KHBmgwmZ8isRb3YeADqIS/XI8eKkLtcSn8Hf28
	 c4vEJy9A/OXNwE/xU9RnOVwXmKOl4qju9qmO9TW8koF3+NBWkNvMSBYrIyVhHs39cl
	 yEH6/lfMjA0UdDc3fTQc2OEAtN0XJNNEDaGH+duo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731845AbgCCUjk (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 3 Mar 2020 15:39:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:40912 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729681AbgCCUjk (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 3 Mar 2020 15:39:40 -0500
Received: from tzanussi-mobl7 (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ED00320848;
        Tue,  3 Mar 2020 20:39:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583267979;
        bh=knYRWXGS61DRVFa5XZOhaWuesiDvSgsYGK32jWx2rnw=;
        h=Subject:From:To:Date:In-Reply-To:References:From;
        b=MDakxZK/1Ju+j0JR74tJyG0dtLHLaZIZSCp2V4d3Okqj4ngwsw721m5fc2MCoDFXg
         uFVgjZeDrUSsFyZwrfrwQULeaa/zyfUQWPqKHTzjCP7vL/RMLp8tqdhMbWhFIeIA1G
         yxJL/FADxa6gEibS+nwsrE71fTxrI5oO0snzJoa4=
Message-ID: <1583267977.12738.53.camel@kernel.org>
Subject: Re: [PATCH RT 21/23] sched: migrate_enable: Busy loop until the
 migration request is completed
From:   Tom Zanussi <zanussi@kernel.org>
To:     Scott Wood <swood@redhat.com>, LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Wagner <wagi@monom.org>
Date:   Tue, 03 Mar 2020 14:39:37 -0600
In-Reply-To: <f9e97d7214906f7b34aa587b868071a6f673c69a.camel@redhat.com>
References: <cover.1582814004.git.zanussi@kernel.org>
         <fd4bda7ad49f46545a03424fd1327dff8a8b8171.1582814004.git.zanussi@kernel.org>
         <f9e97d7214906f7b34aa587b868071a6f673c69a.camel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi Scott,

On Tue, 2020-03-03 at 13:56 -0600, Scott Wood wrote:
> On Thu, 2020-02-27 at 08:33 -0600, zanussi@kernel.org wrote:
> > From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> > 
> > v4.14.170-rt75-rc2 stable review patch.
> > If anyone has any objections, please let me know.
> > 
> > -----------
> > 
> > 
> > [ Upstream commit 140d7f54a5fff02898d2ca9802b39548bf7455f1 ]
> > 
> > If user task changes the CPU affinity mask of a running task it
> > will
> > dispatch migration request if the current CPU is no longer allowed.
> > This
> > might happen shortly before a task enters a migrate_disable()
> > section.
> > Upon leaving the migrate_disable() section, the task will notice
> > that
> > the current CPU is no longer allowed and will will dispatch its own
> > migration request to move it off the current CPU.
> > While invoking __schedule() the first migration request will be
> > processed and the task returns on the "new" CPU with "arg.done =
> > 0". Its
> > own migration request will be processed shortly after and will
> > result in
> > memory corruption if the stack memory, designed for request, was
> > used
> > otherwise in the meantime.
> > 
> > Spin until the migration request has been processed if it was
> > accepted.
> > 
> > Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> > Signed-off-by: Tom Zanussi <zanussi@kernel.org>
> > ---
> >  kernel/sched/core.c | 7 +++++--
> >  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> As I said in https://marc.info/?l=linux-rt-users&m=158258256415340&w=
> 2 if
> you take thhis you should take the followup 2dcd94b443c5dcbc ("sched:
> migrate_enable: Use per-cpu cpu_stop_work")
> 

Yes, I didn't forget about this, it's just that I can't apply this to
4.14-rt until 4.19-rt does, otherwise it will be seen as a regression
to someone moving from 4.14-rt to 4.19-rt.

I will be keeping my eye out for when that happens and will apply it to
the next backport release at that point.

Thanks for making sure it wasn't missed in any case.

Tom 


> -Scott
> 
> 
