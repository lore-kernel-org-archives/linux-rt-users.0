Return-Path: <SRS0=JiWK=33=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81BBBC2D0B1
	for <linux-rt-users@archiver.kernel.org>; Fri,  7 Feb 2020 06:11:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5859520726
	for <linux-rt-users@archiver.kernel.org>; Fri,  7 Feb 2020 06:11:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="Cr+xk4aI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726915AbgBGGLp (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 7 Feb 2020 01:11:45 -0500
Received: from mout.gmx.net ([212.227.17.20]:54993 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726465AbgBGGLp (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 7 Feb 2020 01:11:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1581055868;
        bh=zwIJQyblkdT/B0XEpsgP9b14s8pW7hoPchmkjp0pJog=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=Cr+xk4aIfCE5u8B+OMGaeen7mySSNTDya/iGTqVjz9Yb77wXvlEPqz8bxuobUADi5
         FYfzk9nopFJdp7y7DGojcO+uj3631TsYfTTAT3af5N9OVF2iKFS/K1jQ0KHgmy4j+p
         VzTZk/ipCch+ZbLqchkDTLvYPH0esr8fZDeYhaVQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from homer.simpson.net ([185.191.217.186]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MMobU-1jGNFA1n6K-00ImZa; Fri, 07
 Feb 2020 07:11:08 +0100
Message-ID: <1581055866.25780.7.camel@gmx.de>
Subject: Re: [ANNOUNCE] v5.4.17-rt9
From:   Mike Galbraith <efault@gmx.de>
To:     Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Date:   Fri, 07 Feb 2020 07:11:06 +0100
In-Reply-To: <cda47e2f-fd9d-c4c8-7991-64fef38af0ef@ccrma.stanford.edu>
References: <20200204165811.imc5lvs3wt3soaw2@linutronix.de>
         <cda47e2f-fd9d-c4c8-7991-64fef38af0ef@ccrma.stanford.edu>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:uiGXE7JE7REaR6G8RTc5Vt0E/kd9fp46jPPnr9ZS6MUHoa/01rh
 h/F0boIJi4Ft0cu9kkRAMxLy+ZbXMcYYVkFUFwxjAi3YSPHw8MURU4ks/2a0kNEnuEMMyvt
 b+aMvohBQ/Dh96UREIuJ35ShjdLOps2LldBQBq/QT6l5JI3wCcg4c/wjGdzo/ex/ZqSirja
 Z26iSdFmNYb7fUntggUpQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:bsT713x8Zbc=:MTyFXxFFPf54WJ5sgG/6pl
 DUthVDAZ7TDZVasLHG05QRk1c6LXiwtn9DirQYHEDBKom7H4+/3h3kt2P2TDshbOTgd2gdYZA
 A6ycKC+jdMXGTmER51AidymMLeEj9HGQY+hqKF7Kei50eE6SrrKTv7N4lDnmfz4AKjR5iaRN0
 rxBKHsV44S1iYcMO6JORscgkCP0Bmtf5xr17CxRq20QBHjhKx/iD/enClwm9NaH5h8C9bHwnx
 Ld/JBRQMtCCiYXMOgcUmOkueDniW/2VBLjDHcV7QSthOOCPORQQZmp+/Mw7zJRLozXfcwJIoU
 9CdPYZpGukq7fKyhL8omj/HeUYhaN+rPnRWNnLgeczSrLlta3AWpa95hvn/PNxrVB0u1t5qiX
 w4LwdmoRL6qTdRgQ93COCSuW04M3P5OXZWb5gauwjLyzSrxdtQKj4eeBc6GZ5gUmOemLGErsD
 Og1UXL0I6E0akfWiQdASsqjGeAIQL5Dkn2J3QWgfu/BdgreAlsbUiAdnqUFvkz8ArtVn/B2rQ
 4tAxat+b1YPRSR4dOREnvfldALUddhar7mCEKo9sLPb2agqmh4zfxpeMjsfHUYjP9pHQehMnj
 nastD/f2pu3Bqzn4MM/Wb8NqePvwuofMPC4NdTQ6VOMloOr5zBsRi+1yiGE3jR6e/J0Q+QZXx
 6q/s/8Hu9aF8TwGCSTPV7qeTdz4xH8AVw5E7QCBCJOuHxORk2VVCOqTh4J5tEAcevVNBm/kJm
 9ERweNx25pukwAEqvos361AFGk//Mq0XKLw+9crh/k+5n4YYsiisL8m3BtQyuy19BFAMV5LyO
 klJe66QjV05b+xGasDnTxbriFQdN/Uk3lnnWlt3nd45W29V7ViR/eap288cn2JS66H9HZ2icg
 Z/MgRXdDno7wPLvg1fxWbHFIMyvc0PddHm56NInXVCzPkJV5pWNPfED4qyGtpA8VtQFIQBkij
 ETSjpbc9OFjNzw0ofGrmvzSf7UcQ/O2bDR2iSbaoZA6GYKm08DcOrFoQKq5j9Su5Fqm9VI6A5
 qstvx6fCx0fqsjm/EvODEH/avZgUJxx2LkMZZJhSftpvz/Jrroje0vyYdybbjzrk36cGCvtbe
 uKkUk3MaGrvpmkyh8HR/IVpFMY5MY8b4Gmo5aqeFfNwPgGlO21KAFkkhaZZkjGoNIO3oEANxm
 tFBmc8wgLcj/3pkuUmkDIwucA55U1X7emWsn+U2P4woGahs9p+nmdTuiXYXCWMj2TQJqvyHMT
 32wyeVSv82Pr5thFj
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Thu, 2020-02-06 at 15:59 -0800, Fernando Lopez-Lezcano wrote:
> On 2/4/20 8:58 AM, Sebastian Andrzej Siewior wrote:
> > Dear RT folks!
> >
> > I'm pleased to announce the v5.4.17-rt9 patch set.
>
> Thanks!
> I see a continuous stream of these:

(snips gripage)

Yup, d67739268cf0 annoys RT locking if lockdep is enabled.  The below
shut it up for my i915 equipped lappy.

drm/i915/gt: use a LOCAL_IRQ_LOCK in __timeline_mark_lock()

Quoting drm/i915/gt: Mark up the nested engine-pm timeline lock as irqsafe

    We use a fake timeline->mutex lock to reassure lockdep that the timeli=
ne
    is always locked when emitting requests. However, the use inside
    __engine_park() may be inside hardirq and so lockdep now complains abo=
ut
    the mixed irq-state of the nested locked. Disable irqs around the
    lockdep tracking to keep it happy.

This lockdep appeasement breaks RT because we take sleeping locks between
__timeline_mark_lock()/unlock().  Use a LOCAL_IRQ_LOCK instead.

Signed-off-by: Mike Galbraith <efaukt@gmx.de>
=2D--
 drivers/gpu/drm/i915/gt/intel_engine_pm.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

=2D-- a/drivers/gpu/drm/i915/gt/intel_engine_pm.c
+++ b/drivers/gpu/drm/i915/gt/intel_engine_pm.c
@@ -38,12 +38,15 @@ static int __engine_unpark(struct intel_
 }

 #if IS_ENABLED(CONFIG_LOCKDEP)
+#include <linux/locallock.h>
+
+static DEFINE_LOCAL_IRQ_LOCK(timeline_lock);

 static inline unsigned long __timeline_mark_lock(struct intel_context *ce=
)
 {
 	unsigned long flags;

-	local_irq_save(flags);
+	local_lock_irqsave(timeline_lock, flags);
 	mutex_acquire(&ce->timeline->mutex.dep_map, 2, 0, _THIS_IP_);

 	return flags;
@@ -53,7 +56,7 @@ static inline void __timeline_mark_unloc
 					  unsigned long flags)
 {
 	mutex_release(&ce->timeline->mutex.dep_map, 0, _THIS_IP_);
-	local_irq_restore(flags);
+	local_unlock_irqrestore(timeline_lock, flags);
 }

 #else

