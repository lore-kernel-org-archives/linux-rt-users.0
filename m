Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44ECEC64E7A
	for <linux-rt-users@archiver.kernel.org>; Fri, 27 Nov 2020 12:04:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C68A521D93
	for <linux-rt-users@archiver.kernel.org>; Fri, 27 Nov 2020 12:04:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="eG6g0U3j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727802AbgK0MEB (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 27 Nov 2020 07:04:01 -0500
Received: from m15111.mail.126.com ([220.181.15.111]:41229 "EHLO
        m15111.mail.126.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726162AbgK0MD7 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 27 Nov 2020 07:03:59 -0500
X-Greylist: delayed 1841 seconds by postgrey-1.27 at vger.kernel.org; Fri, 27 Nov 2020 07:03:54 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=Subject:From:Message-ID:Date:MIME-Version; bh=ECINj
        pexssyoaenETD5TN02m4CwlovM3up2NLXQKo/U=; b=eG6g0U3jknNfeVjpkblQA
        VWDRvBR/xTbbL0geyGdtb/iKwU399XkeWGQo9e5Rntx5fNBHc8+I0vwTGhK2uhlB
        tdGZkdzSjmIEp9scn7KJ2wzBCArCzeejhG5BQqcI2WAq7rqra41VLoGnl3hRYzT+
        PZZLt8MXpwzA/ZxTjFxzjM=
Received: from [192.168.0.234] (unknown [113.91.142.252])
        by smtp1 (Coremail) with SMTP id C8mowABXG0uj48BfSbjyLg--.19732S2;
        Fri, 27 Nov 2020 19:31:49 +0800 (CST)
Subject: Re: [PATCH RT] mm/swap: use local lock in deactivate_page()
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-rt-users@vger.kernel.org, tglx@linutronix.de,
        rostedt@goodmis.org, lcapitulino@redhat.com
References: <20201125142858.2559-1-zqiu2000@126.com>
 <20201126163552.ago5fpy3opi5nb7p@linutronix.de>
From:   Zanxiong Qiu <zqiu2000@126.com>
Message-ID: <915f8627-0976-1bd5-1453-bbeee788a89b@126.com>
Date:   Fri, 27 Nov 2020 19:31:47 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20201126163552.ago5fpy3opi5nb7p@linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: C8mowABXG0uj48BfSbjyLg--.19732S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7AryDZw1rZFyrWr47JF1UWrg_yoW8ZF1Dpa
        yDGFWay3WDXryYvay2qwnFyry5Zan5Ga18tr4UJFyfur10vF1FyF1xKrs0kw13C3Z3Ca17
        Za1DXrnIvFn0yaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07banmiUUUUU=
X-Originating-IP: [113.91.142.252]
X-CM-SenderInfo: p2tl3jqqqqqiyswou0bp/1tbimQzpFF9E1cKMdgAAse
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2020/11/27 上午12:35, Sebastian Andrzej Siewior wrote:
> On 2020-11-25 22:28:58 [+0800], zqiu2000@126.com wrote:
>> From: Zanxiong Qiu <zqiu2000@126.com>
>>
>> get_cpu_var() calls preempt_disable(), while on RT kernel,
>> pagevec_lru_move_fn() will call spinlock and might schedule
>> the context out and hence the schedule bug occurred, issue
>> is found on 5.4.70-rt40 and reproducable on 5.4.74-rt41.
>>
> …
> 
>> 2154a0abcc9 ("mm: Revert the DEFINE_PER_CPU_PAGEVEC implementation")
>> reverted the lock/unlock_swap_pvec function, however, get_cpu_var()
>> was added back in deactivate_page(), actually, get_locked_var()
>> shall be used instead to avoid preempt_disable() call for RT.
> 
> The commit is
>      32154a0abcc97 ("mm: Revert the DEFINE_PER_CPU_PAGEVEC implementation")
> 
> the reasoning is correct. deactivate_page() was added in v5.4 and I
> missed that part when I added back the old patches which did not handle
> it :/
> 
> Acked-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> 

My bad, will correct the commit msg and resend, thanks.

>> Signed-off-by: Zanxiong Qiu <zqiu2000@126.com>
>> ---
>>   mm/swap.c | 5 +++--
>>   1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/mm/swap.c b/mm/swap.c
>> index cdb4f1fa3a48..463cac334fcf 100644
>> --- a/mm/swap.c
>> +++ b/mm/swap.c
>> @@ -666,12 +666,13 @@ void deactivate_file_page(struct page *page)
>>   void deactivate_page(struct page *page)
>>   {
>>   	if (PageLRU(page) && PageActive(page) && !PageUnevictable(page)) {
>> -		struct pagevec *pvec = &get_cpu_var(lru_deactivate_pvecs);
>> +		struct pagevec *pvec = &get_locked_var(swapvec_lock,
>> +							lru_deactivate_pvecs);
>>   
>>   		get_page(page);
>>   		if (!pagevec_add(pvec, page) || PageCompound(page))
>>   			pagevec_lru_move_fn(pvec, lru_deactivate_fn, NULL);
>> -		put_cpu_var(lru_deactivate_pvecs);
>> +		put_locked_var(swapvec_lock, lru_deactivate_pvecs);
>>   	}
>>   }
>>   
> 
> Sebastian
> 

