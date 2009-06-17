From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: NOHZ: local_softirq_pending
Date: Thu, 18 Jun 2009 00:03:32 +0200 (CEST)
Message-ID: <alpine.LFD.2.00.0906180001210.2800@localhost.localdomain>
References: <4A35171C.9090800@albentia.com>  <8e6b7a710906141250m2a991ca9r5949e502b9976e39@mail.gmail.com>  <alpine.LFD.2.00.0906151501200.2800@localhost.localdomain>  <4A365CCF.2020707@albentia.com> <8e6b7a710906160101x6a8ae9d5qa7638627f513278@mail.gmail.com>
 <4A376450.5020209@albentia.com> <4A376559.5060604@albentia.com> <4A37B014.4040104@albentia.com> <4A37E6D1.5010207@albentia.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>,
	=?ISO-8859-15?Q?Noelia_Mor=F3n?= <nmoron@albentia.com>,
	"'Rodrigo Partearroyo'" <rpartearroyo@albentia.com>
To: Iratxo Pichel Ortiz <ipichel@albentia.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.tglx.de ([62.245.132.106]:41156 "EHLO www.tglx.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753491AbZFQWDh (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 17 Jun 2009 18:03:37 -0400
In-Reply-To: <4A37E6D1.5010207@albentia.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Tue, 16 Jun 2009, Iratxo Pichel Ortiz wrote:
> I have tried disabling the CONFIG_NOHZ kernel option. Of course the trace is
> gone, but the weird behavior is still there. When I run my software without
> load from the network, the main task of the system experiences runtimes of
> about 700us. When I load the system, there are latencies of 50700us, so the
> 50ms delay is again there, and again the time when the task finishes is always
> X.296, 1 jiffy after the "NOHZ: pending..." was shown with CONFIG_NOHZ
> enabled.

What kind of system is this ? 

Can you please check whether you can reproduce with NOHZ=y and function
tracer enabled ?

That would be great.

Thanks,

	tglx
