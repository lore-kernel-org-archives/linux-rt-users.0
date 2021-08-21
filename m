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
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDD98C4338F
	for <linux-rt-users@archiver.kernel.org>; Sat, 21 Aug 2021 06:49:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C84560FF2
	for <linux-rt-users@archiver.kernel.org>; Sat, 21 Aug 2021 06:49:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232005AbhHUGto (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Sat, 21 Aug 2021 02:49:44 -0400
Received: from mout.gmx.net ([212.227.17.22]:47801 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231666AbhHUGto (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Sat, 21 Aug 2021 02:49:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1629528531;
        bh=3Hi+jZkTgBxxdvwosQIWwN4GaVtWC2NcWXDQ9Hx7BIw=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date;
        b=HiF+qPlLgofw/m4hn9OJArxIkovEoDaAT9hXZTP+B4tnZbGDlyu69cjvxKyMF4LB0
         x9XUghkHE+BQF2tQF92bBmwTrC2cV8Y6o82n2K1Dul03jHDso4ipDp3q36qbWthJI0
         cqI7ESN96AjqOeG3cp06G/P6pFM3/cpbbkSa8ACM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from homer.fritz.box ([185.146.51.70]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mjj87-1mkaxk0ZH1-00lDfO; Sat, 21
 Aug 2021 08:48:51 +0200
Message-ID: <213cb4097c80dac762f597bbba5540757dc9db71.camel@gmx.de>
Subject: [patch] kasan: Make it RT aware
From:   Mike Galbraith <efault@gmx.de>
To:     linux-rt-users <linux-rt-users@vger.kernel.org>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>
Date:   Sat, 21 Aug 2021 08:48:50 +0200
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.3 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:qSaJlMQhz/lqRNoxbOgmoFKmchnCpB6Nb2q8uTaRpMc0wTK6UrE
 w+6S1z3hJFeZZkP4ePB0uGaE0UIJMRkFi02VAeRa/0QtYaJzzjDiZaFybLEgKAFUEh6tDnt
 0CvaupNFHWuw02jhwwaw+/U7jGa5a+wQBf9imb9UAKTPQF+Drqc4z4SHqD3pGnaPXxQ409T
 QBKz4/5sFn1NJXoWoN9/A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:iOB6YCB1wZ0=:BBq8vdk8J8yTs4gyeckKRp
 cYyZ2NUImJHan1a2WoCCSgjXiwmJXbD88BmtoXkfv7or950oe8tGZseuuu4jPQQjp1qBUEDGi
 vg6vJle69FkqUi3wymsJnnhqfZKztFgtdw+CMiPcsE+f3SeOyLBV9qQ2VA4Elut39daieiehO
 7zG5fhTMbfR4rzrvDQVwAytY5Vh+xSVln7zcZKAin2cUUBWExmtGDQOHrLu/HOphX1wuZaJWg
 i4WKlLt3QEiSlztmetR4UVPMsYkvCrf0gY4ZeSw4kfzviNT1fp3Vpt7ooJFDjo+uEyRCHSlMl
 xXf58b/yIg9Ls7LcokqSv8knTLKwqFIo9/r8t23JXbpAumS4L7mnvKOaerSP0DV1/o+1nr+jA
 DTnlGPNNl5EhI1+W8cIIz/eked480fzwgAcl6wGmGBLgPsZ98M+RLuWDgk9Krpgy8HF1gAlp7
 kX2SZV++lsExtHbe0wFAfnqin+rkPgZaW6YDkJ06eGVqRcP+dUvGRaS2YeHTelX1+UUAkQycL
 DKjHrsVzIAFBPabrlvwWVvr5/dfxYdy1t0IZBuxdRuqswMrqbg0cK0ECXg0cHDcCuSafcucoY
 iE2aaqnidbTYP5T2biIpqIxJd/qmQo9zgu4ggXf1SWrGaayr2oohWliBSIP6+Mh3X/BwO0STx
 yqBHMoQuwuuxFJdeuBjDzRTRu0nvwplm7iUuuFKpNzMReao6/BMeqi/NFv2REknhEsM6e3r12
 eM6wkK1fIdjI4rPBPSYctKzxMewO6EGrZ31HnNmGRfCEP6t0af17lbsHf+3mnamm+pg60HHrg
 oQJ35NVVc/LPay8r3msWH/58nS+mzv0v/UA2Ail0TruTvgwQ9aRdzS9IcK2KlME7MtyGVSEqm
 jWK/dP7bG/J5UDiv5/Tq4XqokbgA0/0gIdoGUpL3SNXuy3YuLXW2tKpLQwtaIzVYbxu6UToDE
 2x6Jwt6ryJz4FNWv1i7X8pzzKsw5w21Rqbe56Fn+mt4E6+vJ4J808qZLtQwr3zRBD/kwG3a0d
 QI257nM9a27c/sw/axUNRvKSjO526nSAPGAS7plFWttaiZCGFRTWxNxVvZA4wxNzKonc3/e16
 +rviGEM/vEC9u+QRRaPsq/DhSG2RZbufooJ
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org


Skip preallocation when not possible for RT, and move cache removal
from IPI, where freeing is not possible for RT, to synchronous work.

Signed-off-by: Mike Galbraith <efault@gmx.de>
=2D--
 lib/stackdepot.c      |    4 ++--
 mm/kasan/quarantine.c |   49 ++++++++++++++++++++++++++++++++++++++++++++=
+++++
 2 files changed, 51 insertions(+), 2 deletions(-)

=2D-- a/lib/stackdepot.c
+++ b/lib/stackdepot.c
@@ -265,7 +265,7 @@ depot_stack_handle_t stack_depot_save(un
 	struct page *page =3D NULL;
 	void *prealloc =3D NULL;
 	unsigned long flags;
-	u32 hash;
+	u32 hash, may_prealloc =3D !IS_ENABLED(CONFIG_PREEMPT_RT) || preemptible=
();

 	if (unlikely(nr_entries =3D=3D 0) || stack_depot_disable)
 		goto fast_exit;
@@ -291,7 +291,7 @@ depot_stack_handle_t stack_depot_save(un
 	 * The smp_load_acquire() here pairs with smp_store_release() to
 	 * |next_slab_inited| in depot_alloc_stack() and init_stack_slab().
 	 */
-	if (unlikely(!smp_load_acquire(&next_slab_inited))) {
+	if (unlikely(!smp_load_acquire(&next_slab_inited) && may_prealloc)) {
 		/*
 		 * Zero out zone modifiers, as we don't have specific zone
 		 * requirements. Keep the flags related to allocation in atomic
=2D-- a/mm/kasan/quarantine.c
+++ b/mm/kasan/quarantine.c
@@ -19,6 +19,9 @@
 #include <linux/srcu.h>
 #include <linux/string.h>
 #include <linux/types.h>
+#include <linux/cpu.h>
+#include <linux/mutex.h>
+#include <linux/workqueue.h>
 #include <linux/cpuhotplug.h>

 #include "../slab.h"
@@ -308,6 +311,48 @@ static void per_cpu_remove_cache(void *a
 	qlist_free_all(&to_free, cache);
 }

+#ifdef CONFIG_PREEMPT_RT
+struct remove_cache_work {
+	struct work_struct work;
+	struct kmem_cache *cache;
+};
+
+static DEFINE_MUTEX(remove_caches_lock);
+static DEFINE_PER_CPU(struct remove_cache_work, remove_cache_work);
+
+static void per_cpu_remove_cache_work(struct work_struct *w)
+{
+	struct remove_cache_work *rcw;
+
+	rcw =3D container_of(w, struct remove_cache_work, work);
+	per_cpu_remove_cache(rcw->cache);
+}
+
+static void per_cpu_remove_caches_sync(struct kmem_cache *cache)
+{
+	struct remove_cache_work *rcw;
+	unsigned int cpu;
+
+	cpus_read_lock();
+	mutex_lock(&remove_caches_lock);
+
+	for_each_online_cpu(cpu) {
+		rcw =3D &per_cpu(remove_cache_work, cpu);
+		INIT_WORK(&rcw->work, per_cpu_remove_cache_work);
+		rcw->cache =3D cache;
+		schedule_work_on(cpu, &rcw->work);
+	}
+
+	for_each_online_cpu(cpu) {
+		rcw =3D &per_cpu(remove_cache_work, cpu);
+		flush_work(&rcw->work);
+	}
+
+	mutex_unlock(&remove_caches_lock);
+	cpus_read_unlock();
+}
+#endif
+
 /* Free all quarantined objects belonging to cache. */
 void kasan_quarantine_remove_cache(struct kmem_cache *cache)
 {
@@ -321,7 +366,11 @@ void kasan_quarantine_remove_cache(struc
 	 * achieves the first goal, while synchronize_srcu() achieves the
 	 * second.
 	 */
+#ifndef CONFIG_PREEMPT_RT
 	on_each_cpu(per_cpu_remove_cache, cache, 1);
+#else
+	per_cpu_remove_caches_sync(cache);
+#endif

 	raw_spin_lock_irqsave(&quarantine_lock, flags);
 	for (i =3D 0; i < QUARANTINE_BATCHES; i++) {


