Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5100BC07E9C
	for <linux-rt-users@archiver.kernel.org>; Fri,  9 Jul 2021 05:20:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3060461363
	for <linux-rt-users@archiver.kernel.org>; Fri,  9 Jul 2021 05:20:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229742AbhGIFXh (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 9 Jul 2021 01:23:37 -0400
Received: from mout.gmx.net ([212.227.17.21]:49283 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229583AbhGIFXf (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 9 Jul 2021 01:23:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1625808049;
        bh=hFhzOqM1oYZNo+YO+moH8YhnNEBNxzGYyI3kJVIAr+A=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=O4rG9ozpC6hnRXD+/hx1neNcONRhSMRczcqJOdnGfyTY2rt2UOaY/12HBP67vI7Sx
         h5rGCPm2WMHeEg2U/Ew3fquX8gxDeKZkazaywp7C0lJZG99PYx+yBTJ7uFAIX6EOzD
         7MRKghFp+lBgApb8ra3jUiBTTYm9XSCRUc5ktBjY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from homer.fritz.box ([185.191.217.33]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M3DJl-1m2XMK1Ypp-003baI; Fri, 09
 Jul 2021 07:20:49 +0200
Message-ID: <b9b2dbb062bd25d9f6c0b918c3c834bc6964c2d6.camel@gmx.de>
Subject: [patch] mm/slub: Replace do_slab_free()
 local_lock_irqsave/restore() calls in PREEMPT_RT scope
From:   Mike Galbraith <efault@gmx.de>
To:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     linux-rt-users@vger.kernel.org,
        Mel Gorman <mgorman@techsingularity.net>,
        Vlastimil Babka <vbabka@suse.cz>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Date:   Fri, 09 Jul 2021 07:20:48 +0200
In-Reply-To: <87tul5p2fa.ffs@nanos.tec.linutronix.de>
References: <87tul5p2fa.ffs@nanos.tec.linutronix.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:01p2lwGVKz9WK7vvHBExumLJM56JpWoWlZFtXp4x2rx26ieP5h4
 3fDAMYrQbUQvyk9eY+lxfqCxiSUYWu8Zh4ag9V00FGHALFjKoMXIOBsjYfZZ17uGOXwd1Cz
 4BjJV01D8dUyk/mSBpmfh61pq0MSDcdZEx8U1qr+gzR5O7QVGwLj0+Oo/Bs/GLeH4DRa/VG
 rLBnpo0MbLlLUvRXOSl+w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:6t3MjBR812Y=:j3kXo/h4JNqEhxHGGUVphY
 v6dDHblihdFW0+HJHzuZaMzNgGsV3aOn5fB9VlrifpgBNgEg7gTKKf8LZOEtmItQzIRQGxu30
 7xr4P5+c5daUU3SOPTlrsiydqtNCE/Rm4n77rEcihJZZ23/ZKoyUaFDhiZu2fID9GBL1ZwvVE
 FScOnLQsEk3ctTdvcQi7lzx6qGHUAjgk2Wr4HKdprkvx3IwdmuuN3T3Yc782E+y27/I19ryKb
 ZHQVDMqFDxy1RI9T7KKvVKfiyqjeeK3/9Z2MiFQ9elyyvWHAtRKg+M9kk2jiUfBHHMJdXvdpt
 qPVwPN8Tv6gAXlU1AtT1mn55Hp37ExGLBKggeN8iOhcjtpGzuLEYnBl45cICSB5ReOSywkKhG
 XXqmCYTthHV9Eu2hawirr8W0dtnjYB4PG7mT6wYCkRsHk22cVMsFM7N2g8xSiQqg1kqw4ljpS
 znO6Z5VW58HHNIFp7qD6VCejeSoaaugFDX42FVSgMyUpRjJpLQ2ktDrUb1VKL3isHSzki3DYk
 VNCxOjl+EkZqpXBWv7ttgK1Vo3bnyFjb7HuqsSyKzKsIenimQHySJPwuRLqkYhoEMf/2A/T9K
 hwj88HA1MHeXer6nuRrtZoeU+cl2gkS7M6ruTc5Xc6AdHktdyO/3a423+aTO+HzelXG9kECSx
 4QFY50bA0IWeyrWICwKKFE/sxXOmT8UA5WlvJQh0VZEyTg1Bevxu7vuEfi612WWm51bxeZ1YB
 u4I0SNvk+YdPeoiarx7HLkU5A2+n7zyral8fff2LGXcnh2G+siqoNNFSMwVKz4UBuf2EexIak
 6YOW0/Oc+sCuSdXrLSs5gGtDvoxHXvTRqEA+5mSa86lWqm9b2lRCSDIdPuHiIqbdBwNdpm792
 GAavdseRWwzQbOKAsCkCrvyQheIT6CXnVb8nKQIQ8J6cFET+JM9/kkuTv80f2H1r9D7nHLt35
 rJVCK5db0wXED4Vsi14JOOzRN8RkHXNpOhRKtqC1wbG+0puhVcuaKg2RVEhmaMjErWArv6oTF
 EjFzsMdwATITYmbBjYZbDVVEi3gsX6iy3Be+wfPm+aXuJBSKtNtb+OujxF11BJna37K8l8tMR
 mKyucrrmIAttdK4atNv9H0HBPuUuxA1HtF+
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org


IRQ affecting local lock operations are intended for dual RT/!RT scope,
only affect IRQs in !RT scope.  Replace misplaced do_slab_free() calls
with plain local_lock()/local_unlock().  Purely cosmetic.

Signed-off-by: Mike Galbraith <efault@gmx.de>
=2D--
 mm/slub.c |    7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

=2D-- a/mm/slub.c
+++ b/mm/slub.c
@@ -3362,13 +3362,12 @@ static __always_inline void do_slab_free
 		 * we need to take the local_lock. We shouldn't simply defer to
 		 * __slab_free() as that wouldn't use the cpu freelist at all.
 		 */
-		unsigned long flags;
 		void **freelist;

-		local_lock_irqsave(&s->cpu_slab->lock, flags);
+		local_lock(&s->cpu_slab->lock);
 		c =3D this_cpu_ptr(s->cpu_slab);
 		if (unlikely(page !=3D c->page)) {
-			local_unlock_irqrestore(&s->cpu_slab->lock, flags);
+			local_unlock(&s->cpu_slab->lock);
 			goto redo;
 		}
 		tid =3D c->tid;
@@ -3378,7 +3377,7 @@ static __always_inline void do_slab_free
 		c->freelist =3D head;
 		c->tid =3D next_tid(tid);

-		local_unlock_irqrestore(&s->cpu_slab->lock, flags);
+		local_unlock(&s->cpu_slab->lock);
 #endif
 		stat(s, FREE_FASTPATH);
 	} else

