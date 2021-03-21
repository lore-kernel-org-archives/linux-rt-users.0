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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7918AC433DB
	for <linux-rt-users@archiver.kernel.org>; Sun, 21 Mar 2021 17:12:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4472D61925
	for <linux-rt-users@archiver.kernel.org>; Sun, 21 Mar 2021 17:12:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230221AbhCURMA (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Sun, 21 Mar 2021 13:12:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230200AbhCURL7 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Sun, 21 Mar 2021 13:11:59 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B80AC061574
        for <linux-rt-users@vger.kernel.org>; Sun, 21 Mar 2021 10:11:55 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id u5so17511272ejn.8
        for <linux-rt-users@vger.kernel.org>; Sun, 21 Mar 2021 10:11:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=JngjCol7w10sk45YU7x4XP3AsCuQ7EQ1jTrfwseyJjI=;
        b=rlAoHmrjuapH+Y22MqMQhP9upRQRon6poPJt3f1GrmUGFykB9tzERkBL7Nr7H+5CgF
         gSBI9HOjz+EWyf9bLG/xsJjJBLtMJoL85RKJpRWRzUawO3FARV3rCykl7mr+CDIiGuAv
         Mota3NqaP/0v9Nq/EqK8nWvDkIc+EPqcCydtv1CnBe0Aq2tiQ8Q+itFOV70NOAPL8+Ny
         SxnmCyfT4mAzlK7gNXiHWtQ75gi3751NARvJd0XT60ud0dkReIT1G+xqZCIp2CvOGkSp
         LoqY11qWmzplOHeZtcyGQdKt3WZL+PfHVvAncCgNJp7nL3celx82osUk1ITKUQcuxD8p
         3xWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=JngjCol7w10sk45YU7x4XP3AsCuQ7EQ1jTrfwseyJjI=;
        b=ESySRdgjdEU3NkHig7Pbwc7xGHi1S7HVcwBqf9VrZfCToZFmhaLYKbXkfxLfsElUvU
         E2S4NFdJ4epNYM6NBjodXi3sMo1G6TiELCXlRfyS7B1wmz9XHk1YYWnrKYmwRMDLT0sn
         rVyYR03ErPs19oBE8D/A0Pymxi8c5g+OEP6lZ4v7w9yE84cPxaprYn7Q252ma/dbredz
         BkRUCrUDkx0/73cukC1+1XY9YHYVP+GWToY0wjKCH3k2uY0gA8A2ysHROIPRTHxP87qs
         rmBq0R+pF2p9FD5AUZGR8mlD38p7QohRqGGydxGmx1c3Gwi5gtSGXRo1sc6M6tpCdVof
         zrNg==
X-Gm-Message-State: AOAM53214kHQ/q1QNiO4LyEYjl98pazuCnE+7tmbBLnEFzunjMkbmB1j
        +paEeJd7UcY5E24eaBE2FOyGX5cvPPI=
X-Google-Smtp-Source: ABdhPJw3pdrzx2VzeQKx9nj58xsqSjnbO9uHJyU9IkvaLzCfZha1a+hE8QqHR8PVn1TATCZapKtxxA==
X-Received: by 2002:a17:906:8614:: with SMTP id o20mr14851726ejx.386.1616346713377;
        Sun, 21 Mar 2021 10:11:53 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a01-0c22-b40f-e800-1142-f69e-ece9-d398.c22.pool.telefonica.de. [2a01:c22:b40f:e800:1142:f69e:ece9:d398])
        by smtp.gmail.com with ESMTPSA id ld19sm7427807ejb.102.2021.03.21.10.11.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 21 Mar 2021 10:11:52 -0700 (PDT)
Subject: Re: rt-tests: cyclictest: Add option to specify main pid affinity
To:     "Ahmed S. Darwish" <a.darwish@linutronix.de>
Cc:     jkacur@redhat.com, williams@redhat.com,
        linux-rt-users@vger.kernel.org
References: <20210222152833.8758-1-schwenderjonathan@gmail.com>
 <YDPZ0xrEcsS5SfWh@lx-t490>
From:   Jonathan Schwender <schwenderjonathan@gmail.com>
Message-ID: <dd40b81d-7099-7740-c2ad-64b49e582234@gmail.com>
Date:   Sun, 21 Mar 2021 18:11:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <YDPZ0xrEcsS5SfWh@lx-t490>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org


On 2/22/21 5:20 PM, Ahmed S. Darwish wrote:
> On Mon, Feb 22, 2021 at 04:28:30PM +0100, Jonathan Schwender wrote:
>> Hi John,
>>
>> This patch adds the option --mainaffinity to specify the affinity of
>> the main pid.
>> This is mainly useful if you want to bind the main thread to a
>> different (e.g. housekeeping ) CPU than the measurement threads.
>>
> Do you also have any numbers showing different results with/without
> "--mainaffinity"?

Sorry for the delay. I do have some numbers now, and there is a benefit 
to using this option if CPU isolation + CAT are used. Otherwise it's not 
really visible.

Rendered Markdown: 
https://gist.github.com/jschwe/d4c46026aec57b10a2b0e6f72258b96e

# Testing proposed cyclictest --mainaffinity option

System information:
- 2 socket Intel Xeon E5-2643 v4 @ 3.40Ghz
- Turbo boost is disabled.
- Fedora 33 with kernel 5.10.1-rt20 with small patch (see cmdline isolcpus)
- Cmdline: `nosmt isolcpus=domain,managed_irq,wq,rcu,misc,kthread,3,5,7,9,11 rcu_nocbs=3,5,7,9,11 irqaffinity=0,2,4 maxcpus=12 rcu_nocb_poll nowatchdog tsc=nowatchdog processor.max_cstate=1 intel_idle.max_cstate=0 systemd.unified_cgroup_hierarchy=0`
     - The additional isolcpus arguments set the HK_FLAG with the corresponding name.
       This cmdline adds all HK_FLAGs usually set by nohz_full, except the actual
       nohz flags `tick` and `timer`. This improves cyclictest latencies on my system.
- Rteval is running on all CPUs from node 0 + CPU 1, but not on the isolated CPUs.
- L3 Cache is reserved for the isolated CPUs via `resctrl` (CPU based allocation)
- Test duration 24 hours, interval 200 µs


## Test 1: 5 cyclictest instance with main pid on same cpu as the measurement thread

This test simply starts 5 cyclictest instances (via numactl) with one measurement thread each and bound to a single
CPU via `--affinity`, so that the main thread is also bound to the same CPU.

![Figure: 5 cyclictest instances with main pid pinned to same CPU as measurement thread](https://gist.githubusercontent.com/jschwe/d4c46026aec57b10a2b0e6f72258b96e/raw/e27c3f284cf4bbeecded84865dfee5676b47fe88/2021-03-11.png)

## Test 2: Single cyclictest instance with --mainaffinity=1 for isolated CPUs 3,5,7,9,11
The main thread was placed on CPU 1 via `--mainaffinity` and `--refresh_on_max` was added for good measure to keep the
logfile small.

![Figure: Single cyclictest instance with --mainaffinity=1 for isolated CPUs 3,5,7,9,11](https://gist.githubusercontent.com/jschwe/d4c46026aec57b10a2b0e6f72258b96e/raw/afd81b2a70a3e88bdebc46615d0f60e24238b405/2021-03-19.png)

>
> Thanks,
>
> --
> Ahmed S. Darwish
Jonathan
