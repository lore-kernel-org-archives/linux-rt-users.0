From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: ???
Date: Tue, 15 Nov 2016 16:58:36 -0500
Message-ID: <20161115165836.2202a9a6@gandalf.local.home>
References: <alpine.DEB.2.20.1611151428190.28591@east.gentwo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Peter Zijlstra <peterz@infradead.org>,
        Daniel Vacek <neelx.g@gmail.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Tommaso Cucinotta <tommaso.cucinotta@sssup.it>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>
To: Christoph Lameter <cl@linux.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.DEB.2.20.1611151428190.28591@east.gentwo.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


What's with people sending out replies without subjects?

On Tue, 15 Nov 2016 14:29:16 -0600 (CST)
Christoph Lameter <cl@linux.com> wrote:

> > > There is a deadlock, Peter!!!  
> >
> > Describe please? Also, have you tried disabling RT_RUNTIME_SHARE ?
> >  
> 
> 
> The description was given earlier in the the thread and the drawbacks of
> using RT_RUNTIME_SHARE as well.

Peter is saying to disable that, because of the drawbacks. I think the
question is, do you still have a deadlock after disabling it? If not,
then that's your solution.

-- Steve
