From: Mike Galbraith <umgwanakikbuti@gmail.com>
Subject: Re: [ANNOUNCE] 3.14-rt1
Date: Fri, 02 May 2014 13:16:51 +0200
Message-ID: <1399029411.5233.133.camel@marge.simpson.net>
References: <20140411185739.GA6644@linutronix.de>
	 <1397918766.5436.16.camel@marge.simpson.net>
	 <20140502100951.GC9178@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>, rostedt@goodmis.org,
	John Kacur <jkacur@redhat.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140502100951.GC9178@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Fri, 2014-05-02 at 12:09 +0200, Sebastian Andrzej Siewior wrote:=20
> * Mike Galbraith | 2014-04-19 16:46:06 [+0200]:
>=20
> >Hi Sebastian,
> Hi Mike,
>=20
> >This hunk in hotplug-light-get-online-cpus.patch looks like a bug.
> >
> >@@ -333,7 +449,7 @@ static int __ref _cpu_down(unsigned int
> >                /* CPU didn't die: tell everyone.  Can't complain. *=
/
> >                smpboot_unpark_threads(cpu);
> >                cpu_notify_nofail(CPU_DOWN_FAILED | mod, hcpu);
> >-               goto out_release;
> >+               goto out_cancel;
> >        }
> >        BUG_ON(cpu_online(cpu));
>=20
> Yes, it looks like it. v3.12-rt did not have this=E2=80=A6

I just sent a set of dinky patches with which patch to fold them into,
along with my way of dealing with the new stopper_lock.

-Mike
