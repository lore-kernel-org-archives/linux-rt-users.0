Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60CA4C4338F
	for <linux-rt-users@archiver.kernel.org>; Sat, 14 Aug 2021 19:09:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 453BC60F21
	for <linux-rt-users@archiver.kernel.org>; Sat, 14 Aug 2021 19:09:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234517AbhHNTJ1 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Sat, 14 Aug 2021 15:09:27 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:37844 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbhHNTJ0 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Sat, 14 Aug 2021 15:09:26 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 58D391FDCE;
        Sat, 14 Aug 2021 19:08:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1628968136; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=127TjAPx8KQOwIpkvIdUi/9Nroy0dYk4GGz2yrb3uZ0=;
        b=FGBicascI1IKpUNA4S6XZfRZX0jlhyPmCUYzT2gNyDOCUhtuVBjs7veJGdATer9LsMUPA5
        a4IuNs8EqhWn7AhKNBj8Rd0cyoZOyfJTNiNn460syqFR+sFyLZ8+6hNVRWQc8w/bvyZBwn
        DDe9nsrhORGeDSVA6oejvSzTvltZeak=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1628968136;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=127TjAPx8KQOwIpkvIdUi/9Nroy0dYk4GGz2yrb3uZ0=;
        b=MLsg8OIU1bHUcslfIWhql2eSKPI3FG/n7BYgTCiylPTYw9vwrxi6+6zJGecefbKfxxOCT/
        cuYTiWp/THaKhfBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E682013D20;
        Sat, 14 Aug 2021 19:08:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id JPiPNMcUGGFWbAAAMHmgww
        (envelope-from <vbabka@suse.cz>); Sat, 14 Aug 2021 19:08:55 +0000
Subject: Re: [ANNOUNCE] v5.14-rc5-rt8
To:     Clark Williams <williams@redhat.com>,
        Mike Galbraith <efault@gmx.de>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        RT <linux-rt-users@vger.kernel.org>
References: <20210810163731.2qvfuhenolq2gdlv@linutronix.de>
 <20210812151803.52f84aaf@theseus.lan>
 <5f0c793d-5084-4607-8475-209fa7310ba2@suse.cz>
 <20210812162448.26274298@theseus.lan>
 <bb98b54c-6d88-2a56-4998-51a304c19e8c@suse.cz>
 <20210812164440.0426d8b7@theseus.lan>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <96ceab8e-4bf9-147a-e931-848676003c3f@suse.cz>
Date:   Sat, 14 Aug 2021 21:08:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210812164440.0426d8b7@theseus.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 8/12/21 11:44 PM, Clark Williams wrote:
> On Thu, 12 Aug 2021 23:30:29 +0200
> Vlastimil Babka <vbabka@suse.cz> wrote:
> 
>> On 8/12/21 11:24 PM, Clark Williams wrote:
>>> On Thu, 12 Aug 2021 22:45:19 +0200
>>> Vlastimil Babka <vbabka@suse.cz> wrote:
>>>   
>>>> On 8/12/21 10:18 PM, Clark Williams wrote:  
>>>>> On Tue, 10 Aug 2021 18:37:31 +0200
>>>>> Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:
>>>>>
>>>>> Sebastian, et al,
>>>>>
>>>>> Got the following panic running v5.14-rc5-rt8:
>>>>>
>>>>> Aug 13 06:35:05 oberon kernel: page:000000009ac5dd73 refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x1ab3db
>>>>> Aug 13 06:35:05 oberon kernel: flags: 0x17ffffc0000000(node=0|zone=2|lastcpupid=0x1fffff)
>>>>> Aug 13 06:35:05 oberon kernel: raw: 0017ffffc0000000 ffffee1286aceb88 ffffee1287b66288 0000000000000000
>>>>> Aug 13 06:35:05 oberon kernel: raw: 0000000000000000 0000000000100000 00000000ffffffff 0000000000000000
>>>>> Aug 13 06:35:05 oberon kernel: page dumped because: VM_BUG_ON_PAGE(!PageSlab(page))
>>>>> Aug 13 06:35:05 oberon kernel: ------------[ cut here ]------------
>>>>> Aug 13 06:35:05 oberon kernel: kernel BUG at include/linux/page-flags.h:814!
>>>>> Aug 13 06:35:05 oberon kernel: invalid opcode: 0000 [#1] PREEMPT_RT SMP PTI
>>>>> Aug 13 06:35:05 oberon kernel: CPU: 3 PID: 12345 Comm: hackbench Not tainted 5.14.0-rc5-rt8+ #12
>>>>> Aug 13 06:35:05 oberon kernel: Hardware name:  /NUC5i7RYB, BIOS RYBDWi35.86A.0359.2016.0906.1028 09/06/2016
>>>>> Aug 13 06:35:05 oberon kernel: RIP: 0010:___slab_alloc+0x340/0x940    
>>>>
>>>> Are you able to translate this RIP via addr2line?  
>>>
>>> $ addr2line -e /data/o/linux-5.14.y-rt/vmlinux ___slab_alloc+0x340/0x940
>>> <snip>/arch/x86/include/asm/processor.h:440  
>>
>> Hm that's not much useful, I'd need the line in mm/slub.c
>> does ./scripts/faddr2line give better output?
> 
> Why, yes it does!  :)
> 
> $ ./scripts/faddr2line /data/o/linux-5.14.y-rt/vmlinux ___slab_alloc+0x340/0x940
> ___slab_alloc+0x340/0x940:
> PageSlabPfmemalloc at include/linux/page-flags.h:814
> (inlined by) pfmemalloc_match at mm/slub.c:2772
> (inlined by) ___slab_alloc at mm/slub.c:2874

Aha! That's helpful. Hopefully it's just a small issue where we
opportunistically test flags on a page that's protected by the local
lock we didn't take yet, and I didn't realize there's the VM_BUG_ON
which can trigger if our page went away (which we would have realized
after taking the lock).

So hopefully the below diff with uninspired naming should help?

----8<----
diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index 5922031ffab6..24579f71001e 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -815,6 +815,11 @@ static inline int PageSlabPfmemalloc(struct page *page)
 	return PageActive(page);
 }
 
+static inline int __PageSlabPfmemalloc(struct page *page)
+{
+	return PageActive(page);
+}
+
 static inline void SetPageSlabPfmemalloc(struct page *page)
 {
 	VM_BUG_ON_PAGE(!PageSlab(page), page);
diff --git a/mm/slub.c b/mm/slub.c
index ef022fe159c6..3cc7d58a08fa 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -2775,6 +2775,14 @@ static inline bool pfmemalloc_match(struct page *page, gfp_t gfpflags)
 	return true;
 }
 
+static inline bool try_pfmemalloc_match(struct page *page, gfp_t gfpflags)
+{
+	if (unlikely(__PageSlabPfmemalloc(page)))
+		return gfp_pfmemalloc_allowed(gfpflags);
+
+	return true;
+}
+
 /*
  * Check the page->freelist of a page and either transfer the freelist to the
  * per cpu freelist or deactivate the page.
@@ -2871,7 +2879,7 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
 	 * PFMEMALLOC but right now, we are losing the pfmemalloc
 	 * information when the page leaves the per-cpu allocator
 	 */
-	if (unlikely(!pfmemalloc_match(page, gfpflags)))
+	if (unlikely(!try_pfmemalloc_match(page, gfpflags)))
 		goto deactivate_slab;
 
 	/* must check again c->page in case we got preempted and it changed */
