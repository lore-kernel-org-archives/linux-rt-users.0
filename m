Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91D20C433EF
	for <linux-rt-users@archiver.kernel.org>; Sun, 28 Nov 2021 16:24:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352779AbhK1Q10 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Sun, 28 Nov 2021 11:27:26 -0500
Received: from sender4-op-o15.zoho.com ([136.143.188.15]:17537 "EHLO
        sender4-op-o15.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235988AbhK1QZ0 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Sun, 28 Nov 2021 11:25:26 -0500
X-Greylist: delayed 58592 seconds by postgrey-1.27 at vger.kernel.org; Sun, 28 Nov 2021 11:25:26 EST
ARC-Seal: i=1; a=rsa-sha256; t=1638116509; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=M6xT5h0zClw8DD+dgU9Xl3+v+ePIn06JCTs4rk+XqsFLXbZMzjr0N4hrArHarE2PDP9V9kwQY+ZmJE0rpod6MIQbBVsI5oTNIK7kpu1nFHFlJM137Bc4OpwiW30gm7sQYEldgFqmSs/+fPONHv3Q+2pNFLq0z22sOIO/4ZV9n2s=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1638116509; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=YYeOwx6CNvENJgb27Vn+FmTcemWXvXDoI8iKqqUTwyQ=; 
        b=m+G2YSLQIL+JbtZWLEcNRau4XYq2B9bENkqxjj5PdTEqwU4hjDd2oRTy3AeC9P7Gm+a2+bvB/WT2p+t5f3mAkg2DFd1L0n6IGaWRj00Y5auFS5lbMC6GxLYPP/jtTUPWuiRVSj7zUhzWkdLo7Pz/WNGX0fwxPI6bIBmsA7BJwlU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=szanni.org;
        spf=pass  smtp.mailfrom=angelo@szanni.org;
        dmarc=pass header.from=<lkml@szanni.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1638116509;
        s=zoho; d=szanni.org; i=lkml@szanni.org;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
        bh=YYeOwx6CNvENJgb27Vn+FmTcemWXvXDoI8iKqqUTwyQ=;
        b=NeOEjEaZGHcT4y9IZXgSxEIQqjmtypIpD4ts4W1nSokthyLL/PJWafG9r3OLTUvz
        a490hMNHjePMdH8z39+krzkxICIiAM3nZchpkSFn7xZQZjaBx9OHMJMeYFYMSalXLZd
        uGy3QlemYAxtArAYBuQ6M3teWXCAWZSxPFcTDims=
Received: from [192.168.0.128] (200.60.135.218 [200.60.135.218]) by mx.zohomail.com
        with SMTPS id 163811650856923.573649579276434; Sun, 28 Nov 2021 08:21:48 -0800 (PST)
Message-ID: <3bbacbed-2c52-f37f-070c-adece794e3ef@szanni.org>
Date:   Sun, 28 Nov 2021 11:24:12 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: sched: some non-GPL symbols becoming GPL-only with
 CONFIG_PREEMPT_RT enabled
Content-Language: en-US
To:     linux-kernel@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Will Deacon <will@kernel.org>, linux-rt-users@vger.kernel.org,
        Oleksandr Natalenko <oleksandr@natalenko.name>
References: <5475c3ab-a53c-8728-98c5-98fd948ff556@szanni.org>
 <2606453.mvXUDI8C0e@natalenko.name>
From:   Angelo Haller <lkml@szanni.org>
In-Reply-To: <2606453.mvXUDI8C0e@natalenko.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 28/11/2021 04.46, Oleksandr Natalenko wrote:
> Hello.
> 
> On neděle 28. listopadu 2021 1:07:49 CET Angelo Haller wrote:
>> Greetings. I hope I picked the right mailing list, as this issue might
>> be one that affects various subsystems and components:
>>
>> When compiling kernel 5.15 (and 5.16-rc2) with `CONFIG_PREEMPT_RT`
>> enabled, some of the symbols being exported as `EXPORT_SYMBOL` suddenly
>> become `EXPORT_SYMBOL_GPL` through transitive effects.
>>
>> In particular the symbols `migrate_enable` and `migrate_disable` are
>> currently marked as `EXPORT_SYMBOL_GPL` - yet are called from multiple
>> functions that are marked as `EXPORT_SYMBOL`.
>>
>> Here an (incomplete?) listing of call sites I came across:
>>
>> kernel/locking/spinlock_rt.c - rt_spin_unlock()
>> kernel/locking/spinlock_rt.c - rt_read_unlock()
>> kernel/locking/spinlock_rt.c - rt_write_unlock()
>> mm/highmem.c - kunmap_local_indexed()
>>
>> The issue I'm facing in particular is kmap_atomic() calling
>> `migrate_disable` and therefore suddenly becoming GPL-only. This breaks
>> the out-of-tree CDDL licensed module ZFS and has been reported before
>> already [0]. The conversation seemingly going nowhere - or patches at
>> least not being applied upstream. Downstream issue for reference [1].
> 
> What about going the other way around and let ZFS be re-licensed under GPL?
> 
That would be lovely but is unlikely to ever happen. Numerous people 
have tried over the years - many, including me, would love for ZFS to be 
mainlined but unless Oracle decides to re-license the original code this 
will most likely not happen [3].

This is not really the main issue I was trying to highlight though.
What I was highlighting is the fact that exported symbols change license 
depending on the kconfig!
This will randomly stop dkms modules from building depending on my (or 
my distributions) kconfig. To me as a user this effectively BREAKS user 
space.
And yes, I am aware exported symbols are not syscalls but I thought 
there was at least some type of stability guarantee within the same 
kernel version. Maybe my thoughts on that matter are incorrect though.

[3] https://github.com/openzfs/zfs/issues/8314
>> As the original implementation of `migrate_enable` and `migrate_disable`
>> is apparently by Peter Zijlstra [2]. Peter would you be willing to
>> re-license both symbols `migrate_enable` and `migrate_disable` as
>> `EXPORT_SYMBOL`?
>>
>> The bigger issue I'm seeing though is that there is currently no
>> automated test to uncover exported symbols changing their license
>> depending on build configuration? I am not intimately familiar with the
>> API guarantees the kernel gives, but this seems like a violation. There
>> might be other symbols with similar licensing problems.
>>
>> I can open a bugzilla ticket too - if that is preferred.
>>
>> Angelo
>>
>>
>> [0]
>> https://lore.kernel.org/linux-rt-users/20201208212841.694b3022@orivej.orivej
>> .org/T/ [1] https://github.com/openzfs/zfs/issues/11097
>> [2]
>> https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git/diff/p
>> atches/0009-sched-Add-migrate_disable.patch?h=v5.9-rc8-rt14-patches&id=9a89b
>> fdb3bc77aecdd0ff8cc69b595541c7b50c4
> 
> 
