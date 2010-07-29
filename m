From: Mike Galbraith <efault@gmx.de>
Subject: Re: Q6600 + low frequency periodic timer + CPU_IDLE = much jitter
Date: Thu, 29 Jul 2010 13:21:34 +0200
Message-ID: <1280402494.9599.53.camel@marge.simson.net>
References: <1280394320.9599.48.camel@marge.simson.net>
	 <4C515958.60301@osadl.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: RT <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Len Brown <lenb@kernel.org>
To: Carsten Emde <Carsten.Emde@osadl.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mailout-de.gmx.net ([213.165.64.22]:46807 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S1753453Ab0G2LVY (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 29 Jul 2010 07:21:24 -0400
In-Reply-To: <4C515958.60301@osadl.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Thu, 2010-07-29 at 12:35 +0200, Carsten Emde wrote:
> Mike,
> 
> > It's looking like my Q6600 is kinda slow at switching gears, and I'd
> > just like to verify that it is the hardware, not something odd going on
> > in cpuidle territory.
> Yes, it's the CPU. It is a known restriction of this processor and has
> been verified on a number of different systems. It appears that the
> processor is halted while the PLL is stabilizing. However, there is no
> formal confirmation from Intel AFAIK.

Thanks for the confirmation.

	-Mike

