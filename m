Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 027D2C433DB
	for <linux-rt-users@archiver.kernel.org>; Mon, 29 Mar 2021 14:38:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB2C76192C
	for <linux-rt-users@archiver.kernel.org>; Mon, 29 Mar 2021 14:38:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230338AbhC2OiF (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 29 Mar 2021 10:38:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230213AbhC2Oht (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 29 Mar 2021 10:37:49 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AFD5C061574
        for <linux-rt-users@vger.kernel.org>; Mon, 29 Mar 2021 07:37:49 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id x16so13109459wrn.4
        for <linux-rt-users@vger.kernel.org>; Mon, 29 Mar 2021 07:37:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=8Jvnee+Q900q/ypwMQgUrBJYgJ4FSXjMEcf4/EubCW8=;
        b=rprUBdwtCrj5bB2eTh+K8tMhBlU5X0gFxZ4OKOloVcUL+KvkEJ68YNOjiujhzdvVlO
         h1DnarLKcknYnTV4X2XtSFaGtrOcKX8xEST49ryvKbZpzqNBqocHEGAOblo9jUxcQHs1
         dEHlIEYZTrc0dEv28Lq861B8v4gz4PwsCXrtw4qjwimrwHd+lymxz3NUHm/SqiasR+ay
         SBLhAFmZDYnMea1dGVvqobppX++HfxKW0rRIawISC2YAzR7j+9H5b33VmdTuTjtAfcTr
         TSSUvvLy4lyvfKSrxjPRqZITDt5x9b4AOHbIqCs2GdBhKX2VktwuI8vNzfL2pNkwBQaU
         QcKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=8Jvnee+Q900q/ypwMQgUrBJYgJ4FSXjMEcf4/EubCW8=;
        b=gjvBcQAglXBVllnuhTDdhWwynItcHxYobtXqhGEV50OdfY2JC3qfeEOtHmX4gvB7Wu
         qWeyEP9ytpeB13YwWre8daf2+e1rdIWiltRpHSb7lJ3M3kY+OMOP+qRAIt/jmBLY9mwJ
         iHb5ghK1KkX5fs6MnjCvfzyJO2pDlALqbeYD0qIcTWEDLzCmVNiTDiSg8HaEnfLNl1E7
         KJM/3xFGxa+KLcAZR1v11s2bn50Ckpd1x1JhraRFeqdpTGGGSOT3aM2q3sOmiW8higEF
         /rRGrOlp7PsB7tpjjfeux95PcDQNzcEwjCGLIw19GZke0kXGSxcdcuBUAIKGVTcmQV2x
         yckw==
X-Gm-Message-State: AOAM530d+/Fp1BRuj3x5oAPDJHv5IuYEul367+kqsVxlgGLSiXCstqmE
        oMm9Xn4VkQMWxg+0HpW2/CLe1TTnALb/QA==
X-Google-Smtp-Source: ABdhPJylWNSEeopWRc8JRWCdtn/85xH+G8jqnxETPOBXeQ0ASNq216Ik5b4rSmZi51IKlX2vjewgww==
X-Received: by 2002:adf:e3c9:: with SMTP id k9mr30094958wrm.308.1617028667394;
        Mon, 29 Mar 2021 07:37:47 -0700 (PDT)
Received: from ?IPv6:2a01:c22:bc82:bc00:1dc8:a1bf:455:bc0b? (dynamic-2a01-0c22-bc82-bc00-1dc8-a1bf-0455-bc0b.c22.pool.telefonica.de. [2a01:c22:bc82:bc00:1dc8:a1bf:455:bc0b])
        by smtp.gmail.com with ESMTPSA id f126sm24162056wmf.17.2021.03.29.07.37.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Mar 2021 07:37:46 -0700 (PDT)
From:   Jonathan Schwender <schwenderjonathan@gmail.com>
Subject: Re: rt-tests: cyclictest: Add option to specify main pid affinity
To:     "Ahmed S. Darwish" <a.darwish@linutronix.de>
Cc:     linux-rt-users@vger.kernel.org
References: <20210222152833.8758-1-schwenderjonathan@gmail.com>
 <YDPZ0xrEcsS5SfWh@lx-t490> <dd40b81d-7099-7740-c2ad-64b49e582234@gmail.com>
 <YFsHN/w+2mDHr1W8@lx-t490>
Message-ID: <f3cfb8ce-1d06-e1f1-a9e9-129595bbe3d2@gmail.com>
Date:   Mon, 29 Mar 2021 16:37:45 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <YFsHN/w+2mDHr1W8@lx-t490>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi Ahmed,


On 3/24/21 10:32 AM, Ahmed S. Darwish wrote:
> Hi Jonathan,
>
>
> Since I'm doing some CAT-related stuff on RT tasks vs. GPU workloads,
> I'm curious, how much was the benefit of CAT ON/OFF?

I'm assuming you're testing iGPU workloads and not on a dedicated GPU 
since you are mentioning CAT. Or is there any benefit of using CAT with 
a dedicated GPU?


> In your benchmarks you show that the combination of --mainaffinity, CPU
> isolation, and CAT, improves worst case latency by 2 micro seconds. If
> you keep everything as-is, but disable only CAT, how much change happens
> in the results?

First I'd like to mention that my test system had an inclusive 
cache-architecture. I'd guess that the difference between CAT and no CAT 
is smaller for exclusive or non-inclusive caches (assuming cyclictest is 
running on an isolated CPU).

So the results will depend on the amount of isolated CPUs and how much 
of the shared L3 cache the load on housekeeping CPU uses.

Rendered Markdown: 
https://gist.github.com/jschwe/3502dbf1e56c85e9bf1a340041885b33

# Isolation capabilities without CAT

## Test 2021-01-31 - Isolate all CPUs on NUMA node 1

The figure below shows a worst-case latency of 4 microseconds
measured by cyclictest on the isolated CPUs on NUMA node 1.

cmdline: `nosmt 
isolcpus=domain,managed_irq,wq,rcu,misc,kthread,1,3,5,7,9,11 
rcu_nocbs=1,3,5,7,9,11 irqaffinity=0,2,4 maxcpus=12 rcu_nocb_poll 
nowatchdog tsc=nowatchdog processor.max_cstate=1 intel_idle.max_cstate=0`

Test parameters: `sudo taskset -c 0-11 rteval --duration=24h 
--loads-cpulist=0,2,4,6,8,10 --measurement-cpulist=0-11`

![Figure: Latency of completely isolated node vs housekeeping 
node](https://gist.githubusercontent.com/jschwe/3502dbf1e56c85e9bf1a340041885b33/raw/962244e4e5309507feb0b4ec0627efbabe064c85/2021-01-31.png)


## Test 2021-02-01 - Isolate only CPU 11

The figure below shows a worst-case latency of 11 microseconds for the 
isolated CPU 11.
Interestingly, the worst-case latencies also increased for the 
housekeeping CPUs with respect
to the previous test.
It is consistent with other tests I made though, and the worst-case 
latency of the housekeeping CPUs is reduced
if I isolate all or all-but-one CPUs on node 1.

cmdline: `nosmt isolcpus=domain,managed_irq,wq,rcu,misc,kthread,11 
rcu_nocbs=11 irqaffinity=0,2,4 maxcpus=12 rcu_nocb_poll nowatchdog 
tsc=nowatchdog processor.max_cstate=1 intel_idle.max_cstate=0`

Test parameters: `sudo taskset -c 0-11 rteval --duration=24h 
--loads-cpulist=0-10 --measurement-cpulist=0-11`

![Figure: CPU 11 latency with load on neighboring 
CPUs](https://gist.githubusercontent.com/jschwe/3502dbf1e56c85e9bf1a340041885b33/raw/962244e4e5309507feb0b4ec0627efbabe064c85/2021-02-01.png)

Note: The error bars show the unbiased standard error of the mean

> Also, how many classes of service (CLOS) your CPU has? How was the cache
> bitmask divided vis-a-vis the available CLOSes? And did you assign
> isolated CPUs to one CLOS, and non-isolated CPUs to a different CLOS? Or
> was the division more granular?

I don't have access to the system anymore, but I think it had 8 CLOS 
available (according to resctrl).

I always used exclusive bitmasks. I mostly used one CLOS for the 
isolated CPUs, the default CLOS, and sometimes an additional CLOS for 
tid-based CAT.Due to the "exclusive" setting in resctrl I had to take 
away one way of the node 0 cache, even for CLOS that were only intended 
for node 1, which is a bit unfortunate.

I also tested tid-based vs. CPU based CAT on isolated CPUs and the 
take-away was it doesn't matter too much:

tid based CAT visibly (negatively) impacts the best-case latencies (1 
micro-second bin). However, the differences regarding the worst-case 
latencies were minor.

In one test, I used CDP to reserve 4-ways (4 MiB) for each code and data 
(so 8-way total) for 1 cyclictest instance (with 3 measurement threads). 
For CPU-based CAT the utilization oscillated between 0.98MB and 1.11MB. 
For tid-based CAT, the utilization oscillated between 98kB and 163kB.

In the next test I only used CAT to reserve 2-ways (2 MiB) shared 
between code and data,  also for 1 cyclictest instance with 3 
measurement threads. In this case the CPU-based approach utilized 
between 0.45MB and 0.85MB of the reserved L3 cache, but the latencies 
measured by cyclictest were basically unchanged. The tid-based approach 
actually had a utilization of 0. I'm assuming that's because more L3 was 
available to the default CLOS, and the relevant cache-lines were never 
evicted from that part of the L3 cache, so the reservation didn't even 
come in to play there.


> Kind regards,
>
> --
> Ahmed S. Darwish
> Linutronix GmbH

Best regards


Jonathan Schwender

