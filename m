From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [ANNOUNCE] 3.14-rt1
Date: Fri, 2 May 2014 12:09:51 +0200
Message-ID: <20140502100951.GC9178@linutronix.de>
References: <20140411185739.GA6644@linutronix.de>
 <1397918766.5436.16.camel@marge.simpson.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>, rostedt@goodmis.org,
	John Kacur <jkacur@redhat.com>
To: Mike Galbraith <umgwanakikbuti@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1397918766.5436.16.camel@marge.simpson.net>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

* Mike Galbraith | 2014-04-19 16:46:06 [+0200]:

>Hi Sebastian,
Hi Mike,

>This hunk in hotplug-light-get-online-cpus.patch looks like a bug.
>
>@@ -333,7 +449,7 @@ static int __ref _cpu_down(unsigned int
>                /* CPU didn't die: tell everyone.  Can't complain. */
>                smpboot_unpark_threads(cpu);
>                cpu_notify_nofail(CPU_DOWN_FAILED | mod, hcpu);
>-               goto out_release;
>+               goto out_cancel;
>        }
>        BUG_ON(cpu_online(cpu));

Yes, it looks like it. v3.12-rt did not have this=E2=80=A6

Sebastian
