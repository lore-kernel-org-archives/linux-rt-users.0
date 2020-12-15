Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F17F9C2BB40
	for <linux-rt-users@archiver.kernel.org>; Tue, 15 Dec 2020 03:23:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A298B224DE
	for <linux-rt-users@archiver.kernel.org>; Tue, 15 Dec 2020 03:23:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727363AbgLODWE (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 14 Dec 2020 22:22:04 -0500
Received: from mout.gmx.net ([212.227.15.19]:42695 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727517AbgLODV5 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 14 Dec 2020 22:21:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1608002367;
        bh=1R3VTzNtmLt4a1ey+tM18AI2OSxI2AuI9oIlNEoUEck=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=O2qngto/NvDxHYjS6dnNq0FqPELy2iatowwl4bnoKqOdx+ClIfoz2kOmO3/mrewco
         aJ6RaMg1uS7IZaCCZYo895KXn6/P6/2dGhSB0NaoIYnrG9DhfQ8rmeN3oHe+3o4Ln0
         9967gLaK0RQMAcrojnojamnrxCS74qjiNmw0p7mQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from homer.fritz.box ([185.191.217.61]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MmULr-1kOzZm2y37-00iSJG; Tue, 15
 Dec 2020 04:19:27 +0100
Message-ID: <6307cab9d73d88b16e1e87ddb273a7b27d3e51f6.camel@gmx.de>
Subject: Re: sched: exporting linux-rt migrate_disable for ZFS
From:   Mike Galbraith <efault@gmx.de>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Orivej Desh <c@orivej.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-rt-users@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Brian Behlendorf <behlendorf1@llnl.gov>
Date:   Tue, 15 Dec 2020 04:19:23 +0100
In-Reply-To: <20201214123302.w2bem7tlb664jdvx@linutronix.de>
References: <20201208212841.694b3022@orivej.orivej.org>
         <20201214123302.w2bem7tlb664jdvx@linutronix.de>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:yKjNETWY0HsaZY6T2BYLNDCWN9rc7CA0Ir+tsxvYfkwSRIj9we1
 lSqn8le7LxhHY1xMBgpOdVJNzqig9RMDeMeWQr+V0jWj+4C1Y2s366y1qTaWwK26fJaTJ9a
 qkHoHHQckM3ELhtsxYgteIbjhZ3GIdo18d03KkawLBSohNbTrGv3DhADpK5T+0pKHRWRy/x
 zB7p9RX7vgTpx4D1z/DBg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:okDZ+/oZF+8=:oYnUGi0+EsXs0GblwtEAPy
 6QauqZKM7GdFYoGaT/JSGLyGsacqVSKNMLSbnum75Eo0L2GEJIxFvFgqUsZTS3+3IV2yjjVad
 S0gBZ7HLwzbnWaN0AOSovdMkBHjQzsbIYP5qb29afRFSCTSOAUhSqH9h/7jBJ9eYRYTI1Yqp0
 n+sRScN8ZP00KphPqzVl6H7xNs9QQmHMDAkp0ohndpF3Fsb/8freO6f5elJUlTwBBitF+k8Sc
 ONLSgnBrYSjIlbXfmJv9xUkGBI4Ur7tahA+sMJFbmBcfiS4oq4GRp+E66mMPU4Og+dTKaWRGO
 YSQGS/8ZzkfqjaRAEqPG3bNeq2ri3ndQqAhOvlpJvh4dWlfeggMLXBtthJNQPVVN84rFDnGyL
 1FJnqjKohPCxg+nSLDd6cXtFDmmyhA2ODMcST1tCVTdmcn9hsMg929bRLHtRvCt3BJlofhk9i
 ixPu297u5yOXGp4FT2JFVr2QfNx/rGYcRGy6bsIVeUWlIm0lilVykaZ7ZThHsZoTXyw6b1Fml
 6bKbd3WOClbnOIYydlAfyeh71VnBJ1AECMpPCdtKWSDWRTQ5+LuW9wp36bN6oQR+fNycszbAO
 uCyCs9o66ZnfOLiRZMtVsaWPvJNC97UZ6ioeTgWC0s05UcHqij+9CN8X3CUm0gsA3kkWVMK87
 I6aAwZGtEWtJhdY8eLtotMv4rMSfkRYQPzyaq0S0rQ2FBdIsRfHpNJ72pZkX5hJuTqlzBrtrv
 WFMbOFInQEQm0j8i2G6jRd52Ag/ELPEGT4Ke35nT/yKZOayZ9Bgaw7SjV3E6JBK48G14Q26k0
 IpDZIj97QOHZ318WEo1Mkfd+Z83qkH07GDmJMFdIDSdXVaJbIqYAJqpXAoSoQiYRbuPYAFB6e
 NFnktWKWnrKGtWkhzdYw==
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Mon, 2020-12-14 at 13:33 +0100, Sebastian Andrzej Siewior wrote:
> On 2020-12-08 23:58:27 [+0000], Orivej Desh wrote:
> > Greetings!
> Hi,
>
> > With sched-Add-migrate_disable.patch first released in v5.9-rc8-rt14 [=
1]
> > linux-rt defines functions migrate_disable and migrate_enable.
> > They are used in linux headers in various macros and static inline
> > functions, and in particular in kmap_atomic and kunmap_atomic.
> > The latter are needed by ZFS which currently fails to build against
> > 5.9-rt [2] because these functions are exported with EXPORT_SYMBOL_GPL=
.
> > Could you export them with EXPORT_SYMBOL instead?
>
> This is out of my jurisdiction, so just a few notes:
> - v5.9 is out of maintenance. Be careful.
> - We don't export symbols for out-of-tree modules.

Hm, dejavu all over again.  I recall this issue long ago having been
resolved in favor of exporting via plain EXPORT_SYMBOL.

https://lore.kernel.org/linux-rt-users/1321359802.4181.1.camel@frodo/

=46rom 859a31c5ec958326dd046f4e41f6fa0db0ce98c3 Mon Sep 17 00:00:00 2001
From: Steven Rostedt <srostedt@redhat.com>
Date: Mon, 16 Apr 2012 21:51:54 -0400
Subject: rt: Make migrate_disable/enable() and __rt_mutex_init non-GPL onl=
y

Modules that load on the normal vanilla kernel should also load on
an -rt kernel as well. This does not mean we condone non-GPL modules,
we are only being consistent.

Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
=2D--
 kernel/rtmutex.c | 2 +-
 kernel/sched.c   | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/rtmutex.c b/kernel/rtmutex.c
index a02fbd9f9583..d58db993f5cd 100644
=2D-- a/kernel/rtmutex.c
+++ b/kernel/rtmutex.c
@@ -1282,7 +1282,7 @@ void __rt_mutex_init(struct rt_mutex *lock, const ch=
ar *name)

 	debug_rt_mutex_init(lock, name);
 }
-EXPORT_SYMBOL_GPL(__rt_mutex_init);
+EXPORT_SYMBOL(__rt_mutex_init);

 /**
  * rt_mutex_init_proxy_locked - initialize and lock a rt_mutex on behalf =
of a
diff --git a/kernel/sched.c b/kernel/sched.c
index df3048139d1b..ed3433573641 100644
=2D-- a/kernel/sched.c
+++ b/kernel/sched.c
@@ -4255,7 +4255,7 @@ void migrate_disable(void)
 	p->migrate_disable =3D 1;
 	preempt_enable();
 }
-EXPORT_SYMBOL_GPL(migrate_disable);
+EXPORT_SYMBOL(migrate_disable);

 void migrate_enable(void)
 {
@@ -4307,7 +4307,7 @@ void migrate_enable(void)
 	unpin_current_cpu();
 	preempt_enable();
 }
-EXPORT_SYMBOL_GPL(migrate_enable);
+EXPORT_SYMBOL(migrate_enable);
 #else
 static inline void update_migrate_disable(struct task_struct *p) { }
 #define migrate_disabled_updated(p)		0
=2D-
2.29.2


