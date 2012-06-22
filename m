From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH][RT] spinlock: Add include for BUG() in spinlock_rt.h
Date: Fri, 22 Jun 2012 06:49:01 -0400
Message-ID: <1340362141.27036.228.camel@gandalf.stny.rr.com>
References: <1340285878.27036.138.camel@gandalf.stny.rr.com>
	 <alpine.LFD.2.02.1206221108180.2853@ionos>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 7bit
Cc: LKML <linux-kernel@vger.kernel.org>,
	RT <linux-rt-users@vger.kernel.org>,
	leroy christophe <christophe.leroy@c-s.fr>,
	Iratxo Pichel Ortiz <ipichel@albentia.com>,
	David Garcia <dgarcia@albentia.com>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.LFD.2.02.1206221108180.2853@ionos>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Fri, 2012-06-22 at 11:08 +0200, Thomas Gleixner wrote:
> On Thu, 21 Jun 2012, Steven Rostedt wrote:
> 
> > spinlock_rt.h references BUG(), but it does not include bug.h, and on
> > some architectures (powerpc) this can cause a build failure.
> > 
> > Reported-by: Iratxo Pichel Ortiz <ipichel@albentia.com>
> > Reported-by: leroy christophe <christophe.leroy@c-s.fr>
> > Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
> > ----
> > [ Thomas, can you add this patch to your queue so that I can add it to
> > stable. Please, let me know when you have. Thanks! ]
> 
> Picked it up, thanks. Please take it right away w/o waiting for my
> release.
> 

I'll make a release today.

-- Steve
