From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: Re: [PATCH RT 11/20] ARM: imx: always use TWD on IMX6Q
Date: Mon, 18 Jul 2016 20:18:59 +0300
Message-ID: <578D0F83.2010403@ti.com>
References: <20160712142405.634544943@goodmis.org>
 <20160712142419.367116752@goodmis.org> <20160712200429.GA4302@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	John Kacur <jkacur@redhat.com>,
	Paul Gortmaker <paul.gortmaker@windriver.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([198.47.19.12]:47099 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751451AbcGRST0 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 18 Jul 2016 14:19:26 -0400
In-Reply-To: <20160712200429.GA4302@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 07/12/2016 11:04 PM, Sebastian Andrzej Siewior wrote:
> * Steven Rostedt | 2016-07-12 10:24:16 [-0400]:
> 
>> 4.1.27-rt31-rc1 stable review patch.
>> If anyone has any objections, please let me know.
> 
> I don't recommend to cherry-pick this. The symbol it selects
> (HAVE_ARM_TWD) has "depends on SMP" in v4.1. In v4.4 there should be
> AM43xx which is UP and also uses the TWD so the change is simple here.
> 

yes. AM43xx is UP and supports ARM TWD, but there could be some 'issues' in !RT case :(

ARM TWD might be powered off in deep CPU Idle states and lose its context if !RT & CPUIDLE,
so there are should be backup broadcast timer configured. And that can cause build issues
related to tick_broadcast()->smp_cross_call().

I've solved it locally for OMAP2 only: commit 0b3e6fca4d1af4aa150d32506220f4241323a00c

^Just FYI. But may be it can be done in more generic way.

regards,
-grygorii
