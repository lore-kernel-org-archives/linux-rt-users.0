Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1750CC433EF
	for <linux-rt-users@archiver.kernel.org>; Tue, 21 Sep 2021 18:00:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB958611ED
	for <linux-rt-users@archiver.kernel.org>; Tue, 21 Sep 2021 18:00:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232124AbhIUSCI (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 21 Sep 2021 14:02:08 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:36920 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231903AbhIUSCH (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 21 Sep 2021 14:02:07 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 351871FF03;
        Tue, 21 Sep 2021 18:00:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1632247238; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CYaWP1FKTUsV2gAS0XYYjwyo9Bf8DdyZWhObLWn/jw8=;
        b=VRfyMRk/T9URM/a6Ppj0tGTnK8GE9rrePM2p/b4ekwc01Cxl5ZYYfdmklnVb8BsFiOcGCw
        BzfOEOnROQN2U1ii/GYZSBPKi0zdgPfBZ7Qa/prQ5qItypUADlZGUNJcO7OldpJoOp44JK
        QUq9USv/7zPcePH1dG6usflxWnFkQRo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1632247238;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CYaWP1FKTUsV2gAS0XYYjwyo9Bf8DdyZWhObLWn/jw8=;
        b=r+9DYsUmf9GR/REYQqSWduAic4zAzdLuut4eV/blR4X2P5cQPZM2N9W8CA5JSxR2EMlrnL
        H8VW+d9zygX/XtCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id F151313BE8;
        Tue, 21 Sep 2021 18:00:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id nqNeOsUdSmGpSAAAMHmgww
        (envelope-from <vbabka@suse.cz>); Tue, 21 Sep 2021 18:00:37 +0000
Subject: Re: [PATCH 0/6] mm: Remote LRU per-cpu pagevec cache/per-cpu page
 list drain support
To:     Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        akpm@linux-foundation.org, frederic@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        tglx@linutronix.de, cl@linux.com, peterz@infradead.org,
        juri.lelli@redhat.com, mingo@redhat.com, mtosatti@redhat.com,
        nilal@redhat.com, mgorman@suse.de, ppandit@redhat.com,
        williams@redhat.com, bigeasy@linutronix.de,
        anna-maria@linutronix.de, linux-rt-users@vger.kernel.org
References: <20210921161323.607817-1-nsaenzju@redhat.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <f608b4bf-aa36-b0c4-e748-4f39010f3d06@suse.cz>
Date:   Tue, 21 Sep 2021 19:59:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210921161323.607817-1-nsaenzju@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 9/21/21 6:13 PM, Nicolas Saenz Julienne wrote:
> This series introduces an alternative locking scheme around mm/swap.c's per-cpu
> LRU pagevec caches and mm/page_alloc.c's per-cpu page lists which will allow
> for remote CPUs to drain them. Currently, only a local CPU is permitted to
> change its per-cpu lists, and it's expected to do so, on-demand, whenever a
> process demands it (by means of queueing an drain task on the local CPU). Most
> systems will handle this promptly, but it'll cause problems for NOHZ_FULL CPUs
> that can't take any sort of interruption without breaking their functional
> guarantees (latency, bandwidth, etc...). Having a way for these processes to
> remotely drain the lists themselves will make co-existing with isolated CPUs
> possible, at the cost of more constraining locks.
> 
> Fortunately for non-NOHZ_FULL users, the alternative locking scheme and remote
> drain code are conditional to a static key which is disabled by default. This
> guarantees minimal functional or performance regressions. The feature will only
> be enabled if NOHZ_FULL's initialization process was successful.
> 
> This work is based on a previous series by Thomas Gleixner, Anna-Maria
> Gleixner, and Sebastian Andrzej Siewior[1].

These days the pcplist protection is done by local_lock, which solved
the RT concerns. Probably a stupid/infeasible idea, but maybe what you
want to achieve could be more generally solved at the local_lock level?
That on NOHZ_FULL CPUs, local_locks could have this mode where they
could synchronize with remote cpus?

> [1] https://patchwork.kernel.org/project/linux-mm/patch/20190424111208.24459-3-bigeasy@linutronix.de/
> 
> Nicolas Saenz Julienne (6):
>   mm/swap: Introduce lru_cpu_needs_drain()
>   mm/swap: Introduce alternative per-cpu LRU cache locking
>   mm/swap: Allow remote LRU cache draining
>   mm/page_alloc: Introduce alternative per-cpu list locking
>   mm/page_alloc: Allow remote per-cpu page list draining
>   sched/isolation: Enable 'remote_pcpu_cache_access' on NOHZ_FULL
>     systems
> 
>  kernel/sched/isolation.c |   9 +-
>  mm/internal.h            |   2 +
>  mm/page_alloc.c          | 111 ++++++++++++++++-----
>  mm/swap.c                | 202 ++++++++++++++++++++++++++++++---------
>  4 files changed, 253 insertions(+), 71 deletions(-)
> 

