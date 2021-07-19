Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98C04C07E9B
	for <linux-rt-users@archiver.kernel.org>; Mon, 19 Jul 2021 13:16:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A61260FF4
	for <linux-rt-users@archiver.kernel.org>; Mon, 19 Jul 2021 13:16:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237222AbhGSMfS (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 19 Jul 2021 08:35:18 -0400
Received: from mout.gmx.net ([212.227.17.21]:35105 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237207AbhGSMfL (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 19 Jul 2021 08:35:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1626700539;
        bh=p2xXXdAMmzbgIPaaxiB1xHT4XsLBG7DJ30Cs+VWqgkg=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=StWYi3PtsP/2J0PIJInTgR0qTE7SLEq2ajC09YcjXoBg6tgZEhMZNAnpJOxLKOmSV
         lW1X0e+UxuU2RrZRmb2V24Ib9swV6kFAN7KEtuJ1zu2T+IzhIMciGllvrWh1Au/kSf
         7ncd9MStUXELBjvW+r8Ggy0bxlmFkdXNFLgVGx+A=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from homer.fritz.box ([185.191.216.243]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N7iCg-1l22Lh1Dmc-014mrL; Mon, 19
 Jul 2021 15:15:39 +0200
Message-ID: <b0932b75e4fda27504dcf4e7c028528fdf5e2ae6.camel@gmx.de>
Subject: Re: [patch] v2 mm/slub: restore/expand unfreeze_partials() local
 exclusion scope
From:   Mike Galbraith <efault@gmx.de>
To:     Vlastimil Babka <vbabka@suse.cz>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     linux-rt-users@vger.kernel.org,
        Mel Gorman <mgorman@techsingularity.net>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Date:   Mon, 19 Jul 2021 15:15:38 +0200
In-Reply-To: <00a7c04b109c01a7668abc2a8192a6b889765de5.camel@gmx.de>
References: <87tul5p2fa.ffs@nanos.tec.linutronix.de>
         <8c0e0c486056b5185b58998f2cce62619ed3f05c.camel@gmx.de>
         <878s2fnv79.ffs@nanos.tec.linutronix.de>
         <6c0e20dd84084036d5068e445746c3ed7e82ec4b.camel@gmx.de>
         <7431ceb9761c566cf2d1f6f263247acd8d38c4b5.camel@gmx.de>
         <476d147ab6eec386a1e8b8e11cb09708377f8c3e.camel@gmx.de>
         <dd10ebb3-7687-6e8d-8984-3dfb9cd0e927@suse.cz>
         <00a7c04b109c01a7668abc2a8192a6b889765de5.camel@gmx.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:4VFtE93I9WqMcaHAtufpgmGp5lnkwfEXXrKK82pxfBgQZ4s31Oi
 P6wEbuTwMQ+Mw/ml8x7O9oR5cdG94MYPY8eqELcJq4y8hVX7hNToXmfZkpc2uS9OB3/iTut
 Kq+HAjjLyiaH2IXK1CzLAeR8qBTYCL2/XbSj5pGcSy/v34XBPVbOJ4kWbvjep109pAowjj8
 WOilBQQBWCzEvBH+9algA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:6l3gLsmczn0=:swEmbUbB3ZOKPz/k25h1G1
 HpIbdT7DfC/jkq4MO8RVOz+2XX1wySQSrseNWRN9fsPrMJyoEO6hYfvaSEtQLB9pgdGHPQAbi
 fTNi1zXOwJMFHLcKdfB+fDP9aGADKHSd+1rWz2O7SWADwdGMXPJR5o0nq0dSsEXQYtck++YNV
 mqBlOjNOy/C45NQKDsc2onJdcMUMgsD3dVhfsvuko894qAyXbGhD3FARYQatv9XJNqIPOeXzE
 Z59H9LZJzeFEYjDoV/dOKn8TGKUapzo0A7rdpL/rGXDHeNok9CHD0TnSxX/5nh6/LFK5slbk8
 vlt/ZKW3iHGiuAwiCmxeU7R8zjewajfOYb/Irqky13OUQWmnXdpHzPM+DMVISCjU51h4LHUfo
 FyxWk5PpZCPkVeKsZuJhAT1KYP7KcLFhKhSaWF0B1H4buLX43m8PpqtwQyBUPy0uoD+eP7qob
 ZT0oHhhMpSKAjWmI8rlEt0POOtrOmW3gbN8xLDNX/2kh5fgOWZxCTAnROVcbMprAoaDLOcYhT
 3ZdKO2a5wSFlZF78TXvJPCMxeLq2zdcxkxCdLMncBuW8jCsZDTdUHq2ydUUfMtMvBdazxAax1
 /smEY31ay9qb5sL7vb8DaSYiuuJI6aIoToONpgp8BeAVc/bu23RFjCRDEjiRxxPGweNT3tE+3
 Y8alodyq+2d/t0pTAyBpBnsbuxBOwmzoQ7JqC7lULj7m/q4rDsZ6z4T1A6oPUzSp7E7xmPhr4
 xUtuESkPUsrYT9OdZBSGR0QgzmVcbiPn4o/QsJNuBvLH6Ec/4+PfwKPesPZgZ3p5BkbXj8hJd
 meJuEwX2oHdMeXS9XrtXmNLBIERSVdS+/rJ/AQPQObx4cP8OK7XYRXtN2SYZ8Zvur+Hn5dW8/
 yec9sJU6wvLOuK37r/tJOKfwFTwKqnin3zEwb4v0wFwtbL46hMbUj1kBG+zcAyVgHn0ABuoMC
 SXpQuBJaKJ9aEvpWrjpbfu5ZFm4x1H9gIn+y9XLsx+4WPZ5APUDGzfThSw05FnCrxeY1mQeT5
 +7uEE6RI1gaWLo1jjMCjEru3CwRDKhSKMZ7ApE8bzVxF68TAdx15XU+Zz7bsCcbG2XNnNLBfc
 e9Zy3/fGSPkrqPxLRWyKv1zR2kInzLHhwCo
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Mon, 2021-07-19 at 06:01 +0200, Mike Galbraith wrote:
>
> ... despite the unlock/relock in this patch, it still manages to be a
> -ENOBOOT.

The somewhat bent up half of your patch below has been chugging away
long enough for me to speculate that __slab_free() vs ___slab_alloc()
is the *only* player in the explosion varieties I've been seeing.

=2D--
 mm/slub.c |   13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

=2D-- a/mm/slub.c
+++ b/mm/slub.c
@@ -2484,6 +2484,9 @@ static void put_cpu_partial(struct kmem_
 	int pobjects;

 	slub_get_cpu_ptr(s->cpu_slab);
+	/* __slab_free() vs ___slab_alloc() critical sections */
+	if (IS_ENABLED(CONFIG_PREEMPT_RT) && drain)
+		local_lock(&s->cpu_slab->lock);
 	do {
 		pages =3D 0;
 		pobjects =3D 0;
@@ -2497,7 +2500,13 @@ static void put_cpu_partial(struct kmem_
 				 * partial array is full. Move the existing
 				 * set to the per node partial list.
 				 */
-				unfreeze_partials(s);
+				this_cpu_write(s->cpu_slab->partial, NULL);
+				if (IS_ENABLED(CONFIG_PREEMPT_RT) && drain)
+					local_unlock(&s->cpu_slab->lock);
+				__unfreeze_partials(s, oldpage);
+				if (IS_ENABLED(CONFIG_PREEMPT_RT) && drain)
+					local_lock(&s->cpu_slab->lock);
+
 				oldpage =3D NULL;
 				pobjects =3D 0;
 				pages =3D 0;
@@ -2514,6 +2523,8 @@ static void put_cpu_partial(struct kmem_

 	} while (this_cpu_cmpxchg(s->cpu_slab->partial, oldpage, page)
 								!=3D oldpage);
+	if (IS_ENABLED(CONFIG_PREEMPT_RT) && drain)
+		local_unlock(&s->cpu_slab->lock);
 	slub_put_cpu_ptr(s->cpu_slab);
 #endif	/* CONFIG_SLUB_CPU_PARTIAL */
 }

