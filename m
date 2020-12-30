Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AACEC433E9
	for <linux-rt-users@archiver.kernel.org>; Wed, 30 Dec 2020 13:10:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1ECF8221FA
	for <linux-rt-users@archiver.kernel.org>; Wed, 30 Dec 2020 13:10:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727635AbgL3NKD (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 30 Dec 2020 08:10:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727464AbgL3NKC (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 30 Dec 2020 08:10:02 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C489C061799
        for <linux-rt-users@vger.kernel.org>; Wed, 30 Dec 2020 05:09:22 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id i24so15344966edj.8
        for <linux-rt-users@vger.kernel.org>; Wed, 30 Dec 2020 05:09:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=jtr2LJckUcdTHYWy1XxJxXEm8c7Fjx9S+RgZtvOr31g=;
        b=VGXMvX0k4yXviNayI4PsYkJ14o/XTQ4EtgfY6fxJqPOc7yNztFVBG2eKsUufy4Lah6
         R8iR1v0bxZ0QmhBsCPV1Z+hceMMlfdqePD3n2prmyQzB1I8slQi8OQo5up7y1bfdjt/u
         N4K4rT8HDG3wvwPMZ1TA1jjM7QHR/LzWDZVQb+csPsu1UwNyb5GWaas6FjDKe6liXOVQ
         a8/oTPEXRhqcP1eOfBcYshyMOZy+sdfhEZTUsXGRdBJ5RcNuPRNobU4yRB/6yWtIAH9y
         9Nno9/fLSIqZbrMpSMfekM4iVJpEcw8ehwPA3M340HJrclgWgtTBq9/PGcWVqB1MQ8GB
         5jyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=jtr2LJckUcdTHYWy1XxJxXEm8c7Fjx9S+RgZtvOr31g=;
        b=f+G3X/9vT8DE4TDvT03wceRMVghmT5Xer2nF/axgDjx5c8agg3jNAKoFUpdH8P7FPa
         8DU20ul15/5Sxz+84F1YCy9PZ5B4SM/wrEe74O6Dzcxopxy2fd3dFo+JGiZaZQzFSJkY
         LUU5/tvWopb00nIPKeNAfKCTr1Xds1+I/vos+jba9IxfEawlNJy/q9L5ieX8gQ6BLhIr
         Nv2oayWuBMD/y1UXurzFrZi1zXfiYdHJ4WuDPp2BBFzRTLu2LMEQCkFa8TTDw6fPYiDF
         yEUtQYtpH+o5powotpqcmi3y9glnCTUi0W9ShYIHYXondAkR4fY0aUCe2LVtrG9+6dD/
         WF1A==
X-Gm-Message-State: AOAM531317k6najCb/VVEj2FU2CV1EYARbu+W2CLdEfs7e5yDIea7Uad
        DN5Qoq/qozyq+lq5NeylrP1ntuP/wtMInGU5
X-Google-Smtp-Source: ABdhPJx5LpoJhkqR6aDA5VVRGt4OqtxyOc4KmnQpHl9rzK0qDxFMKfcdioUSA5N2gKhqnT3TFpbdSg==
X-Received: by 2002:a50:e846:: with SMTP id k6mr51163136edn.245.1609333760563;
        Wed, 30 Dec 2020 05:09:20 -0800 (PST)
Received: from localhost.localdomain (dynamic-2a01-0c23-7482-7800-f5f9-b4f5-b4eb-dc20.c23.pool.telefonica.de. [2a01:c23:7482:7800:f5f9:b4f5:b4eb:dc20])
        by smtp.gmail.com with ESMTPSA id qp16sm19125131ejb.74.2020.12.30.05.09.19
        for <linux-rt-users@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Dec 2020 05:09:19 -0800 (PST)
From:   Jonathan Schwender <schwenderjonathan@gmail.com>
Subject: Issue with cyclictest, RT_GROUP_SCHED, isolcpus and NOHZ_FULL
To:     linux-rt-users@vger.kernel.org
Message-ID: <b07b6fc7-1a5f-0dcc-ca65-821de96cd8b4@gmail.com>
Date:   Wed, 30 Dec 2020 14:09:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi everyone,

I've been trying to test the real-time `performance` possible with
containers, by running cyclictest in a container on an RT-Kernel.
The issue I've been having does not require containers or an
RT kernel though.

Issue: cyclictest freezes after running for a few seconds
to minutes. After that only the loadavg section is updated,
while the count line does not change anymore.
cyclictest can't be killed after that point
other than by restarting the machine, and
this also takes a few minutes until the kernel kills
cyclictest.

This behaviour only occurs when the following conditions are
met:

- RT_GROUP_SCHED is used
- cyclictest is bound to an isolated cpu core with
   nohz_full=<core>, and isolcpus=nohz,domain,<core>

I've tested this on a machine with Fedora 33 and vanilla
stable 5.10.3 kernel with RT_GROUP_SCHED.
The same behaviour also exists on 5.10.1-rt20 with
PREEMPT_RT and RT_GROUP_SCHED configured.

After booting I configure the rt_runtime_us like this:
`echo "700000" > /sys/fs/cgroup/cpu,cpuacct/user.slice/cpu.rt_runtime_us`
`echo "100000" > /sys/fs/cgroup/cpu,cpuacct/system.slice/cpu.rt_runtime_us`

Then I start cyclictest via:
`taskset -c 14 cgexec -g cpu,cpuacct:user.slice cyclictest --mlockall \
   --priority=96 --interval=200 --affinity=14 --duration=15m`

These are the cmdline options I tried out to narrow the problem down:
working: `isolcpus=14 irqaffinity=0-3 maxcpus=15 
systemd.unified_cgroup_hierarchy=0`
working: `isolcpus=nohz,14 nohz_full=14 irqaffinity=0-3 maxcpus=15 
systemd.unified_cgroup_hierarchy=0`
working: `isolcpus=nohz,domain,14 irqaffinity=0-3 maxcpus=15 
systemd.unified_cgroup_hierarchy=0`
broken:  `isolcpus=nohz,domain,14 nohz_full=14 irqaffinity=0-3 
maxcpus=15 systemd.unified_cgroup_hierarchy=0`

unified_cgroup_hierarchy is needed to get cgroups v1, which
seems to be needed for RT_GROUP_SCHED (at least I couldn't
find any options similar to cpu.rt_runtime_us with the default
cgroup v2).
Basically it boils down to that the combination of the
domain parameter to isolcpus and nohz_full together with
RT_GROUP_SCHED cause the problem I'm observing.

Does anyone have any idea what could be causing this?
Am I doing something wrong, or is there an issue with cyclictest or
even the kernel that's causing this?

My motivation is running (testing) a real-time container on isolated
cores, so I think I do need all the kernel parameters I used above to
get good latencies.

Regards,

Jonathan Schwender

