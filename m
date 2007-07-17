From: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Subject: Re: v2.6.21.5-rt19 (sched_getaffinity?)
Date: Tue, 17 Jul 2007 12:47:48 -0700
Message-ID: <1184701668.21931.17.camel@cmn3.stanford.edu>
References: <1183582155.3291.160.camel@chaos>
	 <9609.194.65.103.1.1183731007.squirrel@www.rncbc.org>
	 <1183758545.20747.34.camel@cmn3.stanford.edu>
	 <20070707092401.GB21234@elte.hu>
	 <1183934205.11854.11.camel@cmn3.stanford.edu>
	 <46917678.70700@googlemail.com>
	 <Pine.LNX.4.63.0707082047130.12404@cmn3.stanford.edu>
	 <1183957703.12681.4.camel@cmn3.stanford.edu>
	 <20070717193223.GJ26283@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: nando@ccrma.Stanford.EDU, Gabriel C <nix.or.die@googlemail.com>,
	Carsten Emde <carsten.emde@osadl.org>,
	"jcaceres@ccrma.Stanford.EDU" <jcaceres@ccrma.Stanford.EDU>,
	Steven Rostedt <rostedt@goodmis.org>,
	RT-Users <linux-rt-users@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Rui Nuno Capela <rncbc@rncbc.org>
To: Ingo Molnar <mingo@elte.hu>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtp1.Stanford.EDU ([171.67.22.28]:59980 "EHLO
	smtp1.stanford.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760480AbXGQTrw (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 17 Jul 2007 15:47:52 -0400
In-Reply-To: <20070717193223.GJ26283@elte.hu>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Tue, 2007-07-17 at 21:32 +0200, Ingo Molnar wrote:
> * Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU> wrote:
> 
> > I do get flash 9 (I know, not the best example) and tomboy to hang as 
> > reported by one of my Planet CCRMA users - flash 9 tested working on 
> > stock fedora 7 kernel - and both seem to hang in the same system call:
> > 
> > sched_getaffinity(3528, 32, <unfinished ...>
> > 
> > Full output of strace attached for both cases.
> 
> hm, that's weird. Is it completely unkillable at that time? Could you do 
> a few things: enable CONFIG_PROVE_LOCKING (lockdep), and also try to get 
> a full task state dump via:
> 
>   echo t > /proc/sysrq-trigger
> 
> thanks,

kill -9 does nothing. If there's another way to kill something let me
know :-) I'll try to get the dump asap. 

Hope you had a good time over the long weekend, you certainly deserve
some rest (and congrats over the scheduler inclusing in mainline!)

-- Fernando
