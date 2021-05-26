Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81736C2B9F7
	for <linux-rt-users@archiver.kernel.org>; Wed, 26 May 2021 07:16:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E8A6610A8
	for <linux-rt-users@archiver.kernel.org>; Wed, 26 May 2021 07:16:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232827AbhEZHRg (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 26 May 2021 03:17:36 -0400
Received: from ptr.189.cn ([183.61.185.101]:11365 "EHLO 189.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232617AbhEZHRf (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 26 May 2021 03:17:35 -0400
HMM_SOURCE_IP: 10.64.8.31:33702.2133943001
HMM_ATTACHE_NUM: 0000
HMM_SOURCE_TYPE: SMTP
Received: from clientip-123.150.8.42 (unknown [10.64.8.31])
        by 189.cn (HERMES) with SMTP id 3E01A1009D5;
        Wed, 26 May 2021 15:16:00 +0800 (CST)
Received: from  ([123.150.8.42])
        by gateway-153622-dep-cc6c69dc5-fn5jv with ESMTP id 1121ca39ac214aa3bcecf776f674b34c for linux-rt-users@vger.kernel.org;
        Wed May 26 15:16:01 2021
X-Transaction-ID: 1121ca39ac214aa3bcecf776f674b34c
X-filter-score: 
X-Real-From: chensong_2000@189.cn
X-Receive-IP: 123.150.8.42
X-MEDUSA-Status: 0
Sender: chensong_2000@189.cn
Subject: Re: Network latency on 5.4 and 5.10
To:     Christoph Mathys <eraserix@gmail.com>
Cc:     Linux RT Users <linux-rt-users@vger.kernel.org>
References: <6aa61bb9-0443-6da3-0902-9fe700c24017@gmail.com>
 <7e7394a6-cec6-e3c6-b5a8-e1cb6627a96d@gmail.com>
 <c856e656-24a0-a3ef-d023-197bffd19b4e@189.cn>
 <CALqGcGoHiyeNta5=WBq6txk-ykMBfYof5g3c2Yh+KL8Oii+_sQ@mail.gmail.com>
From:   "chensong_2000@189.cn" <chensong_2000@189.cn>
Message-ID: <826566ef-71f6-2f8f-8134-2e5f304a6fd6@189.cn>
Date:   Wed, 26 May 2021 15:15:47 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CALqGcGoHiyeNta5=WBq6txk-ykMBfYof5g3c2Yh+KL8Oii+_sQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

ok, looks enabling all events is enough. many thanks.

BR

Song

在 2021/5/26 下午2:10, Christoph Mathys 写道:
> Hi Song,
> 
>> what's your command to get this log? it seems to have better information
>> than mine.
> 
> I just do old-school tracing:
> 
> # enable all available events
> echo 1 > /sys/kernel/debug/tracing/events/enable
> # start tracing
> echo 1 > /sys/kernel/debug/tracing/tracing_on
> 
> Then I run cyclictest with -b and --tracemark to stop tracing when a
> latency hits and write a mark to the file.
> The trace can then be obtained by:
> cat /sys/kernel/debug/tracing/trace
> 
> HTH
> Christoph
> 
