From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH RT] fix migrating softirq [cause of network hang]
Date: Thu, 14 Jun 2007 10:20:06 -0400 (EDT)
Message-ID: <Pine.LNX.4.58.0706141017090.891@gandalf.stny.rr.com>
References: <fa4052ef0706131414o27b2281bp81d3f5b3d3104f87@mail.gmail.com>
 <Pine.LNX.4.58.0706131723430.20636@gandalf.stny.rr.com>
 <fa4052ef0706131520x619ff3f5ke23cf649b8ff2b79@mail.gmail.com>
 <Pine.LNX.4.58.0706131954220.20636@gandalf.stny.rr.com>
 <fa4052ef0706140710s547115d5o13f3dba018caaa78@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-rt-users@vger.kernel.org, mingo@elte.hu
To: Shane <gnome42@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:41270 "EHLO
	ms-smtp-03.nyroc.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751441AbXFNOUT (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 14 Jun 2007 10:20:19 -0400
In-Reply-To: <fa4052ef0706140710s547115d5o13f3dba018caaa78@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Thu, 14 Jun 2007, Shane wrote:

> On 6/13/07, Steven Rostedt <rostedt@goodmis.org> wrote:

> Yeah, I can't reproduce the problem at will, it takes from minutes to
> hours to happen. After a few hours of problem free operation with your
> patch I thought it was solved but then, the same problem. Applications
> accessing this nfs filesystem on this host will just hang and the df,
> lsof etc commands also started to  hang. Other nfs clients have no
> problem accessing that filesystem its only this host, which is the
> only core2 (smp) box in the mix so the description you gave with the
> patch sounded pretty good to me.

Before the patch was applied, was it easier (quicker) to trigger the bug?
I'm just thinking that my patch may have solved part of your problem, but
you are facing another. There's another bug we have that my patch seems to
help, but not fix the problem. Which means that there are two bugs at
play.


>
> I'm not even sure it's a kernel problem, although I just updated my
> nfs user space stuff and half of user space that came along with it
> and still no luck. I've been using this nfs mount for years but I just
> changed the nfs exports slightly. I mounted and exported two other
> file systems under the original export. I added the 'nohide' export
> option and to my amazement these filesystems appeared on the client
> having only mounted the original export. I thought I was lucky, I
> didn't have to mount all these other sub-filesystems.

When I get a chance, I'll start testing NFS on my boxes. But I'm a bit
buried in other issues at the moment, so it might be a while.

>
> I would summarize as:
> 2.6.21.4-rt13 core2, smp nfs client access hangs when using nohide export option
>
> So, smp and the more recent kernel seem to be suspect. Also cpufreq,
> which I just disabled.
>
> These UP clients have no problems accessing the same nfs export:
> celeronA -  2.6.21-rc5-rt11
> pII -  2.6.17-rc6-mm1
>

Could you also do sysrq-T when you see the hang. Could you post the dmesg
as well as the sysrq-T somewhere so I can take a look?

Thanks,

-- Steve
