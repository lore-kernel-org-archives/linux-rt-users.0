From: Piotr Gregor <piotrgregor@rsyncme.org>
Subject: Re: Calculate average latencies on the fly
Date: Sat, 19 Nov 2016 23:27:24 +0000
Message-ID: <CAK+oA4UTKEazEFZ9+H6xWT7yNw50LNLe+e_DpfwKFvnwaYe1xQ@mail.gmail.com>
References: <CAK+oA4V8yFDnieAa4tsCQKTapNe6gA_VLJvvEh6_u_jgWpyahQ@mail.gmail.com>
 <CAK+oA4WFAaT4DmR=8nKqTsyKe9imDYCu5p6DG4kqbhoBPD=LXw@mail.gmail.com> <alpine.LFD.2.20.1611161525280.12617@riemann.fritz.box>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Clark Williams <williams@redhat.com>,
        Linux RT Users <linux-rt-users@vger.kernel.org>
To: John Kacur <jkacur@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-yw0-f175.google.com ([209.85.161.175]:34984 "EHLO
        mail-yw0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752971AbcKSX1Z (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Sat, 19 Nov 2016 18:27:25 -0500
Received: by mail-yw0-f175.google.com with SMTP id i145so188329051ywg.2
        for <linux-rt-users@vger.kernel.org>; Sat, 19 Nov 2016 15:27:25 -0800 (PST)
In-Reply-To: <alpine.LFD.2.20.1611161525280.12617@riemann.fritz.box>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi John, Clark,

Recently I observed jitter of > 100 000 during tests of virtualized system.
In that case 30 years would change into 0.3 year which is not as much.
The jitter depends on the hardware/software you test, what if someone
deliberately wishes to measure jitter of more than this or he is just
out of luck and gets huge values?
Also, the limit will change if the type of average changes, but if it
is calculated in the way I proposed, it will always work.
Apart from this, since the benign possibility exists - why not to fix this
if the fix is easy.

cheers,
Piotr
