From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: your mail
Date: Wed, 16 Nov 2016 11:40:14 +0100
Message-ID: <20161116104014.GQ3142@twins.programming.kicks-ass.net>
References: <alpine.DEB.2.20.1611151428190.28591@east.gentwo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Daniel Vacek <neelx.g@gmail.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Tommaso Cucinotta <tommaso.cucinotta@sssup.it>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
To: Christoph Lameter <cl@linux.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1611151428190.28591@east.gentwo.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Tue, Nov 15, 2016 at 02:29:16PM -0600, Christoph Lameter wrote:
> 
> > > There is a deadlock, Peter!!!
> >
> > Describe please? Also, have you tried disabling RT_RUNTIME_SHARE ?
> >
> 
> 
> The description was given earlier in the the thread and the drawbacks of
> using RT_RUNTIME_SHARE as well.

I've not seen a deadlock described. It either was an unbounded priority
inversion or a starvation issue, both of which are 'design' features of
the !rt kernel.

Neither things are new, so its not a regression either.

And, as stated, I'm not really happy to muck with this known troublesome
code and add features for which we must then maintain feature parity
when replacing it either.

On top of which, the implementation had issues; now I know you're the
blinder kind of person that disregards everything not in his immediate
interest, but if you'd looked at the patch you'd have seen he'd added
code the idle entry path, which will slow down every single to-idle
transition.
