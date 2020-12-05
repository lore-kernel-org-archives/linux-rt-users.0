Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4614C433FE
	for <linux-rt-users@archiver.kernel.org>; Sat,  5 Dec 2020 18:32:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A834B230FD
	for <linux-rt-users@archiver.kernel.org>; Sat,  5 Dec 2020 18:32:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727661AbgLESbh (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Sat, 5 Dec 2020 13:31:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725996AbgLESbU (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Sat, 5 Dec 2020 13:31:20 -0500
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE8D2C061A51
        for <linux-rt-users@vger.kernel.org>; Sat,  5 Dec 2020 10:30:33 -0800 (PST)
Received: by mail-lj1-x234.google.com with SMTP id t22so10443121ljk.0
        for <linux-rt-users@vger.kernel.org>; Sat, 05 Dec 2020 10:30:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=RD+ie+8HHQuj+/J7FeQWBhDPl0VMzGGBPo3EeCozX+8=;
        b=Z2sVHpedo4BRsRRCaB/HL6Me8jh52VDIcYrk6As0mL+7EXihvVYNQIxLDVc6vjRI3y
         ede1IZJ2pMTxx/q2zEzqUmOtBcPzZWr545sofvifgrmJPa+YQZUEth7kzpdQ5bvGolgs
         ocAf+kx7f+xxBmqtjTLE3W/9VHcreCx7Vup9V7/WhUzRkLmkfyENOOxI45h4hnXs1/Qy
         hFhC/U3cZySGhVAQAa4gScYSe40g05pX2pnznWp9DlIOYPi9UFFoYWdVQmjU5Qu3RHRe
         99NuNAPR/UQJ9DrGlWj/IzSv5/kXnq8W2O9w1KQN75D5zjLCUqE9gG1R4LQEQfBU/xxN
         5UDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=RD+ie+8HHQuj+/J7FeQWBhDPl0VMzGGBPo3EeCozX+8=;
        b=hWO3yYb1yHeMtFd9oO0OG7Rd97Rng0WLb4gLFDZPGhYB9AbrTKM3mGZOR8nFnxYP2G
         Sq+MjteRE/leJTPxfDpkV8aS1ada9lB6R2OkrKXtRWI6KKI6HlTMBSMTMHErsxlnQvK3
         VPoMuf8MLWdMfo2RF94/tGaotqvewTerk/4930v9YijGhnDkkVkmbApS3TJFHJC6b5ev
         a+IHO+EbTriuGSDoExA5u6En/bNgEt+FclhMHmMCuYWBHc1U9cu2YgaUD0Ch/wdNfsj6
         soypNNy5NaJDIv2mSpsN+S1XTMcdQloLo8hT2S+qUboqwpgF0zvr+hg8jzeNKOMODB0D
         jwUw==
X-Gm-Message-State: AOAM532SfxwzRvmNYI5cjBXwAy6VzCrM6JcmoxPCvqlF2oGikWEF0EJ0
        sDoLNRm/2TRZZ8bIhnvHlwBx0raSuDFqDm73+ZqvHt2dDVGmGA==
X-Google-Smtp-Source: ABdhPJxNj5bXYuPKgi2MCjNGesaiz5H3VuPgwmovjXWp0FKzSJTY4FVFnqZgDo979s2DulqOjtIHyatzTPFlPOw7jVE=
X-Received: by 2002:a2e:8796:: with SMTP id n22mr5762818lji.345.1607193032215;
 Sat, 05 Dec 2020 10:30:32 -0800 (PST)
MIME-Version: 1.0
From:   Paul Thomas <pthomas8589@gmail.com>
Date:   Sat, 5 Dec 2020 13:30:21 -0500
Message-ID: <CAD56B7dKyiUBQctrrpLYU6XM5cjfXD10E1fFMU5GpAe00g_TZQ@mail.gmail.com>
Subject: net latency, long wait for softirq_entry
To:     linux-rt-users <linux-rt-users@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

(this time with a proper subject)
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
sched_waking
sched_wakeup
softirq_exit
sched_switch

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
