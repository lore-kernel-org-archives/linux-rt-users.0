From: Mark Knecht <markknecht@gmail.com>
Subject: Re: future of -rt kernels for realtime audio
Date: Tue, 6 Jul 2010 08:45:14 -0700
Message-ID: <AANLkTinznqiQuo3g30kFuEViJwc3bnd4P3Xoar4TJw6y@mail.gmail.com>
References: <AANLkTikZNjYJnDM6iKgrT1230FP8DSMgHUrZz2lYL4ll@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: linux-rt-users@vger.kernel.org
To: Pedro Ribeiro <pedrib@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:47664 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752287Ab0GFPpP (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 6 Jul 2010 11:45:15 -0400
Received: by pzk26 with SMTP id 26so914110pzk.19
        for <linux-rt-users@vger.kernel.org>; Tue, 06 Jul 2010 08:45:14 -0700 (PDT)
In-Reply-To: <AANLkTikZNjYJnDM6iKgrT1230FP8DSMgHUrZz2lYL4ll@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Tue, Jul 6, 2010 at 4:19 AM, Pedro Ribeiro <pedrib@gmail.com> wrote:
> Hi,
>
> I've been using -rt kernels since 2.6.29 because I do realtime audio
> on my laptop.
>
> The audio stability has been steadily improving since, and now I find
> that I can use 2.6.34 without the -rt patch and achieve the same
> stability as 2.6.33-rt - well, my latency requirements aren't that
> high, I just need to maintain 8.9ms completely stable, however before
> .34 it would be impossible without the -rt patch.
>
> So out of curiosity, what changed for .34? According to [1], on .33
> Raw Spinlock Annotation was introduced in the mainline kernel.
> However, as said above, I can't get the same performance than with
> .34.
>
> I remember that I read somewhere that the one the biggest problems
> with latency requirements was the use of the BKL. Do you think there
> will be a significant improvement of latency (in specific cases of
> course) with the scheduled removal of BKL for 2.6.36?
>
> Thanks for the help,
> Pedro
>
> [1] http://www.osadl.org/Realtime-Linux.projects-realtime-linux.0.html

With my HDSP 9652 and a good quality desktop machine I've been able to
achieve <2mS latency for over a couple of years with the standard
kernel, but only under controlled setups. If I'm just doing audio and
I run nothing else, doing my best to ensure the machine won't jump
into some cron job that uses a lot of disk access, etc., then the main
line kernel works fine and has for me for quite a long time.

In my experience the value of rt-sources is that I don't have to be as
careful. I can open a broswer, do a little email, etc., or even build
some code and still not get xruns. I cannot do that today with the
main line kernel.

So, I think it's not that the basic Linux kernel cannot do the job
because it can. I suggest it's more about how much extra protection do
you want or need? If you've got a machine that's fully dedicated to
audio then possibly you could get away with it. If you are using this
machine for additional tasks then being able to control real-time
priorities will like win out every time.

Cheers,
Mark
