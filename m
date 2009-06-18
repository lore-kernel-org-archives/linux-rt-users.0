From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: NOHZ: local_softirq_pending
Date: Thu, 18 Jun 2009 10:57:44 +0200 (CEST)
Message-ID: <alpine.LFD.2.00.0906181048500.2800@localhost.localdomain>
References: <4A35171C.9090800@albentia.com>  <8e6b7a710906141250m2a991ca9r5949e502b9976e39@mail.gmail.com>  <alpine.LFD.2.00.0906151501200.2800@localhost.localdomain>  <4A365CCF.2020707@albentia.com> <8e6b7a710906160101x6a8ae9d5qa7638627f513278@mail.gmail.com>
 <4A376450.5020209@albentia.com> <4A376559.5060604@albentia.com> <4A37B014.4040104@albentia.com> <4A37E6D1.5010207@albentia.com> <alpine.LFD.2.00.0906180001210.2800@localhost.localdomain> <4A396FB8.3020807@albentia.com> <alpine.LFD.2.00.0906180133220.2800@localhost.localdomain>
 <4A398B4F.6080702@albentia.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>,
	=?ISO-8859-15?Q?Noelia_Mor=F3n?= <nmoron@albentia.com>,
	"'Rodrigo Partearroyo'" <rpartearroyo@albentia.com>
To: Iratxo Pichel Ortiz <ipichel@albentia.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.tglx.de ([62.245.132.106]:46823 "EHLO www.tglx.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752618AbZFRI5s (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 18 Jun 2009 04:57:48 -0400
In-Reply-To: <4A398B4F.6080702@albentia.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Iratxo,

On Thu, 18 Jun 2009, Iratxo Pichel Ortiz wrote:
> Having read the three of them, regardless of the last process before the
> "NOHZ...", there is always a call to the FPE emulator. I am going to do some
> tests changing the FPE emulator, in case it helps.

No, what happens is that the -RT starvation protector kicks in. That's
a mechanism which checks whether the CPU is monopolized by rt tasks
for longer than 950ms. It then blocks execution of rt tasks for
50ms. The silly thing is that it goes idle, but that's a different
problem.

It's default on and can be disabled via:

echo 0 > /proc/sys/kernel/rt_runtime_us

Sorry that I did not notice that earlier, but when that triggers, then
something is really wrong. There should never be a situation where -rt
tasks (neither irq threads nor softirqs) should monopolize the CPU.

Thanks,

	tglx
