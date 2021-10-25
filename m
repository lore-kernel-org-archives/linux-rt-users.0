Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD32CC433F5
	for <linux-rt-users@archiver.kernel.org>; Mon, 25 Oct 2021 09:44:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD23960FBF
	for <linux-rt-users@archiver.kernel.org>; Mon, 25 Oct 2021 09:44:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232717AbhJYJq2 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 25 Oct 2021 05:46:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232546AbhJYJq1 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 25 Oct 2021 05:46:27 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71B2DC061745;
        Mon, 25 Oct 2021 02:44:05 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id j21so10060257lfe.0;
        Mon, 25 Oct 2021 02:44:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=rCGuC9ewYiAfYgiMkd1Yzii2AFCTuDrZolTjPAQg3+c=;
        b=iU7RJCmXcYEuggBefGylFwYi5nT3nQEIBL9C3howVlfj1yqS/mQxUnMSTQRyeTkPyu
         LPqeRdAZpTiHUTZq3VCCFdm9ecIXsl51GH1QXpT3b0sVWW6uERkxUj7b53jb8vcVsjp8
         uA7KiMOOMkYV3j9e4LL0ztkrNMqsO9njfkq9fLbEP7AUzGLt9slLGDhBlArgJ0FgFiKC
         Dq8ganCs1B4D5lrcUi7Su1DUyd9Xn+/EGaW30TqB1uAVoTQHC3MMPXs0EYbMWPMR4fWu
         2WJ11Auf+7c5M12yKVuJ50sOsju9Up3tZbQnfKCQSkqNd6XVfQPlJno/VojUAsJoU8HS
         fTkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=rCGuC9ewYiAfYgiMkd1Yzii2AFCTuDrZolTjPAQg3+c=;
        b=o0kJAWJcTtlsSrnK2Fmg7n9akJTA5A37m0kQ6pDZg20w8vcvSBpho52kKqyRnO1oiF
         6sfCWUxlwzPG8sDCLOIAZSzZssLK3eBbGMsgmV8rDUNqccNGATD5R9x28vHGz2ORSrKa
         ZJ8YEcLIZXAAmPZWoa7/GjnvjQRy++eTRFFlBDKdU+Fqnaoj3mCd+D/M/34AfdOX9ixm
         3nfyyDQ97mmTicS6kqwmQmvqPJWqLlLZHKLXrsT+p8Z7vSujZVoeGgex5QQaO1xWD7ya
         +XiQmEFDh7ieZbLJRJLQh7eiIs03BQZ2UXagMG4lk3qP+8yUIXARd++oByoXHI0c9olp
         1nfQ==
X-Gm-Message-State: AOAM531bsSmZ1tjM3h79FYsWDTTUixZCsgKS6NTIUBePUVU0LAufa5Ui
        fHNtwMFYq652koFUPKH8YkeO33Y04nX4odKf3shbojcvxAkpcc4f
X-Google-Smtp-Source: ABdhPJxiSulMEdaSn86bJ2DVKn1Z22IQaRk/25SbQTk1vo51j+dq64XPUf6rN9M1Tul89e3XIL8alSQPdkOtXn73rEA=
X-Received: by 2002:a05:6512:b29:: with SMTP id w41mr16174240lfu.240.1635155043576;
 Mon, 25 Oct 2021 02:44:03 -0700 (PDT)
MIME-Version: 1.0
From:   Ronny Meeus <ronny.meeus@gmail.com>
Date:   Mon, 25 Oct 2021 11:43:52 +0200
Message-ID: <CAMJ=MEd9WuGA0MN+n0rGD6T+sgd=yciTmeEW9TjRjNXt+cF=qQ@mail.gmail.com>
Subject: Unbounded priority inversion while assigning tasks into cgroups.
To:     linux-kernel@vger.kernel.org
Cc:     linux-rt-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hello

an unbounded priority inversion is observed when moving tasks into cgroups.
In my case I'm using the cpu and cpuacct cgroups but the issue is
independent of this.

Kernel version: 4.9.79
CPU: Dual core Cavium Octeon (MIPS)
Kernel configured with CONFIG_PREEMPT=y

I have a small application running at RT priority 92.
Its job is to move high CPU consuming applications into a cgroup when
the system is under high load.
Under extreme load conditions (meaning a lot of script processing
(process clone / exec / exit) and high application load), sometimes
the application hangs for a long time (can be a couple of seconds but
also hangs of 2 minutes are observed already).

Extending the kernel with traces (see below) showed that the
root-cause of the blocking is the global rwsem
"cgroup_threadgroup_rwsem".
While adding a task into the cgroup (__cgroup_procs_write), the write
lock is taken which will have to wait until all writers and readers
have completed their critical section which can take very long.
Especially since there are many of them running at a much lower
priority and we have also applications running at medium priority
running with a very high load.

As an initial attempt I tried applying the RT patch but this does not
resolve the issue.

The second attempt was to replace the cgroup_threadgroup_rwsem by a
rt_mutex (which offers priority inheritance).
After this change the issue seems to be resolved.
A disadvantage of this approach is that all accesses to the critical
section are serialized on all cores (writes to assign tasks to cgroups
and reads to create/exec/exit processes).

For the moment I do not see any other alternative to resolve this problem.
Any advice on the right way forward would be appreciated.

Best regards,
Ronny


Relevant part of the instrumented code of function: __cgroup_procs_write:

trace_cgroup_lock(1000);
percpu_down_write(&cgroup_threadgroup_rwsem);
trace_cgroup_lock(2000);
rcu_read_lock();

A normal trace looks like:
resource_monito-18855 [001] ....  2685.097016: cgroup_lock: idx=2
resource_monito-18855 [001] ....  2685.097017: cgroup_lock: idx=1000
resource_monito-18855 [001] ....  2685.097018: cgroup_lock: idx=2000
resource_monito-18855 [001] ....  2685.097018: cgroup_lock: idx=101

A trace of a blocked application looks like:
resource_monito-18855 [001] ....  2689.736364: cgroup_lock: idx=2
resource_monito-18855 [001] ....  2689.736365: cgroup_lock: idx=1000
resource_monito-18855 [001] ....  2693.780339: cgroup_lock: idx=2000
resource_monito-18855 [001] ....  2693.780339: cgroup_lock: idx=101

In the problematic case above, the resource_monitor application was
blocked for 4s waiting for the write lock on the cgroup.
