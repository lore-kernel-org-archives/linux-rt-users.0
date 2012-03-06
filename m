From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [ANNOUNCE] 3.2.9-rt15
Date: Tue, 6 Mar 2012 09:20:29 +0100 (CET)
Message-ID: <alpine.LFD.2.02.1203060919170.2742@ionos>
References: <alpine.LFD.2.02.1203021743040.2742@ionos> <1330985640.25686.342.camel@gandalf.stny.rr.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Clark Williams <clark@redhat.com>,
	"Luis Claudio R. Goncalves" <lclaudio@uudg.org>,
	Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:56737 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755353Ab2CFIUd (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 6 Mar 2012 03:20:33 -0500
In-Reply-To: <1330985640.25686.342.camel@gandalf.stny.rr.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Mon, 5 Mar 2012, Steven Rostedt wrote:

> Thomas,
> 
> Please fold this change into
> 
>    cpu-rt-make-hotplug-lock-a-sleeping-spinlock-on-rt.patch
> 
> 
> As the patch was never tested (nor even compiled) it introduced a nasty
> bug into taking a CPU down instead of fixing one.

Grr. I noticed that and fricking forgot to fix it :(

Thanks,

	tglx
