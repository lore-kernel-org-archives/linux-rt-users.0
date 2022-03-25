Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E32BC433EF
	for <linux-rt-users@archiver.kernel.org>; Fri, 25 Mar 2022 15:50:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355088AbiCYPwH (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 25 Mar 2022 11:52:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234183AbiCYPwG (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 25 Mar 2022 11:52:06 -0400
Received: from mail-vs1-xe30.google.com (mail-vs1-xe30.google.com [IPv6:2607:f8b0:4864:20::e30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07BD74CD58
        for <linux-rt-users@vger.kernel.org>; Fri, 25 Mar 2022 08:50:33 -0700 (PDT)
Received: by mail-vs1-xe30.google.com with SMTP id 2so8765206vse.4
        for <linux-rt-users@vger.kernel.org>; Fri, 25 Mar 2022 08:50:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Gc0yMZObXS2V0IXPdzgqXMhHKX+gDNiypy2vjhzQizs=;
        b=dJtAVW8mq42w8y4SNhokhi467wxuKM2UbNrxV9iiPo6yRLmiu2xZ7Yu+fZCFpyvyof
         gwLu75BVRcd+JHI22l2cHfnJmQ9Bl5KnyPyay5Sl/G0lTn0E6jCoqR9skZxtdd446eP9
         4Imfj8hJ/gEM1lJyRiNLtnVVfxvVia8dQ98BfQFKCo+LTr5jeGc3gbMZtOlMN8BQZImk
         4i0hFyb5CT/MB6/iXgFyy6RZHYZ48FkTaaFCCPntypGExaGetfqf5eIx+u8x8DqUIQT9
         JTBSiI4kvyZhs1ZHPvJWedxv5Et+LFCLJQ2qTdAlJuUiEyyMzsvOSYmQbzHsHIjp948B
         HoMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Gc0yMZObXS2V0IXPdzgqXMhHKX+gDNiypy2vjhzQizs=;
        b=PJi/39dOVt/v6QYdVaf7sgw6hbUIXjsJiIjyiMSAMHy4p169Cs0ZRyULPs39cpVU2o
         1DgU/7tzK/Z/NwZkFO2pwTxB4nRqFAD2uO3SW/qoR3z+5rOYRPw0E1/U0ETjsNKplri1
         oH/jnvlhqbSy2SaxsGY6Fd7dEG6isR17Qhy++XoaU+QU4fGh6C0dCZNAqBU1zez4Ydef
         pagBhCsa/OBSqaDE5UGtIZruNYk600j/W1D2TkqVWRStWjrjhjw1Bok29dNORtSmYkIN
         rUkFu3GzXuDanzkJXMYo/w35KeyQ3e+XP+mxoP2HMQwFWcdHWqvmW7I/mAbx3YXZMRbE
         O5SQ==
X-Gm-Message-State: AOAM530gBh8ZDmif7YRrGO3uSIk+SKf5KfBHocw4LSyKwuVPozyJaDlD
        c7VCcbAzWcn2P6oiywhH33HH6DqSwZRFs2hDou/VbkToRgM=
X-Google-Smtp-Source: ABdhPJxcSOd1/CkqegLYBc0E7gX7SDYair1HxN/k7y5pcn1SIm731x0poZAOea1B/p0vgpMMOWdypEKLYH07Co704kk=
X-Received: by 2002:a05:6102:1614:b0:325:6e2d:8b93 with SMTP id
 cu20-20020a056102161400b003256e2d8b93mr2447305vsb.59.1648223432003; Fri, 25
 Mar 2022 08:50:32 -0700 (PDT)
MIME-Version: 1.0
References: <CA+1+E3UVmbLA76t_JkZMMC6FHsmc_EOKeLztvgN6nAhTjjK5bQ@mail.gmail.com>
 <871qyse8ra.fsf@jogness.linutronix.de> <CA+1+E3WxTOMbh5OCub2wNiNWNELA2fcDL1hXgzJzr-Yc-FuoTQ@mail.gmail.com>
 <87lewzohkk.fsf@jogness.linutronix.de> <CA+1+E3WBGf1Q9aXAMiN3gfUEEqWQDfzPH-Hg6-G8FrZEBSZUYw@mail.gmail.com>
 <87r16qzbpu.fsf@jogness.linutronix.de>
In-Reply-To: <87r16qzbpu.fsf@jogness.linutronix.de>
From:   Gautam Thaker <ghthaker@gmail.com>
Date:   Fri, 25 Mar 2022 08:50:19 -0700
Message-ID: <CA+1+E3XkM=4ZPbbOGtj7kuWtJfciAJ+=M-UrOn-9YA2_B2mjmA@mail.gmail.com>
Subject: Re: 5.15.28-rt35 #2 SMP PREEMPT_RT: Should scheduling latency be as
 large as 800 usec?
To:     John Ogness <john.ogness@linutronix.de>
Cc:     linux-rt-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Fri, Mar 25, 2022 at 1:18 AM John Ogness <john.ogness@linutronix.de> wrote:
> With the performance governor you will see that "current CPU frequency"
> is _always_ the max. Without that, I cannot imagine eliminating >100us
> latencies.

Even after I set  to "-g performance"  and set "-d 3.2GHz -u 3.2GHz"  I get:

..[same for all CPUS 0-30 as well]
analyzing CPU 31:
  driver: intel_cpufreq
  CPUs which run at the same hardware frequency: 31
  CPUs which need to have their frequency coordinated by software: 31
  maximum transition latency: 20.0 us.
  hardware limits: 1.20 GHz - 3.20 GHz
  available cpufreq governors: conservative, ondemand, userspace,
powersave, performance, schedutil
  current policy: frequency should be within 3.20 GHz and 3.20 GHz.
                  The governor "performance" may decide which speed to use
                  within this range.
  current CPU frequency is 1.20 GHz.

The current CPU freq is at 1.2 GHz.   SHould "current CPU frequency"
be at 3.2 GHz now all the time?

And even at 1.2GHz, if that freq is steady, why should 'hwlatdetect'
report the 800 usec latency? It seems my issues are something other
than  "cpufreq-set" policy I am using. (SMIs?)

Gautam



>
> John Ogness
