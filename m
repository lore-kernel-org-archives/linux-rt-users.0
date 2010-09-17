From: Bernardo Barros <bernardobarros2@gmail.com>
Subject: Re: "yum install ...." based instruction on building a RT kernel.
Date: Fri, 17 Sep 2010 10:06:26 -0300
Message-ID: <AANLkTikst6kRs5O=qdcq+ridrE9cFsge75g_vZRuNNmB@mail.gmail.com>
References: <4C92A00C.6050401@atl.lmco.com>
	<AANLkTi=eaPvCZmecBKT_d0C8YunJr7L6M8A7Y9pEiQK_@mail.gmail.com>
	<AANLkTi=GbDU7fKh9LvCEpjhSSMFF0syCqJVuqUERVBEJ@mail.gmail.com>
	<4C936152.5000505@64studio.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: John Kacur <jkacur@redhat.com>,
	jordan <triplesquarednine@gmail.com>,
	Gautam Thaker <gautam.h.thaker@lmco.com>,
	linux-rt-users@vger.kernel.org
To: Daniel James <daniel@64studio.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:36123 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753964Ab0IQNG2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 17 Sep 2010 09:06:28 -0400
Received: by pzk34 with SMTP id 34so576717pzk.19
        for <linux-rt-users@vger.kernel.org>; Fri, 17 Sep 2010 06:06:27 -0700 (PDT)
In-Reply-To: <4C936152.5000505@64studio.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Maybe this helps:
http://fedoraproject.org/wiki/Docs/CustomKernel

2010/9/17 Daniel James <daniel@64studio.com>:
> Hi John,
>
>> There is something called Planet CCRMA, which is a set of
>> repositories for audio packages that run on RedHat, Fedora and CentO=
S.
>> They also package the real-time kernel in rpm form.
>
> Ready-packaged RT kernels make sense for JACK users with generic PCs,
> who may not be all that interested in optimisation (at first). They j=
ust
> want to be able to install a program like Ardour and have it run
> glitch-free.
>
> Being a release or two behind the bleeding edge is no bad thing for t=
hat
> type of user either - if (for instance) 2.6.31-rt works fine in a
> production audio system, there's no big hurry to change it and
> potentially break stuff. For that sort of user, high availability is
> much more important than squeezing every last drop of performance out=
 of
> the hardware.
>
> In audio recording, we're potentially capturing once-in-a-lifetime or
> one-time-ever events, particularly since the industry focus has shift=
ed
> from the studio to the live stage - whether TV, stadium or festival,
> that's where the artists are making their living these days. Even
> festivals run to tight schedules, with only 15 minutes allowed to swi=
tch
> between acts, including moving all the gear and repatching it. You ca=
n't
> ask the band to go and get a beer while you recompile your kernel :-)
>
> Cheers!
>
> Daniel
> --
> To unsubscribe from this list: send the line "unsubscribe linux-rt-us=
ers" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml
>
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
