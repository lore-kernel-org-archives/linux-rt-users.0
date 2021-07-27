Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 559CAC4338F
	for <linux-rt-users@archiver.kernel.org>; Tue, 27 Jul 2021 04:09:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B81960F58
	for <linux-rt-users@archiver.kernel.org>; Tue, 27 Jul 2021 04:09:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229552AbhG0EJ0 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 27 Jul 2021 00:09:26 -0400
Received: from mout.gmx.net ([212.227.15.19]:57851 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229487AbhG0EJX (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 27 Jul 2021 00:09:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1627358951;
        bh=MhHQxBPD0SkzIRhdLbh5noHSduvNM3ZHn/1tMVf1+Bk=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=XY1KPacLbaFyxoJ5Bl+TVdGTJRVtQ6bVAbdIWwq3JYRs/BXfTG/2FwE9QXnOKTIcU
         cgxkMuMsqu7jDMDc1Qrc7oVNjuD3dAXOF+Wa1jFfjKc5+dKbroGZ2gCfJ7pGmPd/D9
         O5jvsyZeTqw07N1YnBRKuJ2E93FsRhlxi33AL06w=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from homer.fritz.box ([185.146.48.197]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N3se2-1l8bG311rE-00zq8E; Tue, 27
 Jul 2021 06:09:11 +0200
Message-ID: <7970e9c3de5d29b93f692001a3796da1b3df45b4.camel@gmx.de>
Subject: Re: [rfc/patch] mm/slub: restore/expand unfreeze_partials() local
 exclusion scope
From:   Mike Galbraith <efault@gmx.de>
To:     Vlastimil Babka <vbabka@suse.cz>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     linux-rt-users@vger.kernel.org,
        Mel Gorman <mgorman@techsingularity.net>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Date:   Tue, 27 Jul 2021 06:09:10 +0200
In-Reply-To: <26c181c9-ec48-09e2-2d73-6fc769a19c76@suse.cz>
References: <87tul5p2fa.ffs@nanos.tec.linutronix.de>
         <8c0e0c486056b5185b58998f2cce62619ed3f05c.camel@gmx.de>
         <878s2fnv79.ffs@nanos.tec.linutronix.de>
         <6c0e20dd84084036d5068e445746c3ed7e82ec4b.camel@gmx.de>
         <7431ceb9761c566cf2d1f6f263247acd8d38c4b5.camel@gmx.de>
         <f9935c4c-078c-4b52-5297-64ee22272664@suse.cz>
         <f16b78bd3bb8fecf734017d40274e4c3294554ab.camel@gmx.de>
         <240f104fc6757d8c38fa01342511eda931632d5a.camel@gmx.de>
         <69da2ecd-a797-e264-fbfa-13108dc7a573@suse.cz>
         <84a7bd02cf109c6a5a8c7cc2bfc2898cb98270aa.camel@gmx.de>
         <5be1a703-9a0a-4115-1d69-634e5e8ecefd@suse.cz>
         <bd121f5db01404774dbecc70bd7155f8431d8046.camel@gmx.de>
         <76dedfc3-0497-1776-d006-486b9bfd88da@suse.cz>
         <72a045663bf8f091ae11dd328d5e085541d54fcd.camel@gmx.de>
         <18ca0ce9-3407-61e1-31d6-5c48e80eb5bb@suse.cz>
         <73f032c2-70f1-77b6-9fd2-9aca52fd5b4d@suse.cz>
         <b41fa4f2-8368-f33a-10c2-68554b16eb1e@suse.cz>
         <e3470ab357b48bccfbd1f5133b982178a7d2befb.camel@gmx.de>
         <26c181c9-ec48-09e2-2d73-6fc769a19c76@suse.cz>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.3 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Hj8IWfIhhUmfj4vfBhuyZsvrBFu4wH3QmEhDzZM7T8Ps93bZ4HU
 /Kbd01RDfUgp4lQHsyQuhthppWaZwa1t4ZPihJ0BhW9EyyC6NM0kIiWTvRbujkldnjXsGXp
 OAxzbqRIRmu9GWcSXzkA59avnuXuWRjgiaPGDlnjrOsppues6Wk+sW430XkSCMLD9scoz5w
 mC5yC6CmT2WTd9J4ogoLw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:RpUaWjk9VeI=:xSm55vdDtfkd+Z6bHnxsKs
 pg2tcbD8u5q+z0hHLPyFYRpkgN4CTx+Q1E4/sohjFCkT/64RYQYX2JfQNF56g8E4r6ZZm7vC6
 mAuV+zuJPcTbGJahPxKlxdyYDkCdzXZW/y6T/36ThcRee8U75Cs2QpOAhUL0scVlqSqSu514Z
 UM23R5Q0TZvnOaImPZkiT8QYIaqvLuWdW6MkYWN34fLZwqVepN/3PVGFjEoM7qUf07EQpSvoG
 BK9bhRvqALoDbrbL/URfkkCry4tKJnHcWTkn8TZGD86vy1lkrfH/GeSbqTvfDrdA5cWUhI6JD
 VPIFXi7SSjngwW4sICJWqzANfc0eF1b4BiapiKciXbI+dS/rGsKV6oPLiFIAKwv++zRg602uV
 PKadTOQoyPkX631ksshd/OiiwI3flrxZqjp5M40q7QdO5d06jxh5NnMF/cBbzo+8ggumF7PxJ
 PNvzukBHFEObvl1veMRVPbpdI4FYVm3PPpHVTsf9OLuRsod/hv2j8iMo7go6iN72VvxyCMx5N
 zh0Tlp4heMs0op9YbaGIoXj+57r0Ubp93vZg5Eu0SEIAWhoRnwYKSatqKuF4R6JPXWpEkO169
 xaz3Ex5VP0bDaACD2G3wV7Mks/SGtkRG7AQB8aUb9iMNNoWMyCWAkdTU4uHg7eTro6RAycSJa
 eY4DH8WuffZQPPZ4PzONV5d+WOBvcXNAsT2tB7d9ET2pwSH07v2SLqx4kD1Ksb5JM8gkx+g+N
 EC9TMHTlDQVhs2MqgQqIks92/gDbU4SI6WZZk6DRbcilyyzJktDit0451G8dS59/hWKMEDrsH
 dOwz3jMDF1QYbTnwByvLpqae4b8dl7NakcjmVE9K/1R2hn9HapkqFKIUth3af8GDGthiKCml6
 qAZOkpl+4/+M0BSIMjR81khgeARJZJ4BkBN28ize2mPYQ21bqI2vvCnAq6jR1wyJdIEpvgvbQ
 n+zlfqAdYhWXyoDt+U8sH/RIPYDmMNZB8QKAvi0Uv2pyAtyYDRDDNcfER0pAue+YZdklzqK0e
 ngLvpopCoW6WUF+a1P7a1unwmpPpyI4r1S/GhiGxx7ycroXgYMfEsn1VMXl5ljpI2dgR5qkgu
 GLCWeKX7rSXNmcTzY+vgO8OxBENjL+VQjs3
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Mon, 2021-07-26 at 23:26 +0200, Vlastimil Babka wrote:
> On 7/26/21 7:00 PM, Mike Galbraith wrote:
> >
> > Why not do something like the below?...
>
> Yep, sounds like a good approach, thanks. Percpu partial is not *the*
> SLUB fast path, so it should be sufficient without the lockless cmpxchg
> tricks. Will incorporate in updated series.

Great, my >=3D 5.13 trees will meanwhile wear it like so:

From: Vlastimil Babka <vbabka@suse.cz>
Date: Fri, 23 Jul 2021 23:17:18 +0200

mm, slub: Fix PREEMPT_RT plus SLUB_CPU_PARTIAL local exclusion

See https://lkml.org/lkml/2021/7/25/185

Mike: Remove ifdefs, make all configs take the straight line path layed
out for RT by Vlastimil in his prospective (now confirmed) fix.

Signed-off-by: Mike Galbraith <efault@gmx.de>
=2D--
 mm/slub.c |   79 ++++++++++++++++++++++++++++++++------------------------=
------
 1 file changed, 41 insertions(+), 38 deletions(-)

=2D-- a/mm/slub.c
+++ b/mm/slub.c
@@ -2437,13 +2437,12 @@ static void __unfreeze_partials(struct k
 static void unfreeze_partials(struct kmem_cache *s)
 {
 	struct page *partial_page;
+	unsigned long flags;

-	do {
-		partial_page =3D this_cpu_read(s->cpu_slab->partial);
-
-	} while (partial_page &&
-		 this_cpu_cmpxchg(s->cpu_slab->partial, partial_page, NULL)
-				  !=3D partial_page);
+	local_lock_irqsave(&s->cpu_slab->lock, flags);
+	partial_page =3D this_cpu_read(s->cpu_slab->partial);
+	this_cpu_write(s->cpu_slab->partial, NULL);
+	local_unlock_irqrestore(&s->cpu_slab->lock, flags);

 	if (partial_page)
 		__unfreeze_partials(s, partial_page);
@@ -2480,41 +2479,45 @@ static void put_cpu_partial(struct kmem_
 {
 #ifdef CONFIG_SLUB_CPU_PARTIAL
 	struct page *oldpage;
-	int pages;
-	int pobjects;
-
-	slub_get_cpu_ptr(s->cpu_slab);
-	do {
-		pages =3D 0;
-		pobjects =3D 0;
-		oldpage =3D this_cpu_read(s->cpu_slab->partial);
-
-		if (oldpage) {
-			pobjects =3D oldpage->pobjects;
-			pages =3D oldpage->pages;
-			if (drain && pobjects > slub_cpu_partial(s)) {
-				/*
-				 * partial array is full. Move the existing
-				 * set to the per node partial list.
-				 */
-				unfreeze_partials(s);
-				oldpage =3D NULL;
-				pobjects =3D 0;
-				pages =3D 0;
-				stat(s, CPU_PARTIAL_DRAIN);
-			}
+	struct page *page_to_unfreeze =3D NULL;
+	unsigned long flags;
+	int pages =3D 0, pobjects =3D 0;
+
+	local_lock_irqsave(&s->cpu_slab->lock, flags);
+
+	if (oldpage =3D this_cpu_read(s->cpu_slab->partial)) {
+		pobjects =3D oldpage->pobjects;
+		pages =3D oldpage->pages;
+		if (drain && pobjects > slub_cpu_partial(s)) {
+			/*
+			 * partial array is full. Move the existing
+			 * set to the per node partial list.
+			 *
+			 * Postpone unfreezing until we drop the local
+			 * lock to avoid an RT unlock/relock requirement
+			 * due to MEMCG __slab_free() recursion.
+			 */
+			page_to_unfreeze =3D oldpage;
+
+			oldpage =3D NULL;
+			pobjects =3D 0;
+			pages =3D 0;
+			stat(s, CPU_PARTIAL_DRAIN);
 		}
+	}
+
+	pages++;
+	pobjects +=3D page->objects - page->inuse;
+
+	page->pages =3D pages;
+	page->pobjects =3D pobjects;
+	page->next =3D oldpage;

-		pages++;
-		pobjects +=3D page->objects - page->inuse;
+	this_cpu_write(s->cpu_slab->partial, page);
+	local_unlock_irqrestore(&s->cpu_slab->lock, flags);

-		page->pages =3D pages;
-		page->pobjects =3D pobjects;
-		page->next =3D oldpage;
-
-	} while (this_cpu_cmpxchg(s->cpu_slab->partial, oldpage, page)
-								!=3D oldpage);
-	slub_put_cpu_ptr(s->cpu_slab);
+	if (page_to_unfreeze)
+		__unfreeze_partials(s, page_to_unfreeze);
 #endif	/* CONFIG_SLUB_CPU_PARTIAL */
 }



