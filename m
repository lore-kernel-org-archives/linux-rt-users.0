From: Rolando Martins <rolando.martins@gmail.com>
Subject: Re: [ANNOUNCE] 3.0.4-rt13
Date: Sat, 10 Sep 2011 18:27:34 +0100
Message-ID: <CABcS5h3+4br6aBfvRRPNhEkmSinbVNo3VoKJmRfW-cbeuj3Ksg@mail.gmail.com>
References: <alpine.LFD.2.02.1109101052340.2723@ionos>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Peter Zijlstra <peterz@infradead.org>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.LFD.2.02.1109101052340.2723@ionos>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hi,
recent work from Peter fixed the crashes caused by sched_rt_group (cgro=
ups).
Nevertheless, its use still makes the system sluggish.
To test this, it's just a matter of mounting the "cpu" cgroup and then:
echo 100 > cpu.rt_period_us
echo 100 > cpu.rt_runtime_us

Thanks,
Rolando

On Sat, Sep 10, 2011 at 10:12 AM, Thomas Gleixner <tglx@linutronix.de> =
wrote:
> Dear RT Folks,
>
> I'm pleased to announce the 3.0.4-rt13 release.
>
> Changes versus 3.0.2-rt11
>
> =A0* Migrate disable cure (Mike, Peter)
>
> =A0* ARM smpboot fix
>
> =A0* Printk debug (Peter)
>
> =A0* Ftrace: workaround the waitqueue issue
>
> Patch against 3.0.4 can be found here:
>
> =A0https://tglx.de/~tglx/rt/patch-3.0.4-rt13.patch.gz
>
> The split quilt queue is available at:
>
> =A0https://tglx.de/~tglx/rt/patches-3.0.4-rt13.tar.gz
>
> For those who don't have 3.0.4 around:
>
> =A0git://tesla.tglx.de/git/linux-2.6-tip rt/3.0
>
> =A0https://tglx.de/~tglx/rt/patch-3.0.4.gz
>
> Thanks,
>
> =A0 =A0 =A0 =A0tglx
> --
> To unsubscribe from this list: send the line "unsubscribe linux-rt-us=
ers" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
