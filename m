From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: your mail
Date: Wed, 16 Nov 2016 15:28:21 +0100
Message-ID: <20161116142821.GZ3117@twins.programming.kicks-ass.net>
References: <alpine.DEB.2.20.1611151428190.28591@east.gentwo.org>
 <20161116104014.GQ3142@twins.programming.kicks-ass.net>
 <20161116092543.663e1d2c@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Christoph Lameter <cl@linux.com>, Daniel Vacek <neelx.g@gmail.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Tommaso Cucinotta <tommaso.cucinotta@sssup.it>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20161116092543.663e1d2c@gandalf.local.home>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Wed, Nov 16, 2016 at 09:25:43AM -0500, Steven Rostedt wrote:
> On Wed, 16 Nov 2016 11:40:14 +0100
> Peter Zijlstra <peterz@infradead.org> wrote:
> 
> 
> > On top of which, the implementation had issues; now I know you're the
> > blinder kind of person that disregards everything not in his immediate
> > interest, but if you'd looked at the patch you'd have seen he'd added
> > code the idle entry path, which will slow down every single to-idle
> > transition.
> 
> Isn't to-idle a bit bloated anyway? Or has that been fixed. I know
> there was some issues with idle_balance() which can add latency to
> wakeups. idle_balance() is also in the to-idle path.
> 

Yes it is too heavy as is, but just stacking more crap in just because
its already expensive seems to wrong way around.
