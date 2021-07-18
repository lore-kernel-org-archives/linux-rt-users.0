Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61155C636CA
	for <linux-rt-users@archiver.kernel.org>; Sun, 18 Jul 2021 21:19:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 39C0E61181
	for <linux-rt-users@archiver.kernel.org>; Sun, 18 Jul 2021 21:19:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231918AbhGRVWq (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Sun, 18 Jul 2021 17:22:46 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:45088 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbhGRVWp (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Sun, 18 Jul 2021 17:22:45 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id E3BA6220EA;
        Sun, 18 Jul 2021 21:19:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1626643185; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ExL8vB9Qx3eR5ggHERFJxosSa1ncV8PMZ+AT9hitkh8=;
        b=fKcI0WRaHFTw9riALTE2BpEB2w3q3zfYezTKbkNPbDbJrv7tPPVGE/CzAGjZNgUkwgAuks
        mdyz5MBWxusGICuSnMa21VpaSF6KAs/lJEU0ZCVTSXYd+yk9lxcp2AfCFkwGpkHajJKr/2
        IP7i4jSRawplENtecXh1v3uQ2mNuyY8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1626643185;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ExL8vB9Qx3eR5ggHERFJxosSa1ncV8PMZ+AT9hitkh8=;
        b=yuRnG/6SSGMdB8n64rHkLQVS2HmJkssdghXB9SYxYFQGQyYV2pNTQ+bNWiHrQznXoBvBuM
        epqulXGETKAC/XAg==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id B2F6F1332A;
        Sun, 18 Jul 2021 21:19:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id HF3nKfGa9GAeEgAAGKfGzw
        (envelope-from <vbabka@suse.cz>); Sun, 18 Jul 2021 21:19:45 +0000
Subject: Re: [patch] v2 mm/slub: restore/expand unfreeze_partials() local
 exclusion scope
To:     Mike Galbraith <efault@gmx.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     linux-rt-users@vger.kernel.org,
        Mel Gorman <mgorman@techsingularity.net>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
References: <87tul5p2fa.ffs@nanos.tec.linutronix.de>
 <8c0e0c486056b5185b58998f2cce62619ed3f05c.camel@gmx.de>
 <878s2fnv79.ffs@nanos.tec.linutronix.de>
 <6c0e20dd84084036d5068e445746c3ed7e82ec4b.camel@gmx.de>
 <7431ceb9761c566cf2d1f6f263247acd8d38c4b5.camel@gmx.de>
 <476d147ab6eec386a1e8b8e11cb09708377f8c3e.camel@gmx.de>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <dd10ebb3-7687-6e8d-8984-3dfb9cd0e927@suse.cz>
Date:   Sun, 18 Jul 2021 23:19:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <476d147ab6eec386a1e8b8e11cb09708377f8c3e.camel@gmx.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 7/17/21 4:58 PM, Mike Galbraith wrote:
> On Thu, 2021-07-15 at 18:34 +0200, Mike Galbraith wrote:
>> Greetings crickets,
>>
>> Methinks he problem is the hole these patches opened only for RT.
>>
>> static void put_cpu_partial(struct kmem_cache *s, struct page *page,
>> int drain)
>> {
>> #ifdef CONFIG_SLUB_CPU_PARTIAL
>> 	struct page *oldpage;
>> 	int pages;
>> 	int pobjects;
>>
>> 	slub_get_cpu_ptr(s->cpu_slab);
>>         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> 
> Bah, I'm tired of waiting to see what if anything mm folks do about
> this little bugger, so I'm gonna step on it my damn self and be done
> with it.  Fly or die little patchlet.
> 
> mm/slub: restore/expand unfreeze_partials() local exclusion scope
> 
> 2180da7ea70a ("mm, slub: use migrate_disable() on PREEMPT_RT") replaced
> preempt_disable() in put_cpu_partial() with migrate_disable(), which when
> combined with ___slab_alloc() having become preemptibile, leads to
> kmem_cache_free()/kfree() blowing through ___slab_alloc() unimpeded,
> and vice versa, resulting in PREMPT_RT exclusive explosions in both
> paths while stress testing with both SLUB_CPU_PARTIAL/MEMCG enabled,
> ___slab_alloc() during allocation (duh), and __unfreeze_partials()
> during free, both while accessing an unmapped page->freelist.
> 
> Serialize put_cpu_partial()/unfreeze_partials() on cpu_slab->lock to

Hm you mention put_cpu_partial() but your patch handles only the
unfreeze_partial() call from that function? If I understand the problem
correctly, all modifications of cpu_slab->partial has to be protected
on RT after the local_lock conversion, thus also the one that
put_cpu_partial() does by itself (via this_cpu_cmpxchg).

On the other hand the slub_cpu_dead() part should really be unnecessary,
as tglx pointed out.

How about the patch below? It handles also the recursion issue
differently by not locking around __unfreeze_partials().
If that works, I can think of making it less ugly :/

----8<----
diff --git a/mm/slub.c b/mm/slub.c
index 581004a5aca9..1c7a41460941 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -2437,6 +2437,9 @@ static void unfreeze_partials(struct kmem_cache *s)
 {
 	struct page *partial_page;
 
+#ifdef CONFIG_PREEMPT_RT
+	local_lock(&s->cpu_slab->lock);
+#endif
 	do {
 		partial_page = this_cpu_read(s->cpu_slab->partial);
 
@@ -2444,6 +2447,9 @@ static void unfreeze_partials(struct kmem_cache *s)
 		 this_cpu_cmpxchg(s->cpu_slab->partial, partial_page, NULL)
 				  != partial_page);
 
+#ifdef CONFIG_PREEMPT_RT
+	local_unlock(&s->cpu_slab->lock);
+#endif
 	if (partial_page)
 		__unfreeze_partials(s, partial_page);
 }
@@ -2482,7 +2488,11 @@ static void put_cpu_partial(struct kmem_cache *s, struct page *page, int drain)
 	int pages;
 	int pobjects;
 
-	slub_get_cpu_ptr(s->cpu_slab);
+#ifndef CONFIG_PREEMPT_RT
+	get_cpu_ptr(s->cpu_slab);
+#else
+	local_lock(&s->cpu_slab->lock);
+#endif
 	do {
 		pages = 0;
 		pobjects = 0;
@@ -2496,7 +2506,15 @@ static void put_cpu_partial(struct kmem_cache *s, struct page *page, int drain)
 				 * partial array is full. Move the existing
 				 * set to the per node partial list.
 				 */
+#ifndef CONFIG_PREEMPT_RT
 				unfreeze_partials(s);
+#else
+				this_cpu_write(s->cpu_slab->partial, NULL);
+				local_unlock(&s->cpu_slab->lock);
+				__unfreeze_partials(s, oldpage);
+				local_lock(&s->cpu_slab->lock);
+#endif
+
 				oldpage = NULL;
 				pobjects = 0;
 				pages = 0;
@@ -2513,7 +2531,11 @@ static void put_cpu_partial(struct kmem_cache *s, struct page *page, int drain)
 
 	} while (this_cpu_cmpxchg(s->cpu_slab->partial, oldpage, page)
 								!= oldpage);
-	slub_put_cpu_ptr(s->cpu_slab);
+#ifndef CONFIG_PREMPT_RT
+	put_cpu_ptr(s->cpu_slab);
+#else
+	local_unlock(&s->cpu_slab->lock);
+#endif
 #endif	/* CONFIG_SLUB_CPU_PARTIAL */
 }
 
