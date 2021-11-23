Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66C9BC433F5
	for <linux-rt-users@archiver.kernel.org>; Tue, 23 Nov 2021 14:41:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237703AbhKWOor (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 23 Nov 2021 09:44:47 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:46538 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234213AbhKWOoq (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 23 Nov 2021 09:44:46 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id A0D191FD58;
        Tue, 23 Nov 2021 14:41:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1637678497; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=u/cQOmDsMGE1zNrUjACvW9ixb6i/exjodJj6jtugNWI=;
        b=OpbQEPzqIVvXAGfdrUbyl1dJujqOU7fR3U4JKpY9vk6dFlqUbbCZNB70DOX0gBVE/IPnkW
        WVH4dJmpCSc58H/E1Ty64k5O6CJm+q5myehwoOXObq31bBE5Y8+EyNyxu0gorpO4uBQxTk
        oE5+Os0AdFL9ko9DFxBUVZ56Le/09cc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1637678497;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=u/cQOmDsMGE1zNrUjACvW9ixb6i/exjodJj6jtugNWI=;
        b=7sCsD+/K+bwuSA32KAhvAi0K1tQ0g1AukGQr9v4WaH02jzgq0w/32frWrW9ub6JKaAdAAC
        QiXssFwz5ndzUrBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6880513E20;
        Tue, 23 Nov 2021 14:41:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id NF3bGKH9nGEhMwAAMHmgww
        (envelope-from <vbabka@suse.cz>); Tue, 23 Nov 2021 14:41:37 +0000
Message-ID: <51e45c99-1ad8-339b-0c6a-e88288fa41ba@suse.cz>
Date:   Tue, 23 Nov 2021 15:41:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH v2 1/3] mm/page_alloc: Don't pass pfn to
 free_unref_page_commit()
Content-Language: en-US
To:     Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        frederic@kernel.org, tglx@linutronix.de, peterz@infradead.org,
        mtosatti@redhat.com, nilal@redhat.com, mgorman@suse.de,
        linux-rt-users@vger.kernel.org, cl@linux.com, ppandit@redhat.com
References: <20211103170512.2745765-1-nsaenzju@redhat.com>
 <20211103170512.2745765-2-nsaenzju@redhat.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20211103170512.2745765-2-nsaenzju@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 11/3/21 18:05, Nicolas Saenz Julienne wrote:
> free_unref_page_commit() doesn't make use of its pfn argument, so get
> rid of it.

Yeah, looks like since df1acc856923 ("mm/page_alloc: avoid conflating IRQs
disabled with zone->lock")

> Signed-off-by: Nicolas Saenz Julienne <nsaenzju@redhat.com>

Reviewed-by: Vlastimil Babka <vbabka@suse.cz>

> ---
>  mm/page_alloc.c | 17 ++++++-----------
>  1 file changed, 6 insertions(+), 11 deletions(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index c5952749ad40..9ef03dfb8f95 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -3355,8 +3355,8 @@ static int nr_pcp_high(struct per_cpu_pages *pcp, struct zone *zone)
>  	return min(READ_ONCE(pcp->batch) << 2, high);
>  }
>  
> -static void free_unref_page_commit(struct page *page, unsigned long pfn,
> -				   int migratetype, unsigned int order)
> +static void free_unref_page_commit(struct page *page, int migratetype,
> +				   unsigned int order)
>  {
>  	struct zone *zone = page_zone(page);
>  	struct per_cpu_pages *pcp;
> @@ -3405,7 +3405,7 @@ void free_unref_page(struct page *page, unsigned int order)
>  	}
>  
>  	local_lock_irqsave(&pagesets.lock, flags);
> -	free_unref_page_commit(page, pfn, migratetype, order);
> +	free_unref_page_commit(page, migratetype, order);
>  	local_unlock_irqrestore(&pagesets.lock, flags);
>  }
>  
> @@ -3415,13 +3415,13 @@ void free_unref_page(struct page *page, unsigned int order)
>  void free_unref_page_list(struct list_head *list)
>  {
>  	struct page *page, *next;
> -	unsigned long flags, pfn;
> +	unsigned long flags;
>  	int batch_count = 0;
>  	int migratetype;
>  
>  	/* Prepare pages for freeing */
>  	list_for_each_entry_safe(page, next, list, lru) {
> -		pfn = page_to_pfn(page);
> +		unsigned long pfn = page_to_pfn(page);
>  		if (!free_unref_page_prepare(page, pfn, 0)) {
>  			list_del(&page->lru);
>  			continue;
> @@ -3437,15 +3437,10 @@ void free_unref_page_list(struct list_head *list)
>  			free_one_page(page_zone(page), page, pfn, 0, migratetype, FPI_NONE);
>  			continue;
>  		}
> -
> -		set_page_private(page, pfn);
>  	}
>  
>  	local_lock_irqsave(&pagesets.lock, flags);
>  	list_for_each_entry_safe(page, next, list, lru) {
> -		pfn = page_private(page);
> -		set_page_private(page, 0);
> -
>  		/*
>  		 * Non-isolated types over MIGRATE_PCPTYPES get added
>  		 * to the MIGRATE_MOVABLE pcp list.
> @@ -3455,7 +3450,7 @@ void free_unref_page_list(struct list_head *list)
>  			migratetype = MIGRATE_MOVABLE;
>  
>  		trace_mm_page_free_batched(page);
> -		free_unref_page_commit(page, pfn, migratetype, 0);
> +		free_unref_page_commit(page, migratetype, 0);
>  
>  		/*
>  		 * Guard against excessive IRQ disabled times when we get
> 

