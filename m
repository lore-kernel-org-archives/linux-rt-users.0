From: John Kacur <jkacur@redhat.com>
Subject: Re: Calculate average latencies on the fly
Date: Mon, 21 Nov 2016 19:32:41 +0100 (CET)
Message-ID: <alpine.LFD.2.20.1611211928160.8986@riemann>
References: <CAK+oA4V8yFDnieAa4tsCQKTapNe6gA_VLJvvEh6_u_jgWpyahQ@mail.gmail.com> <CAK+oA4WFAaT4DmR=8nKqTsyKe9imDYCu5p6DG4kqbhoBPD=LXw@mail.gmail.com> <alpine.LFD.2.20.1611161525280.12617@riemann.fritz.box>
 <CAK+oA4UTKEazEFZ9+H6xWT7yNw50LNLe+e_DpfwKFvnwaYe1xQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Clark Williams <williams@redhat.com>,
        Linux RT Users <linux-rt-users@vger.kernel.org>
To: Piotr Gregor <piotrgregor@rsyncme.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wm0-f45.google.com ([74.125.82.45]:35390 "EHLO
        mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754009AbcKUScw (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 21 Nov 2016 13:32:52 -0500
Received: by mail-wm0-f45.google.com with SMTP id a197so162962307wmd.0
        for <linux-rt-users@vger.kernel.org>; Mon, 21 Nov 2016 10:32:51 -0800 (PST)
In-Reply-To: <CAK+oA4UTKEazEFZ9+H6xWT7yNw50LNLe+e_DpfwKFvnwaYe1xQ@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>



On Sat, 19 Nov 2016, Piotr Gregor wrote:

> Hi John, Clark,
> 
> Recently I observed jitter of > 100 000 during tests of virtualized system.
> In that case 30 years would change into 0.3 year which is not as much.
> The jitter depends on the hardware/software you test, what if someone
> deliberately wishes to measure jitter of more than this or he is just
> out of luck and gets huge values?
> Also, the limit will change if the type of average changes, but if it
> is calculated in the way I proposed, it will always work.
> Apart from this, since the benign possibility exists - why not to fix this
> if the fix is easy.
> 

I already explained why. Everytime you do a floating point long division 
you are potentially accumulating small errors. Something is terribly 
wrong if you are getting a diff of greater than 100,000, if that really 
is true you need to fix it right away instead of run cyclictest for a 
long period of time.

John> 
