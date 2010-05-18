From: Xianghua Xiao <xiaoxianghua@gmail.com>
Subject: Re: PREEMPT_RT (2.6.33-rt17) disabled printk-to-console after
	console_init
Date: Tue, 18 May 2010 15:49:54 -0500
Message-ID: <AANLkTiktb6CIP9PsM4pX2Izwrx5bXjXjqoHNqXSdyhJG@mail.gmail.com>
References: <AANLkTimxLHngWamPvWt-htGoZ7Nub72rvJAnmGtw4Eqw@mail.gmail.com>
	 <AANLkTinClrTDoXH4NPP2-SgSYH24ZTnqsop88aocdg4R@mail.gmail.com>
	 <alpine.LFD.2.00.1005182143100.3368@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.LFD.2.00.1005182143100.3368@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Tue, May 18, 2010 at 2:47 PM, Thomas Gleixner <tglx@linutronix.de> w=
rote:
> On Tue, 18 May 2010, Xianghua Xiao wrote:
>> I could not get dmesg output to console/serial and
>> klogd(/var/log/messages) anymore with 2.6.33-rt17 _after_ the kernel
>> boot is done(on non-RT kernel it works fine). I made below changes i=
t
>> starts to work again, however I'm unsure how safe the change is.
>> Please advise.
>
> Well, obviously it's unsafe if you remove safety checks. And if you
> care to look at the changelog of kernel/printk.c you'll find out why.
>
> Short story: It's introducing nasty latencies.
>
> Use "earlyprintk=3Dserial,ttyS0,115200,keep" if you care, but do not
> complain about the resulting latencies.
>
> Thanks,
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0tglx
>

The earlyprintk bootargs did not work...

will try http://lkml.org/lkml/2008/1/24/390 to see if helps on latencie=
s.

While latency is key, we also need klogd to work at least(disabling
output to serial console may be fine), without that hack somehow klogd
did not get invoked and we have nothing logged from the kernel onto
storage device.

Thanks again,
Xianghua
