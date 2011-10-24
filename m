From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [RFC] [PATCH -rt 5/5] cpufreq: get rid of
 get_online_cpus()/put_online_cpus()
Date: Mon, 24 Oct 2011 13:45:16 +0200 (CEST)
Message-ID: <alpine.LFD.2.02.1110241343130.2633@ionos>
References: <1318762607-2261-1-git-send-email-yong.zhang0@gmail.com> <1318762607-2261-6-git-send-email-yong.zhang0@gmail.com> <alpine.LFD.2.02.1110191110140.3240@ionos> <20111024024416.GB24581@zhy> <alpine.LFD.2.02.1110241123190.2642@ionos>
 <20111024113056.GA2635@zhy>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
To: Yong Zhang <yong.zhang0@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:57708 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755436Ab1JXLpU (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 24 Oct 2011 07:45:20 -0400
In-Reply-To: <20111024113056.GA2635@zhy>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Mon, 24 Oct 2011, Yong Zhang wrote:
> On Mon, Oct 24, 2011 at 11:24:51AM +0200, Thomas Gleixner wrote:
> > > No sure whether it's big issue or not.
> > > Mind showing more about your concern?
> > 
> > This is probably not the only place which will run into that issue and
> > I have not much interest to patch all those sites.
> 
> If so, I think that kind of violation has been caught in mainline,
> because mainline has had CPU_DOWN_PREPARE called under
> cpu_hotplug.lock, right?
> 
> Or am I missing something?

Hmm, no. I obviously forgot that I moved it in RT :(

So yes, it should be safe. Though the question is why cpufreq does not
suffer from that that problem in mainline. I'll stare at that code
some more.

Thanks,

	tglx
