From: Vincent Legout <vincent@legout.info>
Subject: Re: set_schedattr + cpuset issue
Date: Tue, 02 Sep 2014 10:16:44 -0400
Message-ID: <87sika5cqb.fsf@cecht.legt.fr>
References: <CAMLzMweCcxPBJExGsY-2oHK6sdF6EVgBsa1XVxQT0=kzNRZAJQ@mail.gmail.com>
	<20140710122033.58bdd366fe3f869a71b1c05e@gmail.com>
	<871ts0s4pn.fsf@cecht.legt.fr>
	<CAE-h8tG6VCG0oX=AsPA-jKGqC=FheJD=4awByMukkUgD4uOUDg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Kevin Burns <kevinpb@vt.edu>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	juri.lelli@arm.com
To: Juri Lelli <juri.lelli@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from cethen.legt.fr ([92.243.2.98]:37476 "EHLO cethen.legt.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750963AbaIBOQr (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 2 Sep 2014 10:16:47 -0400
In-Reply-To: <CAE-h8tG6VCG0oX=AsPA-jKGqC=FheJD=4awByMukkUgD4uOUDg@mail.gmail.com>
	(Juri Lelli's message of "Tue, 2 Sep 2014 11:36:08 +0100")
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi,

Juri Lelli <juri.lelli@gmail.com> writes:

> thanks a lot for your report. I was also actually experiencing something that I
> think is related to your issue, but then I didn't find any time to send out
> a proper patch :/.
>
> Could you please test what I've attached and see if it fixes your problem?

Thanks for the patch, it fixes the second issue I mentioned in my
previous email, i.e. the one for which I posted a patch. For this issue,
FWIW:

 Tested-by: Vincent Legout <vincent@legout.info>
 Tested-by: Kevin Burns <kevinpb@vt.edu>

But it doesn't seem to fix the main issue related to cpusets and
SCHED_DEADLINE. It still fails if we don't come back to SCHED_OTHER
before moving the task to another cpuset. I think it's due to the fact
that SCHED_DEADLINE's data structures don't seem to be aware that a task
migrated, they are not updated during this process. Any idea where I
could have a look? Or if this is not supported, would it be possible to
add some checks such that total_bw doesn't overflow when calling
__dl_clear? If yes, I can try to provide a patch.

Thanks!
Vincent
