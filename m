From: Marcelo Tosatti <mtosatti@redhat.com>
Subject: Re: [patch -rt 1/2] KVM: use simple waitqueue for vcpu->wq
Date: Thu, 26 Feb 2015 21:23:57 -0300
Message-ID: <20150227002357.GA11577@amt.cnet>
References: <20150114171251.882318257@redhat.com>
 <20150114171459.593877145@redhat.com>
 <20150116114846.4e7b718d@gandalf.local.home>
 <20150119144100.GA10794@amt.cnet>
 <20150120054653.GA6473@iris.ozlabs.ibm.com>
 <20150120131613.009903a0@gandalf.local.home>
 <20150121150716.GD11596@twins.programming.kicks-ass.net>
 <20150217174419.GY26177@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Peter Zijlstra <peterz@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Paul Mackerras <paulus@samba.org>,
	linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
	Luiz Capitulino <lcapitulino@redhat.com>,
	Rik van Riel <riel@redhat.com>,
	Steven Rostedt <srostedt@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>, kvm@vger.kernel.org,
	Paolo Bonzini <pbonzini@redhat.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150217174419.GY26177@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Tue, Feb 17, 2015 at 06:44:19PM +0100, Sebastian Andrzej Siewior wro=
te:
> * Peter Zijlstra | 2015-01-21 16:07:16 [+0100]:
>=20
> >On Tue, Jan 20, 2015 at 01:16:13PM -0500, Steven Rostedt wrote:
> >> I'm actually wondering if we should just nuke the _interruptible()
> >> version of swait. As it should only be all interruptible or all no=
t
> >> interruptible, that the swait_wake() should just do the wake up
> >> regardless. In which case, swait_wake() is good enough. No need to=
 have
> >> different versions where people may think do something special.
> >>=20
> >> Peter?
> >
> >Yeah, I think the lastest thing I have sitting here on my disk only =
has
> >the swake_up() which does TASK_NORMAL, no choice there.
>=20
> what is the swait status in terms of mainline? This sounds like it
> beeing worked on.
> I could take the series but then I would drop it again if the mainlin=
e
> implementation changes=E2=80=A6

Hi Sebastian,

No, you would just adjust it to the upstream kernel interfaces, as the =
rest of
the -rt users of the swait interfaces.

Can you please include the series?

Thanks
