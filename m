Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74FA3C6377A
	for <linux-rt-users@archiver.kernel.org>; Wed, 21 Jul 2021 09:57:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 325616120C
	for <linux-rt-users@archiver.kernel.org>; Wed, 21 Jul 2021 09:57:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238131AbhGUJIk (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 21 Jul 2021 05:08:40 -0400
Received: from mout.gmx.net ([212.227.17.21]:36425 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237702AbhGUIxz (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 21 Jul 2021 04:53:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1626860022;
        bh=QmdL01pmor+IWHIS1CdJrkCqY7QNMbMK7ucbZiQKmUA=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=aR+cve4/BcjXKNZ/eG+ywb+m+Uogna4+tDky9euC2L+u3gLHb3Dh+KupyXSyMsyQI
         bK1TYa80bcpfus9oRRvziUsyfds3+xHiZ/pNH2X0Duuuvki00CugqxDwUA5bs4gmzC
         Wxa+WH0zVHbpZ34zSqjZlpZG38WYPosK981pSnio=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from homer.fritz.box ([185.221.150.108]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MJE27-1lppyn2519-00KhIV; Wed, 21
 Jul 2021 11:33:42 +0200
Message-ID: <84a7bd02cf109c6a5a8c7cc2bfc2898cb98270aa.camel@gmx.de>
Subject: Re: [rfc/patch] mm/slub: restore/expand unfreeze_partials() local
 exclusion scope
From:   Mike Galbraith <efault@gmx.de>
To:     Vlastimil Babka <vbabka@suse.cz>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     linux-rt-users@vger.kernel.org,
        Mel Gorman <mgorman@techsingularity.net>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Date:   Wed, 21 Jul 2021 11:33:41 +0200
In-Reply-To: <69da2ecd-a797-e264-fbfa-13108dc7a573@suse.cz>
References: <87tul5p2fa.ffs@nanos.tec.linutronix.de>
         <8c0e0c486056b5185b58998f2cce62619ed3f05c.camel@gmx.de>
         <878s2fnv79.ffs@nanos.tec.linutronix.de>
         <6c0e20dd84084036d5068e445746c3ed7e82ec4b.camel@gmx.de>
         <7431ceb9761c566cf2d1f6f263247acd8d38c4b5.camel@gmx.de>
         <f9935c4c-078c-4b52-5297-64ee22272664@suse.cz>
         <f16b78bd3bb8fecf734017d40274e4c3294554ab.camel@gmx.de>
         <240f104fc6757d8c38fa01342511eda931632d5a.camel@gmx.de>
         <69da2ecd-a797-e264-fbfa-13108dc7a573@suse.cz>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:fQhsIRfZyMUR0bUanRrqW8hhCOpgRPD8dle9Q68q3lM7dS0FWI1
 5IcWwp8mJ9CK/Vv4wC91fSJzoM0O87sbpQ2kaSrakjIqAIyMbHN/kzKGQUrpfMlljvG2CjA
 x1L3XtlzZpKEHs2bljTCwQGRB3Ekwv4xBQu21Er2V0VPlMg+WRSFU9IQg6IqRoBI+s2rFGg
 /kEnmPUhmN84FHZc7hexg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:jqP8deKCgRM=:aq7YJew0PGP5rDFc9bHRz8
 Go44LjP1SOq2qBay08tvODGaogRNgnV3aBaJm+RiiFwRITahmvZPf/x1/HIUcMP74ZND+56jG
 K6RXIR/UnB+jlDs4R7eJR3vgKY/3oTnaO53lTIJza6GrWpo56UBlogmZHmnjAEqbm+auKTi+x
 A5zdMneL9+1fpyzhEndadTedrwv/xG9ZpJRLA3PjAZGDqvjO0Z9kjqcuDHGS1XN+8/35rwgWY
 DnqQxSWtWaGmYLCKvKnsA4poV4GETkbtV2zMjhSguTU6v/WJOxIDwwiecsZ4+dHMByPygaDc9
 jBlY2QoBIxpAIPlx5DV5UxHcIbnrcUOjkt33MqwUrG0VIMkddzwTtpUJ/VD7IUNNhTRIAU3Ik
 AgYDP4vxSylCxLnpJGlWG9osLjnrjfiThtCRKSz+XAOwPswsJ1JDHVExaQatx+H15klKkSQrf
 +TfeWp86sXyRb96dFa6xIjaVj+zAfzk6OklOLv13/+4wtT7F0VHf6n06Q6IbIp1ex5ngNDHuO
 mM+Gntx2XL+ckUpOrv5DjYYhDTkZB55V69L/zrfNEMvpG4EWhMZE9wKYMecrHPHO6bsgDkSNw
 DCZM0heFPM5D8anTSwshmzJJbRzKQGKCjJLpxvqoZboqujI/d1mSLwzY613RQxGio+btUsj1I
 hXMkxyO6ovDjJpMgkN//OeY5gPXMOqWwOlFxlF4mZ6h5w4LTYOBBXksnwgg1A+TyZItAdboRo
 D9Cubu1Ah8idXP+nuvYEp9ro5Gp+rBNCm6f4NSYXajsWXHgHNy1otBndmX/PGVY/HgDG2ZwAH
 azGqm+nDA9fc1oJtW+/9KZ2a6UeqkiKmuY2fFpYim0x5PTV1Rmvn6vQtBXALi/I4kMAneGzq0
 0ZzR3ekpVKqcclDjfE+QURf5QsgU3le6/yaiwAbPGBE73dcNymHvTG5sp3asxuJAi/wQk5wMv
 wmCOm08IEfKyvBY+YuhZzh2KJrqBmOvkf3yFkCX5leEyswDUEgqCpTHyVmTC2HcMd+FH22DTp
 xK5VGpdx0cwQhJnIZcCZcynAdF+m0KiBMrCTsrVIAy5ieNKZKG77S9wfPbNbaH6Uf58Fittg5
 xaTwKKa6Wx7fph86hM3f1tOBKwqzorxORcI
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Wed, 2021-07-21 at 10:44 +0200, Vlastimil Babka wrote:
>
> So this doesn't look like our put_cpu_partial() preempted a
> __slab_alloc() on the same cpu, right?

No, likely it was the one preempted by someone long gone, but we'll
never know without setting a trap.

> BTW did my ugly patch work?

Nope.  I guess you missed my reporting it to have been a -ENOBOOT, and
that cutting it in half, ie snagging only __slab_free() does boot, and
seems to cure all of the RT fireworks.

(chainsaw noises...)

=2D--
 mm/slub.c |   12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

=2D-- a/mm/slub.c
+++ b/mm/slub.c
@@ -2551,6 +2551,8 @@ static void put_cpu_partial(struct kmem_
 	int pobjects;

 	slub_get_cpu_ptr(s->cpu_slab);
+	if (IS_ENABLED(CONFIG_PREEMPT_RT) && drain)
+		local_lock(&s->cpu_slab->lock);
 	do {
 		pages =3D 0;
 		pobjects =3D 0;
@@ -2564,7 +2566,13 @@ static void put_cpu_partial(struct kmem_
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
@@ -2581,6 +2589,8 @@ static void put_cpu_partial(struct kmem_

 	} while (this_cpu_cmpxchg(s->cpu_slab->partial, oldpage, page)
 								!=3D oldpage);
+	if (IS_ENABLED(CONFIG_PREEMPT_RT) && drain)
+		local_unlock(&s->cpu_slab->lock);
 	slub_put_cpu_ptr(s->cpu_slab);
 #endif	/* CONFIG_SLUB_CPU_PARTIAL */
 }


