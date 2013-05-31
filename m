From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: 3.8.10-rt6 : Observing high latency as preempt_schedule_irq:__schedule
 is not getting called
Date: Fri, 31 May 2013 13:11:37 +0200
Message-ID: <51A88569.503@linutronix.de>
References: <AC83832D6324604BB08FAE5A33553F190B386F60@039-SN2MPN1-013.039d.mgd.msft.net> <AC83832D6324604BB08FAE5A33553F190B388AD8@039-SN2MPN1-013.039d.mgd.msft.net> <AC83832D6324604BB08FAE5A33553F190B3B0367@039-SN2MPN1-012.039d.mgd.msft.net> <AC83832D6324604BB08FAE5A33553F190B3B04F2@039-SN2MPN1-012.039d.mgd.msft.net> <AC83832D6324604BB08FAE5A33553F190B3B849B@039-SN2MPN1-012.039d.mgd.msft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	"tglx@linutronix.de" <tglx@linutronix.de>
To: Jain Priyanka-B32167 <B32167@freescale.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:37312 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753642Ab3EaLLk (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 31 May 2013 07:11:40 -0400
In-Reply-To: <AC83832D6324604BB08FAE5A33553F190B3B849B@039-SN2MPN1-012.039d.mgd.msft.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 05/28/2013 06:01 AM, Jain Priyanka-B32167 wrote:
> Submitted below patch to linuxppc-dev@lists.ozlabs.org to fix this issue

Thank you very much. The problem was introduced in v3.7-rc1 so it is a
v3.8-rt problem only.

Sebastian
