Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF461C43334
	for <linux-rt-users@archiver.kernel.org>; Thu, 23 Jun 2022 18:59:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229923AbiFWS7e (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 23 Jun 2022 14:59:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231443AbiFWS7U (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 23 Jun 2022 14:59:20 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1149010B648
        for <linux-rt-users@vger.kernel.org>; Thu, 23 Jun 2022 11:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656007469;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HuFxUR6BTCKmq3RBhsxlLVghh4qSMBYPTGysPk14N1Q=;
        b=StjD9XNQuEK7zqantzUuRbeaC4dyAS8ZbY8L67ILG5Nd3oNZCeHZSS31y9EQAoWk7t0ttY
        VB6MGq+rT8XMcgWGrCVzqQV8Vb3WRH6VactiLArRAQpu1Yxvf48Pgds4rLQgqDAiLDytbM
        ehQOj33uw9RV2UepcLnKNBtAtl1LqXY=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-201-YrC2u1TuMBC5FUUJwd0YGw-1; Thu, 23 Jun 2022 14:04:25 -0400
X-MC-Unique: YrC2u1TuMBC5FUUJwd0YGw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4B3EB3806709;
        Thu, 23 Jun 2022 18:04:25 +0000 (UTC)
Received: from [10.22.9.91] (unknown [10.22.9.91])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7FC7F2166B29;
        Thu, 23 Jun 2022 18:04:24 +0000 (UTC)
Message-ID: <dd4f2422-3151-2c0b-e4c6-fe49f6d2ac30@redhat.com>
Date:   Thu, 23 Jun 2022 14:04:24 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [Question] vmalloc latency in RT-Linux
Content-Language: en-US
To:     Baoquan He <bhe@redhat.com>, Zhipeng Shi <zhipeng.shi0@gmail.com>
Cc:     linux-mm@kvack.org, linux-rt-users@vger.kernel.org,
        tglx@linutronix.de, shengjian.xu@horizon.ai, schspa@gmail.com,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
References: <20220621121547.GB37196@ubuntu20>
 <YrRFpmk0pxvXanbH@MiWiFi-R3L-srv>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <YrRFpmk0pxvXanbH@MiWiFi-R3L-srv>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 6/23/22 06:51, Baoquan He wrote:
> On 06/21/22 at 08:15pm, Zhipeng Shi wrote:
>> I noticed in rt-linux, vmalloc has a large latency. This is because the
>> free_vmap_area_lock is held for a long time in the function
>> __purge_vmap_area_lazy.
>>
>> In non-RT-Linux, because the function spin_is_contended is well
>> implemented, so there will be no such problem.
>>
>> But in RT-Linux, spin_is_contended simply returns 0. I don't understand
>> why this function was implemented like this before, but in order to
>> solve this problem, I thought of two ways.
>>
>> The first is to modify the spin_is_contended definition in spinlock_rt.h
>> as shown below, but I'm not sure if the change has side-effects:
>>
>> -#define spin_is_contended(lock)    (((void)(lock), 0))
>> +static inline int spin_is_contended(spinlock_t *lock)
>> +{
>> + unsigned long *p = (unsigned long *) &lock->lock.owner;
>> +
>> + return (READ_ONCE(*p) & RT_MUTEX_HAS_WAITERS);
>> +}
>>
>> The second is by reducing the number of lazy_max_pages, but it will lead
>> to lower performance of vmalloc.
> __purge_vmap_area_lazy() has cond_resched_lock() to reschedule and drop
> the lock. From your saying, it's spin_is_contended() which is not
> working well to make rescheduling happen during __purge_vmap_area_lazy()
> handling. Then the fixing should be done in lock side.

Sebastian had sent out patch last year to fix spin_is_contended().

https://lore.kernel.org/lkml/20210906143004.2259141-3-bigeasy@linutronix.de/

However, there is no follow-up after some discussion and the patch 
wasn't merged.

Cheers,
Longman

