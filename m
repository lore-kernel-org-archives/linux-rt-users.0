From: Ingo Molnar <mingo@elte.hu>
Subject: Re: v2.6.21.5-rt19 (sched_getaffinity?)
Date: Tue, 17 Jul 2007 21:32:23 +0200
Message-ID: <20070717193223.GJ26283@elte.hu>
References: <1183582155.3291.160.camel@chaos> <9609.194.65.103.1.1183731007.squirrel@www.rncbc.org> <1183758545.20747.34.camel@cmn3.stanford.edu> <20070707092401.GB21234@elte.hu> <1183934205.11854.11.camel@cmn3.stanford.edu> <46917678.70700@googlemail.com> <Pine.LNX.4.63.0707082047130.12404@cmn3.stanford.edu> <1183957703.12681.4.camel@cmn3.stanford.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Gabriel C <nix.or.die@googlemail.com>,
	Carsten Emde <carsten.emde@osadl.org>,
	"jcaceres@ccrma.Stanford.EDU" <jcaceres@ccrma.Stanford.EDU>,
	Steven Rostedt <rostedt@goodmis.org>,
	RT-Users <linux-rt-users@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Rui Nuno Capela <rncbc@rncbc.org>
To: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1764953AbXGQTdY@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1183957703.12681.4.camel@cmn3.stanford.edu>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


* Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU> wrote:

> I do get flash 9 (I know, not the best example) and tomboy to hang as 
> reported by one of my Planet CCRMA users - flash 9 tested working on 
> stock fedora 7 kernel - and both seem to hang in the same system call:
> 
> sched_getaffinity(3528, 32, <unfinished ...>
> 
> Full output of strace attached for both cases.

hm, that's weird. Is it completely unkillable at that time? Could you do 
a few things: enable CONFIG_PROVE_LOCKING (lockdep), and also try to get 
a full task state dump via:

  echo t > /proc/sysrq-trigger

thanks,

	Ingo
