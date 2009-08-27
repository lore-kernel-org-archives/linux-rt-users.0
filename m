From: "Chris Friesen" <cfriesen@nortel.com>
Subject: Re: RFC: THE OFFLINE SCHEDULER
Date: Thu, 27 Aug 2009 17:51:52 -0600
Message-ID: <4A971C18.7050109@nortel.com>
References: <1251282598.3514.20.camel@raz>  <alpine.DEB.1.10.0908260943090.9924@gentwo.org>  <1251297910.1791.22.camel@maxim-laptop> <1251298443.4791.7.camel@raz>  <1251300625.18584.18.camel@twins>  <alpine.DEB.1.10.0908261136590.9933@gentwo.org>  <1251302598.18584.31.camel@twins>  <alpine.DEB.1.10.0908261211340.9933@gentwo.org>  <20090826180407.GA13632@elte.hu>  <alpine.DEB.1.10.0908261509580.9933@gentwo.org>  <20090826193252.GA14721@elte.hu>  <alpine.DEB.1.10.0908261627110.5554@gentwo.org>  <20090826135041.e6169d18.akpm@linux-foundation.org>  <4A95A5EE.90400@nortel.com> <1251322663.3882.48.camel@raz> <4A96B997.1070001@nortel.com> <alpine.DEB.1.10.0908271257270.17470@gentwo.org> <alpine.LFD.2.00.0908272242500.2888@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Christoph Lameter <cl@linux-foundation.org>,
	raz ben yehuda <raziebe@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>, mingo@elte.hu,
	peterz@infradead.org, maximlevitsky@gmail.com, efault@gmx.de,
	riel@redhat.com, wiseman@macs.biu.ac.il,
	linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from zrtps0kp.nortel.com ([47.140.192.56]:43990 "EHLO
	zrtps0kp.nortel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751323AbZH0XxF (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 27 Aug 2009 19:53:05 -0400
In-Reply-To: <alpine.LFD.2.00.0908272242500.2888@localhost.localdomain>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 08/27/2009 03:09 PM, Thomas Gleixner wrote:

> That's just the wrong approach. All you need is a way to tell the
> kernel that CPUx can switch off the scheduler tick when only one
> thread is running and that very thread is running in user space. Once
> another thread arrives on that CPU or the single thread enters the
> kernel for a blocking syscall the scheduler tick has to be
> restarted.

That's an elegant approach...I like it.

How would you deal with per-cpu kernel threads (softirqs, etc.) or
softirq processing while in the kernel?  Switching off the timer tick
isn't sufficient because the scheduler will be triggered on the way back
to userspace in a syscall.

Chris
