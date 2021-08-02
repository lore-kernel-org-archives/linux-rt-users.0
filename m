Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C97BC4338F
	for <linux-rt-users@archiver.kernel.org>; Mon,  2 Aug 2021 06:48:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4875561050
	for <linux-rt-users@archiver.kernel.org>; Mon,  2 Aug 2021 06:48:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232338AbhHBGsv (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 2 Aug 2021 02:48:51 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:46768 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbhHBGsv (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 2 Aug 2021 02:48:51 -0400
Date:   Mon, 2 Aug 2021 08:48:39 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1627886921;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Xgf1w1Yr/16S3cF94i8thIesk7lQfXggo53DqXgkW/U=;
        b=b8dBOzF271SQA/M35jNDcWW/IhmmpdbKIerURJYyAEdGo/BMTQYePCp7Kp37uX7YTtki8L
        Quk3npsD7kHWAlG/lzr/10YsZVaClYNVb0pWKu5fxrbiAuhumMsLRov/7MRze2O5c1BLGV
        aRN8wrIhrslJ7RXmfpkw9iy7Lil3Dnypr6VQxPdTgsqvd8Bo/myjLfVWM7TZjq+OAZro1C
        YQYP4OOBzjLyZzcx0DYbr0ux3S1NFxvIkZuFK+zdOSnomphGraLukeQmTxU7Ua+PnteZLj
        7psWSsS8YJVOz86nO9PjnoE2ZpiCuQOt0hJoEauNZMVhHF5ilfLJ2oXvNwvz+w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1627886921;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Xgf1w1Yr/16S3cF94i8thIesk7lQfXggo53DqXgkW/U=;
        b=hRfOp6IpGCycyJp2CE5/Aow8e1okWEvCw/bMhbGqS7OnkbbtRaFV3GaVSTxWdmr1qyEpZt
        L5EkSCWl7pPDD9Bw==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     chao.qin@intel.com, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org, tglx@linutronix.de,
        rostedt@goodmis.org, mgross@linux.intel.com, paul.mei@intel.com,
        lili.li@intel.com
Subject: Re: [PREEMPT_RT][PATCH] printk: Enhance the condition check of
 msleep in pr_flush()
Message-ID: <20210802064839.eukhmuxxv76uij3j@linutronix.de>
References: <20210719022649.3444072-1-chao.qin@intel.com>
 <87mtqiuzd4.fsf@jogness.linutronix.de>
 <20210730140143.53wls2g7xf2ktdgv@linutronix.de>
 <87k0l7svu5.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87k0l7svu5.fsf@jogness.linutronix.de>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2021-07-30 16:52:42 [+0206], John Ogness wrote:
> On 2021-07-30, Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:
> > I don't have more context but scheduling should work starting with
> > SYSTEM_SCHEDULING.
> 
> I also thought this, but a quick test shows that is not the case. For
> example, init/main.c:kernel_init() is called in preemptible context, but
> msleep() will hang if called at the beginning of that function.

hmm. So the timer device is missing. Everything else is fine.

> John Ogness

Sebastian
