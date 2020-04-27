Return-Path: <SRS0=jUvr=6L=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF2C5C54EEB
	for <linux-rt-users@archiver.kernel.org>; Mon, 27 Apr 2020 19:26:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B23B4214AF
	for <linux-rt-users@archiver.kernel.org>; Mon, 27 Apr 2020 19:26:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588015618;
	bh=+6ORraxcq0bFebqoTSSgJj2lGpfwZ/siWQ6vQG2K/Ek=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:List-ID:From;
	b=LCu3OfNfEjs0tWl5FEqBqwkXfP/MEUasDq41nLIX0OtbnCBKT0rDldUXerlfj26L0
	 58zuNbqi5WW5CxcfccJ127+03engpWJbLqZiUkDsBOzFlQPvpHZbkYXxQUQDgHWZ5d
	 uRRvGI8zG7xR06Ak/L/xjlQnMDjuOsQWNjiAmLxg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726678AbgD0T04 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 27 Apr 2020 15:26:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:43958 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726315AbgD0T0z (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 27 Apr 2020 15:26:55 -0400
Received: from tzanussi-mobl (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1D01220775;
        Mon, 27 Apr 2020 19:26:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588015615;
        bh=+6ORraxcq0bFebqoTSSgJj2lGpfwZ/siWQ6vQG2K/Ek=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=iDvgkZAbTXBJmLrnTrp5dbaKID+/ZmDkyzHXhFmHDlJn7HtVvQO2LUoiqilYn0AES
         RBN698cxUIZHagHu47Wla60SruRknJobEmXOnxVBLpeRg3PXDhbqpMANtwsQuviQaw
         zu5MruNuJDi2STH/bn4ZGdnc1ZHBSs6S3tLZpQ4U=
Message-ID: <2535a046bc15f28478c5289742e617a468becbd6.camel@kernel.org>
Subject: Re: [PATCH RT 10/30] hrtimer: Prevent using
 hrtimer_grab_expiry_lock() on migration_base
From:   Tom Zanussi <zanussi@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Cc:     linux-kernel@vger.kernel.org,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        John Kacur <jkacur@redhat.com>,
        Julia Cartwright <julia@ni.com>,
        Daniel Wagner <wagi@monom.org>,
        Julien Grall <julien.grall@arm.com>
Date:   Mon, 27 Apr 2020 14:26:52 -0500
In-Reply-To: <20200427150626.4f217c82@gandalf.local.home>
References: <20200123203930.646725253@goodmis.org>
         <20200123203943.749508731@goodmis.org>
         <ac4168c7-68d6-e558-644e-e0daceea1f61@prevas.dk>
         <20200427150626.4f217c82@gandalf.local.home>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Mon, 2020-04-27 at 15:06 -0400, Steven Rostedt wrote:
> On Mon, 27 Apr 2020 15:10:00 +0200
> Rasmus Villemoes <rasmus.villemoes@prevas.dk> wrote:
> 
> > However, building with their rescue initrd and booting that, the
> > board
> > would consistently hang during reboot. Sometimes I would get lines
> > like
> > 
> > [   72.956630] sched: RT throttling activated
> > [   72.973769] lanx: port 1(lan1) entered disabled state
> > [   73.000401] lanx: port 2(lan2) entered disabled state
> > [   73.974951] lanx: port 3(lan3) entered disabled state
> > [   73.997473] lanx: port 4(lan4) entered disabled state
> > [   74.968006] lanx: port 5(lan5) entered disabled state
> > 
> > other times there would be no output, but the board was still
> > hanging.
> > Reverting
> > 
> > b1a471ec4df1 - hrtimer: Prevent using hrtimer_grab_expiry_lock() on
> > migration_base
> > 40aae5708e7a - hrtimer: Add a missing bracket and hide
> > `migration_base'
> > on !SMP
> > 
> > on top of v4.19.94-rt39 makes that problem go away, i.e. the board
> > reboots as expected.
> > 
> > The board is a 32 bit powerpc (mpc8309) !SMP. Any ideas what I can
> > do to
> > debug this further?
> 
> Thanks Rasmus for looking into this. Tom now maintains 4.19-rt.
> 
> Tom, care to pull in these patches on top of 4.19-rt?
> 

Those patches are already in 4.19-rt - he's saying that reverting them
fixes the problem.

I'm guessing that the assumption of base or base->cpu_base always being
non-NULL in those patches might be wrong.  If so, the below patch
should fix the problem:

Subject: [PATCH] hrtimer: Add back base and base->cpu_base checks in
 hrtimer_grab_expiry_lock()

4.19 commit b1a471ec4df1 [hrtimer: Prevent using
hrtimer_grab_expiry_lock() on migration_base] removed the NULL checks
for timer->base and timer->base->cpu_base on the assumption that
they're always non-NULL.  That assumption is apparently not to be
true, so add the checks back.

Signed-off-by: Tom Zanussi <zanussi@kernel.org>
---
 kernel/time/hrtimer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index e54a95de8b79..6f20cf23008b 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -953,7 +953,7 @@ void hrtimer_grab_expiry_lock(const struct hrtimer *timer)
 {
 	struct hrtimer_clock_base *base = READ_ONCE(timer->base);
 
-	if (timer->is_soft && is_migration_base(base)) {
+	if (timer->is_soft && base && base->cpu_base && is_migration_base(base)) {
 		spin_lock(&base->cpu_base->softirq_expiry_lock);
 		spin_unlock(&base->cpu_base->softirq_expiry_lock);
 	}
-- 
2.17.1


> -- Steve

