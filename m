Return-Path: <SRS0=a459=VB=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C12EC06513
	for <linux-rt-users@archiver.kernel.org>; Thu,  4 Jul 2019 10:17:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D912218A0
	for <linux-rt-users@archiver.kernel.org>; Thu,  4 Jul 2019 10:17:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jy16tDD5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727562AbfGDKRO (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 4 Jul 2019 06:17:14 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:42842 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727529AbfGDKRO (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 4 Jul 2019 06:17:14 -0400
Received: by mail-pg1-f196.google.com with SMTP id t132so2696977pgb.9
        for <linux-rt-users@vger.kernel.org>; Thu, 04 Jul 2019 03:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=s7SOe1F5ObWdkVUT2XPTzQRYpPi2RSZ9/8GPWAQIeeY=;
        b=Jy16tDD5PGT9KdFyc2APdwsHQ7zg8Fo6xUtjaNJ/MFlO8VhgnvqPJzheXf/rZLLfXY
         12+lKTf13GJ/fAASVpSDypD8CeF11JxH4qBkaGJOeWsNaklQyfbOVnEKgwrqkn29ZGTH
         TQ0F8mKDlvCijteR1u0lAZEeJS3nsGPa9ZURmm+pyYA7bfD0Prkr7JX2SdpazsFT1fFc
         GU5Ft/vIxj68iLkE3rZy6nmQJ86ZOH13Dpc1lioGBLj+NlxxshS3uwiVVwzBv2YfHoq+
         CrB0yTE9iVyDqITiUmkXMFn2uZgopiqUzNIDRdo3MuPJUF9IcdgWOrFBDScf/OBYVdzJ
         v4GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=s7SOe1F5ObWdkVUT2XPTzQRYpPi2RSZ9/8GPWAQIeeY=;
        b=GCEyFJ8k3ZZOCqZy1eWLJVwntIh/jEsOWbckNAQhQ0ivCsqCWHsabqny0GN18QVtWP
         psasEd6lU4mWB8YSfd25YBtgOky//hYwyiDuMfUD/VDx33bSYDj+MK51pVPJkRked6UM
         TJ3+ulK1xPAPh2TSeBpdeC/E5oTHYrU9ioorz7kLSfv0Q8sa37qKxIGTHvn6vYt7rvvP
         mJ36daxhKCLZ9k/J7YBEPRu3kEQ6XVZWC7n3fOZyxmzkZ9wDLwmwd23v1VoFtdZ7nFJG
         WvCf2rROBJygztIOGRnHwrCRv3CEOxASRIM9zHhbildTESyohenCK8EdS/37ahzLpHmi
         Ab6Q==
X-Gm-Message-State: APjAAAW08ShfzQ/BZiUPdXpp1UFBeQFV0lTgL5lQpm/LLg313YRSp2hz
        YB+E6CNWbVLjbhfNWHBjxCmCt/wWn18=
X-Google-Smtp-Source: APXvYqzdbGxuj34YKYohv0ClOa+TqNsmSEDB4PXxcYLSKa2F4ASHI1/RUP8/nVE4MSgvgxL1tE8XNw==
X-Received: by 2002:a17:90a:ad89:: with SMTP id s9mr18945231pjq.41.1562235433786;
        Thu, 04 Jul 2019 03:17:13 -0700 (PDT)
Received: from [10.11.32.138] ([43.230.89.66])
        by smtp.gmail.com with ESMTPSA id k8sm5868067pgm.14.2019.07.04.03.17.12
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Jul 2019 03:17:13 -0700 (PDT)
Subject: Re: schdule bug in 4.4.38-rt49
From:   "xiaoqiang.zhao" <zhaoxiaoqiang007@gmail.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-rt-users@vger.kernel.org
References: <55c68f08-4160-4bee-fdc5-9fc1ea86cf57@gmail.com>
 <20190703114256.3b52kbrududxq7vz@linutronix.de>
 <987eec05-14d0-29a5-723c-7bfbc0a5465b@gmail.com>
Message-ID: <3d020904-95c2-9cb1-1560-c1a2c931ba83@gmail.com>
Date:   Thu, 4 Jul 2019 18:17:09 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <987eec05-14d0-29a5-723c-7bfbc0a5465b@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Resend as plain-text to linux-rt-users list.

在 2019/7/4 下午1:50, xiaoqiang.zhao 写道:

在 2019/7/3 下午7:42, Sebastian Andrzej Siewior 写道:
> On 2019-06-26 15:35:04 [+0800], xiaoqiang.zhao wrote:
>> Hi, guys:
> Hi,
>
Thanks for your reply ;-)

>> 2) -> __schedule_bug ( leads to kernel pagefault exception, OOPS!!)
>>
>> Before schedule, we have call preempt_disable twice, this will 
>> definitely
>> bump preempt_count to 2 and
>
> something probably disabled preemption before that

I feel this is not make sense.  In my opinion, the preempt_count must be 
zero before we call 'schedule()',

otherwise, in_atomic_preempt_off will return true and trigger the 
__schedule_bug. If we have already

disable_preempt, we may in atomic context and we should not call 
schedule, right ?

>> in_atomic_preempt_off will fail.
>>
>> I did not figure out:   WHY we call schedule inside 
>> rt_spin_lock_slowlock
>> and under what condition this call is correct ?
> if the lock is acquired you schedule out and wait und it is available
> again.
got this.


>
