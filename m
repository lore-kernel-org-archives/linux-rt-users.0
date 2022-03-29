Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0C3AC433EF
	for <linux-rt-users@archiver.kernel.org>; Tue, 29 Mar 2022 05:22:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231966AbiC2FXw (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 29 Mar 2022 01:23:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232336AbiC2FXv (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 29 Mar 2022 01:23:51 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94E331B2C44
        for <linux-rt-users@vger.kernel.org>; Mon, 28 Mar 2022 22:22:09 -0700 (PDT)
Date:   Tue, 29 Mar 2022 07:22:06 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1648531327;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sFbCVjRrU3zZVp2mrDIQP9dFhWQRBtFx8KRaM4vviF4=;
        b=APndlu3awwjdAGTLDk0oM2zOcEJ+jphHt2GWioL0W9UlW034hfLPlVra4p/atV6y9UCywW
        dFmUq3ukwpQrvE52Zb2571ylb5ebCwj1tfKxaYy/hh7iWp5Gy+Z9bTXC4nao+mwHA1z1+P
        L0OUG29SVoFJrS2sIDWpH6PxrUJIMyvcF8aMhr1JYsw6zvf9L2F4M3e0RuqFfqd+eoTOtT
        SUzBnoCWf8Acjv8d4DWIhpeDDJAcsxdeQyLrZAonP2AJIZ5N4jIfr37AFrNaoNeXl2byFw
        IrQXZLljM6cr4PG1petVfx8boJweM/cse64Qhs1drOxSbwSbRAyd9z9a2doh+A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1648531327;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sFbCVjRrU3zZVp2mrDIQP9dFhWQRBtFx8KRaM4vviF4=;
        b=o38xCPtOrafBmVD5pCyxkJ/SGCcTyO9fNlkbYNZoIPJBGPtqcFK14uxrTt88EfUdQBkn/p
        2rNFB41OYkROySBQ==
From:   "Ahmed S. Darwish" <a.darwish@linutronix.de>
To:     "Chen, Angus" <angus.chen@intel.com>
Cc:     "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
        "bigeasy@linutronix.de" <bigeasy@linutronix.de>,
        "Chang, Junxiao" <junxiao.chang@intel.com>,
        "Ung, Teng En" <teng.en.ung@intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>
Subject: Re: RT  kernel video playback issue (screen freeze)
Message-ID: <YkKXfiwl+CJvAswz@lx-t490>
References: <DM6PR11MB4596027F97399B46BCD7681B8F199@DM6PR11MB4596.namprd11.prod.outlook.com>
 <DM6PR11MB459605ADA58FBEAE43EDD3468F1E9@DM6PR11MB4596.namprd11.prod.outlook.com>
 <DM6PR11MB45963AAEF4717C359986FBCB8F1E9@DM6PR11MB4596.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DM6PR11MB45963AAEF4717C359986FBCB8F1E9@DM6PR11MB4596.namprd11.prod.outlook.com>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Am Tue, Mar 29, 2022, schrieb Chen, Angus:
>
> When we playing a H265 file on our Tiger Lake platform (OS : Yocto,
> CPU : Intel® CoreT i7-1185GRE Processor (12M Cache, up to 4.40 GHz)),
>  we encounter a system hang/freeze issue (without enabling GuC
> submitting)
>
> We use the following command to reproduce this issue.
>
[gst-launch snippet]...
>
> We also can reproduce this issue on upstream v5.15.27-rt35.
>
> The dmesg log from UART port.  After the log showed "the sched: RT
> throttling activated", the screen freeze.
>

First, are you running a custom RT workload that has gone rogue; e.g.,
your RT application got stuck in an infinite loop?

Second, were you by any chance running gst-launch with RT priorities?

Anyway, before running the gst-launch snippet above, can you also try
first, under root:

  echo -1 > /proc/sys/kernel/sched_rt_runtime_us

and see if it helps?

>
>
> After bisecting, we found that it was related to the following patchset
>
> https://lkml.org/lkml/2021/10/6/367
>

In general, please avoid using https://lkml.org. It's a private service
that obscures the unique email identifier, Message-ID, within its URL.

Use the now official "https://lore.kernel.org/" instead, which keeps the
Message-ID field explicit.

Anyway, I always got a Cloudflare-404 when accessing the lkml.org link
above, sorry.

Good luck,

--
Ahmed S. Darwish
Linutronix GmbH
