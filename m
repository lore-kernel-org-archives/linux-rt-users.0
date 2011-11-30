From: Mike Galbraith <efault@gmx.de>
Subject: Re: [PATCH RT] tasklet/rt: Prevent tasklets from going into
 infinite spin in RT
Date: Wed, 30 Nov 2011 08:34:01 +0100
Message-ID: <1322638441.5677.25.camel@marge.simson.net>
References: <1322618120.17003.104.camel@frodo>
	 <1322627551.17283.11.camel@marge.simson.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: LKML <linux-kernel@vger.kernel.org>,
	RT <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@elte.hu>,
	"Luis Claudio R. Goncalves" <lclaudio@uudg.org>,
	Clark Williams <williams@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1322627551.17283.11.camel@marge.simson.net>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Wed, 2011-11-30 at 05:32 +0100, Mike Galbraith wrote:
> On Tue, 2011-11-29 at 20:55 -0500, Steven Rostedt wrote:

> > I booted this patch against 3.0-rt stable, and it didn't crash ;)
> > Could you apply it and see if it fixes the hang that you've been seeing.
> 
> I'll most certainly be testing it too.

Tested-by: Mike Galbraith <efault@gmx.de>

The other me tested it too.  Coincidentally, he was having the same darn
problem with a fat enterprise config (on the same x3550 M3 too).

Tested-by: Mike Galbraith <mgalbraith@suse.de>

Thanks, I can now turn x3550 (by Pratt & Whitney) off for a bit.

	-Mike
