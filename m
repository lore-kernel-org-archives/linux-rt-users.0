Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C74EC7112B
	for <linux-rt-users@archiver.kernel.org>; Fri, 18 Aug 2023 09:43:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359310AbjHRJnV (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 18 Aug 2023 05:43:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233355AbjHRJmz (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 18 Aug 2023 05:42:55 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 653A8121
        for <linux-rt-users@vger.kernel.org>; Fri, 18 Aug 2023 02:42:54 -0700 (PDT)
Date:   Fri, 18 Aug 2023 11:42:49 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1692351772;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RSJexWM+tdYY5BgLMQOevh7vzAWYQDtpzPD2CJ3NG2U=;
        b=FLga2JpM6gwEs2MTvm8w7N1tmiNYypObQhHqJdpQaIUYf1Bm95/BolR+NS9IVkLXLtEioK
        z/w7MC3odczPvwQ6y47dGXN95IdRAAWuLJ0q6nCGD630kdGo33mvOOGUWGP8qkQ2IGs+YD
        sFZX9SvHtLIkTjiSFJ2Y5O9/bVM0e66LQY6lrL9owBPG0t1+aEtV1OVhHvuVNW2DtaEPwN
        CNNS4A8pJHXEAdUBlusE+WKfeIQ/FYCU2tGjy6Wjb5LZZzgKsihOSkB+Q9ksBuua4/gmyR
        aLnH2W2u8jS3qq7NNEmaXziX5HteN98NFLF5SiU6AmP11dGBbOEN+g63ncJrdQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1692351772;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RSJexWM+tdYY5BgLMQOevh7vzAWYQDtpzPD2CJ3NG2U=;
        b=yUdRQFMqCcbGIGiWgnqWUmNIOvl+47KeasSGkXnc1/i/72uu7kUCUTuN8GY3MMjkg0qX7l
        i3OhTurMIR+UROCg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Kegl Rohit <keglrohit@gmail.com>
Cc:     linux-rt-users@vger.kernel.org
Subject: Re: rcu stall caused by rt task with high minor page fault rate
Message-ID: <20230818094249.ZH2yxSBA@linutronix.de>
References: <CAMeyCbgGgxpF5Nk=dZXEBS92VxUBR_OcRQqdQdEJAAzqcbP+fQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMeyCbgGgxpF5Nk=dZXEBS92VxUBR_OcRQqdQdEJAAzqcbP+fQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2023-05-30 12:51:48 [+0200], Kegl Rohit wrote:
> Hello!
Hi,

> But for my understanding RCU_BOOST should help here, even if the rt
> app is not implemented correctly?

RCU_BOOST will help to move a task outside of its rcu_read() section if
it got preempted there. Otherwise the RCU machine can't make progress
and free after a grace period. If a task with low priority is stuck in
such a section, then RCU_BOOST will help to move it out. This requires
that the high-priority task gets into a RCU section for it work (usually
not a problem but wouldn't happen if a task loops 100% in userland).

From you describe, your RCU warning came probably from the fact that
your application is consuming 100% of the CPU. Your RT task needs to
rest from to time so that other kernel threads get their turn.

By enabling callback offloading and moving that RCU thread another CPU
you ensure that the completion callbacks get invoked.
Then you need to ensure that RCU can assure that it makes progress. This
is probably what triggers here. There is another thread for that but
this one can only be offloaded with CONFIG_NOHZ_FULL.

> Thanks in advance!

Sebastian
