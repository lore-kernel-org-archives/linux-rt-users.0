From: Patrick Doyle <wpdster@gmail.com>
Subject: Current Best Practices for periodic threads
Date: Thu, 28 Dec 2017 11:55:50 -0500
Message-ID: <CAF_dkJDZ+OH5f6mad_zLmHgLq-ysESj984JQ5XTkteN+8Ldwqg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-ot0-f176.google.com ([74.125.82.176]:45093 "EHLO
        mail-ot0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750854AbdL1Q4V (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 28 Dec 2017 11:56:21 -0500
Received: by mail-ot0-f176.google.com with SMTP id d44so26377714otd.12
        for <linux-rt-users@vger.kernel.org>; Thu, 28 Dec 2017 08:56:21 -0800 (PST)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello List!
What are the current best practices for creating periodic threads with
real-time Linux?

Do folks primarily use timerfd?

Do folks primarily use POSIX timers and sigwait?

On a somewhat related topic... how do folks stagger the startup of
periodic threads?  For example, suppose one (high priority) thread
needs to run every 20ms, only takes 1ms to do its work, but _really_
needs to run on that 20ms clock.  Now suppose some other thread needs
4ms out of every 20ms to accomplish it's work.  If it were to start
9ms after the first thread started, then every 10ms one thread or the
other would run, leaving 15ms for non-realtime (or lower priority real
time) threads to run.

I can imagine any number of home-grown solutions to manage the
staggered startup of these two threads.  I am wondering if there is a
more standard way to do this.

Any thoughts?

--wpd
