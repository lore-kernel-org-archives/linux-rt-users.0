From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RT] Lockdep warning on boot with 2.6.31-rc5-rt1.1
Date: Sat, 8 Aug 2009 11:19:02 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0908081117040.19562-100000@netrider.rowland.org>
References: <d82e647a0908080206j78a49674i99ba80801398055d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Peter Zijlstra <peterz@infradead.org>,
	Clark Williams <williams@redhat.com>,
	LKML <linux-kernel@vger.kernel.org>,
	RT <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	"greg@kroah.com" <greg@kroah.com>,
	"Rafael J. Wysocki" <rjw@sisk.pl>,
	Kay Sievers <kay.sievers@vrfy.org>
To: Ming Lei <tom.leiming@gmail.com>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751837AbZHHPTF@vger.kernel.org>
In-Reply-To: <d82e647a0908080206j78a49674i99ba80801398055d@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Sat, 8 Aug 2009, Ming Lei wrote:

> > The ordering requirement is: Don't try to acquire a device's lock i=
f
> > you already hold the lock for a non-ancestor device. =A0More genera=
lly
> > (if more obscurely): If you already hold device A's lock, then don'=
t
> > try to acquire the lock for device B unless you already hold the lo=
ck
> > for A & B's most recent common ancestor.
> >
>=20
> It seems that the following case is very common, and A and B have no
> common ancestor, but we can hold device A and B's lock at the same
> time, can't we?
>=20
> Thanks.
>=20
> device A  comes in one bus:
> 	device_add()
>          ->bus_attach_device()
>             ->device_attach():drivers/base/dd.c /*holding device A's =
lock*/
>                ->...drv->probe()		/*sleep here some time*/

So right now thread 1 is sleeping.

> then device B comes in another bus:

So all this must happen in a different thread, thread 2:

> 	device_add()
>          ->bus_attach_device()
>             ->device_attach():drivers/base/dd.c /*holding device B's =
lock*/
>                ->...drv->probe()		/*sleep here some time*/

At this point, thread 1 holds A's lock and thread 2 holds B's lock. =20
Neither thread holds both locks.

Alan Stern
