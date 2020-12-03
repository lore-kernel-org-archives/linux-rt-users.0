Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E31FC71155
	for <linux-rt-users@archiver.kernel.org>; Thu,  3 Dec 2020 08:20:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B9B621527
	for <linux-rt-users@archiver.kernel.org>; Thu,  3 Dec 2020 08:20:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388354AbgLCIUa (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 3 Dec 2020 03:20:30 -0500
Received: from mout.gmx.net ([212.227.15.15]:38071 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388247AbgLCIUa (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 3 Dec 2020 03:20:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1606983503;
        bh=+mg95bL0eB1QM3vNqeKO61wWaQkqiUstVwa5YpwRRGo=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=VeSxLyfIY0H0JPcKgmQ5ZLpB7STufUn6B66XhSgKJ71wuAurRNXRXg7g9gbAy/b1u
         IxXmqfPAHswFGwZT73L2Hq8ZRG6Fvt+RyX1Fx5eBHJ6eIt+0PqA/tEZ9Pi8aB8+DAR
         CL2SE+FFpcLeWnZn/k2N1HHR4mWUydtuGc1Qmllg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from homer.fritz.box ([185.221.149.242]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MEV3I-1kwIHV1i2M-00Fz1B; Thu, 03
 Dec 2020 09:18:23 +0100
Message-ID: <64ab382309c41ca5c7a601fc3efbb6d2a6e68602.camel@gmx.de>
Subject: Re: scheduling while atomic in z3fold
From:   Mike Galbraith <efault@gmx.de>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Vitaly Wool <vitaly.wool@konsulko.com>
Cc:     Oleksandr Natalenko <oleksandr@natalenko.name>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-rt-users@vger.kernel.org
Date:   Thu, 03 Dec 2020 09:18:21 +0100
In-Reply-To: <abe48cb9ab522659a05d7e41ce07317da2a85163.camel@gmx.de>
References: <f1c39a0504310a97e42b667fc4d458af4a86d97a.camel@gmx.de>
         <e38055ffe19751ba63f1c9beceae222438bcac59.camel@gmx.de>
         <20201129112922.db53kmtpu76xxukj@spock.localdomain>
         <90c4857c53b657147bfb71a281ece9839b0373c2.camel@gmx.de>
         <20201130132014.mlvxeyiub3fpwyw7@linutronix.de>
         <856b5cc2a3d4eb673743b52956bf1e60dcdf87a1.camel@gmx.de>
         <20201130145229.mhbkrfuvyctniaxi@linutronix.de>
         <05121515e73891ceb9e5caf64b6111fc8ff43fab.camel@gmx.de>
         <20201130160327.ov32m4rapk4h432a@linutronix.de>
         <fca7ecadf1bddafb7e88cbeb4a57d1464c87b044.camel@gmx.de>
         <20201202220826.5chy56mbgvrwmg3d@linutronix.de>
         <abe48cb9ab522659a05d7e41ce07317da2a85163.camel@gmx.de>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:/IX7vUtk4rT5MqHxVvtHQ0lWlxEyiWzRjfnNmJ7bUptZZTISoAg
 O6a1AVKfK5ZxO7qugA6ryljYEUqAQq5TwUgdcGjSYsLe9nz0CzFt/nMM+9hJLXIDCx+27fJ
 uUP9UTabMGxbTxKfDEgFUU/ChTMkERwBuhM8W2uLQrgXGtRIgdngMXN3sMU1sy51arftOQs
 5IYNvFyW047nOePJiOT8g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:IF6acc0iF7Y=:zBvLRz5x4Ka+WeQg42f/QG
 Kf6rJ6b+fFD+lUhyL0oBdZSsI74V4natxuaKAmdcqGY5GVl0z5JxbNxvTwxFBAONKSd/6cURq
 06N8qbjyYBzwClqGdJDKi3SrpSXdnRVzEnpqzDX/DoAlSg0G2Bh5MgTd2LoQ0VlaMz+aoQgs6
 T69PT9wtmmnS26RgXHEbWTLflI/24IbwmX+m4go8sFVoxKoOl4IIfqtuNEx2p4mj+3SCap5y9
 0twXqU6P53r/3NmTBzqR1e7juv3vqwDshQ79HPiM9hNlkpIdauCMFYI2AFyEyXFRs6LJsXbSG
 215YZzOHY3JAKJYFARdqGiNzqBQTxwE1PzX6NOGA6Dja4ZN8EVPDdsFeiA4ChxlM2bczC+aVk
 piSIvIYM3fZglAdpY807Pj7ZnBSVvqQQ55Xb6IubitG1BPgLH1wOqhg6cyIrzm9i7vqAYIWZm
 C/FHUO2AgGn8I/Gtxt+O2MmutSu+e+dBT+dqnQekeRClrHiFtSl1TFXBWDMDS9dLuM7mexQLc
 62WSHQziY/EQe1Og+OY/sUjQzX9TvomcY+cJ1cfWd62by+SzISRBnSXMl2JGOptomhjIR3rBX
 1Bm/BNyeJcuZRVamU/YddjezINHkRVEXKbUZP3rDnKjh9DYsVMgD5BBcr7MGkT1D90S413bYz
 JnSAQsm0GjaraixUF7eqqy7RV+xis3f7KQrGfylXUfNLwpFoGST7RFzDg1suddjnZTB5TCMsU
 gdX2P82POeBzwZhYATwJDFOsDxYWhskBgTwlo+hy8o81CEED67lWBsOdgHz5LIcxui/dTkUvs
 MdUiG9Mo1H7m01+Q4/vqX01tIDsoX5tRu4MgaB4oTkav6Qmh/R/KrGo1PTcQdJr18rmLRyY2I
 FlSIyVvR/IeIjABH1bIw==
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Thu, 2020-12-03 at 03:16 +0100, Mike Galbraith wrote:
> On Wed, 2020-12-02 at 23:08 +0100, Sebastian Andrzej Siewior wrote:
> Looks like...
>
> d8f117abb380 z3fold: fix use-after-free when freeing handles
>
> ...wasn't completely effective...

The top two hunks seem to have rendered the thing RT tolerant.

diff --git a/mm/z3fold.c b/mm/z3fold.c
index 18feaa0bc537..851d9f4f1644 100644
=2D-- a/mm/z3fold.c
+++ b/mm/z3fold.c
@@ -537,7 +537,7 @@ static void __release_z3fold_page(struct z3fold_header=
 *zhdr, bool locked)
 	spin_unlock(&pool->lock);

 	/* If there are no foreign handles, free the handles array */
-	read_lock(&zhdr->slots->lock);
+	write_lock(&zhdr->slots->lock);
 	for (i =3D 0; i <=3D BUDDY_MASK; i++) {
 		if (zhdr->slots->slot[i]) {
 			is_free =3D false;
@@ -546,7 +546,7 @@ static void __release_z3fold_page(struct z3fold_header=
 *zhdr, bool locked)
 	}
 	if (!is_free)
 		set_bit(HANDLES_ORPHANED, &zhdr->slots->pool);
-	read_unlock(&zhdr->slots->lock);
+	write_unlock(&zhdr->slots->lock);

 	if (is_free)
 		kmem_cache_free(pool->c_handle, zhdr->slots);
@@ -642,14 +642,16 @@ static inline void add_to_unbuddied(struct z3fold_po=
ol *pool,
 {
 	if (zhdr->first_chunks =3D=3D 0 || zhdr->last_chunks =3D=3D 0 ||
 			zhdr->middle_chunks =3D=3D 0) {
-		struct list_head *unbuddied =3D get_cpu_ptr(pool->unbuddied);
-
+		struct list_head *unbuddied;
 		int freechunks =3D num_free_chunks(zhdr);
+
+		migrate_disable();
+		unbuddied =3D this_cpu_ptr(pool->unbuddied);
 		spin_lock(&pool->lock);
 		list_add(&zhdr->buddy, &unbuddied[freechunks]);
 		spin_unlock(&pool->lock);
 		zhdr->cpu =3D smp_processor_id();
-		put_cpu_ptr(pool->unbuddied);
+		migrate_enable();
 	}
 }

@@ -886,8 +888,9 @@ static inline struct z3fold_header *__z3fold_alloc(str=
uct z3fold_pool *pool,
 	int chunks =3D size_to_chunks(size), i;

 lookup:
+	migrate_disable();
 	/* First, try to find an unbuddied z3fold page. */
-	unbuddied =3D get_cpu_ptr(pool->unbuddied);
+	unbuddied =3D this_cpu_ptr(pool->unbuddied);
 	for_each_unbuddied_list(i, chunks) {
 		struct list_head *l =3D &unbuddied[i];

@@ -905,7 +908,7 @@ static inline struct z3fold_header *__z3fold_alloc(str=
uct z3fold_pool *pool,
 		    !z3fold_page_trylock(zhdr)) {
 			spin_unlock(&pool->lock);
 			zhdr =3D NULL;
-			put_cpu_ptr(pool->unbuddied);
+			migrate_enable();
 			if (can_sleep)
 				cond_resched();
 			goto lookup;
@@ -919,7 +922,7 @@ static inline struct z3fold_header *__z3fold_alloc(str=
uct z3fold_pool *pool,
 		    test_bit(PAGE_CLAIMED, &page->private)) {
 			z3fold_page_unlock(zhdr);
 			zhdr =3D NULL;
-			put_cpu_ptr(pool->unbuddied);
+			migrate_enable();
 			if (can_sleep)
 				cond_resched();
 			goto lookup;
@@ -934,7 +937,7 @@ static inline struct z3fold_header *__z3fold_alloc(str=
uct z3fold_pool *pool,
 		kref_get(&zhdr->refcount);
 		break;
 	}
-	put_cpu_ptr(pool->unbuddied);
+	migrate_enable();

 	if (!zhdr) {
 		int cpu;

