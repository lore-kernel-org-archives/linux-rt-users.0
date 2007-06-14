From: Shane <gnome42@gmail.com>
Subject: Re: [PATCH RT] fix migrating softirq [cause of network hang]
Date: Thu, 14 Jun 2007 10:10:40 -0400
Message-ID: <fa4052ef0706140710s547115d5o13f3dba018caaa78@mail.gmail.com>
References: <fa4052ef0706131414o27b2281bp81d3f5b3d3104f87@mail.gmail.com>
	 <Pine.LNX.4.58.0706131723430.20636@gandalf.stny.rr.com>
	 <fa4052ef0706131520x619ff3f5ke23cf649b8ff2b79@mail.gmail.com>
	 <Pine.LNX.4.58.0706131954220.20636@gandalf.stny.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org, mingo@elte.hu
To: "Steven Rostedt" <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.180]:51071 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751162AbXFNOKk (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 14 Jun 2007 10:10:40 -0400
Received: by wa-out-1112.google.com with SMTP id v27so688931wah
        for <linux-rt-users@vger.kernel.org>; Thu, 14 Jun 2007 07:10:40 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.58.0706131954220.20636@gandalf.stny.rr.com>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On 6/13/07, Steven Rostedt <rostedt@goodmis.org> wrote:
> > Heh, I spoke too soon. This patch doesn't seem to help my problem after all. :/
> >
>
> Really?  Darn.
>
> So it seemed to work? Just curious to why you thought it worked and but it
> didn't?

Yeah, I can't reproduce the problem at will, it takes from minutes to
hours to happen. After a few hours of problem free operation with your
patch I thought it was solved but then, the same problem. Applications
accessing this nfs filesystem on this host will just hang and the df,
lsof etc commands also started to  hang. Other nfs clients have no
problem accessing that filesystem its only this host, which is the
only core2 (smp) box in the mix so the description you gave with the
patch sounded pretty good to me.

I'm not even sure it's a kernel problem, although I just updated my
nfs user space stuff and half of user space that came along with it
and still no luck. I've been using this nfs mount for years but I just
changed the nfs exports slightly. I mounted and exported two other
file systems under the original export. I added the 'nohide' export
option and to my amazement these filesystems appeared on the client
having only mounted the original export. I thought I was lucky, I
didn't have to mount all these other sub-filesystems.

I would summarize as:
2.6.21.4-rt13 core2, smp nfs client access hangs when using nohide export option

So, smp and the more recent kernel seem to be suspect. Also cpufreq,
which I just disabled.

These UP clients have no problems accessing the same nfs export:
celeronA -  2.6.21-rc5-rt11
pII -  2.6.17-rc6-mm1

I'll let you know if I am able to pin it down.

Shane
