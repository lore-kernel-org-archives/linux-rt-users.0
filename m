Return-Path: <SRS0=t/x/=UZ=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13936C4646B
	for <linux-rt-users@archiver.kernel.org>; Wed, 26 Jun 2019 07:35:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0010208E3
	for <linux-rt-users@archiver.kernel.org>; Wed, 26 Jun 2019 07:35:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c8Bq644T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726648AbfFZHfI (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 26 Jun 2019 03:35:08 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:41285 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725797AbfFZHfI (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 26 Jun 2019 03:35:08 -0400
Received: by mail-pf1-f195.google.com with SMTP id m30so871114pff.8
        for <linux-rt-users@vger.kernel.org>; Wed, 26 Jun 2019 00:35:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=9cOlOuJsamJMtckMqRhrPsT9WJMRL8uiT/4JdPUn2Z4=;
        b=c8Bq644T9uooZDUhsR9HalNuKcu+ucT9ZVUGj3fpI1tNJqsRZAfa5uUrLkb/rbPXC7
         +0cM2RZtN47o7a8HSbZOibof6YvLPq+6GYwAlqLhjYzn4r2g9Z7d5xCZpLWPPXpqqqmP
         ivCd8UxCtPSIvfwflr0nFydUtCXzHfYdUcu3DSSPT1zyybuB20i0k3yPt/ncQSs6YUa5
         /pHuNSx/uT1QAtJqu4A3QmBShzJOueEUwchtPWgAHybYKSPsPqorprlFex84Vu+IEQfk
         CN1hdxcoKr4I5pJnmZ3r+WORRHX+Ce4i6j9J6JqVuaErsyNCy8iym0ISUw8ZCaVTel00
         VocQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=9cOlOuJsamJMtckMqRhrPsT9WJMRL8uiT/4JdPUn2Z4=;
        b=BQLW131+11rQPKskojRreS+ycWrn+1+L5OjQTontqvtO+5Ax5B34Ra9CjyoU3mf88l
         WE80Fs90UFtN00NI4qRQHzBdWfJpVm+y2Er9lenyT40LpB+qcvJNG3g6i+EE2z4NEm7+
         N0ui/lPC3iSoxOuetm60jvaIucx+LE3FJ5FWRzGYt95V5lAqN4JPvhtWg347mzKEv9jd
         VPqItroWqspfpKAZHsdzI7qiayCU7CXhSpX0UQuYjA1CDlqWvBWVRfjHv1AmBLNxd2Sc
         FO2ZZLBaouCaWQ1JXZLjNBIZx9zPokPmTBHTGXgUQIIsjO7m6VuGPVQz3qs2zjvFlyb4
         qimA==
X-Gm-Message-State: APjAAAV/PjqcwymEoQguR0ifIEk8gGEtfg1L0yYlkTuRLj6774CaMIdP
        AmioMOcoL2CqIZ+U/dYHOyGMo7rB+Qc=
X-Google-Smtp-Source: APXvYqz7KEAKRYSXgAR2TEMVYZ/vaB/uDw4jQnMtzgZwQkix1XDWXTk7Kbup6d4Sbv+NzSz1JlZgeA==
X-Received: by 2002:a17:90a:3270:: with SMTP id k103mr2926247pjb.54.1561534507362;
        Wed, 26 Jun 2019 00:35:07 -0700 (PDT)
Received: from [10.11.32.138] ([43.230.89.66])
        by smtp.gmail.com with ESMTPSA id x25sm17639557pfm.48.2019.06.26.00.35.06
        for <linux-rt-users@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Jun 2019 00:35:06 -0700 (PDT)
To:     linux-rt-users@vger.kernel.org
From:   "xiaoqiang.zhao" <zhaoxiaoqiang007@gmail.com>
Subject: schdule bug in 4.4.38-rt49
Message-ID: <55c68f08-4160-4bee-fdc5-9fc1ea86cf57@gmail.com>
Date:   Wed, 26 Jun 2019 15:35:04 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi, guys:

     I have built a kernel 4.4.38-rt49 with CONFIG_PREEMPT_RT_FULL=y , 
the kernel crash when I run the UnixBench of spawn test case.

     Here is the oops info:

[  206.143829] BUG: scheduling while atomic: spawn/27356/0x00000002
[  206.143839] Modules linked in: bcmdhd pci_tegra bluedroid_pm ip_tables
[  206.143846] CPU: 5 PID: 27356 Comm: spawn Tainted: G W       
4.4.38-DATA-RT-g06219d69-dirty #7
[  206.143848] Hardware name: quill (DT)
[  206.143850] Call trace:
[  206.143871] [<ffffffc0000898f0>] dump_backtrace+0x0/0x100
[  206.143875] [<ffffffc000089ab8>] show_stack+0x14/0x1c
[  206.143884] [<ffffffc000314120>] dump_stack+0x98/0xc0
[  206.143902] [<ffffffc00016c330>] __schedule_bug+0x44/0x5c
[  206.143911] [<ffffffc000afd690>] __schedule+0x418/0x4f4
[  206.143913] [<ffffffc000afd7b8>] schedule+0x4c/0xe4
[  206.143918] [<ffffffc000afeeb8>] rt_spin_lock_slowlock+0x194/0x2c4
[  206.143921] [<ffffffc000b0048c>] rt_spin_lock+0x58/0x5c
[  206.143926] [<ffffffc0000e4678>] __wake_up+0x20/0x4c
[  206.143930] [<ffffffc0000e6d58>] __percpu_up_read+0x34/0x3c
[  206.143939] [<ffffffc0000a2de0>] copy_process.isra.52+0x136c/0x19f0
[  206.143942] [<ffffffc0000a3590>] _do_fork+0x74/0x39c
[  206.143945] [<ffffffc0000a3980>] SyS_clone+0x1c/0x24
[  206.143949] [<ffffffc000084ff0>] el0_svc_naked+0x24/0x28
[  206.143963] Unable to handle kernel paging request at virtual address 
7ff31fc040
[  206.143964] pgd = ffffffc1df8d7000
[  206.143985] [7ff31fc040] *pgd=0000000262400003, 
*pud=0000000262400003, *pmd=000000025ff4c003, *pte=00e0000255829f3
[  206.143989] Internal error: Oops: 9200004f [#1] PREEMPT SMP
[  206.143996] Modules linked in: bcmdhd pci_tegra bluedroid_pm ip_tables
[  206.143999] CPU: 5 PID: 27356 Comm: spawn Tainted: G W       
4.4.38-DATA-RT-g06219d69-dirty #7
[  206.144000] Hardware name: quill (DT)
[  206.144002] task: ffffffc1e45bd100 ti: ffffffc1e0320000 task.ti: 
ffffffc1e0320000
[  206.144005] PC is at 0x7f9fb6a198
[  206.144006] LR is at 0x559517b9b0
[  206.144008] pc : [<0000007f9fb6a198>] lr : [<000000559517b9b0>] 
pstate: 20000000
[  206.144009] sp : 0000007ff31fc060
[  206.144013] x29: 0000007ff31fc0a0 x28: 0000000000000000
[  206.144016] x27: 0000000000000000 x26: 0000000000000000
[  206.144018] x25: 0000000000000000 x24: 0000000000000000
[  206.144021] x23: 0000000000000000 x22: 000000000000001e
[  206.144023] x21: 000000559518b000 x20: 0000007ff31fc094
[  206.144026] x19: 000000559518c048 x18: 0000000000000003
[  206.144028] x17: 0000007f9fb6a198 x16: 000000559518bf90
[  206.144030] x15: 0000007f9fc4c150 x14: 0000000000000008
[  206.144033] x13: 0000007f9fc2a34c x12: 0000007ff31fbfa0
[  206.144035] x11: 0000007f9fc4f740 x10: 0000000000000000
[  206.144038] x9 : 0000007ff31fc128 x8 : 00000000000000dc
[  206.144040] x7 : 0000007f9fbee088 x6 : 0000007f9fc4fac8
[  206.144042] x5 : 0000007f9fc40bb0 x4 : 0000007f9fc40c80
[  206.144045] x3 : 0000000000000000 x2 : 8c391e6c47b6d000
[  206.144047] x1 : 0000000000000000 x0 : 0000007ff31fc094
[  206.144048]
[  206.144050] Process spawn (pid: 27356, stack limit = 0xffffffc1e0320028)


The call path is:

  do_fork-> copy_process -> threadgroup_change_end -> 
percpu_up_read(call preempt_disable) -> __percpu_up_read

  -> wake_up -> rt_spin_lock -> rt_spin_lock_slowlock ->  schedule(call 
preempt_disable again) -> __schedule

  -> schedule_debug -> in_aotmic_preempt_off (return true, preempt_count 
== 2) -> __schedule_bug ( leads to kernel pagefault exception, OOPS!!)

Before schedule, we have call preempt_disable twice, this will 
definitely bump preempt_count to 2 and

in_atomic_preempt_off will fail.

I did not figure out:   WHY we call schedule inside 
rt_spin_lock_slowlock and under what condition this call is correct ?

Any ideas ?



