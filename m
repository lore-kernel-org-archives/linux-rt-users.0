From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: your mail
Date: Wed, 16 Nov 2016 09:25:43 -0500
Message-ID: <20161116092543.663e1d2c@gandalf.local.home>
References: <alpine.DEB.2.20.1611151428190.28591@east.gentwo.org>
        <20161116104014.GQ3142@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Christoph Lameter <cl@linux.com>, Daniel Vacek <neelx.g@gmail.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Tommaso Cucinotta <tommaso.cucinotta@sssup.it>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtprelay0016.hostedemail.com ([216.40.44.16]:45996 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751277AbcKPOZr (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 16 Nov 2016 09:25:47 -0500
In-Reply-To: <20161116104014.GQ3142@twins.programming.kicks-ass.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Wed, 16 Nov 2016 11:40:14 +0100
Peter Zijlstra <peterz@infradead.org> wrote:


> On top of which, the implementation had issues; now I know you're the
> blinder kind of person that disregards everything not in his immediate
> interest, but if you'd looked at the patch you'd have seen he'd added
> code the idle entry path, which will slow down every single to-idle
> transition.

Isn't to-idle a bit bloated anyway? Or has that been fixed. I know
there was some issues with idle_balance() which can add latency to
wakeups. idle_balance() is also in the to-idle path.

Note, that this is a sched feature which would be a nop (jump_label)
when disabled. And I'm sure it could also be optimized to be a static
inline as well when it is enabled.

I'm not saying we need to go this approach, but I'm just saying that
the to-idle issue is a bit of a red herring.

-- Steve
