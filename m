From: jordan <triplesquarednine@gmail.com>
Subject: Re: "yum install ...." based instruction on building a RT kernel.
Date: Sat, 18 Sep 2010 15:24:18 -0400
Message-ID: <AANLkTint6iHc6DPeEVpKd0ER0XsYMDK=0yiekHGkWtWF@mail.gmail.com>
References: <4C92A00C.6050401@atl.lmco.com>
	<AANLkTi=eaPvCZmecBKT_d0C8YunJr7L6M8A7Y9pEiQK_@mail.gmail.com>
	<AANLkTi=GbDU7fKh9LvCEpjhSSMFF0syCqJVuqUERVBEJ@mail.gmail.com>
	<4C936152.5000505@64studio.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: John Kacur <jkacur@redhat.com>,
	Gautam Thaker <gautam.h.thaker@lmco.com>,
	linux-rt-users@vger.kernel.org
To: Daniel James <daniel@64studio.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-ew0-f46.google.com ([209.85.215.46]:53256 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756523Ab0IRTYT (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 18 Sep 2010 15:24:19 -0400
Received: by ewy23 with SMTP id 23so1301150ewy.19
        for <linux-rt-users@vger.kernel.org>; Sat, 18 Sep 2010 12:24:18 -0700 (PDT)
In-Reply-To: <4C936152.5000505@64studio.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Fri, Sep 17, 2010 at 8:38 AM, Daniel James <daniel@64studio.com> wrote:
> Hi John,
>
>> There is something called Planet CCRMA, which is a set of
>> repositories for audio packages that run on RedHat, Fedora and CentOS.
>> They also package the real-time kernel in rpm form.
>
> Ready-packaged RT kernels make sense for JACK users with generic PCs,
> who may not be all that interested in optimisation (at first). They just
> want to be able to install a program like Ardour and have it run
> glitch-free.

I generally agree with you Daniel, this rings true. But myself, i have
been able to improve latency and performance dramatically, by not
using pre-packaged rt-kernels.  Once users get more advanced in their
understanding, there are a number of things you can tune in the
kernel. (i know you already know this)...

> Being a release or two behind the bleeding edge is no bad thing for that
> type of user either - if (for instance) 2.6.31-rt works fine in a
> production audio system, there's no big hurry to change it and
> potentially break stuff. For that sort of user, high availability is
> much more important than squeezing every last drop of performance out of
> the hardware.

true enough. 2.6.32 and 2.6.33 are much nicer though...

> In audio recording, we're potentially capturing once-in-a-lifetime or
> one-time-ever events, particularly since the industry focus has shifted
> from the studio to the live stage - whether TV, stadium or festival,
> that's where the artists are making their living these days. Even
> festivals run to tight schedules, with only 15 minutes allowed to switch
> between acts, including moving all the gear and repatching it. You can't
> ask the band to go and get a beer while you recompile your kernel :-)

Ideally, no one would ever be compiling the kernel at a show, lol. I
know I never would! lol....that's hilarious.
You do that stuff on your own time!  Artists have always made their
money live, and through merchandise. Record sales go into the Label's
pockets for the most part.

jordan
