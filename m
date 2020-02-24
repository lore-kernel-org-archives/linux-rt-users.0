Return-Path: <SRS0=opgi=4M=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 854D4C11D30
	for <linux-rt-users@archiver.kernel.org>; Mon, 24 Feb 2020 15:31:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DCC620828
	for <linux-rt-users@archiver.kernel.org>; Mon, 24 Feb 2020 15:31:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582558272;
	bh=6nw4Wh11lpnEtqX0aH/aaIrhLA2Xtrbkwjh0ZyZP2as=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:List-ID:From;
	b=E3Ys55Q8dM0H+0BEssTSUEjkofsXZ5USgBoBgwXmx2BejXGEHsHK07kKodDhhIFZo
	 86Gl8mTF+1vBN1qOPmy+bGQ37OslX2gaCa8Y9wT3LGjRcZD5W1+r71urdVho3uHlhh
	 h12XBs2HYAB6FGJ7WtT77bFJAGuxEC4xDf+/gmUg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727803AbgBXPbI (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 24 Feb 2020 10:31:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:47746 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727359AbgBXPbI (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 24 Feb 2020 10:31:08 -0500
Received: from tzanussi-mobl7 (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EFC8F20714;
        Mon, 24 Feb 2020 15:31:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582558267;
        bh=6nw4Wh11lpnEtqX0aH/aaIrhLA2Xtrbkwjh0ZyZP2as=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=xNm5aVd2+DfQ5YJLQHGx16shVQvO9CFQ8cUn6H+2PYHkktqW7jUvuUhcXau+sgXbs
         64pDgesTJNzbArd3WFsoQZrWNOtjkC8cMsg9EwJ1eMerR79WBW1ujQ7IjWkCsUsjjl
         Po10WmZRVbW5DZlbrXMPruw6YuMHChdNqENEgnQQ=
Message-ID: <1582558266.12738.32.camel@kernel.org>
Subject: Re: [PATCH RT 15/25] sched: migrate_enable: Use select_fallback_rq()
From:   Tom Zanussi <zanussi@kernel.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>, Daniel Wagner <wagi@monom.org>
Date:   Mon, 24 Feb 2020 09:31:06 -0600
In-Reply-To: <20200224094349.5x6dca4tggtmmbnq@linutronix.de>
References: <cover.1582320278.git.zanussi@kernel.org>
         <eb183ce95bb3d92b426bdadf36f0648cda474379.1582320278.git.zanussi@kernel.org>
         <20200224094349.5x6dca4tggtmmbnq@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Mon, 2020-02-24 at 10:43 +0100, Sebastian Andrzej Siewior wrote:
> On 2020-02-21 15:24:43 [-0600], zanussi@kernel.org wrote:
> > From: Scott Wood <swood@redhat.com>
> > 
> > v4.14.170-rt75-rc1 stable review patch.
> > If anyone has any objections, please let me know.
> 
> This creates bug which is stuffed later via
> 	sched: migrate_enable: Busy loop until the migration request is
> completed
> 
> So if apply this, please take the bug fix, too. This is Stevens queue
> for reference:
> > [PATCH RT 22/30] sched: migrate_enable: Use select_fallback_rq()
> 
> ^^ bug introduced
> 

Hmm, it seemed from the comment on the 4.19 series that it was '24/32
sched: migrate_enable: Use stop_one_cpu_nowait()' that required 'sched:
migrate_enable: Busy loop until the migration request is
completed' as a bug fix.

  https://lore.kernel.org/linux-rt-users/20200122083130.kuu3yppckhyjrr4u@linutronix.de/#t

I didn't take the stop_one_cpu_nowait() one, so didn't take the busy
loop one either.

Thanks,

Tom

> > [PATCH RT 23/30] sched: Lazy migrate_disable
> > processing                                                         
> >                      
> > [PATCH RT 24/30] sched: migrate_enable: Use stop_one_cpu_nowait()
> > [PATCH RT 25/30] Revert "ARM: Initialize split page table locks for
> > vector page"
> > [PATCH RT 26/30] locking: Make spinlock_t and rwlock_t a RCU
> > section on RT
> > [PATCH RT 27/30] sched/core: migrate_enable() must access
> > takedown_cpu_task on !HOTPLUG_CPU
> > [PATCH RT 28/30] lib/smp_processor_id: Adjust
> > check_preemption_disabled()
> > [PATCH RT 29/30] sched: migrate_enable: Busy loop until the
> > migration request is completed
> 
> ^^ bug fixed
> 
> Sebastian
