Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5E73C433F5
	for <linux-rt-users@archiver.kernel.org>; Wed,  3 Nov 2021 09:13:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C80761073
	for <linux-rt-users@archiver.kernel.org>; Wed,  3 Nov 2021 09:13:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231361AbhKCJQa (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 3 Nov 2021 05:16:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231278AbhKCJQ3 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 3 Nov 2021 05:16:29 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8A3DC061714
        for <linux-rt-users@vger.kernel.org>; Wed,  3 Nov 2021 02:13:53 -0700 (PDT)
Date:   Wed, 3 Nov 2021 10:13:49 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1635930831;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=O3jk4lsncNEl8j8yDlxj6Z4OdqMcv7jc0ROPO1HjMvo=;
        b=s+3by7/d9QWHCzupu4nqLQ3bCY+0pfpTta0u/3BULEtWoDPLl4KMLytaJ1+tDmURVlYwQA
        o7NT4GhvHRIFoF5WjKdPFIjIAjGqXvjcDhUNUSOR0wRK/QkZcLLATzCZgobsKjANwGuA1b
        dnvpy5wCnOlQf5sFU31Em7NnYayn4nkc5Mi4eEASsKIgHzPss2EozFP3wBsmQxDSloQHZ/
        nrSq1gXo5QSpqHFi4fHQrOO3hoT2lWp5WAuw1Om2UZM58YdSHo1PhNiwFDZd7unELNKkES
        0PakLLBVM6Xm4ISnEUaEED45sdU2tYw25iVDr7kcTUFkBGrRGNp6K0IsEKlQEw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1635930831;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=O3jk4lsncNEl8j8yDlxj6Z4OdqMcv7jc0ROPO1HjMvo=;
        b=PEtTCe9O8JlR5IEKrtBSKEG+muOM9b9nc060qDB4tVwcMQolr96UwQ3sVw0xtyw3R7XRGc
        Xs8QddZ2faLjzHBw==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Chanho Park <chanho61.park@samsung.com>
Cc:     linux-rt-users@vger.kernel.org,
        'Thomas Gleixner' <tglx@linutronix.de>
Subject: Re: hackbench score comparison between 5.10.75-rt47 and 5.14.14-rt21
Message-ID: <20211103091349.m7dvgqpbc2epgbi3@linutronix.de>
References: <CGME20211103031549epcas2p34418a4e6218ca93da57a0c373691bd41@epcas2p3.samsung.com>
 <009301d7d061$1a1bbeb0$4e533c10$@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <009301d7d061$1a1bbeb0$4e533c10$@samsung.com>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2021-11-03 12:15:49 [+0900], Chanho Park wrote:
> Dear RT folks,
Hi,

> I found an uncomprehended value of hackbench while I tested preempt rt
> patches on my ARM64(Cortex A76 x 8) target.
> So, I decided to check it on QEMU x86_64 KVM with yocto. I executed both
> images with below command.
> 
> $ runqemu qemux86-64 kvm nographic qemuparams="-smp cores=4"
> 
> I was able to get similar score values with my arm64 target. It was half
> than 5.10.75 kernel like below.
> Any idea about this? Actually, I'm not sure it could be a regression or not.
> 
> <5.10.75-rt47>
> root@qemux86-64:~# hackbench -l 10000
> Running in process mode with 10 groups using 40 file descriptors each (==
> 400 tasks)
> Each sender will pass 10000 messages of 100 bytes
> Time: 49.898
> 
> <5.14.14-rt21>
> root@qemux86-64:~# hackbench -l 10000
> Running in process mode with 10 groups using 40 file descriptors each (==
> 400 tasks)
> Each sender will pass 10000 messages of 100 bytes
> Time: 96.973

The 5.14 series has a different SLUB implementation. Could you please
make sure that SLUB_CPU_PARTIAL is disabled?
So v5.14-rc3-rt1 should be worse than v5.10. Then v5.14-rc3-rt2
introduced adaptive spinning which should improve the situation. However
it is slightly worse than v5.10 but it should have improved.
Could verify that?

Also could double check this on hardware? I have no idea how well the
adaptive spinning is working in KVM and this (hackbench) is a micro
benchmark for the memory allocator/SLUB and any spin/guest preemption
can have a visible outcome.
While I saw worse numbers here (hackbench) I didn't observe it in a
real-work workload like a kernel build for instance.

> Best Regards,
> Chanho Park

Sebastian
