From: Carsten Emde <C.Emde@osadl.org>
Subject: Re: Preferred way for rt-linux using git
Date: Fri, 08 Apr 2011 21:16:31 +0200
Message-ID: <4D9F5F0F.1010600@osadl.org>
References: <BANLkTi=3s8bZLibMZX7y6_NGhHivErwS_Q@mail.gmail.com> <BANLkTikP3ZEndzdOxA8aX29125h9MXG6xQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: dashesy <dashesy@gmail.com>, linux-rt-users@vger.kernel.org
To: John Kacur <jkacur@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from toro.web-alm.net ([62.245.132.31]:55518 "EHLO toro.web-alm.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757676Ab1DHTVR (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 8 Apr 2011 15:21:17 -0400
In-Reply-To: <BANLkTikP3ZEndzdOxA8aX29125h9MXG6xQ@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 04/08/2011 06:41 PM, John Kacur wrote:
> On Fri, Apr 8, 2011 at 5:51 PM, dashesy<dashesy@gmail.com>  wrote:
>> I am new to rt-linux, what is the preferred way of getting the source
>> and applying the patch using git?
>> Should I do:
>> "git clone git://git.kernel.org/pub/scm/linux/kernel/git/tip/linux-2.6-tip.git
>> rt/2.6.33"
>> or maybe I should start from the long-term 2.6.33 version?
>> "git clone git://git.kernel.org/pub/scm/linux/kernel/git/longterm/linux-2.6.33.y.git
>> linux-2.6.33"
>> then apply the newest patch?
>> Thanks for the great work BTW
> For -rt you want to clone the one in tip. tglx pulls from stable and
> merges it into -rt himself.
> The latest tag is 2.6.33.9-rt31
> If you have any problems with it, we're always interesting in hearing
> about them.
That's correct. The more testers we have, the earlier the RT version 
under development will become stable. However, there is no guarantee, 
and sometimes - for example now - tip may even contain unreleased 
material that runs just for a couple of days on a limited number of 
machines.

Alternatively, if you do not have the time to test software under 
development and you would like to use it for production purposes, you 
may want to use the "Latest Stable" PREEMPT_RT release. This "Latest 
Stable" version underwent heavy testing on a number of different 
machines, and latency plots and long-term latency recording results are 
available in all cases. The "Latest Stable" version is announced here -> 
osadl.org/Latest-Stable, the related QA data are available here -> 
osadl.org/QA.

Hope this helps,
Carsten.
