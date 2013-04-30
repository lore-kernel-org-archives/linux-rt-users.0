From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [ANNOUNCE] 3.4.41-rt55-feat3
Date: Tue, 30 Apr 2013 10:59:17 -0400
Message-ID: <1367333957.30667.61.camel@gandalf.local.home>
References: <1367283987.30667.49.camel@gandalf.local.home>
	 <2805818.g7STVSuEne@dabox>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: LKML <linux-kernel@vger.kernel.org>,
	RT <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>, John Kacur <jkacur@redhat.com>
To: Tim Sander <tim.sander@hbm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <2805818.g7STVSuEne@dabox>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Tue, 2013-04-30 at 11:14 +0200, Tim Sander wrote:
> Hi Steve and all RT Folks
> 
> > I'm pleased to announce the 3.4.41-rt55-feat3 feature release.
> > 
> > Note, I first uploaded -feat2 then realized I didn't add a compile fix by
> > Mike Galbraith, and then created the -feat3 with that fix.
> I just wanted to say thanks that this patch enables compilation again with the 
> preempt rt patchset with CONFIG_HIGH_RES_TIMERS disabled :-). 
> I think this patch* should be moved out of the feat patchset into the stable 
> rt backport branch as this also doesn't compile beginning with the 3.6.36-rt50 
> patch with CONFIG_HIGH_RES_TIMERS disabled .

As the discussion was originally in the -feat thread, I didn't realize
it was required for vanilla. Hmm, as it had nothing to do with softirqs
I should have realized that. Oh well.

Anyway, I'm working on getting the mainline stable releases merged into
the current stable-rt releases, and then I'll be looking at backports
from upstream -rt. I'll add it then.

-- Steve
