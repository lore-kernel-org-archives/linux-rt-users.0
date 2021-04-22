Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 348F0C433ED
	for <linux-rt-users@archiver.kernel.org>; Thu, 22 Apr 2021 12:34:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E39D16147F
	for <linux-rt-users@archiver.kernel.org>; Thu, 22 Apr 2021 12:34:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236176AbhDVMfE (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 22 Apr 2021 08:35:04 -0400
Received: from mx2.suse.de ([195.135.220.15]:52922 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230510AbhDVMfE (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 22 Apr 2021 08:35:04 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D0135AF03;
        Thu, 22 Apr 2021 12:34:28 +0000 (UTC)
Subject: Re: [PATCH 2/9] mm/page_alloc: Convert per-cpu list protection to
 local_lock
To:     Mel Gorman <mgorman@techsingularity.net>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Chuck Lever <chuck.lever@oracle.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Michal Hocko <mhocko@kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux-RT-Users <linux-rt-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20210422111441.24318-1-mgorman@techsingularity.net>
 <20210422111441.24318-3-mgorman@techsingularity.net>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <e9744c08-8384-70d1-26bc-d7e73e88ded2@suse.cz>
Date:   Thu, 22 Apr 2021 14:34:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20210422111441.24318-3-mgorman@techsingularity.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 4/22/21 1:14 PM, Mel Gorman wrote:
> There is a lack of clarity of what exactly local_irq_save/local_irq_restore
> protects in page_alloc.c . It conflates the protection of per-cpu page
> allocation structures with per-cpu vmstat deltas.
> 
> This patch protects the PCP structure using local_lock which for most
> configurations is identical to IRQ enabling/disabling. The scope of the
> lock is still wider than it should be but this is decreased later.
> 
> It is possible for the local_lock to be embedded safely within struct
> per_cpu_pages but it adds complexity to free_unref_page_list.
> 
> [lkp@intel.com: Make pagesets static]
> Signed-off-by: Mel Gorman <mgorman@techsingularity.net>

Acked-by: Vlastimil Babka <vbabka@suse.cz>
