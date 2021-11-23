Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0545C433F5
	for <linux-rt-users@archiver.kernel.org>; Tue, 23 Nov 2021 14:58:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235069AbhKWPBM (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 23 Nov 2021 10:01:12 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:47364 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231387AbhKWPBM (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 23 Nov 2021 10:01:12 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 445F11FD5A;
        Tue, 23 Nov 2021 14:58:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1637679483; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Jtn7w+ulBrJ0GSkjWvnH8j3v5RkPR9t9V0PNMAUIlUs=;
        b=Qy5LIRlTntBAcE8PTopd5/41cIJmz2IR2+1o/lup8wL9ur+MuDxJDLePpJlPVQ8gcJtk9+
        M4UO3HtB82SjOMHgj5sjx79kuePQs5Vbf1rMqEYv81kzci+dJcbgz/30S2SOyo3iOOH1Wf
        ze/RnLpEjqKBQkTCsMhu4IO9plSYgwY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1637679483;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Jtn7w+ulBrJ0GSkjWvnH8j3v5RkPR9t9V0PNMAUIlUs=;
        b=wCmRzLDWObMWr2uAAjUNjn1quRRQh+34UdoA/yLaX4WltserwlfbpEUq6wfFd5CHyuLxfh
        oy4ERBjbLM9ZzTBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1376A13E20;
        Tue, 23 Nov 2021 14:58:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id N9cQBHsBnWFjOwAAMHmgww
        (envelope-from <vbabka@suse.cz>); Tue, 23 Nov 2021 14:58:03 +0000
Message-ID: <7549db15-5149-160f-86e3-55136fe482ce@suse.cz>
Date:   Tue, 23 Nov 2021 15:58:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Content-Language: en-US
To:     Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        frederic@kernel.org, tglx@linutronix.de, peterz@infradead.org,
        mtosatti@redhat.com, nilal@redhat.com, mgorman@suse.de,
        linux-rt-users@vger.kernel.org, cl@linux.com, ppandit@redhat.com
References: <20211103170512.2745765-1-nsaenzju@redhat.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH v2 0/3] mm/page_alloc: Remote per-cpu page list drain
 support
In-Reply-To: <20211103170512.2745765-1-nsaenzju@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 11/3/21 18:05, Nicolas Saenz Julienne wrote:
> This series introduces a new locking scheme around mm/page_alloc.c's per-cpu
> page lists which will allow for remote CPUs to drain them. Currently, only a
> local CPU is permitted to change its per-cpu lists, and it's expected to do so,
> on-demand, whenever a process demands it (by means of queueing an drain task on
> the local CPU). Most systems will handle this promptly, but it'll cause
> problems for NOHZ_FULL CPUs that can't take any sort of interruption without
> breaking their functional guarantees (latency, bandwidth, etc...).
> 
> This new locking scheme, based on per-cpu spinlocks, is the simpler and more
> maintainable approach so far[1], although also has some drawbacks: it comes
> with a small performance. Depending on the page allocation code path
> micro-benchmark we can expect 0% to 0.6% degradation on x86_64, and 0% to 2% on
> arm64[2].
> 
> Assuming there is nothing too horrible in the patches themselves I believe it
> all comes down to whether we prefer to take the small performance hit vs the
> maintenance burden of a more complex solution[1]. I don't have enough

I'd be for the small performance hit over more complex solution, if possible.

> experience with performance tuning, nor with maintenance to have an
> authoritative opinion here, so I'll defer to whatever is hopefully discussed
> here. Also, I'll be happy to run any extra tests that I might have missed.

I think Mel has done most page allocator optimizations recently so he would
be most authoritative to say what is or isn't acceptable.

> Patch #1 could be taken regardless of the rest of the series as it removes dead
> code.
> 
> The series is based on today's linux-next. 
> 
> Changes since v2:
>  - Provide performance numbers
>  - Unanimously use per-cpu spinlocks
> 
> [1] Other approaches can be found here:
> 
>   - Static branch conditional on nohz_full, no performance loss, the extra
>     config option makes is painful to maintain (v1):
>     https://lore.kernel.org/linux-mm/20210921161323.607817-5-nsaenzju@redhat.com/
> 
>   - RCU based approach, complex, yet a bit less taxing performance wise
>     (RFC):
>     https://lore.kernel.org/linux-mm/20211008161922.942459-4-nsaenzju@redhat.com/

Hm I wonder if there might still be another alternative possible. IIRC I did
propose at some point a local drain on the NOHZ cpu before returning to
userspace, and then avoiding that cpu in remote drains, but tglx didn't like
the idea of making entering the NOHZ full mode more expensive [1].

But what if we instead set pcp->high = 0 for these cpus so they would avoid
populating the pcplists in the first place? Then there wouldn't have to be a
drain at all. On the other hand page allocator operations would not benefit
from zone lock batching on those cpus. But perhaps that would be acceptable
tradeoff, as a nohz cpu is expected to run in userspace most of the time,
and page allocator operations are rare except maybe some initial page
faults? (I assume those kind of workloads pre-populate and/or mlock their
address space anyway).

[1] https://lore.kernel.org/all/878rznh93e.ffs@tglx/

> [2] See individual patches for in-depth results
> 
> ---
> 
> Nicolas Saenz Julienne (3):
>   mm/page_alloc: Don't pass pfn to free_unref_page_commit()
>   mm/page_alloc: Convert per-cpu lists' local locks to per-cpu spin
>     locks
>   mm/page_alloc: Remotely drain per-cpu lists
> 
>  include/linux/mmzone.h |   1 +
>  mm/page_alloc.c        | 151 ++++++++++++++---------------------------
>  2 files changed, 52 insertions(+), 100 deletions(-)
> 

