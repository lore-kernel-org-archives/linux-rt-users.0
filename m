From: Ran Shalit <ranshalit@gmail.com>
Subject: Optimizing performance - i5
Date: Mon, 11 Dec 2017 18:59:26 +0200
Message-ID: <CAJ2oMh+S-C6+TrHMZxd6o0+c8PgE7j93WEngT71mgUMxngQ9xQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
To: linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wm0-f44.google.com ([74.125.82.44]:37228 "EHLO
        mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750707AbdLKQ72 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 11 Dec 2017 11:59:28 -0500
Received: by mail-wm0-f44.google.com with SMTP id f140so15432872wmd.2
        for <linux-rt-users@vger.kernel.org>; Mon, 11 Dec 2017 08:59:27 -0800 (PST)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello,

We are trying to optimize performance with  i5 , 4 cores.
We saw some strange behavior when using stress on all cores:
"Sometimes" when testing performance with cyclictest we see that
average on each core to ~20usec.
Then, when we start stress on all 4 cores, it gets down to ~2usec.
The weird thing is that it is not consistent.
Most of the time, we see same behavior in both stress and without
stress, of 2usec average.
And suddenly in next boot it gets the "weird" performance.
We are not yet sure, what happens in boot that gets this behavior.
The maximum is kept the same all the time:  ~35usec

We are also trying to optimize the jitter, below 35usec.
We tried the following:
1. use only idle mode (disable power states)
2. disable frequency save
3. isolating cpu.

Yet, we still get the same ~35usec, using all this trials.

Do you think it worth to try to use the latest rt kernel (4.9) ?
Currently we use kernel 4.4 (with ubuntu 16.04).

Best Regards,
Ran
