Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D980C4320A
	for <linux-rt-users@archiver.kernel.org>; Fri,  6 Aug 2021 12:38:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D5D061164
	for <linux-rt-users@archiver.kernel.org>; Fri,  6 Aug 2021 12:38:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343762AbhHFMjO (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 6 Aug 2021 08:39:14 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:42022 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343743AbhHFMjL (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 6 Aug 2021 08:39:11 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 466E722238;
        Fri,  6 Aug 2021 12:38:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1628253535; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fVnQMqrob9/IFuGf5EbNL3WQENObUrkXU+LC4+olYdY=;
        b=yikrRqNKDzssgPajRQZtzuJzAdAgmFAi8Q7QuojndI5AoZIPHbeq22FZXncR0jfjYYRv6s
        nFMlgnvNJqDjiVNHUNVKBRmoT53NKFyGtWrBIpNFUb6Lq5c66y76S9jdxRZXr1mNgiD8nh
        bmL4Mn3RjNgSW4tO23hcKpHXTuj4be4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1628253535;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fVnQMqrob9/IFuGf5EbNL3WQENObUrkXU+LC4+olYdY=;
        b=Li6bD+Fg/AYldNcFmarfwiFRStRjdnW2AX7iH8+FMFKnyvDMhpJfgRQ7SP3cEFB4XRE8Ro
        4gzyYiytkmhxQSAg==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 1BF5413A82;
        Fri,  6 Aug 2021 12:38:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id WjdwBV8tDWF5dwAAGKfGzw
        (envelope-from <vbabka@suse.cz>); Fri, 06 Aug 2021 12:38:55 +0000
Subject: Re: [PATCH 1/1] mm/vmstat: Protect per cpu variables with preempt
 disable on RT
To:     Mel Gorman <mgorman@techsingularity.net>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Hugh Dickins <hughd@google.com>, Linux-MM <linux-mm@kvack.org>,
        Linux-RT-Users <linux-rt-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20210805160019.1137-1-mgorman@techsingularity.net>
 <20210805160019.1137-2-mgorman@techsingularity.net>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <d54e0958-5680-0d5c-e4a7-6ec4afe53b48@suse.cz>
Date:   Fri, 6 Aug 2021 14:38:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210805160019.1137-2-mgorman@techsingularity.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 8/5/21 6:00 PM, Mel Gorman wrote:
> From: Ingo Molnar <mingo@elte.hu>
> 
> Disable preemption on -RT for the vmstat code. On vanila the code runs
> in IRQ-off regions while on -RT it may not when stats are updated under
> a local_lock. "preempt_disable" ensures that the same resources is not
> updated in parallel due to preemption.
> 
> This patch differs from the preempt-rt version where __count_vm_event and
> __count_vm_events are also protected. The counters are explicitly "allowed
> to be to be racy" so there is no need to protect them from preemption. Only
> the accurate page stats that are updated by a read-modify-write need
> protection. This patch also differs in that a preempt_[en|dis]able_rt
> helper is not used. As vmstat is the only user of the helper, it was
> suggested that it be open-coded in vmstat.c instead of risking the helper
> being used in unnecessary contexts.
> 
> Signed-off-by: Ingo Molnar <mingo@elte.hu>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Mel Gorman <mgorman@techsingularity.net>

Acked-by: Vlastimil Babka <vbabka@suse.cz>
