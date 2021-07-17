Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0764DC636C9
	for <linux-rt-users@archiver.kernel.org>; Sat, 17 Jul 2021 14:58:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E55D06113D
	for <linux-rt-users@archiver.kernel.org>; Sat, 17 Jul 2021 14:58:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234744AbhGQPBQ (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Sat, 17 Jul 2021 11:01:16 -0400
Received: from mout.gmx.net ([212.227.15.18]:58481 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234437AbhGQPBP (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Sat, 17 Jul 2021 11:01:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1626533887;
        bh=04xoGtUfP29/HnxDxC9oJykIveZ1+k8cBhMNVT6MtnA=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=boJ9INB3hK9jxRM8kKULYOkkppcAutJZvlFu+fZQJ33ojalbkxCb7BKIAq1qVKB34
         NiaLXQCJdaS8HRmikJ1PpPXj3Xzvpj7mqbx1wpoSJM/MiVb8rOOXb9v1pYV3SU0seG
         nlW0qqd/orJE4/PfUAF9Sm3SgPHQLjVd56Y3p7WU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from homer.fritz.box ([185.191.217.205]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M2f5Z-1m7mIi08nH-004Am1; Sat, 17
 Jul 2021 16:58:07 +0200
Message-ID: <476d147ab6eec386a1e8b8e11cb09708377f8c3e.camel@gmx.de>
Subject: [patch] v2 mm/slub: restore/expand unfreeze_partials() local
 exclusion scope
From:   Mike Galbraith <efault@gmx.de>
To:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     linux-rt-users@vger.kernel.org,
        Mel Gorman <mgorman@techsingularity.net>,
        Vlastimil Babka <vbabka@suse.cz>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Date:   Sat, 17 Jul 2021 16:58:05 +0200
In-Reply-To: <7431ceb9761c566cf2d1f6f263247acd8d38c4b5.camel@gmx.de>
References: <87tul5p2fa.ffs@nanos.tec.linutronix.de>
         <8c0e0c486056b5185b58998f2cce62619ed3f05c.camel@gmx.de>
         <878s2fnv79.ffs@nanos.tec.linutronix.de>
         <6c0e20dd84084036d5068e445746c3ed7e82ec4b.camel@gmx.de>
         <7431ceb9761c566cf2d1f6f263247acd8d38c4b5.camel@gmx.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:JqZyItgw8KDovOoYnYJzQfp8No7m7bYMIvjYTMQ8MeqT813pU3k
 FxVWQb/WTVFjneXntlRXPBfL+DQhuwukZq2Pa9TnxASm6PFcz8yxL/rwk97Wwb6pKgaZbgP
 bT4+dPioWlXsW37owlHbRmdYyJbthERp3xM/I/ZwvmCC0Le8Eu1Nlz9bFxUly4vpXus02OO
 x8TGiFeXTzNxqdOsihOMg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:nBMkpUL43ZM=:coA3ZzRIYdbV3HCaiQDyaF
 S1iw0PmN27pSxgbCyYkFUAiOkly8NLJCnccNifZYauXdxFDuP9N8hRgT6bJCLzVnliAcNDwWo
 YvwxEW1AHPo+HZqvQvCUoFRQjuNO/pXhnk18mgt3bV2vITuHOWkfLnImxqRhulYJBap0JECVa
 loIL9YPZanh2BT++zjPwyk9EZ70JXPrM5v0nw/M/OolzuvBUIREZOKyrF8ZURG7bCFm/AvwMX
 G7sJ0uFqBSJZK6ag50ruv5nUWsQX5ehF+RweFin5Oz3iLggzTnV9ziV2kkcMkbbgC2hQMyZ+2
 boXQk3vTmpSkK/AdZH5mneRoWC99YueiyKE1vr1HkrGEstNVzL6xXuU+/Psq/RTJfNq08yXLq
 7WiPzc9kUoS264ldLUMkSpftzyo/3/0Gvu5iKWpohNOgSiWLz3lB6w+WbdP1/srkmrtAjCgY2
 gdWHRsnkFTgcQ9ZWUhnjSzzxwP+oIMZUrriNVTVmU4GeuaCm0J6jKTOk/joctgViWAWTAWJT8
 XTuMGUnu2MdEYIP5K6+jz5N8L7OZW1c/A5sGhr52/7ggUxDYN+g6wD98aIzQ2h+6IJGY8LqQK
 IUL53zMIPT/jlIlDTSYzKx40dy3Fhsn1AoUFL4WCHdwYmWUWnitjKHGeXGy1ODc7sEHcZDAjS
 LJ0ieH+A9EJ02LEFZ9/T3hnDtxx6iK4lyex9GBpWYqoSe2AbuG7CDjwzBplDuhTlxF99bvl9I
 SI1F7KIv7JxYNRcGUOug8tpIoCbIUIJ8o49uD1pmZfZs/sCFOq6Vhy/WmM5rEZyBFzF/CFsf8
 C/7pSyqBYR254IBTM3BjD9HuSpXutmSns5ci/IRqrWLmPrTmynSxEKbb6N89vIFZy6oU052Dq
 jI9lb053Hj61enyhlTpuyzTsdmTUm8E52jOpSSACCyPCmffIBGKJUlkI2yhUBLEgx4JEVWMZr
 ASx453dVMaM/my7hZc/BK0JycBopO4ZHtiFS69evAmDybMRdL/8hsW7TXIYT/go11wK5ekkLd
 2yNh0wCgZbLFaWmZuFJ+fZbQLORDzWK6835HKDZyOwZjRqRQpBarMP53PsZZsZCeTgF9hhGbF
 X9UiCWxDeFd9XON6BSc69b+n3py7mENZdoS
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Thu, 2021-07-15 at 18:34 +0200, Mike Galbraith wrote:
> Greetings crickets,
>
> Methinks he problem is the hole these patches opened only for RT.
>
> static void put_cpu_partial(struct kmem_cache *s, struct page *page,
> int drain)
> {
> #ifdef CONFIG_SLUB_CPU_PARTIAL
> 	struct page *oldpage;
> 	int pages;
> 	int pobjects;
>
> 	slub_get_cpu_ptr(s->cpu_slab);
>         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Bah, I'm tired of waiting to see what if anything mm folks do about
this little bugger, so I'm gonna step on it my damn self and be done
with it.  Fly or die little patchlet.

mm/slub: restore/expand unfreeze_partials() local exclusion scope

2180da7ea70a ("mm, slub: use migrate_disable() on PREEMPT_RT") replaced
preempt_disable() in put_cpu_partial() with migrate_disable(), which when
combined with ___slab_alloc() having become preemptibile, leads to
kmem_cache_free()/kfree() blowing through ___slab_alloc() unimpeded,
and vice versa, resulting in PREMPT_RT exclusive explosions in both
paths while stress testing with both SLUB_CPU_PARTIAL/MEMCG enabled,
___slab_alloc() during allocation (duh), and __unfreeze_partials()
during free, both while accessing an unmapped page->freelist.

Serialize put_cpu_partial()/unfreeze_partials() on cpu_slab->lock to
ensure that alloc/free paths cannot pluck cpu_slab->partial out from
underneath each other unconstrained.

Signed-off-by: Mike Galbraith <efault@gmx.de>
Fixes: 2180da7ea70a ("mm, slub: use migrate_disable() on PREEMPT_RT")
=2D--
 mm/slub.c |   23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

=2D-- a/mm/slub.c
+++ b/mm/slub.c
@@ -2418,6 +2418,17 @@ static void __unfreeze_partials(struct k
 	if (n)
 		spin_unlock_irqrestore(&n->list_lock, flags);

+	/*
+	 * If we got here via __slab_free() -> put_cpu_partial(),
+	 * memcg_free_page_obj_cgroups() ->kfree() may send us
+	 * back to __slab_free() -> put_cpu_partial() for an
+	 * unfortunate second encounter with cpu_slab->lock.
+	 */
+	if (IS_ENABLED(CONFIG_PREEMPT_RT) && memcg_kmem_enabled()) {
+		lockdep_assert_held(this_cpu_ptr(&s->cpu_slab->lock.lock));
+		local_unlock(&s->cpu_slab->lock);
+	}
+
 	while (discard_page) {
 		page =3D discard_page;
 		discard_page =3D discard_page->next;
@@ -2426,6 +2437,9 @@ static void __unfreeze_partials(struct k
 		discard_slab(s, page);
 		stat(s, FREE_SLAB);
 	}
+
+	if (IS_ENABLED(CONFIG_PREEMPT_RT) && memcg_kmem_enabled())
+		local_lock(&s->cpu_slab->lock);
 }

 /*
@@ -2497,7 +2511,9 @@ static void put_cpu_partial(struct kmem_
 				 * partial array is full. Move the existing
 				 * set to the per node partial list.
 				 */
+				local_lock(&s->cpu_slab->lock);
 				unfreeze_partials(s);
+				local_unlock(&s->cpu_slab->lock);
 				oldpage =3D NULL;
 				pobjects =3D 0;
 				pages =3D 0;
@@ -2579,7 +2595,9 @@ static void flush_cpu_slab(struct work_s
 	if (c->page)
 		flush_slab(s, c, true);

+	local_lock(&s->cpu_slab->lock);
 	unfreeze_partials(s);
+	local_unlock(&s->cpu_slab->lock);
 }

 static bool has_cpu_slab(int cpu, struct kmem_cache *s)
@@ -2632,8 +2650,11 @@ static int slub_cpu_dead(unsigned int cp
 	struct kmem_cache *s;

 	mutex_lock(&slab_mutex);
-	list_for_each_entry(s, &slab_caches, list)
+	list_for_each_entry(s, &slab_caches, list) {
+		local_lock(&s->cpu_slab->lock);
 		__flush_cpu_slab(s, cpu);
+		local_unlock(&s->cpu_slab->lock);
+	}
 	mutex_unlock(&slab_mutex);
 	return 0;
 }

