Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1D32C433ED
	for <linux-rt-users@archiver.kernel.org>; Thu, 20 May 2021 08:08:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93E8461059
	for <linux-rt-users@archiver.kernel.org>; Thu, 20 May 2021 08:08:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230383AbhETIKM (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 20 May 2021 04:10:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbhETIKM (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 20 May 2021 04:10:12 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D668AC061574
        for <linux-rt-users@vger.kernel.org>; Thu, 20 May 2021 01:08:49 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id c20so23850118ejm.3
        for <linux-rt-users@vger.kernel.org>; Thu, 20 May 2021 01:08:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:references:from:to:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=LViAtvlG4iN6MdWE1brU/HZOElcuCYhd+RSpLOV/aIc=;
        b=tK/u4Cgxug0u2Edz8JUhxjw8oSBet6gn5Tv7Vl36PMIk8mBxJghgcjTLMw1IqBZU24
         7m3BUjeP6QFFB9WsKujMUOYRzWmEhFa5ZP+Lnonvl1Y6mgp3Xsctn5KjFXQ66kql7jh8
         UXG0IzBJfvbJPxVdgoXalmN/3E+1MJePFLeM6CE73/0aMMy6+O4nR/QPbnDuIvDWdR0d
         Q4poN5QEkN66EZUpRuG4y87u6c1jEMzcOUuN2psamrxhWT+TnrRvv5QbYZGhtjNQA+P5
         lbOoMIJaTE/FFWmku6BUxHMDzXDkbTHQrQ5b6kpfcXSLcaJSWLsOHV6iedftLbzGZ7XB
         t1dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:references:from:to:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LViAtvlG4iN6MdWE1brU/HZOElcuCYhd+RSpLOV/aIc=;
        b=Z4CdPq+DLl1D9dz1BYybEw7K++OaukcBg9R6dZCsr5KFgP1jl85kAyv/3czwMen50E
         WWoC001lXvU9zTN5XW6hVBZ7roH65P4kryD3HPvm/th2pl6wntricX8KtmcsuPdzNYgV
         kejMjb2vKsJsmHi7r5os2eVjBquy9GK5L30X0ghHoUHpBCNjTcVReH3wX4cXOzZTWE4c
         9h18412asJwczFzlawBs4nhaK02GNDrRRP739qGIcihCGjHnGfTTQKnA4e3npkb56qKE
         3xuNZyou/jClk10ssjGEoGBWuDWWlFwN1zZHNEeU5IukBB81d1Zw7YHfn6GH5GaJNfJR
         XmBA==
X-Gm-Message-State: AOAM533vNrj8HQi8Wgrlle5C6n90T1NixEn9UY58Rfq2cVOQkFaIj8MB
        G0wmC0CXKjQ2ZG9sfbZ/H/B4J9DULZc=
X-Google-Smtp-Source: ABdhPJyBXLOJnUEOk54yDE9Ei8j4Z+PAsC9IQp9zOftdiBkuS6XdW7NnHsD+5iT08BiD0pUMVDcDlg==
X-Received: by 2002:a17:906:4ece:: with SMTP id i14mr3297626ejv.249.1621498128159;
        Thu, 20 May 2021 01:08:48 -0700 (PDT)
Received: from [192.168.1.11] (46-22-16-89-dynamic-cgnat.cust.swissbackbone.net. [46.22.16.89])
        by smtp.gmail.com with ESMTPSA id r17sm1079549edt.33.2021.05.20.01.08.47
        for <linux-rt-users@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 May 2021 01:08:47 -0700 (PDT)
Subject: Re: Network latency on 5.4 and 5.10
References: <6aa61bb9-0443-6da3-0902-9fe700c24017@gmail.com>
From:   Christoph Mathys <eraserix@gmail.com>
To:     linux-rt-users@vger.kernel.org
Message-ID: <02fc4446-9be6-7fc8-b60a-b47785371dca@gmail.com>
Date:   Thu, 20 May 2021 10:08:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <6aa61bb9-0443-6da3-0902-9fe700c24017@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

While investigating the network latency on 5.4 I noticed
that the packat latencies gets much worse when I run
"stress --hdd 2".

I tried to run cyclictest at the same prio (=80) as the
network interrupt threads and observed very high cyclictest
latencies (this does not happen on 4.9).

The control loop runs at a 250us interval sending and
receiving an EtherCAT packet in every cycle. Below is
a trace of one "normal" iteration and then the last one
which triggered a 400us+ latency on cyclictest.

  - irq/132-ecat0-t: nic tx irq thread @ rt prio 80
  - irq/131-ecat0-r: nic rx irq thread @ rt prio 80
  - EtherlabDaemon-5200: control loop @ rt prio 79
  - EtherCATControl-4181: control loop @ rt prio 79

     kworker/u4:4-91      [000] d...211   169.985712: sched_switch: prev_comm=kworker/u4:4 prev_pid=91 prev_prio=120 prev_state=R+ ==> next_comm=irq/140-nvme0q1 next_pid=157 next_prio=49
  irq/140-nvme0q1-157     [000] .....12   169.985713: nvme_sq: nvme0: disk=nvme0n1, qid=1, head=767, tail=767
  irq/140-nvme0q1-157     [000] .....13   169.985714: nvme_complete_rq: nvme0: disk=nvme0n1, qid=1, cmdid=670, res=0x0, retries=0, flags=0x0, status=0x0
  irq/140-nvme0q1-157     [000] d..h214   169.985716: sched_waking: comm=EtherlabDaemon pid=5200 prio=20 target_cpu=000
  irq/140-nvme0q1-157     [000] d..h214   169.985716: sched_migrate_task: comm=EtherlabDaemon pid=5200 prio=20 orig_cpu=0 dest_cpu=1
  irq/140-nvme0q1-157     [000] d..h314   169.985716: sched_wakeup: comm=EtherlabDaemon pid=5200 prio=20 target_cpu=001
  
  Wakeup control loop 5716
  
           stress-6348    [001] dN..211   169.985717: sched_stat_runtime: comm=stress pid=6348 runtime=32699 [ns] vruntime=12653242325 [ns]
  irq/140-nvme0q1-157     [000] d...314   169.985717: sched_waking: comm=stress pid=6348 prio=120 target_cpu=001
           stress-6348    [001] d...211   169.985717: sched_switch: prev_comm=stress prev_pid=6348 prev_prio=120 prev_state=R+ ==> next_comm=EtherlabDaemon next_pid=5200 next_prio=20
  irq/140-nvme0q1-157     [000] d...414   169.985720: sched_wakeup: comm=stress pid=6348 prio=120 target_cpu=001
   EtherlabDaemon-5200    [001] d...2..   169.985735: sched_waking: comm=EtherCATControl pid=4181 prio=20 target_cpu=001
   EtherlabDaemon-5200    [001] d...2..   169.985736: sched_migrate_task: comm=EtherCATControl pid=4181 prio=20 orig_cpu=1 dest_cpu=0
   EtherlabDaemon-5200    [001] d...3..   169.985737: sched_wakeup: comm=EtherCATControl pid=4181 prio=20 target_cpu=000
  irq/140-nvme0q1-157     [000] d...214   169.985737: sched_switch: prev_comm=irq/140-nvme0q1 prev_pid=157 prev_prio=49 prev_state=R+ ==> next_comm=EtherCATControl next_pid=4181 next_prio=20
   EtherlabDaemon-5200    [001] d...2..   169.985740: sched_switch: prev_comm=EtherlabDaemon prev_pid=5200 prev_prio=20 prev_state=S ==> next_comm=stress next_pid=6348 next_prio=120
           stress-6348    [001] d...211   169.985743: sched_stat_runtime: comm=stress pid=6348 runtime=4002 [ns] vruntime=12653246327 [ns]
  EtherCATControl-4181    [000] d..h2..   169.985743: sched_waking: comm=irq/132-ecat0-t pid=3892 prio=19 target_cpu=000
           stress-6348    [001] d...211   169.985744: sched_stat_runtime: comm=stress pid=6348 runtime=809 [ns] vruntime=12653247136 [ns]
  EtherCATControl-4181    [000] dN.h3..   169.985744: sched_wakeup: comm=irq/132-ecat0-t pid=3892 prio=19 target_cpu=000
  
  Wakeup net-send 5744
  
           stress-6348    [001] d...211   169.985745: sched_switch: prev_comm=stress prev_pid=6348 prev_prio=120 prev_state=D ==> next_comm=swapper/1 next_pid=0 next_prio=120
  EtherCATControl-4181    [000] d...2..   169.985745: sched_switch: prev_comm=EtherCATControl prev_pid=4181 prev_prio=20 prev_state=R ==> next_comm=irq/132-ecat0-t next_pid=3892 next_prio=19
  irq/132-ecat0-t-3892    [000] d...3..   169.985746: sched_migrate_task: comm=EtherCATControl pid=4181 prio=20 orig_cpu=0 dest_cpu=1
  irq/132-ecat0-t-3892    [000] d...3..   169.985746: sched_wake_idle_without_ipi: cpu=1
           <idle>-0       [001] d...2..   169.985747: sched_switch: prev_comm=swapper/1 prev_pid=0 prev_prio=120 prev_state=R ==> next_comm=EtherCATControl next_pid=4181 next_prio=20
  irq/132-ecat0-t-3892    [000] d...312   169.985747: sched_pi_setprio: comm=irq/140-nvme0q1 pid=157 oldprio=49 newprio=19
  irq/132-ecat0-t-3892    [000] d...212   169.985748: sched_switch: prev_comm=irq/132-ecat0-t prev_pid=3892 prev_prio=19 prev_state=D ==> next_comm=irq/140-nvme0q1 next_pid=157 next_prio=19
  
  net-send done 5748
  
  irq/140-nvme0q1-157     [000] d...314   169.985749: sched_waking: comm=stress pid=6348 prio=120 target_cpu=001
  irq/140-nvme0q1-157     [000] d...414   169.985750: sched_wakeup: comm=stress pid=6348 prio=120 target_cpu=001
  EtherCATControl-4181    [001] d...2..   169.985782: sched_waking: comm=EtherlabDaemon pid=5200 prio=20 target_cpu=001
  EtherCATControl-4181    [001] d...3..   169.985783: sched_wakeup: comm=EtherlabDaemon pid=5200 prio=20 target_cpu=001
  EtherCATControl-4181    [001] d...2..   169.985786: sched_switch: prev_comm=EtherCATControl prev_pid=4181 prev_prio=20 prev_state=S ==> next_comm=EtherlabDaemon next_pid=5200 next_prio=20
   EtherlabDaemon-5200    [001] d...2..   169.985792: sched_switch: prev_comm=EtherlabDaemon prev_pid=5200 prev_prio=20 prev_state=S ==> next_comm=stress next_pid=6348 next_prio=120
  irq/140-nvme0q1-157     [000] d..h514   169.985793: sched_waking: comm=cyclictest pid=5753 prio=19 target_cpu=000
  irq/140-nvme0q1-157     [000] d..h614   169.985794: sched_wakeup: comm=cyclictest pid=5753 prio=19 target_cpu=000
  irq/140-nvme0q1-157     [000] d...314   169.985796: sched_pi_setprio: comm=stress pid=6348 oldprio=120 newprio=19
  irq/140-nvme0q1-157     [000] d...314   169.985796: sched_stat_runtime: comm=stress pid=6348 runtime=4476 [ns] vruntime=12653251612 [ns]
           stress-6348    [001] d...311   169.985798: sched_pi_setprio: comm=stress pid=6348 oldprio=19 newprio=120
           stress-6348    [001] dN..311   169.985800: sched_waking: comm=irq/140-nvme0q1 pid=157 prio=19 target_cpu=000
           stress-6348    [001] dN..411   169.985800: sched_wakeup: comm=irq/140-nvme0q1 pid=157 prio=19 target_cpu=000
           stress-6348    [001] dN..211   169.985801: sched_stat_runtime: comm=stress pid=6348 runtime=2795 [ns] vruntime=12653254407 [ns]
  irq/140-nvme0q1-157     [000] d...314   169.985804: sched_pi_setprio: comm=stress pid=6348 oldprio=120 newprio=19
  irq/140-nvme0q1-157     [000] d...314   169.985804: sched_stat_runtime: comm=stress pid=6348 runtime=3889 [ns] vruntime=12653258296 [ns]
           stress-6348    [001] d...311   169.985806: sched_pi_setprio: comm=stress pid=6348 oldprio=19 newprio=120
           stress-6348    [001] dN..311   169.985807: sched_waking: comm=irq/140-nvme0q1 pid=157 prio=19 target_cpu=000
           stress-6348    [001] dN..411   169.985807: sched_wakeup: comm=irq/140-nvme0q1 pid=157 prio=19 target_cpu=000
           stress-6348    [001] dN..211   169.985807: sched_stat_runtime: comm=stress pid=6348 runtime=1701 [ns] vruntime=12653259997 [ns]
  irq/140-nvme0q1-157     [000] d...314   169.985815: sched_waking: comm=stress pid=6348 prio=120 target_cpu=001
  irq/140-nvme0q1-157     [000] d...414   169.985815: sched_wakeup: comm=stress pid=6348 prio=120 target_cpu=001
  irq/140-nvme0q1-157     [000] d...314   169.985816: sched_pi_setprio: comm=stress pid=6348 oldprio=120 newprio=19
  irq/140-nvme0q1-157     [000] d...314   169.985816: sched_stat_runtime: comm=stress pid=6348 runtime=8482 [ns] vruntime=12653268479 [ns]
           stress-6348    [001] d...311   169.985817: sched_pi_setprio: comm=stress pid=6348 oldprio=19 newprio=120
           stress-6348    [001] dN..311   169.985818: sched_waking: comm=irq/140-nvme0q1 pid=157 prio=19 target_cpu=000
           stress-6348    [001] dN..411   169.985818: sched_wakeup: comm=irq/140-nvme0q1 pid=157 prio=19 target_cpu=000
           stress-6348    [001] dN..211   169.985819: sched_stat_runtime: comm=stress pid=6348 runtime=1561 [ns] vruntime=12653270040 [ns]
  irq/140-nvme0q1-157     [000] d...314   169.985820: sched_waking: comm=stress pid=6348 prio=120 target_cpu=001
  irq/140-nvme0q1-157     [000] d...414   169.985821: sched_wakeup: comm=stress pid=6348 prio=120 target_cpu=001
  irq/140-nvme0q1-157     [000] d...314   169.985823: sched_pi_setprio: comm=stress pid=6348 oldprio=120 newprio=19
  irq/140-nvme0q1-157     [000] d...314   169.985823: sched_stat_runtime: comm=stress pid=6348 runtime=4379 [ns] vruntime=12653274419 [ns]
           stress-6348    [001] d...311   169.985824: sched_pi_setprio: comm=stress pid=6348 oldprio=19 newprio=120
           stress-6348    [001] dN..311   169.985825: sched_waking: comm=irq/140-nvme0q1 pid=157 prio=19 target_cpu=000
           stress-6348    [001] dN..411   169.985825: sched_wakeup: comm=irq/140-nvme0q1 pid=157 prio=19 target_cpu=000
           stress-6348    [001] dN..211   169.985826: sched_stat_runtime: comm=stress pid=6348 runtime=1510 [ns] vruntime=12653275929 [ns]
  irq/140-nvme0q1-157     [000] d...314   169.985828: sched_pi_setprio: comm=stress pid=6348 oldprio=120 newprio=19
  irq/140-nvme0q1-157     [000] d...314   169.985829: sched_stat_runtime: comm=stress pid=6348 runtime=2966 [ns] vruntime=12653278895 [ns]
           stress-6348    [001] d...311   169.985830: sched_pi_setprio: comm=stress pid=6348 oldprio=19 newprio=120
           stress-6348    [001] dN..311   169.985831: sched_waking: comm=irq/140-nvme0q1 pid=157 prio=19 target_cpu=000
           stress-6348    [001] dN..411   169.985831: sched_wakeup: comm=irq/140-nvme0q1 pid=157 prio=19 target_cpu=000
           stress-6348    [001] dN..211   169.985831: sched_stat_runtime: comm=stress pid=6348 runtime=1578 [ns] vruntime=12653280473 [ns]
  irq/140-nvme0q1-157     [000] d...314   169.985839: sched_pi_setprio: comm=stress pid=6348 oldprio=120 newprio=19
  irq/140-nvme0q1-157     [000] d...314   169.985839: sched_stat_runtime: comm=stress pid=6348 runtime=7921 [ns] vruntime=12653288394 [ns]
           stress-6348    [001] d...311   169.985840: sched_pi_setprio: comm=stress pid=6348 oldprio=19 newprio=120
           stress-6348    [001] dN..311   169.985841: sched_waking: comm=irq/140-nvme0q1 pid=157 prio=19 target_cpu=000
           stress-6348    [001] dN..411   169.985841: sched_wakeup: comm=irq/140-nvme0q1 pid=157 prio=19 target_cpu=000
           stress-6348    [001] dN..211   169.985842: sched_stat_runtime: comm=stress pid=6348 runtime=1508 [ns] vruntime=12653289902 [ns]
  irq/140-nvme0q1-157     [000] d...314   169.985845: sched_pi_setprio: comm=stress pid=6348 oldprio=120 newprio=19
  irq/140-nvme0q1-157     [000] d...314   169.985845: sched_stat_runtime: comm=stress pid=6348 runtime=3004 [ns] vruntime=12653292906 [ns]
           stress-6348    [001] d...211   169.985845: sched_waking: comm=ksoftirqd/1 pid=21 prio=120 target_cpu=001
           stress-6348    [001] d...311   169.985846: sched_wakeup: comm=ksoftirqd/1 pid=21 prio=120 target_cpu=001
           stress-6348    [001] d...311   169.985847: sched_pi_setprio: comm=stress pid=6348 oldprio=19 newprio=120
           stress-6348    [001] dN..311   169.985848: sched_waking: comm=irq/140-nvme0q1 pid=157 prio=19 target_cpu=000
           stress-6348    [001] dN..411   169.985848: sched_wakeup: comm=irq/140-nvme0q1 pid=157 prio=19 target_cpu=000
           stress-6348    [001] dN..211   169.985848: sched_stat_runtime: comm=stress pid=6348 runtime=1401 [ns] vruntime=12653294307 [ns]
           stress-6348    [001] d...211   169.985849: sched_switch: prev_comm=stress prev_pid=6348 prev_prio=120 prev_state=R+ ==> next_comm=ksoftirqd/1 next_pid=21 next_prio=120
      ksoftirqd/1-21      [001] d...213   169.985850: sched_waking: comm=EtherlabDaemon pid=3998 prio=120 target_cpu=001
      ksoftirqd/1-21      [001] d...313   169.985850: sched_stat_runtime: comm=ksoftirqd/1 pid=21 runtime=1929 [ns] vruntime=62640055548 [ns]
      ksoftirqd/1-21      [001] d...313   169.985851: sched_wakeup: comm=EtherlabDaemon pid=3998 prio=120 target_cpu=001
      ksoftirqd/1-21      [001] d..h413   169.985852: sched_waking: comm=irq/131-ecat0-r pid=3891 prio=19 target_cpu=001
      ksoftirqd/1-21      [001] dN.h513   169.985852: sched_wakeup: comm=irq/131-ecat0-r pid=3891 prio=19 target_cpu=001
      
wakeup net receive 5852
      
      ksoftirqd/1-21      [001] dN..213   169.985852: sched_stat_runtime: comm=ksoftirqd/1 pid=21 runtime=1513 [ns] vruntime=62640057061 [ns]
      ksoftirqd/1-21      [001] d...213   169.985853: sched_switch: prev_comm=ksoftirqd/1 prev_pid=21 prev_prio=120 prev_state=R+ ==> next_comm=irq/131-ecat0-r next_pid=3891 next_prio=19
  irq/131-ecat0-r-3891    [001] d...312   169.985853: sched_pi_setprio: comm=ksoftirqd/1 pid=21 oldprio=120 newprio=19
  irq/131-ecat0-r-3891    [001] d...212   169.985855: sched_switch: prev_comm=irq/131-ecat0-r prev_pid=3891 prev_prio=19 prev_state=D ==> next_comm=ksoftirqd/1 next_pid=21 next_prio=19
      ksoftirqd/1-21      [001] d...312   169.985855: sched_pi_setprio: comm=ksoftirqd/1 pid=21 oldprio=19 newprio=120
      ksoftirqd/1-21      [001] dN..312   169.985856: sched_waking: comm=irq/131-ecat0-r pid=3891 prio=19 target_cpu=001
      ksoftirqd/1-21      [001] dN..412   169.985856: sched_wakeup: comm=irq/131-ecat0-r pid=3891 prio=19 target_cpu=001
      ksoftirqd/1-21      [001] dN..212   169.985856: sched_stat_runtime: comm=ksoftirqd/1 pid=21 runtime=814 [ns] vruntime=62640057875 [ns]
      ksoftirqd/1-21      [001] d...212   169.985857: sched_switch: prev_comm=ksoftirqd/1 prev_pid=21 prev_prio=120 prev_state=R+ ==> next_comm=irq/131-ecat0-r next_pid=3891 next_prio=19
  irq/131-ecat0-r-3891    [001] d...2..   169.985858: sched_switch: prev_comm=irq/131-ecat0-r prev_pid=3891 prev_prio=19 prev_state=S ==> next_comm=EtherlabDaemon next_pid=3998 next_prio=120
  
net receive done 5858

   EtherlabDaemon-3998    [001] d...2..   169.985865: sched_stat_runtime: comm=EtherlabDaemon pid=3998 runtime=6760 [ns] vruntime=20976020850 [ns]
   EtherlabDaemon-3998    [001] d...2..   169.985866: sched_switch: prev_comm=EtherlabDaemon prev_pid=3998 prev_prio=120 prev_state=S ==> next_comm=ksoftirqd/1 next_pid=21 next_prio=120
      ksoftirqd/1-21      [001] d...2..   169.985868: sched_stat_runtime: comm=ksoftirqd/1 pid=21 runtime=3909 [ns] vruntime=62640061784 [ns]
      ksoftirqd/1-21      [001] d...2..   169.985869: sched_switch: prev_comm=ksoftirqd/1 prev_pid=21 prev_prio=120 prev_state=S ==> next_comm=stress next_pid=6348 next_prio=120
  irq/140-nvme0q1-157     [000] d...314   169.985874: sched_pi_setprio: comm=stress pid=6348 oldprio=120 newprio=19
  irq/140-nvme0q1-157     [000] d...314   169.985874: sched_stat_runtime: comm=stress pid=6348 runtime=5573 [ns] vruntime=12653299880 [ns]
           stress-6348    [001] d...311   169.985875: sched_pi_setprio: comm=stress pid=6348 oldprio=19 newprio=120
           stress-6348    [001] dN..311   169.985877: sched_waking: comm=irq/140-nvme0q1 pid=157 prio=19 target_cpu=000
           stress-6348    [001] dN..411   169.985877: sched_wakeup: comm=irq/140-nvme0q1 pid=157 prio=19 target_cpu=000
           stress-6348    [001] dN..211   169.985877: sched_stat_runtime: comm=stress pid=6348 runtime=2275 [ns] vruntime=12653302155 [ns]
  irq/140-nvme0q1-157     [000] d...314   169.985881: sched_pi_setprio: comm=stress pid=6348 oldprio=120 newprio=19
  irq/140-nvme0q1-157     [000] d...314   169.985881: sched_stat_runtime: comm=stress pid=6348 runtime=3173 [ns] vruntime=12653305328 [ns]
           stress-6348    [001] d...311   169.985882: sched_pi_setprio: comm=stress pid=6348 oldprio=19 newprio=120
           stress-6348    [001] dN..311   169.985883: sched_waking: comm=irq/140-nvme0q1 pid=157 prio=19 target_cpu=000
           stress-6348    [001] dN..411   169.985883: sched_wakeup: comm=irq/140-nvme0q1 pid=157 prio=19 target_cpu=000
           stress-6348    [001] dN..211   169.985883: sched_stat_runtime: comm=stress pid=6348 runtime=1533 [ns] vruntime=12653306861 [ns]
  irq/140-nvme0q1-157     [000] d...314   169.985889: sched_waking: comm=stress pid=6348 prio=120 target_cpu=001
  irq/140-nvme0q1-157     [000] d...414   169.985889: sched_wakeup: comm=stress pid=6348 prio=120 target_cpu=001
  irq/140-nvme0q1-157     [000] d...314   169.985890: sched_pi_setprio: comm=stress pid=6348 oldprio=120 newprio=19
  irq/140-nvme0q1-157     [000] d...314   169.985890: sched_stat_runtime: comm=stress pid=6348 runtime=6763 [ns] vruntime=12653313624 [ns]
           stress-6348    [001] d...311   169.985891: sched_pi_setprio: comm=stress pid=6348 oldprio=19 newprio=120
           stress-6348    [001] dN..311   169.985892: sched_waking: comm=irq/140-nvme0q1 pid=157 prio=19 target_cpu=000
           stress-6348    [001] dN..411   169.985892: sched_wakeup: comm=irq/140-nvme0q1 pid=157 prio=19 target_cpu=000
           stress-6348    [001] dN..211   169.985892: sched_stat_runtime: comm=stress pid=6348 runtime=1528 [ns] vruntime=12653315152 [ns]
  irq/140-nvme0q1-157     [000] d...314   169.985894: sched_pi_setprio: comm=stress pid=6348 oldprio=120 newprio=19
  irq/140-nvme0q1-157     [000] d...314   169.985894: sched_stat_runtime: comm=stress pid=6348 runtime=1780 [ns] vruntime=12653316932 [ns]
           stress-6348    [001] d...311   169.985895: sched_pi_setprio: comm=stress pid=6348 oldprio=19 newprio=120
  irq/140-nvme0q1-157     [000] d..h214   169.985896: sched_waking: comm=irq/140-nvme0q1 pid=157 prio=19 target_cpu=000
  irq/140-nvme0q1-157     [000] d..h314   169.985896: sched_wakeup: comm=irq/140-nvme0q1 pid=157 prio=19 target_cpu=000
           stress-6348    [001] dN..211   169.985897: sched_stat_runtime: comm=stress pid=6348 runtime=1471 [ns] vruntime=12653318403 [ns]
  irq/140-nvme0q1-157     [000] d...314   169.985900: sched_waking: comm=stress pid=6348 prio=120 target_cpu=001
  irq/140-nvme0q1-157     [000] d...414   169.985901: sched_wakeup: comm=stress pid=6348 prio=120 target_cpu=001
  irq/140-nvme0q1-157     [000] d...314   169.985901: sched_pi_setprio: comm=stress pid=6348 oldprio=120 newprio=19
  irq/140-nvme0q1-157     [000] d...314   169.985902: sched_stat_runtime: comm=stress pid=6348 runtime=4502 [ns] vruntime=12653322905 [ns]
           stress-6348    [001] d...311   169.985902: sched_pi_setprio: comm=stress pid=6348 oldprio=19 newprio=120
           stress-6348    [001] dN..311   169.985903: sched_waking: comm=irq/140-nvme0q1 pid=157 prio=19 target_cpu=000
           stress-6348    [001] dN..411   169.985904: sched_wakeup: comm=irq/140-nvme0q1 pid=157 prio=19 target_cpu=000
           stress-6348    [001] dN..211   169.985904: sched_stat_runtime: comm=stress pid=6348 runtime=1466 [ns] vruntime=12653324371 [ns]
  irq/140-nvme0q1-157     [000] d...314   169.985906: sched_waking: comm=stress pid=6348 prio=120 target_cpu=001
  irq/140-nvme0q1-157     [000] d...414   169.985906: sched_wakeup: comm=stress pid=6348 prio=120 target_cpu=001
  irq/140-nvme0q1-157     [000] d...314   169.985907: sched_pi_setprio: comm=stress pid=6348 oldprio=120 newprio=19
  irq/140-nvme0q1-157     [000] d...314   169.985907: sched_stat_runtime: comm=stress pid=6348 runtime=2695 [ns] vruntime=12653327066 [ns]
           stress-6348    [001] d...311   169.985908: sched_pi_setprio: comm=stress pid=6348 oldprio=19 newprio=120
           stress-6348    [001] dN..311   169.985909: sched_waking: comm=irq/140-nvme0q1 pid=157 prio=19 target_cpu=000
           stress-6348    [001] dN..411   169.985909: sched_wakeup: comm=irq/140-nvme0q1 pid=157 prio=19 target_cpu=000
           stress-6348    [001] dN..211   169.985909: sched_stat_runtime: comm=stress pid=6348 runtime=1419 [ns] vruntime=12653328485 [ns]
  irq/140-nvme0q1-157     [000] d...314   169.985911: sched_pi_setprio: comm=stress pid=6348 oldprio=120 newprio=19
  irq/140-nvme0q1-157     [000] d...314   169.985911: sched_stat_runtime: comm=stress pid=6348 runtime=1859 [ns] vruntime=12653330344 [ns]
           stress-6348    [001] d...311   169.985912: sched_pi_setprio: comm=stress pid=6348 oldprio=19 newprio=120
           stress-6348    [001] dN.h411   169.985914: sched_waking: comm=cyclictest pid=5754 prio=19 target_cpu=001
           stress-6348    [001] dN.h511   169.985914: sched_wakeup: comm=cyclictest pid=5754 prio=19 target_cpu=001
           stress-6348    [001] dN.h411   169.985914: sched_waking: comm=SafetyLogicShad pid=3990 prio=30 target_cpu=001
           stress-6348    [001] dN.h511   169.985915: sched_wakeup: comm=SafetyLogicShad pid=3990 prio=30 target_cpu=001
           stress-6348    [001] dN..211   169.985916: sched_stat_runtime: comm=stress pid=6348 runtime=2695 [ns] vruntime=12653333039 [ns]
           stress-6348    [001] d...211   169.985916: sched_switch: prev_comm=stress prev_pid=6348 prev_prio=120 prev_state=R+ ==> next_comm=cyclictest next_pid=5754 next_prio=19
       cyclictest-5754    [001] d...2..   169.985920: sched_switch: prev_comm=cyclictest prev_pid=5754 prev_prio=19 prev_state=S ==> next_comm=SafetyLogicShad next_pid=3990 next_prio=30
  SafetyLogicShad-3990    [001] d...2..   169.985958: sched_switch: prev_comm=SafetyLogicShad prev_pid=3990 prev_prio=30 prev_state=S ==> next_comm=stress next_pid=6348 next_prio=120
  irq/140-nvme0q1-157     [000] d...314   169.985964: sched_pi_setprio: comm=stress pid=6348 oldprio=120 newprio=19
  irq/140-nvme0q1-157     [000] d...314   169.985964: sched_stat_runtime: comm=stress pid=6348 runtime=7141 [ns] vruntime=12653340180 [ns]
           stress-6348    [001] d...311   169.985965: sched_pi_setprio: comm=stress pid=6348 oldprio=19 newprio=120
           stress-6348    [001] dN.h411   169.985967: sched_waking: comm=EtherlabDaemon pid=5200 prio=20 target_cpu=001
           stress-6348    [001] dN.h511   169.985968: sched_wakeup: comm=EtherlabDaemon pid=5200 prio=20 target_cpu=001

Wakeup next control loop cycle 5967
         
           stress-6348    [001] dN..211   169.985969: sched_stat_runtime: comm=stress pid=6348 runtime=2493 [ns] vruntime=12653342673 [ns]
           stress-6348    [001] d...211   169.985969: sched_switch: prev_comm=stress prev_pid=6348 prev_prio=120 prev_state=R+ ==> next_comm=EtherlabDaemon next_pid=5200 next_prio=20
  irq/140-nvme0q1-157     [000] d..h214   169.985976: sched_waking: comm=SafetyLogic pid=3989 prio=30 target_cpu=000
  irq/140-nvme0q1-157     [000] d..h314   169.985977: sched_wakeup: comm=SafetyLogic pid=3989 prio=30 target_cpu=000
   EtherlabDaemon-5200    [001] d...2..   169.985987: sched_waking: comm=EtherCATControl pid=4181 prio=20 target_cpu=001
   EtherlabDaemon-5200    [001] d...3..   169.985988: sched_wakeup: comm=EtherCATControl pid=4181 prio=20 target_cpu=001
   EtherlabDaemon-5200    [001] d...2..   169.985991: sched_switch: prev_comm=EtherlabDaemon prev_pid=5200 prev_prio=20 prev_state=S ==> next_comm=EtherCATControl next_pid=4181 next_prio=20
  EtherCATControl-4181    [001] d...2..   169.986023: sched_waking: comm=EtherlabDaemon pid=5200 prio=20 target_cpu=001
  EtherCATControl-4181    [001] d...3..   169.986024: sched_wakeup: comm=EtherlabDaemon pid=5200 prio=20 target_cpu=001
  EtherCATControl-4181    [001] d...2..   169.986027: sched_switch: prev_comm=EtherCATControl prev_pid=4181 prev_prio=20 prev_state=S ==> next_comm=EtherlabDaemon next_pid=5200 next_prio=20
   EtherlabDaemon-5200    [001] d...2..   169.986033: sched_switch: prev_comm=EtherlabDaemon prev_pid=5200 prev_prio=20 prev_state=S ==> next_comm=stress next_pid=6348 next_prio=120
  irq/140-nvme0q1-157     [000] d...314   169.986039: sched_pi_setprio: comm=stress pid=6348 oldprio=120 newprio=19
  irq/140-nvme0q1-157     [000] d...314   169.986039: sched_stat_runtime: comm=stress pid=6348 runtime=7186 [ns] vruntime=12653349859 [ns]
           stress-6348    [001] d...311   169.986040: sched_pi_setprio: comm=stress pid=6348 oldprio=19 newprio=120
           stress-6348    [001] dN..311   169.986042: sched_waking: comm=irq/140-nvme0q1 pid=157 prio=19 target_cpu=000
           stress-6348    [001] dN..411   169.986042: sched_wakeup: comm=irq/140-nvme0q1 pid=157 prio=19 target_cpu=000
           stress-6348    [001] dN..211   169.986043: sched_stat_runtime: comm=stress pid=6348 runtime=2461 [ns] vruntime=12653352320 [ns]
  irq/140-nvme0q1-157     [000] d...314   169.986045: sched_pi_setprio: comm=stress pid=6348 oldprio=120 newprio=19
  irq/140-nvme0q1-157     [000] d...314   169.986046: sched_stat_runtime: comm=stress pid=6348 runtime=2848 [ns] vruntime=12653355168 [ns]
           stress-6348    [001] d...311   169.986047: sched_pi_setprio: comm=stress pid=6348 oldprio=19 newprio=120
           stress-6348    [001] dN..311   169.986048: sched_waking: comm=irq/140-nvme0q1 pid=157 prio=19 target_cpu=000
           stress-6348    [001] dN..411   169.986048: sched_wakeup: comm=irq/140-nvme0q1 pid=157 prio=19 target_cpu=000
           stress-6348    [001] dN..211   169.986048: sched_stat_runtime: comm=stress pid=6348 runtime=1553 [ns] vruntime=12653356721 [ns]
  irq/140-nvme0q1-157     [000] d...314   169.986051: sched_pi_setprio: comm=stress pid=6348 oldprio=120 newprio=19
  irq/140-nvme0q1-157     [000] d...314   169.986052: sched_stat_runtime: comm=stress pid=6348 runtime=3251 [ns] vruntime=12653359972 [ns]
           stress-6348    [001] d...311   169.986053: sched_pi_setprio: comm=stress pid=6348 oldprio=19 newprio=120
           stress-6348    [001] dN..311   169.986054: sched_waking: comm=irq/140-nvme0q1 pid=157 prio=19 target_cpu=000
           stress-6348    [001] dN..411   169.986054: sched_wakeup: comm=irq/140-nvme0q1 pid=157 prio=19 target_cpu=000
           stress-6348    [001] dN..211   169.986054: sched_stat_runtime: comm=stress pid=6348 runtime=1729 [ns] vruntime=12653361701 [ns]
  irq/140-nvme0q1-157     [000] d...314   169.986057: sched_waking: comm=stress pid=6348 prio=120 target_cpu=001
  irq/140-nvme0q1-157     [000] d...414   169.986058: sched_wakeup: comm=stress pid=6348 prio=120 target_cpu=001
  irq/140-nvme0q1-157     [000] d...314   169.986058: sched_pi_setprio: comm=stress pid=6348 oldprio=120 newprio=19
  irq/140-nvme0q1-157     [000] d...314   169.986059: sched_stat_runtime: comm=stress pid=6348 runtime=4213 [ns] vruntime=12653365914 [ns]
           stress-6348    [001] d...311   169.986059: sched_pi_setprio: comm=stress pid=6348 oldprio=19 newprio=120
           stress-6348    [001] dN..311   169.986060: sched_waking: comm=irq/140-nvme0q1 pid=157 prio=19 target_cpu=000
           stress-6348    [001] dN..411   169.986061: sched_wakeup: comm=irq/140-nvme0q1 pid=157 prio=19 target_cpu=000
           stress-6348    [001] dN..211   169.986061: sched_stat_runtime: comm=stress pid=6348 runtime=1535 [ns] vruntime=12653367449 [ns]
  irq/140-nvme0q1-157     [000] d...314   169.986067: sched_pi_setprio: comm=stress pid=6348 oldprio=120 newprio=19
  irq/140-nvme0q1-157     [000] d...314   169.986067: sched_stat_runtime: comm=stress pid=6348 runtime=5639 [ns] vruntime=12653373088 [ns]
           stress-6348    [001] d...311   169.986068: sched_pi_setprio: comm=stress pid=6348 oldprio=19 newprio=120
           stress-6348    [001] dN..311   169.986069: sched_waking: comm=irq/140-nvme0q1 pid=157 prio=19 target_cpu=000
           stress-6348    [001] dN..411   169.986069: sched_wakeup: comm=irq/140-nvme0q1 pid=157 prio=19 target_cpu=000
           stress-6348    [001] dN..211   169.986069: sched_stat_runtime: comm=stress pid=6348 runtime=1561 [ns] vruntime=12653374649 [ns]
  irq/140-nvme0q1-157     [000] d...314   169.986071: sched_pi_setprio: comm=stress pid=6348 oldprio=120 newprio=19
  irq/140-nvme0q1-157     [000] d...314   169.986071: sched_stat_runtime: comm=stress pid=6348 runtime=1607 [ns] vruntime=12653376256 [ns]
           stress-6348    [001] d...311   169.986072: sched_pi_setprio: comm=stress pid=6348 oldprio=19 newprio=120
           stress-6348    [001] dN..311   169.986073: sched_waking: comm=irq/140-nvme0q1 pid=157 prio=19 target_cpu=000
           stress-6348    [001] dN..411   169.986073: sched_wakeup: comm=irq/140-nvme0q1 pid=157 prio=19 target_cpu=000
           stress-6348    [001] dN..211   169.986073: sched_stat_runtime: comm=stress pid=6348 runtime=1382 [ns] vruntime=12653377638 [ns]
  irq/140-nvme0q1-157     [000] d...314   169.986075: sched_waking: comm=stress pid=6348 prio=120 target_cpu=001
  irq/140-nvme0q1-157     [000] d...414   169.986076: sched_wakeup: comm=stress pid=6348 prio=120 target_cpu=001
  irq/140-nvme0q1-157     [000] d...314   169.986076: sched_pi_setprio: comm=stress pid=6348 oldprio=120 newprio=19
  irq/140-nvme0q1-157     [000] d...314   169.986077: sched_stat_runtime: comm=stress pid=6348 runtime=3120 [ns] vruntime=12653380758 [ns]
           stress-6348    [001] d...311   169.986078: sched_pi_setprio: comm=stress pid=6348 oldprio=19 newprio=120
           stress-6348    [001] dN..311   169.986079: sched_waking: comm=irq/140-nvme0q1 pid=157 prio=19 target_cpu=000
           stress-6348    [001] dN..411   169.986079: sched_wakeup: comm=irq/140-nvme0q1 pid=157 prio=19 target_cpu=000
           stress-6348    [001] dN..211   169.986079: sched_stat_runtime: comm=stress pid=6348 runtime=1522 [ns] vruntime=12653382280 [ns]
  irq/140-nvme0q1-157     [000] d...314   169.986081: sched_waking: comm=stress pid=6348 prio=120 target_cpu=001
  irq/140-nvme0q1-157     [000] d...414   169.986081: sched_wakeup: comm=stress pid=6348 prio=120 target_cpu=001
  irq/140-nvme0q1-157     [000] d...314   169.986086: sched_pi_setprio: comm=stress pid=6348 oldprio=120 newprio=19
  irq/140-nvme0q1-157     [000] d...314   169.986086: sched_stat_runtime: comm=stress pid=6348 runtime=6862 [ns] vruntime=12653389142 [ns]
           stress-6348    [001] d...311   169.986087: sched_pi_setprio: comm=stress pid=6348 oldprio=19 newprio=120
           stress-6348    [001] dN..311   169.986088: sched_waking: comm=irq/140-nvme0q1 pid=157 prio=19 target_cpu=000
           stress-6348    [001] dN..411   169.986088: sched_wakeup: comm=irq/140-nvme0q1 pid=157 prio=19 target_cpu=000
           stress-6348    [001] dN..211   169.986089: sched_stat_runtime: comm=stress pid=6348 runtime=1484 [ns] vruntime=12653390626 [ns]
  irq/140-nvme0q1-157     [000] d...314   169.986092: sched_pi_setprio: comm=stress pid=6348 oldprio=120 newprio=19
  irq/140-nvme0q1-157     [000] d...314   169.986092: sched_stat_runtime: comm=stress pid=6348 runtime=3101 [ns] vruntime=12653393727 [ns]
           stress-6348    [001] d...311   169.986093: sched_pi_setprio: comm=stress pid=6348 oldprio=19 newprio=120
           stress-6348    [001] dN..311   169.986094: sched_waking: comm=irq/140-nvme0q1 pid=157 prio=19 target_cpu=000
           stress-6348    [001] dN..411   169.986094: sched_wakeup: comm=irq/140-nvme0q1 pid=157 prio=19 target_cpu=000
           stress-6348    [001] dN..211   169.986094: sched_stat_runtime: comm=stress pid=6348 runtime=1466 [ns] vruntime=12653395193 [ns]
  irq/140-nvme0q1-157     [000] d...314   169.986098: sched_waking: comm=stress pid=6348 prio=120 target_cpu=001
  irq/140-nvme0q1-157     [000] d...414   169.986098: sched_wakeup: comm=stress pid=6348 prio=120 target_cpu=001
  irq/140-nvme0q1-157     [000] d...314   169.986099: sched_pi_setprio: comm=stress pid=6348 oldprio=120 newprio=19
  irq/140-nvme0q1-157     [000] d...314   169.986099: sched_stat_runtime: comm=stress pid=6348 runtime=4177 [ns] vruntime=12653399370 [ns]
           stress-6348    [001] d...311   169.986100: sched_pi_setprio: comm=stress pid=6348 oldprio=19 newprio=120
           stress-6348    [001] dN.h411   169.986101: sched_waking: comm=irq/131-ecat0-r pid=3891 prio=19 target_cpu=001
           stress-6348    [001] dN.h511   169.986102: sched_wakeup: comm=irq/131-ecat0-r pid=3891 prio=19 target_cpu=001
           stress-6348    [001] dN..211   169.986102: sched_stat_runtime: comm=stress pid=6348 runtime=1821 [ns] vruntime=12653401191 [ns]
           stress-6348    [001] d...211   169.986103: sched_switch: prev_comm=stress prev_pid=6348 prev_prio=120 prev_state=R+ ==> next_comm=irq/131-ecat0-r next_pid=3891 next_prio=19
  irq/131-ecat0-r-3891    [001] d...2..   169.986106: sched_switch: prev_comm=irq/131-ecat0-r prev_pid=3891 prev_prio=19 prev_state=S ==> next_comm=stress next_pid=6348 next_prio=120
  irq/140-nvme0q1-157     [000] d...314   169.986110: sched_pi_setprio: comm=stress pid=6348 oldprio=120 newprio=19
  irq/140-nvme0q1-157     [000] d...314   169.986110: sched_stat_runtime: comm=stress pid=6348 runtime=4399 [ns] vruntime=12653405590 [ns]
           stress-6348    [001] d...311   169.986111: sched_pi_setprio: comm=stress pid=6348 oldprio=19 newprio=120
           stress-6348    [001] dN..311   169.986112: sched_waking: comm=irq/140-nvme0q1 pid=157 prio=19 target_cpu=000
           stress-6348    [001] dN..411   169.986112: sched_wakeup: comm=irq/140-nvme0q1 pid=157 prio=19 target_cpu=000
           stress-6348    [001] dN..211   169.986112: sched_stat_runtime: comm=stress pid=6348 runtime=1619 [ns] vruntime=12653407209 [ns]
  irq/140-nvme0q1-157     [000] d...314   169.986115: sched_pi_setprio: comm=stress pid=6348 oldprio=120 newprio=19
  irq/140-nvme0q1-157     [000] d...314   169.986116: sched_stat_runtime: comm=stress pid=6348 runtime=3025 [ns] vruntime=12653410234 [ns]
           stress-6348    [001] d...311   169.986117: sched_pi_setprio: comm=stress pid=6348 oldprio=19 newprio=120
           stress-6348    [001] dN..311   169.986118: sched_waking: comm=irq/140-nvme0q1 pid=157 prio=19 target_cpu=000
           stress-6348    [001] dN..411   169.986118: sched_wakeup: comm=irq/140-nvme0q1 pid=157 prio=19 target_cpu=000
           stress-6348    [001] dN..211   169.986118: sched_stat_runtime: comm=stress pid=6348 runtime=1766 [ns] vruntime=12653412000 [ns]
  irq/140-nvme0q1-157     [000] d...314   169.986127: sched_pi_setprio: comm=stress pid=6348 oldprio=120 newprio=19
  irq/140-nvme0q1-157     [000] d...314   169.986127: sched_stat_runtime: comm=stress pid=6348 runtime=8700 [ns] vruntime=12653420700 [ns]
           stress-6348    [001] d...311   169.986128: sched_pi_setprio: comm=stress pid=6348 oldprio=19 newprio=120
           stress-6348    [001] dN..311   169.986129: sched_waking: comm=irq/140-nvme0q1 pid=157 prio=19 target_cpu=000
           stress-6348    [001] dN..411   169.986129: sched_wakeup: comm=irq/140-nvme0q1 pid=157 prio=19 target_cpu=000
           stress-6348    [001] dN..211   169.986130: sched_stat_runtime: comm=stress pid=6348 runtime=1524 [ns] vruntime=12653422224 [ns]
  irq/140-nvme0q1-157     [000] d...314   169.986131: sched_waking: comm=stress pid=6348 prio=120 target_cpu=001
  irq/140-nvme0q1-157     [000] d...414   169.986132: sched_wakeup: comm=stress pid=6348 prio=120 target_cpu=001
  irq/140-nvme0q1-157     [000] d...314   169.986132: sched_pi_setprio: comm=stress pid=6348 oldprio=120 newprio=19
  irq/140-nvme0q1-157     [000] d...314   169.986133: sched_stat_runtime: comm=stress pid=6348 runtime=2694 [ns] vruntime=12653424918 [ns]
           stress-6348    [001] d...311   169.986133: sched_pi_setprio: comm=stress pid=6348 oldprio=19 newprio=120
           stress-6348    [001] dN..311   169.986134: sched_waking: comm=irq/140-nvme0q1 pid=157 prio=19 target_cpu=000
           stress-6348    [001] dN..411   169.986135: sched_wakeup: comm=irq/140-nvme0q1 pid=157 prio=19 target_cpu=000
           stress-6348    [001] dN..211   169.986135: sched_stat_runtime: comm=stress pid=6348 runtime=1481 [ns] vruntime=12653426399 [ns]
  irq/140-nvme0q1-157     [000] d...314   169.986137: sched_pi_setprio: comm=stress pid=6348 oldprio=120 newprio=19
  irq/140-nvme0q1-157     [000] d...314   169.986137: sched_stat_runtime: comm=stress pid=6348 runtime=1882 [ns] vruntime=12653428281 [ns]
           stress-6348    [001] d...311   169.986138: sched_pi_setprio: comm=stress pid=6348 oldprio=19 newprio=120
           stress-6348    [001] dN..311   169.986139: sched_waking: comm=irq/140-nvme0q1 pid=157 prio=19 target_cpu=000
           stress-6348    [001] dN..411   169.986139: sched_wakeup: comm=irq/140-nvme0q1 pid=157 prio=19 target_cpu=000
           stress-6348    [001] dN..211   169.986139: sched_stat_runtime: comm=stress pid=6348 runtime=1456 [ns] vruntime=12653429737 [ns]
  irq/140-nvme0q1-157     [000] d...314   169.986144: sched_waking: comm=stress pid=6348 prio=120 target_cpu=001
  irq/140-nvme0q1-157     [000] d...414   169.986144: sched_wakeup: comm=stress pid=6348 prio=120 target_cpu=001
  irq/140-nvme0q1-157     [000] d...314   169.986145: sched_pi_setprio: comm=stress pid=6348 oldprio=120 newprio=19
  irq/140-nvme0q1-157     [000] d...314   169.986145: sched_stat_runtime: comm=stress pid=6348 runtime=5167 [ns] vruntime=12653434904 [ns]
           stress-6348    [001] d...311   169.986146: sched_pi_setprio: comm=stress pid=6348 oldprio=19 newprio=120
           stress-6348    [001] dN..311   169.986147: sched_waking: comm=irq/140-nvme0q1 pid=157 prio=19 target_cpu=000
           stress-6348    [001] dN..411   169.986147: sched_wakeup: comm=irq/140-nvme0q1 pid=157 prio=19 target_cpu=000
           stress-6348    [001] dN..211   169.986147: sched_stat_runtime: comm=stress pid=6348 runtime=1512 [ns] vruntime=12653436416 [ns]
  irq/140-nvme0q1-157     [000] d...314   169.986150: sched_waking: comm=stress pid=6348 prio=120 target_cpu=001
  irq/140-nvme0q1-157     [000] d...414   169.986150: sched_wakeup: comm=stress pid=6348 prio=120 target_cpu=001
  irq/140-nvme0q1-157     [000] d...314   169.986151: sched_pi_setprio: comm=stress pid=6348 oldprio=120 newprio=19
  irq/140-nvme0q1-157     [000] d...314   169.986151: sched_stat_runtime: comm=stress pid=6348 runtime=4009 [ns] vruntime=12653440425 [ns]
           stress-6348    [001] d...311   169.986152: sched_pi_setprio: comm=stress pid=6348 oldprio=19 newprio=120
           stress-6348    [001] dN..311   169.986153: sched_waking: comm=irq/140-nvme0q1 pid=157 prio=19 target_cpu=000
           stress-6348    [001] dN..411   169.986153: sched_wakeup: comm=irq/140-nvme0q1 pid=157 prio=19 target_cpu=000
           stress-6348    [001] dN..211   169.986154: sched_stat_runtime: comm=stress pid=6348 runtime=1467 [ns] vruntime=12653441892 [ns]
  irq/140-nvme0q1-157     [000] d...314   169.986156: sched_pi_setprio: comm=stress pid=6348 oldprio=120 newprio=19
  irq/140-nvme0q1-157     [000] d...314   169.986157: sched_stat_runtime: comm=stress pid=6348 runtime=2929 [ns] vruntime=12653444821 [ns]
           stress-6348    [001] d...311   169.986158: sched_pi_setprio: comm=stress pid=6348 oldprio=19 newprio=120
           stress-6348    [001] dN..311   169.986159: sched_waking: comm=irq/140-nvme0q1 pid=157 prio=19 target_cpu=000
           stress-6348    [001] dN..411   169.986159: sched_wakeup: comm=irq/140-nvme0q1 pid=157 prio=19 target_cpu=000
           stress-6348    [001] dN..211   169.986159: sched_stat_runtime: comm=stress pid=6348 runtime=1452 [ns] vruntime=12653446273 [ns]
  irq/140-nvme0q1-157     [000] d...314   169.986161: sched_waking: comm=stress pid=6348 prio=120 target_cpu=001
  irq/140-nvme0q1-157     [000] d...414   169.986161: sched_wakeup: comm=stress pid=6348 prio=120 target_cpu=001
  irq/140-nvme0q1-157     [000] d...314   169.986163: sched_waking: comm=stress pid=6348 prio=120 target_cpu=001
  irq/140-nvme0q1-157     [000] d...414   169.986163: sched_wakeup: comm=stress pid=6348 prio=120 target_cpu=001
  irq/140-nvme0q1-157     [000] d...314   169.986164: sched_pi_setprio: comm=stress pid=6348 oldprio=120 newprio=19
  irq/140-nvme0q1-157     [000] d...314   169.986164: sched_stat_runtime: comm=stress pid=6348 runtime=5179 [ns] vruntime=12653451452 [ns]
           stress-6348    [001] d...311   169.986165: sched_pi_setprio: comm=stress pid=6348 oldprio=19 newprio=120
           stress-6348    [001] dN..411   169.986167: sched_waking: comm=ksoftirqd/1 pid=21 prio=120 target_cpu=001
           stress-6348    [001] dN..511   169.986167: sched_wakeup: comm=ksoftirqd/1 pid=21 prio=120 target_cpu=001
           stress-6348    [001] dN..211   169.986168: sched_stat_runtime: comm=stress pid=6348 runtime=1907 [ns] vruntime=12653453359 [ns]
           stress-6348    [001] d...211   169.986168: sched_switch: prev_comm=stress prev_pid=6348 prev_prio=120 prev_state=R+ ==> next_comm=ksoftirqd/1 next_pid=21 next_prio=120
      ksoftirqd/1-21      [001] d...213   169.986169: sched_waking: comm=EtherlabDaemon pid=3998 prio=120 target_cpu=001
      ksoftirqd/1-21      [001] d...313   169.986170: sched_stat_runtime: comm=ksoftirqd/1 pid=21 runtime=2392 [ns] vruntime=62640255383 [ns]
      ksoftirqd/1-21      [001] d...313   169.986170: sched_wakeup: comm=EtherlabDaemon pid=3998 prio=120 target_cpu=001
      ksoftirqd/1-21      [001] d...2..   169.986171: sched_stat_runtime: comm=ksoftirqd/1 pid=21 runtime=1320 [ns] vruntime=62640256703 [ns]
      ksoftirqd/1-21      [001] d...2..   169.986171: sched_switch: prev_comm=ksoftirqd/1 prev_pid=21 prev_prio=120 prev_state=S ==> next_comm=EtherlabDaemon next_pid=3998 next_prio=120
   EtherlabDaemon-3998    [001] d...2..   169.986178: sched_stat_runtime: comm=EtherlabDaemon pid=3998 runtime=7323 [ns] vruntime=20976028173 [ns]
   EtherlabDaemon-3998    [001] d...2..   169.986180: sched_switch: prev_comm=EtherlabDaemon prev_pid=3998 prev_prio=120 prev_state=S ==> next_comm=stress next_pid=6348 next_prio=120
  irq/140-nvme0q1-157     [000] d...314   169.986185: sched_pi_setprio: comm=stress pid=6348 oldprio=120 newprio=19
  irq/140-nvme0q1-157     [000] d...314   169.986185: sched_stat_runtime: comm=stress pid=6348 runtime=6749 [ns] vruntime=12653460108 [ns]
           stress-6348    [001] d...311   169.986186: sched_pi_setprio: comm=stress pid=6348 oldprio=19 newprio=120
           stress-6348    [001] dN..311   169.986188: sched_waking: comm=irq/140-nvme0q1 pid=157 prio=19 target_cpu=000
           stress-6348    [001] dN..411   169.986188: sched_wakeup: comm=irq/140-nvme0q1 pid=157 prio=19 target_cpu=000
           stress-6348    [001] dN..211   169.986189: sched_stat_runtime: comm=stress pid=6348 runtime=2245 [ns] vruntime=12653462353 [ns]
  irq/140-nvme0q1-157     [000] d...314   169.986191: sched_pi_setprio: comm=stress pid=6348 oldprio=120 newprio=19
  irq/140-nvme0q1-157     [000] d...314   169.986192: sched_stat_runtime: comm=stress pid=6348 runtime=3197 [ns] vruntime=12653465550 [ns]
           stress-6348    [001] d...311   169.986193: sched_pi_setprio: comm=stress pid=6348 oldprio=19 newprio=120
           stress-6348    [001] dN..311   169.986194: sched_waking: comm=irq/140-nvme0q1 pid=157 prio=19 target_cpu=000
           stress-6348    [001] dN..411   169.986194: sched_wakeup: comm=irq/140-nvme0q1 pid=157 prio=19 target_cpu=000
           stress-6348    [001] dN..211   169.986194: sched_stat_runtime: comm=stress pid=6348 runtime=1508 [ns] vruntime=12653467058 [ns]
  irq/140-nvme0q1-157     [000] d...314   169.986196: sched_pi_setprio: comm=stress pid=6348 oldprio=120 newprio=19
  irq/140-nvme0q1-157     [000] d...314   169.986196: sched_stat_runtime: comm=stress pid=6348 runtime=1661 [ns] vruntime=12653468719 [ns]
           stress-6348    [001] d...311   169.986197: sched_pi_setprio: comm=stress pid=6348 oldprio=19 newprio=120
           stress-6348    [001] dN..311   169.986198: sched_waking: comm=irq/140-nvme0q1 pid=157 prio=19 target_cpu=000
           stress-6348    [001] dN..411   169.986198: sched_wakeup: comm=irq/140-nvme0q1 pid=157 prio=19 target_cpu=000
           stress-6348    [001] dN..211   169.986198: sched_stat_runtime: comm=stress pid=6348 runtime=1528 [ns] vruntime=12653470247 [ns]
  irq/140-nvme0q1-157     [000] d...314   169.986200: sched_pi_setprio: comm=stress pid=6348 oldprio=120 newprio=19
  irq/140-nvme0q1-157     [000] d...314   169.986200: sched_stat_runtime: comm=stress pid=6348 runtime=1777 [ns] vruntime=12653472024 [ns]
           stress-6348    [001] d...311   169.986201: sched_pi_setprio: comm=stress pid=6348 oldprio=19 newprio=120
           stress-6348    [001] dN..311   169.986202: sched_waking: comm=irq/140-nvme0q1 pid=157 prio=19 target_cpu=000
           stress-6348    [001] dN..411   169.986202: sched_wakeup: comm=irq/140-nvme0q1 pid=157 prio=19 target_cpu=000
           stress-6348    [001] dN..211   169.986203: sched_stat_runtime: comm=stress pid=6348 runtime=1487 [ns] vruntime=12653473511 [ns]
  irq/140-nvme0q1-157     [000] d...314   169.986208: sched_pi_setprio: comm=stress pid=6348 oldprio=120 newprio=19
  irq/140-nvme0q1-157     [000] d...314   169.986209: sched_stat_runtime: comm=stress pid=6348 runtime=5585 [ns] vruntime=12653479096 [ns]
           stress-6348    [001] d...311   169.986209: sched_pi_setprio: comm=stress pid=6348 oldprio=19 newprio=120
           stress-6348    [001] dN..311   169.986210: sched_waking: comm=irq/140-nvme0q1 pid=157 prio=19 target_cpu=000
           stress-6348    [001] dN..411   169.986211: sched_wakeup: comm=irq/140-nvme0q1 pid=157 prio=19 target_cpu=000
           stress-6348    [001] dN..211   169.986211: sched_stat_runtime: comm=stress pid=6348 runtime=1509 [ns] vruntime=12653480605 [ns]
  irq/140-nvme0q1-157     [000] d...314   169.986214: sched_pi_setprio: comm=stress pid=6348 oldprio=120 newprio=19
  irq/140-nvme0q1-157     [000] d...314   169.986214: sched_stat_runtime: comm=stress pid=6348 runtime=3062 [ns] vruntime=12653483667 [ns]
           stress-6348    [001] d...311   169.986215: sched_pi_setprio: comm=stress pid=6348 oldprio=19 newprio=120
           stress-6348    [001] dN.h411   169.986217: sched_waking: comm=EtherlabDaemon pid=5200 prio=20 target_cpu=001
           stress-6348    [001] dN.h511   169.986217: sched_wakeup: comm=EtherlabDaemon pid=5200 prio=20 target_cpu=001
           stress-6348    [001] dN..211   169.986218: sched_stat_runtime: comm=stress pid=6348 runtime=1942 [ns] vruntime=12653485609 [ns]
           stress-6348    [001] d...211   169.986219: sched_switch: prev_comm=stress prev_pid=6348 prev_prio=120 prev_state=R+ ==> next_comm=EtherlabDaemon next_pid=5200 next_prio=20
   EtherlabDaemon-5200    [001] d...2..   169.986234: sched_waking: comm=EtherCATControl pid=4181 prio=20 target_cpu=001
   EtherlabDaemon-5200    [001] d...3..   169.986235: sched_wakeup: comm=EtherCATControl pid=4181 prio=20 target_cpu=001
   EtherlabDaemon-5200    [001] d...2..   169.986238: sched_switch: prev_comm=EtherlabDaemon prev_pid=5200 prev_prio=20 prev_state=S ==> next_comm=EtherCATControl next_pid=4181 next_prio=20
  irq/140-nvme0q1-157     [000] d...213   169.986242: sched_waking: comm=RTController pid=5320 prio=120 target_cpu=000
  irq/140-nvme0q1-157     [000] d...313   169.986244: sched_wakeup: comm=RTController pid=5320 prio=120 target_cpu=000
  irq/140-nvme0q1-157     [000] d...213   169.986244: sched_waking: comm=EtherCATControl pid=4185 prio=120 target_cpu=000
  irq/140-nvme0q1-157     [000] d...313   169.986245: sched_wakeup: comm=EtherCATControl pid=4185 prio=120 target_cpu=000
  irq/140-nvme0q1-157     [000] d...312   169.986246: sched_pi_setprio: comm=irq/140-nvme0q1 pid=157 oldprio=19 newprio=49
  irq/140-nvme0q1-157     [000] dN..312   169.986246: sched_waking: comm=irq/132-ecat0-t pid=3892 prio=19 target_cpu=000
  irq/140-nvme0q1-157     [000] dN..412   169.986247: sched_wakeup: comm=irq/132-ecat0-t pid=3892 prio=19 target_cpu=000
  irq/140-nvme0q1-157     [000] d...212   169.986247: sched_switch: prev_comm=irq/140-nvme0q1 prev_pid=157 prev_prio=49 prev_state=R+ ==> next_comm=cyclictest next_pid=5753 next_prio=19
       cyclictest-5753    [000] .......   169.986261: tracing_mark_write: hit latency threshold (458 > 150)
