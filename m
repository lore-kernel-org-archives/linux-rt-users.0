From: Daniel Wagner <wagi@monom.org>
Subject: Re: set_schedattr + cpuset issue
Date: Wed, 03 Sep 2014 12:00:32 +0200
Message-ID: <5406E6C0.1060606@monom.org>
References: <CAMLzMweCcxPBJExGsY-2oHK6sdF6EVgBsa1XVxQT0=kzNRZAJQ@mail.gmail.com>	<20140710122033.58bdd366fe3f869a71b1c05e@gmail.com>	<871ts0s4pn.fsf@cecht.legt.fr>	<CAE-h8tG6VCG0oX=AsPA-jKGqC=FheJD=4awByMukkUgD4uOUDg@mail.gmail.com> <87sika5cqb.fsf@cecht.legt.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Kevin Burns <kevinpb@vt.edu>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	juri.lelli@arm.com
To: Vincent Legout <vincent@legout.info>,
	Juri Lelli <juri.lelli@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-we0-f172.google.com ([74.125.82.172]:64444 "EHLO
	mail-we0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754979AbaICKAi (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 3 Sep 2014 06:00:38 -0400
Received: by mail-we0-f172.google.com with SMTP id q59so8284609wes.17
        for <linux-rt-users@vger.kernel.org>; Wed, 03 Sep 2014 03:00:36 -0700 (PDT)
In-Reply-To: <87sika5cqb.fsf@cecht.legt.fr>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


On 09/02/2014 04:16 PM, Vincent Legout wrote:
> Hi,
> 
> Juri Lelli <juri.lelli@gmail.com> writes:
> 
>> thanks a lot for your report. I was also actually experiencing something that I
>> think is related to your issue, but then I didn't find any time to send out
>> a proper patch :/.
>>
>> Could you please test what I've attached and see if it fixes your problem?
> 
> Thanks for the patch, it fixes the second issue I mentioned in my
> previous email, i.e. the one for which I posted a patch. For this issue,
> FWIW:
> 
>  Tested-by: Vincent Legout <vincent@legout.info>
>  Tested-by: Kevin Burns <kevinpb@vt.edu>
> 
> But it doesn't seem to fix the main issue related to cpusets and
> SCHED_DEADLINE. It still fails if we don't come back to SCHED_OTHER
> before moving the task to another cpuset. I think it's due to the fact
> that SCHED_DEADLINE's data structures don't seem to be aware that a task
> migrated, they are not updated during this process. Any idea where I
> could have a look? Or if this is not supported, would it be possible to
> add some checks such that total_bw doesn't overflow when calling
> __dl_clear? If yes, I can try to provide a patch.

I just saw this thread after sending a patch for this problem. It's not
yet in the archive, though it is called:

"[PATCH] sched: Reset bandwith on task when switching from
SCHED_DEADLINE away"

And obviously, I forgot to cc Juri. Sorry about that.

cheers,
daniel
