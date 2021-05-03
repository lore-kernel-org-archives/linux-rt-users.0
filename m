Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFCF1C433ED
	for <linux-rt-users@archiver.kernel.org>; Mon,  3 May 2021 20:40:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B76D761165
	for <linux-rt-users@archiver.kernel.org>; Mon,  3 May 2021 20:40:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229595AbhECUlj (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 3 May 2021 16:41:39 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:53198 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229953AbhECUlQ (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 3 May 2021 16:41:16 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 143KdKTO105859;
        Mon, 3 May 2021 15:39:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1620074360;
        bh=zJSsoRPc7uVygqGOIiFotkTDm64hgrdzUC903fh8uSk=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=w5bgHp/G724ddu/NRQ4+/67LvBtWbb0z++4F9UqiQVvul/U1+vTLQoQPet7Hy+Mad
         iO7LrKkAZ9rPgJWo34bltZblQFD9ZuCvby3Zj6+cRJ7KXjJWR+XBTOuFbsNcUOXYu1
         zthsAAnrhjFmXq0IL6/Tf14jb/RuN3IuPzsdWZRU=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 143KdKj8012891
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 3 May 2021 15:39:20 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Mon, 3 May
 2021 15:39:20 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Mon, 3 May 2021 15:39:20 -0500
Received: from [10.247.25.23] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 143KdJNE062416;
        Mon, 3 May 2021 15:39:20 -0500
Subject: Re: [ANNOUNCE] 5.10.30-rt37
To:     Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Wagner <wagi@monom.org>,
        Tom Zanussi <zanussi@kernel.org>,
        "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>
References: <20210419184731.246fa474@gandalf.local.home>
From:   "Bajjuri, Praneeth" <praneeth@ti.com>
Message-ID: <c3b8a530-2ade-5876-5c93-7f83286796b8@ti.com>
Date:   Mon, 3 May 2021 15:39:19 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210419184731.246fa474@gandalf.local.home>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On 4/19/2021 5:47 PM, Steven Rostedt wrote:
> On Tue, Apr 20, 2021,ycollette.nospam@free.fr  wrote:
>> net/xfrm/xfrm_state.c: In function 'xfrm_state_init':
>> ./include/linux/seqlock.h:178:36: error: initialization of 'seqcount_spinlock_t *' {aka 'struct seqcount_spinlock *'} from incompatible pointer type 'seqcount_t *' {aka 'struct seqcount *'} [-Werror=incompatible-pointer-types]
>>    178 |   seqcount_##lockname##_t *____s = (s);   \
>>        |                                    ^
> ...
>> net/xfrm/xfrm_state.c:2666:2: note: in expansion of macro 'seqcount_spinlock_init'
>>   2666 |  seqcount_spinlock_init(&net->xfrm.xfrm_state_hash_generation,
>>        |  ^~~~~~~~~~~~~~~~~~~~~~
> There is a rebase error at:
> 
>    247560698349 ("Merge tag 'v5.10.30' into v5.10-rt")
> 
> Cherry-pick mainline's commit:
> 
>    bc8e0adff343 ("net: xfrm: Use sequence counter with associated spinlock")

Thanks for this fix, Cherry-pick resolved rt stable integration issue 
that i was seeing.

Is this fix going to be posted for v5.10-rt too ?

> 
> and your compilation issue will be fixed.

