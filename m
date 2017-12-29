From: Chinmay V S <cvs268@gmail.com>
Subject: Re: Current Best Practices for periodic threads
Date: Fri, 29 Dec 2017 10:34:47 +0530
Message-ID: <CAK-9PRDAW8ssE09K8xajWSqLoHe_g=pGo7SZT04xzSmQXa91Mg@mail.gmail.com>
References: <CAF_dkJDZ+OH5f6mad_zLmHgLq-ysESj984JQ5XTkteN+8Ldwqg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: linux-rt-users@vger.kernel.org
To: Patrick Doyle <wpdster@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-ua0-f178.google.com ([209.85.217.178]:45568 "EHLO
        mail-ua0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750707AbdL2FF2 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 29 Dec 2017 00:05:28 -0500
Received: by mail-ua0-f178.google.com with SMTP id e39so6022177uae.12
        for <linux-rt-users@vger.kernel.org>; Thu, 28 Dec 2017 21:05:28 -0800 (PST)
In-Reply-To: <CAF_dkJDZ+OH5f6mad_zLmHgLq-ysESj984JQ5XTkteN+8Ldwqg@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

> On a somewhat related topic... how do folks stagger the startup of
> periodic threads?  For example, suppose one (high priority) thread
> needs to run every 20ms, only takes 1ms to do its work, but _really_
> needs to run on that 20ms clock.  Now suppose some other thread needs
> 4ms out of every 20ms to accomplish it's work.  If it were to start
> 9ms after the first thread started, then every 10ms one thread or the
> other would run, leaving 15ms for non-realtime (or lower priority real
> time) threads to run.
>
> I can imagine any number of home-grown solutions to manage the
> staggered startup of these two threads.  I am wondering if there is a
> more standard way to do this.

Can we simply configure the "timer slack" appropriately and
let the kernel decide how much to stagger or coalesce
the timer events as it sees fit?
https://lwn.net/Articles/369361/


regards
CVS
