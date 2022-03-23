Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C27DC433EF
	for <linux-rt-users@archiver.kernel.org>; Wed, 23 Mar 2022 20:16:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240569AbiCWUST (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 23 Mar 2022 16:18:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239619AbiCWUSS (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 23 Mar 2022 16:18:18 -0400
Received: from mail-vs1-xe36.google.com (mail-vs1-xe36.google.com [IPv6:2607:f8b0:4864:20::e36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87E5789CEE
        for <linux-rt-users@vger.kernel.org>; Wed, 23 Mar 2022 13:16:47 -0700 (PDT)
Received: by mail-vs1-xe36.google.com with SMTP id g21so2720434vsp.6
        for <linux-rt-users@vger.kernel.org>; Wed, 23 Mar 2022 13:16:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Qigl5iDJJTTWNJAy/58wCkCRYQtBucTyLUwoo3L0Ny0=;
        b=MFR1vhISuDxhToPqjPwmw80S9TpSCaE50+nKJkh6bMdWE+pDVNd8ECWLork0ybTdOz
         NigHm4djNWJjjGuox9i3G/eUB+LrQisqdwQ9xcKCDM5XPblnAryUX/qa3JHN6KB5DXA/
         QBEbJyfwVEvjKAhKNpysVk2XILW/gEk/p3eI97A1KBzETnc2wVkWjzbb2lhuIwXiO4m7
         ENGLvgqKvySwjLel4KusHd9FBOpO9h/V7vXy1cO8dP/62cxcLom2VM66PZ8tKHmenIQR
         Kj4LHLGrwm7DDEkaGdh8JMdvrVubgisQc0Ycwhpe3tvBap0ymXHWOjOP+b23T2RfEm3L
         HxzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Qigl5iDJJTTWNJAy/58wCkCRYQtBucTyLUwoo3L0Ny0=;
        b=ADmrbhmAOhB8P+MKWaHYXPL2gG7Ej3hq1+B/Q95mbPGyYC01yK6VDQNnaZ6ACrTpqZ
         1OB7EAskTeY2wvsS2MJ/an+vGaSzejqp7ZCVTeiBt5O9P0BdWmm746auSeNq4Dho0Ww4
         oCtZL7MbcqcQTUqDEoC+xhRVKqup3cfFiYPvGnN0UJe0FKCN7nGcoZsZ2O4NOyTyYCeY
         r/njoaxbvTBq6+Bd5jJM02QY39Af44gKIIXnke7HD5pA4XMknpGRq0jl9sRGCx/DHqH1
         tFFbrTeWr/ox5R32lhIXocVO0mUGpdtDmETMT88/0engxZhr+l6swA2zqsaS7DCuMBZL
         Si4Q==
X-Gm-Message-State: AOAM532n2JV/Gjk4rfcpHnscqrK6qBrsIH1Y1kzUMIQA0sAe4FLKTpea
        9EVzHpcy9Ec1jIybQK6fFSNfGFMNd2kTqW9UfiUllTnjC5U=
X-Google-Smtp-Source: ABdhPJzOhfavB7rNWPOuhQhQPuYdw3Zs+2kLj1J5bCfISh8qj6BCwkTh0Y4xAUuH4K7SeYSzA21NhuqVnJynlLhhCnw=
X-Received: by 2002:a05:6102:f0c:b0:320:9156:732f with SMTP id
 v12-20020a0561020f0c00b003209156732fmr1113023vss.6.1648066606590; Wed, 23 Mar
 2022 13:16:46 -0700 (PDT)
MIME-Version: 1.0
References: <CA+1+E3UVmbLA76t_JkZMMC6FHsmc_EOKeLztvgN6nAhTjjK5bQ@mail.gmail.com>
 <871qyse8ra.fsf@jogness.linutronix.de>
In-Reply-To: <871qyse8ra.fsf@jogness.linutronix.de>
From:   Gautam Thaker <ghthaker@gmail.com>
Date:   Wed, 23 Mar 2022 13:16:35 -0700
Message-ID: <CA+1+E3WxTOMbh5OCub2wNiNWNELA2fcDL1hXgzJzr-Yc-FuoTQ@mail.gmail.com>
Subject: Re: 5.15.28-rt35 #2 SMP PREEMPT_RT: Should scheduling latency be as
 large as 800 usec?
To:     John Ogness <john.ogness@linutronix.de>
Cc:     linux-rt-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

> > processor       : 31
> > vendor_id       : GenuineIntel
> > cpu family      : 6
> > model           : 63
> > model name      : Intel(R) Xeon(R) CPU E5-2630 v3 @ 2.40GHz
> > stepping        : 2
> > microcode       : 0x46
> > cpu MHz         : 1200.000
> > cache size      : 20480 KB
>
> Your CPU is running at 1.2GHz although it is capable of 2.4GHz. This
> looks like you have CPU frequency scaling activated. Investigate:
>
> grep -i cpu_freq /boot/config-5.15.28-rt35

node-0> grep -i cpu_freq /boot/config-5.15.28-rt35
CONFIG_ACPI_CPU_FREQ_PSS=y
CONFIG_CPU_FREQ=y
CONFIG_CPU_FREQ_GOV_ATTR_SET=y
CONFIG_CPU_FREQ_GOV_COMMON=y
CONFIG_CPU_FREQ_STAT=y
CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE=y
# CONFIG_CPU_FREQ_DEFAULT_GOV_POWERSAVE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_SCHEDUTIL is not set
CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
CONFIG_CPU_FREQ_GOV_POWERSAVE=y
CONFIG_CPU_FREQ_GOV_USERSPACE=y
CONFIG_CPU_FREQ_GOV_ONDEMAND=y
CONFIG_CPU_FREQ_GOV_CONSERVATIVE=y
CONFIG_CPU_FREQ_GOV_SCHEDUTIL=y

AND:

>
> The configuration of your tick may also be interesting:
>
> grep -i hz /boot/config-5.15.28-rt35
>

node-0> grep -i hz /boot/config-5.15.28-rt35
CONFIG_NO_HZ_COMMON=y
# CONFIG_HZ_PERIODIC is not set
CONFIG_NO_HZ_IDLE=y
# CONFIG_NO_HZ_FULL is not set
CONFIG_NO_HZ=y
# CONFIG_HZ_100 is not set
CONFIG_HZ_250=y
# CONFIG_HZ_300 is not set
# CONFIG_HZ_1000 is not set
CONFIG_HZ=250
# CONFIG_MACHZ_WDT is not set

> John Ogness

It seems you are saying some of these settings, related to CPU freq
scaling and "tick" settings may be the cause of my ~800 usec latencies
I see.  As I am seeking the "best possible that I can achieve" number
I am willing to set the configs anyway needed. Any suggestions?

Thanks.

Gautam
