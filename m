From: "Luis Claudio R. Goncalves" <lclaudio@uudg.org>
Subject: Re: Soft lock issue with 2.6.33.7-rt29
Date: Thu, 18 Nov 2010 09:35:23 -0200
Message-ID: <20101118113523.GB11256@uudg.org>
References: <4CE428CB.20808@willowgarage.com>
 <4CE480BF.7050603@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nathan Grennan <ngrennan@willowgarage.com>,
	linux-rt-users@vger.kernel.org
To: Darren Hart <dvhart@linux.intel.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:55304 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753894Ab0KRLfd (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 18 Nov 2010 06:35:33 -0500
Received: by gxk23 with SMTP id 23so1745428gxk.19
        for <linux-rt-users@vger.kernel.org>; Thu, 18 Nov 2010 03:35:32 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4CE480BF.7050603@linux.intel.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Wed, Nov 17, 2010 at 05:26:23PM -0800, Darren Hart wrote:
| On 11/17/2010 11:11 AM, Nathan Grennan wrote:
| >I have been working for weeks to get a stable rt kernel. I had been
| >focusing on 2.6.31.6-rt19. It is stable for about four days under stress
| >testing before it soft locks. I am using rt19 instead of rt21, because
| >rt19 seems to be more stable. The rtmutex issue that seems to still be
| >in rt29 is in rt21. I also had to backport the iptables fix to rt19.
| >
| >I just started looking at 2.6.33.7-rt29 again, since I can reproduce a
| >soft lock with it in 10-15 minutes. I have yet to get sysrq output for
| >rt19, since it takes four days. The soft lock with rt29 as far as I can
| >tell seems to relate to disk i/o.
| >
| >There are links to two logs of rt29 from a serial console below. They
| >include sysrq output like "Show Blocked State" and "Show State". The
| >level7 file is with nfsd enable, and level9 is with it disable. So nfsd
| >doesn't seem to be the issue.
| >
| >If any other debugging information is useful or needed, just say the word.
| 
| A reproducible test-case is always the first thing we ask for :-)
| What is your stress test?
| 
| What policy and priority are you running your load at? Are you
| providing enough cycles for the system threads to run?

I noticed a e1000e warning on the first log. Those are usually harmful.

You may also want to boot your kernel with

	"ignore_loglevel debug initcall_debug"

appended to your kernel command line. The real issue or the important
warning may happen during the boot process.

Luis
-- 
[ Luis Claudio R. Goncalves                    Bass - Gospel - RT ]
[ Fingerprint: 4FDD B8C4 3C59 34BD 8BE9  2696 7203 D980 A448 C8F8 ]

