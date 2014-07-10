From: Juri Lelli <juri.lelli@gmail.com>
Subject: Re: set_schedattr + cpuset issue
Date: Thu, 10 Jul 2014 12:20:33 +0200
Message-ID: <20140710122033.58bdd366fe3f869a71b1c05e@gmail.com>
References: <CAMLzMweCcxPBJExGsY-2oHK6sdF6EVgBsa1XVxQT0=kzNRZAJQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org
To: Kevin Burns <kevinpb@vt.edu>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-we0-f171.google.com ([74.125.82.171]:34757 "EHLO
	mail-we0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751134AbaGJKUh (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 10 Jul 2014 06:20:37 -0400
Received: by mail-we0-f171.google.com with SMTP id q58so8843562wes.16
        for <linux-rt-users@vger.kernel.org>; Thu, 10 Jul 2014 03:20:36 -0700 (PDT)
In-Reply-To: <CAMLzMweCcxPBJExGsY-2oHK6sdF6EVgBsa1XVxQT0=kzNRZAJQ@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi Kevin,

On Wed, 2 Jul 2014 17:08:47 -0400
Kevin Burns <kevinpb@vt.edu> wrote:

> Hello Mr. Lelli,
> 
> I am a graduate student at Virginia Tech and am having an issue with
> sched_setattr.
> 
> The folks over at at #linux-rt on irc.oftc.net suggested I bring the issue
> to your attention.
> 

Sorry for the late reply, but I'm traveling in these days.

> Here's the issue:
> 
> I am able to allocate a bandwidth with a ratio of .1 to two processes using
> the sched_setattr() system call.
> 
> I then am able to add said tasks to a cpuset (with one physical processor)
> using cset.
> 
> However, when I then try to update the runtime or period of either task,
> sched_setattr returns a -EBUSY error.
> 
> Now, if I repeat the above experiment with just one task, I am able to
> update the runtime or period without issue. I ran trace-cmd and kernelshark
> to verify that the bandwidths were indeed being updated correctly. That and
> htop was reporting a higher percentage of CPUusage, which correlated to the
> ratios of my task's bandwidth.
> 
> Any ideas as to why cpuset would cause this behaviour?
> 

Could you create a script that I can use to run your setup and reproduce
the problem?

Thanks,

- Juri

> Thanks,
> -Kevin
