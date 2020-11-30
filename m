Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D76B6C64E7B
	for <linux-rt-users@archiver.kernel.org>; Mon, 30 Nov 2020 13:21:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 79FCB206F9
	for <linux-rt-users@archiver.kernel.org>; Mon, 30 Nov 2020 13:21:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1uWmTfu4";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VEiRQK1o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726442AbgK3NU6 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 30 Nov 2020 08:20:58 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:48632 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726162AbgK3NU6 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 30 Nov 2020 08:20:58 -0500
Date:   Mon, 30 Nov 2020 14:20:14 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1606742416;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uFMc1nju8Vt+w/vefCY3bj1WY0IJrNxSDeMxCywROQg=;
        b=1uWmTfu4E+nW1ShlsxD9EkPl+HtTbSBaXRGNfYqW2y9EyghV7JUsbVjNZF15dUXCEttzV1
        pfOPiYaDf1CEwvcv+kqAmYmfcFrF287JLC+YT7XxeIXlku5VmpZTJNaFdtoDdtp0ir43Vb
        +U1zk6nHHmUjIL1Xkjg+WxxxgPhApKGAsa9dkDQGPvXraCQd9dcv3N7EQLE1tXKIdK9aZB
        e6CT95tMIJr4ZkD2F/eeOFPTg9rCTRJsSRopfXKVrUhnm9aa8IHxc8Q/8l6DG0zdc7Rpel
        0t65oJm9U6bwr4XfAHjlKrpeDe/ukeCZiFxw/5XyMM/4TdzblbAqKR0Wd3QPGQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1606742416;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uFMc1nju8Vt+w/vefCY3bj1WY0IJrNxSDeMxCywROQg=;
        b=VEiRQK1ouW5vtsrgyZZddGP84TQY04+uKfrJtsrO3P/CUbab6habOZQ14lnCtRu6k8CY+f
        B41PZuPoziCLTWBQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Mike Galbraith <efault@gmx.de>
Cc:     Oleksandr Natalenko <oleksandr@natalenko.name>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-rt-users@vger.kernel.org
Subject: Re: scheduling while atomic in z3fold
Message-ID: <20201130132014.mlvxeyiub3fpwyw7@linutronix.de>
References: <20201128140523.ovmqon5fjetvpby4@spock.localdomain>
 <20201128140924.iyqr2h52z2olt6zb@spock.localdomain>
 <20201128142723.zik6d5skvt3uwu5f@spock.localdomain>
 <15171df044b167351e7f6a688aabd71bade9ae2a.camel@gmx.de>
 <79ee43026efe5aaa560953ea8fe29a826ac4e855.camel@gmx.de>
 <f1c39a0504310a97e42b667fc4d458af4a86d97a.camel@gmx.de>
 <e38055ffe19751ba63f1c9beceae222438bcac59.camel@gmx.de>
 <20201129112922.db53kmtpu76xxukj@spock.localdomain>
 <90c4857c53b657147bfb71a281ece9839b0373c2.camel@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <90c4857c53b657147bfb71a281ece9839b0373c2.camel@gmx.de>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2020-11-29 12:41:14 [+0100], Mike Galbraith wrote:
> On Sun, 2020-11-29 at 12:29 +0100, Oleksandr Natalenko wrote:
> >
> > Ummm so do compressors explode under non-rt kernel in your tests as
> > well, or it is just -rt that triggers this?
> 
> I only tested a non-rt kernel with z3fold, which worked just fine.

I tried this and it did not not explode yet. Mike, can you please
confirm?

diff --git a/mm/z3fold.c b/mm/z3fold.c
index 18feaa0bc5377..0bf70f624a4bd 100644
--- a/mm/z3fold.c
+++ b/mm/z3fold.c
@@ -642,14 +642,17 @@ static inline void add_to_unbuddied(struct z3fold_pool *pool,
 {
 	if (zhdr->first_chunks == 0 || zhdr->last_chunks == 0 ||
 			zhdr->middle_chunks == 0) {
-		struct list_head *unbuddied = get_cpu_ptr(pool->unbuddied);
-
+		struct list_head *unbuddied;
 		int freechunks = num_free_chunks(zhdr);
+
+		migrate_disable();
+		unbuddied = this_cpu_ptr(pool->unbuddied);
+
 		spin_lock(&pool->lock);
 		list_add(&zhdr->buddy, &unbuddied[freechunks]);
 		spin_unlock(&pool->lock);
 		zhdr->cpu = smp_processor_id();
-		put_cpu_ptr(pool->unbuddied);
+		migrate_enable();
 	}
 }
 
@@ -887,7 +890,8 @@ static inline struct z3fold_header *__z3fold_alloc(struct z3fold_pool *pool,
 
 lookup:
 	/* First, try to find an unbuddied z3fold page. */
-	unbuddied = get_cpu_ptr(pool->unbuddied);
+	migrate_disable();
+	unbuddied = this_cpu_ptr(pool->unbuddied);
 	for_each_unbuddied_list(i, chunks) {
 		struct list_head *l = &unbuddied[i];
 
@@ -905,7 +909,7 @@ static inline struct z3fold_header *__z3fold_alloc(struct z3fold_pool *pool,
 		    !z3fold_page_trylock(zhdr)) {
 			spin_unlock(&pool->lock);
 			zhdr = NULL;
-			put_cpu_ptr(pool->unbuddied);
+			migrate_enable();
 			if (can_sleep)
 				cond_resched();
 			goto lookup;
@@ -919,7 +923,7 @@ static inline struct z3fold_header *__z3fold_alloc(struct z3fold_pool *pool,
 		    test_bit(PAGE_CLAIMED, &page->private)) {
 			z3fold_page_unlock(zhdr);
 			zhdr = NULL;
-			put_cpu_ptr(pool->unbuddied);
+			migrate_enable();
 			if (can_sleep)
 				cond_resched();
 			goto lookup;
@@ -934,7 +938,7 @@ static inline struct z3fold_header *__z3fold_alloc(struct z3fold_pool *pool,
 		kref_get(&zhdr->refcount);
 		break;
 	}
-	put_cpu_ptr(pool->unbuddied);
+	migrate_enable();
 
 	if (!zhdr) {
 		int cpu;
diff --git a/mm/zswap.c b/mm/zswap.c
index 78a20f7b00f2c..b24f761b9241c 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -394,7 +394,9 @@ struct zswap_comp {
 	u8 *dstmem;
 };
 
-static DEFINE_PER_CPU(struct zswap_comp, zswap_comp);
+static DEFINE_PER_CPU(struct zswap_comp, zswap_comp) = {
+	.lock = INIT_LOCAL_LOCK(lock),
+};
 
 static int zswap_dstmem_prepare(unsigned int cpu)
 {

> 	-Mike

Sebastian
