Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA953C433E0
	for <linux-rt-users@archiver.kernel.org>; Thu, 18 Feb 2021 18:35:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 76F8464E33
	for <linux-rt-users@archiver.kernel.org>; Thu, 18 Feb 2021 18:35:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232617AbhBRSfB (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 18 Feb 2021 13:35:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231645AbhBRRp1 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 18 Feb 2021 12:45:27 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34106C06178B
        for <linux-rt-users@vger.kernel.org>; Thu, 18 Feb 2021 09:44:37 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id b3so3909540wrj.5
        for <linux-rt-users@vger.kernel.org>; Thu, 18 Feb 2021 09:44:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=3QqNywVzwo0jAcWHs5horupjtuBKHDrUMlYpEhNunUE=;
        b=VKdsHKCitcoQCPYKnc9JkauFQiaJjCvD4ZJWbrV4po+N9VBweUoijz7PGDbQiFLLs4
         PbbjpFXYMYGQaNjF3wQWQlAdrGF4JNGIPnAsu7HFs39Pl185nPvpB1lj4bk87CsDBFIW
         X/ULUZmRouFEKDsYXHeGpbPnQDwFlakfZLwIhAeaRWd2sY9TgkOan/Tjx2NlyIz0AVZ0
         TjOTD7ZKEEauhVvVIY6PRnHc3+zBP+fFIw+SSDe0JqpgV8r8b7AXJV6ARNIcmwnOIJzX
         q6lxE501t7n6OdItqjGeNtYEe+P/G9C+tnmoZlyPUtZxKNGjH1CiIiKt6cCt0ENMDAOr
         2JTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=3QqNywVzwo0jAcWHs5horupjtuBKHDrUMlYpEhNunUE=;
        b=kBME1zeSNVgaUji304M9lnQvwoFChUI/iAL1VAHTiFHymp3qqNHdZBYC3qdzQNE9GE
         LJmp3xrF0XtCXGh1Gqc7M2JU2pMhL5Xzz6twFrV+Q2oCabF0BRoGpEpW1TeHs+WM9Hvt
         jOGm7PMxDdmtMhhoIzALavrKzLXE3gaLBTL4gu3ExiYJjUhJdtrXogCLt5dQ6m0tovs5
         lUi/Tpqczsyo6GpL/J3sMUsl4ccpLP5fdLDPLkhvqW7kHyBh5eBIaT8FqTLD750fScFc
         Y/m5Fs/aUFSvbUns9EU1R9rYpndHadBXFFpv/aui2BuuoLHoezZ/0wC8noTarRDH/qyl
         IsuA==
X-Gm-Message-State: AOAM531jpI22PsNVIsAofwDHOSo3bY4+fG1MRl9FAq4m1SGRzC9jLx4a
        N0vGmLdCEzH7KPU5I6VSvIyspdKc4rjWVQ==
X-Google-Smtp-Source: ABdhPJx/AOpDffyf6rkCi5XMs2WFKENcI+DkjF4YqsRBmDTNYX6zrWvTJ4qNfB9jHj2XEDC6bnCrXw==
X-Received: by 2002:adf:e70e:: with SMTP id c14mr5373336wrm.54.1613670275443;
        Thu, 18 Feb 2021 09:44:35 -0800 (PST)
Received: from localhost.localdomain (dynamic-2a01-0c22-b447-1900-2209-dfbe-a112-9279.c22.pool.telefonica.de. [2a01:c22:b447:1900:2209:dfbe:a112:9279])
        by smtp.gmail.com with ESMTPSA id i15sm7531924wmq.26.2021.02.18.09.44.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Feb 2021 09:44:34 -0800 (PST)
Subject: Re: Issue with cyclictest, RT_GROUP_SCHED, isolcpus and NOHZ_FULL
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-rt-users@vger.kernel.org
References: <b07b6fc7-1a5f-0dcc-ca65-821de96cd8b4@gmail.com>
 <20210218151231.przmuzsygtutjpck@linutronix.de>
From:   Jonathan Schwender <schwenderjonathan@gmail.com>
Message-ID: <5133b008-baf0-65e0-9c7b-07fa2cbb78c4@gmail.com>
Date:   Thu, 18 Feb 2021 18:44:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210218151231.przmuzsygtutjpck@linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org


On 2/18/21 4:12 PM, Sebastian Andrzej Siewior wrote:
> On 2020-12-30 14:09:19 [+0100], Jonathan Schwender wrote:
>> Hi everyone,
>>
>> I've been trying to test the real-time `performance` possible with
>> containers, by running cyclictest in a container on an RT-Kernel.
>> The issue I've been having does not require containers or an
>> RT kernel though.
>>
>> Issue: cyclictest freezes after running for a few seconds
>> to minutes. After that only the loadavg section is updated,
>> while the count line does not change anymore.
>> cyclictest can't be killed after that point
>> other than by restarting the machine, and
>> this also takes a few minutes until the kernel kills
>> cyclictest.
>>
>> This behaviour only occurs when the following conditions are
>> met:
>>
>> - RT_GROUP_SCHED is used
>> - cyclictest is bound to an isolated cpu core with
>>    nohz_full=<core>, and isolcpus=nohz,domain,<core>
> So if you remove RT_GROUP_SCHED and use cyclictest on the nohz_full
> cores then everything is fine?

Yes, I traced it down to RT throttling breaking if nohz_full is set and 
a non-root cgroup is used.
The timer tick which resets the runtime, gets moved to a housekeeping 
CPU, which
doesn't service the isolated CPUs. This leads to the task being RT 
throttled indefinitely.

I proposed a patch [1] which solved my issue however, I haven't received 
any feedback on it yet.

The patch basically just extends the exception for the root cgroup to 
also apply to all housekeeping CPUs,
but I assume there are better ways to fix this that I don't know about.


[1] 
https://lore.kernel.org/lkml/20210202090010.5350-1-schwenderjonathan@gmail.com/

> Sebastian

Jonathan

