Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC49FC433EF
	for <linux-rt-users@archiver.kernel.org>; Thu, 24 Mar 2022 08:55:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349044AbiCXI5N (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 24 Mar 2022 04:57:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237920AbiCXI5M (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 24 Mar 2022 04:57:12 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15D9D8BF1C
        for <linux-rt-users@vger.kernel.org>; Thu, 24 Mar 2022 01:55:41 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1648112139;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TNA9TKamYeW7v38+fkT2ECMusVkDEgezEgRCQvk+yuc=;
        b=eLX6Q8nlFeFwGxpmkHscwUuaHbvH0/9MOq8rE/+sTgVi4EmNfnqLgTNm7OqGTK6EmBd/ik
        KEtbFQIqZS47xcs3I9UMdCG+cmJLTUcRGESPfuiQCvBoT8BiOuv9WF0gLrcZrRM0dceM4V
        wW73LKIorIGnMQinNEykY0zPRHY6gbPPKjuIgeeHrNMy8dF9s4jdxEdkOrUdo1hJjMDQKK
        UhsSo0qsjkfsGucrn54yU8DCswAnheIzcPHH/aCq6FQkVK+f1aD5mPhUSw9ERrY3uLYH/s
        aW6NxkvQAbxZpErIzDyCP+ENglEDxBBVr80z7y5HygRyFlr16w7ysj1DFAzzvw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1648112139;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TNA9TKamYeW7v38+fkT2ECMusVkDEgezEgRCQvk+yuc=;
        b=RXDAW+mWXnubHxmE1/LCbm/HjTa/s9BmOmuBtPj64bjfvfE0h0PnK7bx+Snyw9r/Reb107
        URJhFdanxup3YmAw==
To:     Gautam Thaker <ghthaker@gmail.com>
Cc:     linux-rt-users@vger.kernel.org
Subject: Re: 5.15.28-rt35 #2 SMP PREEMPT_RT: Should scheduling latency be as
 large as 800 usec?
In-Reply-To: <CA+1+E3WxTOMbh5OCub2wNiNWNELA2fcDL1hXgzJzr-Yc-FuoTQ@mail.gmail.com>
References: <CA+1+E3UVmbLA76t_JkZMMC6FHsmc_EOKeLztvgN6nAhTjjK5bQ@mail.gmail.com>
 <871qyse8ra.fsf@jogness.linutronix.de>
 <CA+1+E3WxTOMbh5OCub2wNiNWNELA2fcDL1hXgzJzr-Yc-FuoTQ@mail.gmail.com>
Date:   Thu, 24 Mar 2022 10:01:39 +0106
Message-ID: <87lewzohkk.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2022-03-23, Gautam Thaker <ghthaker@gmail.com> wrote:
>> > processor       : 31
>> > vendor_id       : GenuineIntel
>> > cpu family      : 6
>> > model           : 63
>> > model name      : Intel(R) Xeon(R) CPU E5-2630 v3 @ 2.40GHz
>> > stepping        : 2
>> > microcode       : 0x46
>> > cpu MHz         : 1200.000
>> > cache size      : 20480 KB
>>
>> Your CPU is running at 1.2GHz although it is capable of 2.4GHz. This
>> looks like you have CPU frequency scaling activated. Investigate:
>>
>> grep -i cpu_freq /boot/config-5.15.28-rt35
>
> node-0> grep -i cpu_freq /boot/config-5.15.28-rt35
> CONFIG_ACPI_CPU_FREQ_PSS=y
> CONFIG_CPU_FREQ=y
> CONFIG_CPU_FREQ_GOV_ATTR_SET=y
> CONFIG_CPU_FREQ_GOV_COMMON=y
> CONFIG_CPU_FREQ_STAT=y
> CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE=y
> # CONFIG_CPU_FREQ_DEFAULT_GOV_POWERSAVE is not set
> # CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE is not set
> # CONFIG_CPU_FREQ_DEFAULT_GOV_SCHEDUTIL is not set
> CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
> CONFIG_CPU_FREQ_GOV_POWERSAVE=y
> CONFIG_CPU_FREQ_GOV_USERSPACE=y
> CONFIG_CPU_FREQ_GOV_ONDEMAND=y
> CONFIG_CPU_FREQ_GOV_CONSERVATIVE=y
> CONFIG_CPU_FREQ_GOV_SCHEDUTIL=y

Your system is configured to support many different governors. For
minimal latency it is important that you are using the performance
governor. The frequency scaling might be the cause of the horrible
hwlatdetect numbers you are seeing.

If you have the cpufrequtils package installed, you can easily switch to
the performance governor with:

cpufreq-set -g performance

With cpufreq-info you can see a nice summary of how your CPUs are
currently set. You should see it running full speed.

You can also configure the performance governor manually using
sysfs. You may want to read through the documentation [0] so that you
understand what you are doing.

[0] https://www.kernel.org/doc/html/latest/admin-guide/pm/cpufreq.html

>> The configuration of your tick may also be interesting:
>>
>> grep -i hz /boot/config-5.15.28-rt35
>>
>
> node-0> grep -i hz /boot/config-5.15.28-rt35
> CONFIG_NO_HZ_COMMON=y
> # CONFIG_HZ_PERIODIC is not set
> CONFIG_NO_HZ_IDLE=y
> # CONFIG_NO_HZ_FULL is not set
> CONFIG_NO_HZ=y
> # CONFIG_HZ_100 is not set
> CONFIG_HZ_250=y
> # CONFIG_HZ_300 is not set
> # CONFIG_HZ_1000 is not set
> CONFIG_HZ=250
> # CONFIG_MACHZ_WDT is not set

The tick configuration won't be responsible for the huge latencies you
are seeing. But when you start getting your latency down, you may want
to consider using CONFIG_HZ_PERIODIC with CONFIG_HZ_100 (or
CONFIG_HZ_1000 if this is a machine with a huge network load). But these
settings can be very dependent on the types of work your system is
doing, so you will need to test the latency affects. Possibly you will
notice no affects.

Adding --secaligned to your cyclictest command can help to force
situations where your latency will be worsened because of the
tick. Optimally you want cyclictest to hit the worst case scenario.

John Ogness
