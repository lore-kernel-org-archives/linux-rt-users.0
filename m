From: John Kacur <jkacur@redhat.com>
Subject: Re: Calculate average latencies on the fly
Date: Wed, 16 Nov 2016 15:47:47 +0100 (CET)
Message-ID: <alpine.LFD.2.20.1611161525280.12617@riemann.fritz.box>
References: <CAK+oA4V8yFDnieAa4tsCQKTapNe6gA_VLJvvEh6_u_jgWpyahQ@mail.gmail.com> <CAK+oA4WFAaT4DmR=8nKqTsyKe9imDYCu5p6DG4kqbhoBPD=LXw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="-1463806542-875870259-1479307668=:12617"
Cc: Clark Williams <williams@redhat.com>,
        linux-rt-users@vger.kernel.org
To: Piotr Gregor <piotrgregor@rsyncme.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-qk0-f179.google.com ([209.85.220.179]:34490 "EHLO
        mail-qk0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752206AbcKPOru (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 16 Nov 2016 09:47:50 -0500
Received: by mail-qk0-f179.google.com with SMTP id q130so177869322qke.1
        for <linux-rt-users@vger.kernel.org>; Wed, 16 Nov 2016 06:47:49 -0800 (PST)
In-Reply-To: <CAK+oA4WFAaT4DmR=8nKqTsyKe9imDYCu5p6DG4kqbhoBPD=LXw@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463806542-875870259-1479307668=:12617
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT


Please inline the patches

There are 1000000 microseconds / second, the default interval is 1000us, 
but let's say we did it more frequently at 100us

1000000 us /  100 intervals = 10000 samples / second * 60 sec/min * 60 
min/hr * 24 hrs/day * 365 days / year * 1000 (very pessimistic diff) =
an accumulated diff of 3.1536×10^14

With a max double of 9x10^15/3.15*10^14 we could run for 30 years before 
we move into normal numbers.

So, the problem with your patch, is not just the problem which it proposes 
to fix, is one I see as mostly theoretical, but there is the potential for 
accumulating small inaccuracies.

Of course, there is always the chance that I made some kind of error in my 
analysis here, please feel free to point it out!

What might be more interesting is how long would it take for the cycles to 
overflow?

Thanks

John

On Mon, 14 Nov 2016, Piotr Gregor wrote:

> There was an error in previous patch. Please find attached corrected patch.
> 
> cheers,
> Piotr
> 
---1463806542-875870259-1479307668=:12617--
