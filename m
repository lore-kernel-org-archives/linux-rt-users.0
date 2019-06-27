Return-Path: <SRS0=/7Cv=U2=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4FEEC48BD6
	for <linux-rt-users@archiver.kernel.org>; Thu, 27 Jun 2019 02:27:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 715B62183F
	for <linux-rt-users@archiver.kernel.org>; Thu, 27 Jun 2019 02:27:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726957AbfF0C1B (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 26 Jun 2019 22:27:01 -0400
Received: from mail1.windriver.com ([147.11.146.13]:60203 "EHLO
        mail1.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726898AbfF0C1B (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 26 Jun 2019 22:27:01 -0400
Received: from ALA-HCA.corp.ad.wrs.com ([147.11.189.40])
        by mail1.windriver.com (8.15.2/8.15.1) with ESMTPS id x5R2QiVx023927
        (version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
        Wed, 26 Jun 2019 19:26:44 -0700 (PDT)
Received: from [128.224.162.221] (128.224.162.221) by ALA-HCA.corp.ad.wrs.com
 (147.11.189.50) with Microsoft SMTP Server (TLS) id 14.3.439.0; Wed, 26 Jun
 2019 19:26:43 -0700
Subject: Re: glibc nptl tst-robustpi8.c crashes since v5.0.3-rt1
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
CC:     <linux-rt-users@vger.kernel.org>
References: <edd7c4be-738e-5b4f-73f4-0ff4b233a281@windriver.com>
 <20190603163853.psno24qkyrjwspg2@linutronix.de>
 <20190626165107.cyo62mcldfhv67gd@linutronix.de>
From:   He Zhe <zhe.he@windriver.com>
Message-ID: <f4cbf076-f37e-a56a-157f-252e0759be3b@windriver.com>
Date:   Thu, 27 Jun 2019 10:26:39 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190626165107.cyo62mcldfhv67gd@linutronix.de>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [128.224.162.221]
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On 6/27/19 12:51 AM, Sebastian Andrzej Siewior wrote:
> On 2019-06-03 18:38:53 [+0200], To He Zhe wrote:
>> On 2019-05-29 18:20:56 [+0800], He Zhe wrote:
>>> Hi,
> Hi,
>  
>>> Since v5.0.3-rt1, glibc/nptl/tst-robustpi8.c causes the following crash.
>>> https://github.com/lattera/glibc/blob/master/nptl/tst-robustpi8.c
>> thank you for the report.
>>
>>> root@intel-x86-64:~# ./tst-robustpi8
>>> 007: ------------[ cut here ]------------
>>> 007: kernel BUG at /buildarea2/zhe/repo/linux-rt-devel/kernel/locking/rtmutex.c:1336!
>> …
>>> 007: Call Trace:
>>> 007:  rt_spin_lock_slowlock_locked+0x87/0x230
>>> 007:  rt_spin_lock_slowlock+0x67/0xa0
>>> 007:  rt_spin_lock+0x38/0x40
>>> 007:  ? futex_lock_pi+0x2cd/0x490
>>> 007:  futex_lock_pi+0x2cd/0x490
>>> 007:  do_futex+0x330/0xc40
>>> 007:  __se_sys_futex+0x7f/0x170
>> …
>>
>> let me see what I can do…
> I released v5.0.21-rt14 which addresses the issue.

Thanks, I'll give a try ASAP

Zhe

>
>>> Zhe
> Sebastian
>

