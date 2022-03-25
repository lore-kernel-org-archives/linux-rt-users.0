Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 652AFC433F5
	for <linux-rt-users@archiver.kernel.org>; Fri, 25 Mar 2022 08:18:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354017AbiCYIU3 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 25 Mar 2022 04:20:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241127AbiCYIU3 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 25 Mar 2022 04:20:29 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6010ECA0EA
        for <linux-rt-users@vger.kernel.org>; Fri, 25 Mar 2022 01:18:55 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1648196333;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5ZouFGEMY9YkUw7s5spDx4et5dv/EBT2rzQpB4R32kY=;
        b=bY87TH4Q6IUCQBW8rwp3LUNGcL0MwMmEWU1ijQtslerikeCJWCrYdGilzCRPzce1CxaTQb
        +8RhwKp+jWUBeWIz/thtSI8ARPCd/+W29EcLawcZTi+eb4Pj385plxduCxcHsX0H7SqL66
        cSz6da2zHbPt7iewyC583wM0Pzw3Z8S8z8u8CffP+65FU/3TjDd3Ju0cu/Oe2qc4OszsJi
        gaMMKUGDSlnFyaOo7JRG+52eAMUnc3w0sw6KxZIX4bwOHtkNIjP+Rs5o9ShDlvQJxA2PRy
        dZ+BIVN827wy3YBS9BkDrxzoCTawFlfag5Ie/ZUStUCgPkTD/ciAHSY+wp79xg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1648196333;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5ZouFGEMY9YkUw7s5spDx4et5dv/EBT2rzQpB4R32kY=;
        b=6Q7rqrgMJy0p2U8GPfE6TyXKCO+AU52YpYbvPH0GIG6LeO9WdkEMibdWtzSKvji0v7mNK/
        X1pp8pNUWsd+c5Bw==
To:     Gautam Thaker <ghthaker@gmail.com>
Cc:     linux-rt-users@vger.kernel.org
Subject: Re: 5.15.28-rt35 #2 SMP PREEMPT_RT: Should scheduling latency be as
 large as 800 usec?
In-Reply-To: <CA+1+E3WBGf1Q9aXAMiN3gfUEEqWQDfzPH-Hg6-G8FrZEBSZUYw@mail.gmail.com>
References: <CA+1+E3UVmbLA76t_JkZMMC6FHsmc_EOKeLztvgN6nAhTjjK5bQ@mail.gmail.com>
 <871qyse8ra.fsf@jogness.linutronix.de>
 <CA+1+E3WxTOMbh5OCub2wNiNWNELA2fcDL1hXgzJzr-Yc-FuoTQ@mail.gmail.com>
 <87lewzohkk.fsf@jogness.linutronix.de>
 <CA+1+E3WBGf1Q9aXAMiN3gfUEEqWQDfzPH-Hg6-G8FrZEBSZUYw@mail.gmail.com>
Date:   Fri, 25 Mar 2022 09:24:53 +0106
Message-ID: <87r16qzbpu.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2022-03-24, Gautam Thaker <ghthaker@gmail.com> wrote:
> On Thu, Mar 24, 2022 at 1:55 AM John Ogness <john.ogness@linutronix.de> wrote:
> I tried both
> cpufreq-set -g performance
> and
> cpufreq-set -g schedutil
>
> And also set the lower and upper freq to 3.2 GHz. Overall this has not
> made much of a  difference, I still see ~800 usec latency reports out
> of 'hwlatdetect'. The best run was:
>
> ...
> ... [Same for CPUs 0-30 ...]
> analyzing CPU 31:
>   driver: intel_cpufreq
>   CPUs which run at the same hardware frequency: 31
>   CPUs which need to have their frequency coordinated by software: 31
>   maximum transition latency: 20.0 us.
>   hardware limits: 1.20 GHz - 3.20 GHz
>   available cpufreq governors: conservative, ondemand, userspace,
> powersave, performance, schedutil
>   current policy: frequency should be within 3.20 GHz and 3.20 GHz.
>                   The governor "schedutil" may decide which speed to use
>                   within this range.
>   current CPU frequency is 1.20 GHz.

With the performance governor you will see that "current CPU frequency"
is _always_ the max. Without that, I cannot imagine eliminating >100us
latencies.

John Ogness
