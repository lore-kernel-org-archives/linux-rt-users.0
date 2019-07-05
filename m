Return-Path: <SRS0=h7Nr=VC=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9795C5B57D
	for <linux-rt-users@archiver.kernel.org>; Fri,  5 Jul 2019 06:32:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B94B1218BA
	for <linux-rt-users@archiver.kernel.org>; Fri,  5 Jul 2019 06:32:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uzMlcXpT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727390AbfGEGcE (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 5 Jul 2019 02:32:04 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:46524 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727291AbfGEGcE (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 5 Jul 2019 02:32:04 -0400
Received: by mail-pf1-f196.google.com with SMTP id 81so3842900pfy.13
        for <linux-rt-users@vger.kernel.org>; Thu, 04 Jul 2019 23:32:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=ywnp2US7ZPK9SBTyG9Rjd35iFP/cy1G7vdtZ2d4neHM=;
        b=uzMlcXpTxxVoMl5JG8zZ2PkGzDeCJsJ+eWpOMw9T22TNZyXayL0jLynyJNYv8bgSH6
         SsNqWiJykKnkkYkLQLASSwsfVSfAdkKhGRuwvPyKcXSeSYD/cMS85u3uWFeef5R5/RGn
         yFpmp7h5hIr/PJ7e2yG3HyigyqtsPkQFB6fT44TzvfOAjv8vwrvHfHAISYcS9X+Hs+tq
         G3F4dLBHm79YKTm6drlAxyG1mM1G23QCkhwWWH+pXKZ/MBnCG5uUvfEybtiFWcpNjnDA
         h8GDbjx0qijilF5jNaVgOGJB0eMqznFOqw9y5ibygDY4yE0iXkUMPdfvXZDfblBSeXJ3
         wP3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=ywnp2US7ZPK9SBTyG9Rjd35iFP/cy1G7vdtZ2d4neHM=;
        b=sb3o8o8rfLrFtccc8MmprlqA/7o9GQG1bGIAYfm26yFe0ElxenVTx58tY0HTW51HAj
         vbneqtTnPd2O2ILCj2Mev8cej0SUMTfUKrSjk6jNHrtXPWcMfw/3U1Ur/SQ2udR95I7w
         JUFYoa5/Cfsnz7IvNST9TcAvU3Cs34dpagdbo80awEhGFMepdldmI+o1CjrTroaWmic2
         d0i8Bpyl1BZjo6TQgS1na1nfWNZ+0nF3hYBIJbAQFaranwBxyBhuwJv3hDB4jY6fiFai
         HyDl1ktOF2MnGHWf213/o+D4K56K2DtlxNMtKDo8tqQstA197Y/yByLYPMdo6OXVgEIJ
         F42g==
X-Gm-Message-State: APjAAAWG1+rgWrGuIDtfMWZPtCwyVISlybJly9VdRUZoityysKfOfSk3
        nT6OnQVUbt05BR8uEnUx7lTMUXs86sc=
X-Google-Smtp-Source: APXvYqyixsw/SGuVFPPorDKeXuA1K5AvsFWBJ3E/MSDoucrJNfLfTmqYBzKpZrAC35sMS26pNO3/EQ==
X-Received: by 2002:a17:90a:32c7:: with SMTP id l65mr2891036pjb.1.1562308323307;
        Thu, 04 Jul 2019 23:32:03 -0700 (PDT)
Received: from [10.11.32.138] ([43.230.89.66])
        by smtp.gmail.com with ESMTPSA id o14sm20839489pfh.153.2019.07.04.23.32.01
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Jul 2019 23:32:02 -0700 (PDT)
Subject: Re: schdule bug in 4.4.38-rt49
From:   "xiaoqiang.zhao" <zhaoxiaoqiang007@gmail.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-rt-users@vger.kernel.org
References: <55c68f08-4160-4bee-fdc5-9fc1ea86cf57@gmail.com>
 <20190703114256.3b52kbrududxq7vz@linutronix.de>
 <987eec05-14d0-29a5-723c-7bfbc0a5465b@gmail.com>
 <3d020904-95c2-9cb1-1560-c1a2c931ba83@gmail.com>
Message-ID: <b9c00fd2-f190-05d6-fa7f-8091c69a4941@gmail.com>
Date:   Fri, 5 Jul 2019 14:31:59 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <3d020904-95c2-9cb1-1560-c1a2c931ba83@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org


在 2019/7/4 下午6:17, xiaoqiang.zhao 写道:
> Resend as plain-text to linux-rt-users list.
>
> 在 2019/7/4 下午1:50, xiaoqiang.zhao 写道:
>
> 在 2019/7/3 下午7:42, Sebastian Andrzej Siewior 写道:
>> On 2019-06-26 15:35:04 [+0800], xiaoqiang.zhao wrote:
>>> Hi, guys:
>> Hi,
>>
> Thanks for your reply ;-)
>
>>> 2) -> __schedule_bug ( leads to kernel pagefault exception, OOPS!!)
>>>
>>> Before schedule, we have call preempt_disable twice, this will 
>>> definitely
>>> bump preempt_count to 2 and
>>
>> something probably disabled preemption before that
>
> I feel this is not make sense.  In my opinion, the preempt_count must 
> be zero before we call 'schedule()',
>
> otherwise, in_atomic_preempt_off will return true and trigger the 
> __schedule_bug. If we have already
>
> disable_preempt, we may in atomic context and we should not call 
> schedule, right ?
>
>>> in_atomic_preempt_off will fail.
>>>
>>> I did not figure out:   WHY we call schedule inside 
>>> rt_spin_lock_slowlock
>>> and under what condition this call is correct ?
>> if the lock is acquired you schedule out and wait und it is available
>> again.
> got this.
>
>
>>

Finally, this issue is resolved by revert commit 
80127a39681bd68c959f0953f84a830cbd7c3b1c <locking/percpu-rwsem: Optimize 
readers and reduce global impact>.  This commit introduce a 
"preempt_disable()" call in "percpu_up_read" function and  can NOT 
coexist with 4.4.38-rt49 preempt-rt patch set

Hope this information may be useful to someone who encounter the same 
problem ;-)

Thanks Sebastian !


