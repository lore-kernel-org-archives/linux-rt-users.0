Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3E72C56202
	for <linux-rt-users@archiver.kernel.org>; Fri, 13 Nov 2020 20:14:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7FEAE22248
	for <linux-rt-users@archiver.kernel.org>; Fri, 13 Nov 2020 20:14:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="KUxgNVg/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726199AbgKMUOF (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 13 Nov 2020 15:14:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:53158 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725941AbgKMUOF (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 13 Nov 2020 15:14:05 -0500
Received: from tzanussi-mobl (c-73-209-127-30.hsd1.il.comcast.net [73.209.127.30])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0AE5D20691;
        Fri, 13 Nov 2020 20:14:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605298444;
        bh=UMAbEywhIQqdSqa/AWiBiV5Nj9uERyKhzGz5vxoQc+4=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=KUxgNVg/crICP2Yq7c0RZhk0mReYHGc8+FJiOhyQcrLrFqEjJwMt/MyjkEdD5yaDh
         qrJFi5o5ccXpBKyKVlv4HM5TB5svB4Q6ZEUtJaObDJMeDlCgvoQ3ikDFn8ldYmiIT6
         AC2N3Xgxbxkuht3v4WFRXTBdUk/mQyS+S17PoeMw=
Message-ID: <aa57c01bceaaac362d4da6e25427827fabe4d37a.camel@kernel.org>
Subject: Re: [PATCH RT 1/5] net: Properly annotate the try-lock for the
 seqlock
From:   Tom Zanussi <zanussi@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        John Kacur <jkacur@redhat.com>, Daniel Wagner <wagi@monom.org>,
        "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>,
        Mike Galbraith <efault@gmx.de>, stable-rt@vger.kernel.org
Date:   Fri, 13 Nov 2020 14:14:01 -0600
In-Reply-To: <617eb5e8478df466afa9013b02a2425f7c4c673f.camel@kernel.org>
References: <20201110153853.463368981@goodmis.org>
         <20201110154024.958923729@goodmis.org>
         <617eb5e8478df466afa9013b02a2425f7c4c673f.camel@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi Steve,

On Fri, 2020-11-13 at 11:06 -0600, Tom Zanussi wrote:
> Hi Steve,
> 
> On Tue, 2020-11-10 at 10:38 -0500, Steven Rostedt wrote:
> > 5.4.74-rt42-rc2 stable review patch.
> > If anyone has any objections, please let me know.
> > 
> > ------------------
> > 
> > From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> > 
> > In patch
> >    ("net/Qdisc: use a seqlock instead seqcount")
> > 
> > the seqcount has been replaced with a seqlock to allow to reader to
> > boost the preempted writer.
> > The try_write_seqlock() acquired the lock with a try-lock but the
> > seqcount annotation was "lock".
> > 
> > Opencode write_seqcount_t_begin() and use the try-lock annotation
> > for
> > lockdep.
> > 
> > Reported-by: Mike Galbraith <efault@gmx.de>
> > Cc: stable-rt@vger.kernel.org
> > Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> > Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> > ---
> >  include/linux/seqlock.h   |  9 ---------
> >  include/net/sch_generic.h | 10 +++++++++-
> >  2 files changed, 9 insertions(+), 10 deletions(-)
> > 
> > diff --git a/include/linux/seqlock.h b/include/linux/seqlock.h
> > index e5207897c33e..f390293974ea 100644
> > --- a/include/linux/seqlock.h
> > +++ b/include/linux/seqlock.h
> > @@ -489,15 +489,6 @@ static inline void write_seqlock(seqlock_t
> > *sl)
> >  	__raw_write_seqcount_begin(&sl->seqcount);
> >  }
> >  
> > -static inline int try_write_seqlock(seqlock_t *sl)
> > -{
> > -	if (spin_trylock(&sl->lock)) {
> > -		__raw_write_seqcount_begin(&sl->seqcount);
> > -		return 1;
> > -	}
> > -	return 0;
> > -}
> > -
> >  static inline void write_sequnlock(seqlock_t *sl)
> >  {
> >  	__raw_write_seqcount_end(&sl->seqcount);
> > diff --git a/include/net/sch_generic.h b/include/net/sch_generic.h
> > index e6afb4b9cede..112d2dca8b08 100644
> > --- a/include/net/sch_generic.h
> > +++ b/include/net/sch_generic.h
> > @@ -168,8 +168,16 @@ static inline bool qdisc_run_begin(struct
> > Qdisc
> > *qdisc)
> >  		return false;
> >  	}
> >  #ifdef CONFIG_PREEMPT_RT
> > -	if (try_write_seqlock(&qdisc->running))
> > +	if (spin_trylock(&qdisc->running.lock)) {
> > +		seqcount_t *s = &qdisc->running.seqcount;
> > +		/*
> > +		 * Variant of write_seqcount_t_begin() telling lockdep
> > that a
> > +		 * trylock was attempted.
> > +		 */
> > +		__raw_write_seqcount_begin(s);
> > +		seqcount_acquire(&s->dep_map, 0, 1, _RET_IP_);
> >  		return true;
> > +	}
> >  	return false;
> >  #else
> >  	/* Variant of write_seqcount_begin() telling lockdep a trylock
> 
> I applied this to 4.19 and saw some splat with my 'debug-full'
> configuration, so tried 5.4 and saw the same thing:
> 
> [   30.573698] BUG: workqueue leaked lock or atomic:
> kworker/1:4/0x00000000/143
>                     last function: wireless_nlevent_process
> [   30.573707] 1 lock held by kworker/1:4/143:
> [   30.573708]  #0: ffffffff8e981d80 (noop_qdisc.running#2){+.+.},
> at: __do_softirq+0xca/0x561
> [   30.573715] CPU: 1 PID: 143 Comm: kworker/1:4 Not tainted 5.4.74-
> rt42-rt-test-full-debug #1
> [   30.573716] Hardware name: LENOVO 4236L51/4236L51, BIOS 83ET59WW
> (1.29 ) 06/01/2011
> [   30.573720] Workqueue: events wireless_nlevent_process
> [   30.573721] Call Trace:
> [   30.573724]  dump_stack+0x71/0x9b
> [   30.573728]  process_one_work+0x533/0x760
> [   30.573731]  worker_thread+0x39/0x3f0
> [   30.573733]  ? process_one_work+0x760/0x760
> [   30.573734]  kthread+0x165/0x180
> [   30.573736]  ? __kthread_create_on_node+0x180/0x180
> [   30.573737]  ret_from_fork+0x3a/0x50
> [   30.629329] wlp3s0: authenticate with 84:1b:5e:41:5e:4d
> [   30.634864] wlp3s0: send auth to 84:1b:5e:41:5e:4d (try 1/3)
> [   30.638433] wlp3s0: authenticated
> [   30.642250] wlp3s0: associate with 84:1b:5e:41:5e:4d (try 1/3)
> [   30.645704] wlp3s0: RX AssocResp from 84:1b:5e:41:5e:4d
> (capab=0x411 status=0 aid=6)
> [   30.650803] wlp3s0: associated
> 
> [   30.656764] ================================================
> [   30.656765] WARNING: lock held when returning to user space!
> [   30.656766] 5.4.74-rt42-rt-test-full-debug #1 Not tainted
> [   30.656767] ------------------------------------------------
> [   30.656768] wpa_supplicant/836 is leaving the kernel with locks
> still held!
> [   30.656769] 1 lock held by wpa_supplicant/836:
> [   30.656770]  #0: ffff98f1c9622280 (&dev->qdisc_running_key){+.+.}, 
> at: packet_sendmsg+0xec1/0x1ad0
> 
> Let me know if you want me to send you my .config or the full output
> (a
> bunch more of the above).
> 
> Thanks,

This patch seems to fix it for me:

From 4855377d0cb34b1b67a5c6d84cc8609c9da0bc3e Mon Sep 17 00:00:00 2001
Message-Id: <4855377d0cb34b1b67a5c6d84cc8609c9da0bc3e.1605297603.git.zanussi@kernel.org>
From: Tom Zanussi <zanussi@kernel.org>
Date: Fri, 13 Nov 2020 13:04:15 -0600
Subject: [PATCH] net: Add missing __raw_write_seqcount_end() and
 seqcount_release()

The patch ('net: Properly annotate the try-lock for the seqlock") adds
__raw_write_seqcount_begin() in qdisc_run_begin() but omits the
corresponding __raw_write_seqcount_end() and seqcount_release() in
qdisc_run_end().

Add it unconditionally, since qdisc_run_end() is never called unless
qdisc_run_begin() succeeds, and if it succeeds,
__raw_write_seqcount_begin() seqcount_acquire() will have been called.

Signed-off-by: Tom Zanussi <zanussi@kernel.org>
---
 include/net/sch_generic.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/net/sch_generic.h b/include/net/sch_generic.h
index 112d2dca8b08..c5ccce4f8f62 100644
--- a/include/net/sch_generic.h
+++ b/include/net/sch_generic.h
@@ -192,7 +192,11 @@ static inline bool qdisc_run_begin(struct Qdisc *qdisc)
 static inline void qdisc_run_end(struct Qdisc *qdisc)
 {
 #ifdef CONFIG_PREEMPT_RT
+	seqcount_t *s = &qdisc->running.seqcount;
+
 	write_sequnlock(&qdisc->running);
+	__raw_write_seqcount_end(s);
+	seqcount_release(&s->dep_map, 1, _RET_IP_);
 #else
 	write_seqcount_end(&qdisc->running);
 #endif
-- 
2.17.1


