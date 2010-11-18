From: Darren Hart <dvhart@linux.intel.com>
Subject: Re: Soft lock issue with 2.6.33.7-rt29
Date: Wed, 17 Nov 2010 17:26:23 -0800
Message-ID: <4CE480BF.7050603@linux.intel.com>
References: <4CE428CB.20808@willowgarage.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org
To: Nathan Grennan <ngrennan@willowgarage.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:36662 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750823Ab0KRB0Y (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 17 Nov 2010 20:26:24 -0500
In-Reply-To: <4CE428CB.20808@willowgarage.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 11/17/2010 11:11 AM, Nathan Grennan wrote:
> I have been working for weeks to get a stable rt kernel. I had been
> focusing on 2.6.31.6-rt19. It is stable for about four days under stress
> testing before it soft locks. I am using rt19 instead of rt21, because
> rt19 seems to be more stable. The rtmutex issue that seems to still be
> in rt29 is in rt21. I also had to backport the iptables fix to rt19.
>
> I just started looking at 2.6.33.7-rt29 again, since I can reproduce a
> soft lock with it in 10-15 minutes. I have yet to get sysrq output for
> rt19, since it takes four days. The soft lock with rt29 as far as I can
> tell seems to relate to disk i/o.
>
> There are links to two logs of rt29 from a serial console below. They
> include sysrq output like "Show Blocked State" and "Show State". The
> level7 file is with nfsd enable, and level9 is with it disable. So nfsd
> doesn't seem to be the issue.
>
> If any other debugging information is useful or needed, just say the word.

A reproducible test-case is always the first thing we ask for :-) What 
is your stress test?

What policy and priority are you running your load at? Are you providing 
enough cycles for the system threads to run?

-- 
Darren Hart
Yocto Linux Kernel
