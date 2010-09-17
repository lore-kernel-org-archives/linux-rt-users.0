From: John Kacur <jkacur@redhat.com>
Subject: Re: "yum install ...." based instruction on building a RT kernel.
Date: Fri, 17 Sep 2010 15:10:06 +0200
Message-ID: <AANLkTikBynRZ470Cv2ot3sCCjHGLU+L6EZ2shyP3oeGe@mail.gmail.com>
References: <4C92A00C.6050401@atl.lmco.com>
	<AANLkTi=eaPvCZmecBKT_d0C8YunJr7L6M8A7Y9pEiQK_@mail.gmail.com>
	<AANLkTi=GbDU7fKh9LvCEpjhSSMFF0syCqJVuqUERVBEJ@mail.gmail.com>
	<4C936152.5000505@64studio.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: jordan <triplesquarednine@gmail.com>,
	Gautam Thaker <gautam.h.thaker@lmco.com>,
	linux-rt-users@vger.kernel.org
To: Daniel James <daniel@64studio.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-qy0-f181.google.com ([209.85.216.181]:35824 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753282Ab0IQNKH (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 17 Sep 2010 09:10:07 -0400
Received: by qyk33 with SMTP id 33so2433522qyk.19
        for <linux-rt-users@vger.kernel.org>; Fri, 17 Sep 2010 06:10:06 -0700 (PDT)
In-Reply-To: <4C936152.5000505@64studio.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Fri, Sep 17, 2010 at 2:38 PM, Daniel James <daniel@64studio.com> wrote:
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
>
> Being a release or two behind the bleeding edge is no bad thing for that
> type of user either - if (for instance) 2.6.31-rt works fine in a
> production audio system, there's no big hurry to change it and
> potentially break stuff. For that sort of user, high availability is
> much more important than squeezing every last drop of performance out of
> the hardware.
>
> In audio recording, we're potentially capturing once-in-a-lifetime or
> one-time-ever events, particularly since the industry focus has shifted
> from the studio to the live stage - whether TV, stadium or festival,
> that's where the artists are making their living these days. Even
> festivals run to tight schedules, with only 15 minutes allowed to switch
> between acts, including moving all the gear and repatching it. You can't
> ask the band to go and get a beer while you recompile your kernel :-)

Well, you've certainly slayed a straw man there. Just because I said it would
be good for people to compile their own kernels doesn't mean I meant
for them to do it on stage! Btw, I quite enjoy studio64, feel free to
update our rtwiki
with information about it.

Thanks.
