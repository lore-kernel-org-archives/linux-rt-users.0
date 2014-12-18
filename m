From: Rolf Wojtech <rolf.wojtech@fos4x.de>
Subject: Re: kernel BUG at /build/linux-rt/kernel/locking/rtmutex.c:997!
Date: Thu, 18 Dec 2014 13:35:38 +0000 (UTC)
Message-ID: <loom.20141218T143235-363@post.gmane.org>
References: <CADLDEKuPf3UNf-CB_xpmjcmQxQA_drFkXzBMQYUF_7K0dM7V3w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:35166 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752457AbaLRNkF (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 18 Dec 2014 08:40:05 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glru-linux-rt-users@m.gmane.org>)
	id 1Y1bJD-0005PD-Tz
	for linux-rt-users@vger.kernel.org; Thu, 18 Dec 2014 14:40:03 +0100
Received: from pd907f7af.dip0.t-ipconnect.de ([217.7.247.175])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-rt-users@vger.kernel.org>; Thu, 18 Dec 2014 14:40:03 +0100
Received: from rolf.wojtech by pd907f7af.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-rt-users@vger.kernel.org>; Thu, 18 Dec 2014 14:40:03 +0100
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Juerg Haefliger <juergh <at> gmail.com> writes:

> 
> Dear RT experts,
> 
> I have a simple test that runs two iperf clients in parallel with the
> ltp network tests and it triggers a deadlock within a few minutes.
> This is 100% repeatable. I've tried this on different RT kernels and
> determined that prior to the following commit (which went into 3.10
> upstream), the machine doesn't deadlock and seems to run just fine:
> 
> fb52f40e085ef4074f1335672cd62c1f832af13b rtmutex: Handle deadlock
> detection smarter
> 
[...]

Hi Juerg,
it seems like we share the same problem.
There is a proposed fix by Paul Gortmaker from October 2014 that I replied 
to here: http://permalink.gmane.org/gmane.linux.rt.user/12699
We will try to reproduce the problem quicker using your suggestion (2 iperf 
clients). Keep us posted if you get a reply from someone with more RT and 
mutex experience.




