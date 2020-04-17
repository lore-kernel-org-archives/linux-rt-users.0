Return-Path: <SRS0=XNcY=6B=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB3FEC2BA2B
	for <linux-rt-users@archiver.kernel.org>; Fri, 17 Apr 2020 02:50:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C507021841
	for <linux-rt-users@archiver.kernel.org>; Fri, 17 Apr 2020 02:50:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729273AbgDQCuv (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 16 Apr 2020 22:50:51 -0400
Received: from mail.windriver.com ([147.11.1.11]:65222 "EHLO
        mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728715AbgDQCuv (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 16 Apr 2020 22:50:51 -0400
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com [147.11.189.40])
        by mail.windriver.com (8.15.2/8.15.2) with ESMTPS id 03H2ocZu021637
        (version=TLSv1 cipher=AES256-SHA bits=256 verify=FAIL);
        Thu, 16 Apr 2020 19:50:38 -0700 (PDT)
Received: from [128.224.162.157] (128.224.162.157) by ALA-HCA.corp.ad.wrs.com
 (147.11.189.50) with Microsoft SMTP Server id 14.3.487.0; Thu, 16 Apr 2020
 19:50:37 -0700
Subject: Re: [PATCH RT] mm: do not warn for suspend when allocate memory on RT
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
CC:     linux-rt <linux-rt-users@vger.kernel.org>
References: <20200413041817.27514-1-liwei.song@windriver.com>
 <20200416170943.hjoytlggvfzzdqjt@linutronix.de>
From:   Liwei Song <liwei.song@windriver.com>
Message-ID: <8cd11f67-dbf8-cce9-548f-ccc544f9486c@windriver.com>
Date:   Fri, 17 Apr 2020 10:50:35 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:76.0) Gecko/20100101
 Thunderbird/76.0
MIME-Version: 1.0
In-Reply-To: <20200416170943.hjoytlggvfzzdqjt@linutronix.de>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On 4/17/20 01:09, Sebastian Andrzej Siewior wrote:
> On 2020-04-13 12:18:17 [+0800], Liwei Song wrote:
>> Interrupts are off during resume from RAM, this will triger a warning
>> when allocate memory in non-preemptible context on RT since commit
>> b5d5bc970f209 ("mm: Warn on memory allocation in non-preemptible
>> context on RT"), exclude suspend from this warning check.
> 
> Is this the ACPI backtrace or do you have something else?

Yes, there are two backtrace here include one ACPI Calltrace, another one
is from iommu:

1).
[ 88.992342] ? acpi_os_allocate_zeroed+0x28/0x2a
[ 88.992349] acpi_os_allocate_zeroed+0x28/0x2a
[ 88.992351] acpi_ns_internalize_name+0x4b/0xa0
[ 88.992354] ? trace_preempt_on+0x2a/0x120
[ 88.992360] acpi_ns_get_node_unlocked+0x6f/0xd7
[ 88.992362] ? _raw_spin_unlock_irqrestore+0x42/0x90
[ 88.992367] ? down_timeout+0x3c/0x60
[ 88.992372] ? acpi_os_wait_semaphore+0x4d/0x70
[ 88.992378] acpi_ns_get_node+0x43/0x5d

2).
[ 88.991560] Call Trace:
[ 88.991561] ? _raw_spin_unlock_irqrestore+0x42/0x90
[ 88.991563] ? iommu_suspend+0x4f/0x1c0
[ 88.991569] iommu_suspend+0x4f/0x1c0
[ 88.991572] syscore_suspend+0x9b/0x3e0
[ 88.991575] suspend_devices_and_enter+0x1fb/0xec0
[ 88.991579] ? rcu_read_lock_sched_held+0x4f/0x80
[ 88.991580] ? prb_unlock+0x18/0x80
[ 88.991585] pm_suspend.cold+0x326/0x37b

During suspend phase the only way to make preemptible() happy is
enable interrupt before kcalloc/kmalloc/kzalloc, but enable interrupt
may cause some unknown issue if device access I/O address which already
suspend, so I think it's better and safe to exclude suspend from this
warning check.

Thanks,
Liwei.


> 
> I'm currently not 100% sure if we can skip the warning.
> 
>> Fixes: b5d5bc970f209 ("mm: Warn on memory allocation in non-preemptible context on RT")
>> Signed-off-by: Liwei Song <liwei.song@windriver.com>
>> ---
>>  mm/slub.c | 6 ++++--
>>  1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/mm/slub.c b/mm/slub.c
>> index 1929645daa53..ebff24ae50ea 100644
>> --- a/mm/slub.c
>> +++ b/mm/slub.c
>> @@ -2771,7 +2771,8 @@ static __always_inline void *slab_alloc_node(struct kmem_cache *s,
>>  	unsigned long tid;
>>  
>>  	if (IS_ENABLED(CONFIG_PREEMPT_RT) && IS_ENABLED(CONFIG_DEBUG_ATOMIC_SLEEP))
>> -		WARN_ON_ONCE(!preemptible() && system_state >= SYSTEM_SCHEDULING);
>> +		WARN_ON_ONCE(!preemptible() && system_state >= SYSTEM_SCHEDULING &&
>> +				system_state != SYSTEM_SUSPEND);
>>  
>>  	s = slab_pre_alloc_hook(s, gfpflags);
>>  	if (!s)
>> @@ -3236,7 +3237,8 @@ int kmem_cache_alloc_bulk(struct kmem_cache *s, gfp_t flags, size_t size,
>>  	int i;
>>  
>>  	if (IS_ENABLED(CONFIG_PREEMPT_RT) && IS_ENABLED(CONFIG_DEBUG_ATOMIC_SLEEP))
>> -		WARN_ON_ONCE(!preemptible() && system_state >= SYSTEM_SCHEDULING);
>> +		WARN_ON_ONCE(!preemptible() && system_state >= SYSTEM_SCHEDULING &&
>> +				system_state != SYSTEM_SUSPEND);
>>  
>>  	/* memcg and kmem_cache debug support */
>>  	s = slab_pre_alloc_hook(s, flags);
> 
> Sebastian
> 
