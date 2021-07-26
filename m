Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C86E7C432BE
	for <linux-rt-users@archiver.kernel.org>; Mon, 26 Jul 2021 17:09:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B4CBB6056B
	for <linux-rt-users@archiver.kernel.org>; Mon, 26 Jul 2021 17:09:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238231AbhGZQ25 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 26 Jul 2021 12:28:57 -0400
Received: from mout.gmx.net ([212.227.17.20]:52683 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234710AbhGZQUb (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 26 Jul 2021 12:20:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1627318847;
        bh=0SxYZ9wT6ladJ9R87jl1NWllejDr5OZ09zn9b56NtuQ=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=dVDtSMQlYampeLu0aD+eEPRup4rkeQCIxsuGcXSZBlFM3y+XbTJbK2UQ9hL9XPWNj
         YIgBDgzmQO3+Gf4du0MWH1wwl03oPHeYobSXhpSw+0xWflrO70+UPuur78Cfz5m3/P
         v16Zgk8coyo2iqj1oyauZWa0y+UBBRa7N5vkqH3k=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from homer.fritz.box ([185.146.48.197]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M7JzQ-1m0NON0AjE-007mnv; Mon, 26
 Jul 2021 19:00:47 +0200
Message-ID: <e3470ab357b48bccfbd1f5133b982178a7d2befb.camel@gmx.de>
Subject: Re: [rfc/patch] mm/slub: restore/expand unfreeze_partials() local
 exclusion scope
From:   Mike Galbraith <efault@gmx.de>
To:     Vlastimil Babka <vbabka@suse.cz>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     linux-rt-users@vger.kernel.org,
        Mel Gorman <mgorman@techsingularity.net>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Date:   Mon, 26 Jul 2021 19:00:46 +0200
In-Reply-To: <b41fa4f2-8368-f33a-10c2-68554b16eb1e@suse.cz>
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
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.2 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:dvVgq3aVm44fakY9w4eL+sR8QXpgDLIoXZTN4aoRXgT5i1+AXYw
 7G1SVtyekZIj0NDt7KSh9rAGANEHs1K/h6HX6VNYODlhOh1K1pyFuYDCicM5Dtket/q0tPo
 9M+srhRI5H0+RN/xOFkZNvZy0Mj428UXOmlv46Nz7aAxzE3u5hgEY3DZYgNa7g3M1dd8ENf
 bCBjNf8MEAxO4bF6JYU/Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:vNPyVG9MuB8=:xmAUsxEk9+HB3cTjopmywY
 OhnJpVMmQf+lktzozCBNlC8yJnCdss5YSvQLGY668njCxZRwovPn2twND5GWcA2uhRjER9bqN
 MrM/iQbVv9r8GQVPsE0Ag5Ezh+iGZQDU4NyExTwQ7FVzK/Sz4zgI8tVKmq8l9ieXI8ldAruEB
 m0JXIccmWnOaVknxpA3Hd02+kJiPCH4wmfxREGlqZAAizvrAmcmwE/pXQ7w5EgFjrY9w1m60k
 qRTK7uuEZtNXjevAWo8Es0qLtFlJ8Ppnq2mURTqGvUebQ66k8ScCGurXkn0nbJVH1gxOtRyUB
 JxR64S4/wuz3Wv2wMYx23fuLmBhS/3bTK2OK51z+NRDUkUq15Wfm3RqFwzgfDU9hOgG5aPz0i
 Z7maO3xPXGptx6K6Ug1/kCdR86huGDW8JF8glxK8INNzUpaJ9OpoDYzCIgo+VM2eTVvC65O8/
 DRKH5GGIAK5Xrzlo6YptBsbMtprxvhwWdbN28gtaJbUJgSXDG52o3MQfTb5IFT3sjSag3CCRl
 vv5bZs3ZP6QDFbyhmWQV4yqLD12fpAG6+CK8dvkPUOemE86o0ahp/hyUcSrZkRFlfb9Jha3U4
 zii8c3GGYDwd1cLqVzP4IbOCsqOXoh21rJLuqolcVlhCX3oFIj5DGK9biLW5HRydp3/uU6fZV
 DzhAy1I4b4kRFbeUlvNdpjUu1fSlFTBa3eWImaGAAHnmo0V8Xi8EEJx5NSf0fI3LSjXbVPnFP
 MCszQZMVK7yr7iIv2gxNJTi6weDIXLmkD/OY+u8nj153JPMnr4r2FEcPTRo4kfQzLGBmZRus3
 IcgUzthwDAV+5xWgQm2euKqRvpUeXrvVQ2ciFXc7HYLJjLS5XQ6x5X9oZGYo73Ay6YvphyESy
 V9H5NproQDv/xqkwxEs83YNPHMnVYK7EwVa7lsmEvFWJ9oQ86i98HRs8S5EAD430SsgKfBW7b
 M4hzot42Tr6KvX2jPKez/O14l2Smjsg/VSWeXRvFlZ1MhECRE4gJb7W65uuU8wpJSU9hPhN3x
 LZmvBDg4DT8CYmGX3KKxXDLi0PTL28J1iqSVk3/2tDFj/GhLskeLxHILt8HzbRw5cKQwQE900
 0jLQwk3BPCTU4OELGRFGLRmQuZNKHWxSLYx
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Sun, 2021-07-25 at 21:34 +0200, Vlastimil Babka wrote:
> On 7/25/21 9:12 PM, Vlastimil Babka wrote:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/*
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * On !RT we just want to d=
isable preemption, on RT we need
> > the lock
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * for real. This happens t=
o match local_lock() semantics.
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0local_lock(&s->cpu_slab->lo=
ck);
>
> OK I realized (and tglx confirmed) that this will blow up on !RT +
> lockdep if interrupted by ___slab_alloc() that will do
> local_lock_irqsave(). So back to #ifdefs it is. But should work as-is
> for RT testing.

Speaking of that local_lock_irqsave(), and some unloved ifdefs..

Why not do something like the below?  When I look at new_slab:, I see
cpu_slab->partial assignment protected by IRQs being disabled, which
implies to me it should probably be so protected everywhere.  There
used to be another slub_set_percpu_partial() call in
unfreeze_partials(), which was indeed called with IRQs disabled, quite
sane looking to an mm outsider looking in. The odd man out ->partial
assignment was the preempt disabled put_cpu_partial() cmpxchg loop,
which contained an IRQ disabled region to accommodate the
aforementioned unfreeze_partials().

Is there real world benefit to the cmpxchg loops whacked below (ala
monkey see monkey do) over everyone just taking the straight shot you
laid down for RT?  It's easier on the eye (mine anyway), and neither
PREEMPT or PREEMPT_RT seem inclined to complain... tick... tock...

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



