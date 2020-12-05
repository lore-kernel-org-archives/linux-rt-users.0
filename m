Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FCA6C4361A
	for <linux-rt-users@archiver.kernel.org>; Sat,  5 Dec 2020 18:31:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C934229C4
	for <linux-rt-users@archiver.kernel.org>; Sat,  5 Dec 2020 18:31:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729075AbgLESar (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Sat, 5 Dec 2020 13:30:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728980AbgLES3o (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Sat, 5 Dec 2020 13:29:44 -0500
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43357C061A54
        for <linux-rt-users@vger.kernel.org>; Sat,  5 Dec 2020 10:28:52 -0800 (PST)
Received: by mail-lj1-x236.google.com with SMTP id e7so160173ljg.10
        for <linux-rt-users@vger.kernel.org>; Sat, 05 Dec 2020 10:28:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=CYaCs+Zlm2AKFyL0gLoWL5WHDWiPmNPb3lAecnwhQoc=;
        b=Jx/gdvkZOSHz56dnIr2eoFvhAKE4s5t6I8aqZnkouqdthygKMIePONe3UJsdzHZVh3
         mD+SFPHAOmRN9L//28OJDePH6aVbNpUkqt/099ARvmf9JNEO5ezCU4lBHOLG82lEB2/6
         nGMJyXcoT/r3jt3B9lu84364OfL4OBCnwZzT6wCKGCOutIMt0/FghiIQKEJQ+cb3y1Zg
         hCEjC+bykwTuWT62/qvI0iWpXsisfmQbQC3202WjNNPxPo6xlX4/36r9P2jyWPUuG6IT
         EwUdranekBbZUOuudt4G6r5cDhP54jY9JKL6KtXdgyYzv9dY37OIGgHB0wSvXkLBbjmw
         Yp7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=CYaCs+Zlm2AKFyL0gLoWL5WHDWiPmNPb3lAecnwhQoc=;
        b=LP5gFiiwhwpUtl9ZuTjwqNx57D5REmmXFRD6JhnhTjqem44Jt6+eAIZlx+G1xmNter
         PzABBD5vJVbFcmrhqudmRbBJO/k3Rn5l1ox0W72FALJCLLl7xCSbGg3Ib86do3gALKH/
         aMetuhknwVK/DV6wuT2MalwNDVCOHWJUVV+ejpEMODPHZt181YVNqUjcPzGZPwZz4vj/
         jrM7e7mgSmT46gaGk89xHlkAxyDsj47ApIDpwk9Iit2+L5DafBqx75XNEdSzze6d+xLm
         jcMZEMVhkELvARR3+Mgxrg2FXSDLPT3fb8xok2Up4va+JTHrY5e6dlGCLCd9ovGaG/tw
         1iGw==
X-Gm-Message-State: AOAM531gr3y3c9ctEbWh5XwRvmRG6Rblp6OdGiD7+nIAdpnPsFuTSDD9
        f5707N6IIisBVY3M/XW9eYT/EyhM/bhxHlGPBkZhFi5vRXBL8A==
X-Google-Smtp-Source: ABdhPJxCuUHEmEbWsOojd5cfqvBhsSMdUlZSo6A1MvSFoU0GeKUYdKOdBAnubEZXGVPay14hW18GwTi9S6nyWtiCv3k=
X-Received: by 2002:a05:651c:96:: with SMTP id 22mr1343177ljq.316.1607192930423;
 Sat, 05 Dec 2020 10:28:50 -0800 (PST)
MIME-Version: 1.0
From:   Paul Thomas <pthomas8589@gmail.com>
Date:   Sat, 5 Dec 2020 13:28:38 -0500
Message-ID: <CAD56B7fwnk66a_hME-VHBfmDKRSvjpuFwZUBwSk6zvggAN36Cw@mail.gmail.com>
Subject: 
To:     linux-rt-users <linux-rt-users@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hello,

I've been testing out the 5.10 rt kernel[1], and now I'm trying to
track down a networking latency issue. Generally this works well, I
have a user thread (priority 99) and the driver (macb) rx irq thread
(priority 98). With tracing (kernelshark is very cool btw) I can see
the normal flow, the irq thread does the netif_receive_skb:
softirq_raise
softirq_entry
napi_gro_receive_entry
napi_gro_receive_exit
netif_receive_skb

Then the user thread does:
sys_exit_recvmsg

But then in the long latency case, instead of going straight to
softirq_entry this is delayed and it does the softirq_entry from the
ksoftirqd task instead of the irq/30-eth%d task. The problem is that
before ksoftirqd runs, another lower priority task runs (in this case
it's the macb tx interrupt thread at priority 80, but I've seen this
be user threads in slightly different tests). It seems the paths
diverge with a call to __kthread_should_park.

This is on an arm64 zynqmp platform.

Any thoughts on how this could be improved would be appreciated.

The trace can be found here:
https://bugzilla.kernel.org/attachment.cgi?id=293951
The softirq_raise with a long wait before the softirq_entry starts at
time 515.509590.

It was captured with:
trace-cmd start -e syscalls -e net -e irq -e rcu -e sched -e
preemptirq -p function

Cyclictest seems OK, a 10 minute run with stress-ng running shows a
maximum latency of 47us
# ./cyclictest -S -m -p 99 -d 0 -i 200 -D 10m
WARN: stat /dev/cpu_dma_latency failed: No such file or directory
policy: fifo: loadavg: 15.99 15.74 13.41 13/152 2605

T: 0 ( 5687) P:99 I:200 C:2999965 Min:      6 Act:   12 Avg:   11 Max:      39
T: 1 ( 5701) P:99 I:200 C:2999647 Min:      8 Act:   12 Avg:   10 Max:      40
T: 2 ( 5720) P:99 I:200 C:2999343 Min:      8 Act:   11 Avg:   10 Max:      41
T: 3 ( 5740) P:99 I:200 C:2999056 Min:      7 Act:   10 Avg:   11 Max:      47

-Paul

[1] I saw the v5.10-rc6-rt14 announcement yesterday, and rebased to
that to for the tracing mentioned here
