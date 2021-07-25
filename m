Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC47BC4338F
	for <linux-rt-users@archiver.kernel.org>; Sun, 25 Jul 2021 19:13:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B98CE608FE
	for <linux-rt-users@archiver.kernel.org>; Sun, 25 Jul 2021 19:13:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231391AbhGYScy (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Sun, 25 Jul 2021 14:32:54 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:57058 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231215AbhGYScx (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Sun, 25 Jul 2021 14:32:53 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 4963521EF9;
        Sun, 25 Jul 2021 19:13:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1627240402; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oCzLE+ap2mKmrXNTbUV0BiILf9trfJCBHHM1JEd+uDE=;
        b=vexRAjv4d7CgGQqib19vcceFhpEmaNw0VpYkuu3TUVvt5X5uk66XSGQboG3r6C6xMF3PKc
        9y32lkpGOBb87MNLGa85OxtoawGenBUhp0Kw4qN/WfI+/igvJNg7ghUpe7Lo7et2YqYuyQ
        RAPlEwBwwlqnWS4pnGcN4kj+yMpnkYE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1627240402;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oCzLE+ap2mKmrXNTbUV0BiILf9trfJCBHHM1JEd+uDE=;
        b=W9++s5wXbcaazYIEp16a5PjUjX8i7jesnXsQq1zn6+0WyiU7kAprOYDlY4QYtVHhM35bPm
        ob8jGWz25o7P6aBA==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 1CE4213277;
        Sun, 25 Jul 2021 19:13:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id yFPGBdK3/WBqNgAAGKfGzw
        (envelope-from <vbabka@suse.cz>); Sun, 25 Jul 2021 19:13:22 +0000
Subject: Re: [rfc/patch] mm/slub: restore/expand unfreeze_partials() local
 exclusion scope
From:   Vlastimil Babka <vbabka@suse.cz>
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
Message-ID: <73f032c2-70f1-77b6-9fd2-9aca52fd5b4d@suse.cz>
Date:   Sun, 25 Jul 2021 21:12:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <18ca0ce9-3407-61e1-31d6-5c48e80eb5bb@suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 7/25/21 6:27 PM, Vlastimil Babka wrote:
>>> Hope fixing that helps then?
>>
>> Yeah, though RT should perhaps be pinned across release/re-acquire?
> 
> Probably not necessary, this_cpu_cmpxchg() will effectively recognize
> being moved to a different CPU.
> Might also move __unfreeze_partials() out of the whole loop to avoid the
> relock. Yeah that should be better.
> 
>> Actually, local locks should rediscover the recursion handling skills
>> they long had so such RT specific hole poking isn't necessary.  There
>> previously would have been no ifdef+typo there for eyeballs to miss and
>> miss and miss.
> 
> Hm, now I'm realizing that local_lock() on !RT is just
> preempt_disable(), i.e. equivalent to get_cpu_ptr(), so some of the
> ifdeffery could go away?

How much will this explode? Thanks.

----8<----
From 99808b198bdf867951131bb9d1ca1bd1cd12b8c4 Mon Sep 17 00:00:00 2001
From: Vlastimil Babka <vbabka@suse.cz>
Date: Fri, 23 Jul 2021 23:17:18 +0200
Subject: [PATCH] PREEMPT_RT+SLUB_CPU_PARTIAL fix attempt

---
 mm/slub.c | 34 +++++++++++++++++++++++++++++++---
 1 file changed, 31 insertions(+), 3 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index 581004a5aca9..d12a50b5ee6f 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -2437,13 +2437,19 @@ static void unfreeze_partials(struct kmem_cache *s)
 {
 	struct page *partial_page;
 
+#ifndef CONFIG_PREEMPT_RT
 	do {
 		partial_page = this_cpu_read(s->cpu_slab->partial);
 
 	} while (partial_page &&
 		 this_cpu_cmpxchg(s->cpu_slab->partial, partial_page, NULL)
 				  != partial_page);
-
+#else
+	local_lock(&s->cpu_slab->lock);
+	partial_page = this_cpu_read(s->cpu_slab->partial);
+	this_cpu_write(s->cpu_slab->partial, NULL);
+	local_unlock(&s->cpu_slab->lock);
+#endif
 	if (partial_page)
 		__unfreeze_partials(s, partial_page);
 }
@@ -2479,10 +2485,15 @@ static void put_cpu_partial(struct kmem_cache *s, struct page *page, int drain)
 {
 #ifdef CONFIG_SLUB_CPU_PARTIAL
 	struct page *oldpage;
+	struct page *page_to_unfreeze = NULL;
 	int pages;
 	int pobjects;
 
-	slub_get_cpu_ptr(s->cpu_slab);
+	/*
+	 * On !RT we just want to disable preemption, on RT we need the lock
+	 * for real. This happens to match local_lock() semantics.
+	 */
+	local_lock(&s->cpu_slab->lock);
 	do {
 		pages = 0;
 		pobjects = 0;
@@ -2496,7 +2507,16 @@ static void put_cpu_partial(struct kmem_cache *s, struct page *page, int drain)
 				 * partial array is full. Move the existing
 				 * set to the per node partial list.
 				 */
+#ifndef CONFIG_PREEMPT_RT
 				unfreeze_partials(s);
+#else
+				/*
+				 * Postpone unfreezing until we drop the local
+				 * lock to avoid relocking.
+				 */
+				page_to_unfreeze = oldpage;
+#endif
+
 				oldpage = NULL;
 				pobjects = 0;
 				pages = 0;
@@ -2511,9 +2531,17 @@ static void put_cpu_partial(struct kmem_cache *s, struct page *page, int drain)
 		page->pobjects = pobjects;
 		page->next = oldpage;
 
+#ifndef CONFIG_PREEMPT_RT
 	} while (this_cpu_cmpxchg(s->cpu_slab->partial, oldpage, page)
 								!= oldpage);
-	slub_put_cpu_ptr(s->cpu_slab);
+#else
+		this_cpu_write(s->cpu_slab->partial, page);
+	} while (false);
+#endif
+
+	local_unlock(&s->cpu_slab->lock);
+	if (page_to_unfreeze)
+		__unfreeze_partials(s, page_to_unfreeze);
 #endif	/* CONFIG_SLUB_CPU_PARTIAL */
 }
 
-- 
2.32.0

