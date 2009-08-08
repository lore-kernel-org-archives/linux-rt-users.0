From: Ming Lei <tom.leiming@gmail.com>
Subject: Re: [RT] Lockdep warning on boot with 2.6.31-rc5-rt1.1
Date: Sat, 8 Aug 2009 17:06:04 +0800
Message-ID: <d82e647a0908080206j78a49674i99ba80801398055d@mail.gmail.com>
References: <1249657743.32113.733.camel@twins>
	 <Pine.LNX.4.44L0.0908071154530.3063-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Peter Zijlstra <peterz@infradead.org>,
	Clark Williams <williams@redhat.com>,
	LKML <linux-kernel@vger.kernel.org>,
	RT <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	"greg@kroah.com" <greg@kroah.com>,
	"Rafael J. Wysocki" <rjw@sisk.pl>,
	Kay Sievers <kay.sievers@vrfy.org>
To: Alan Stern <stern@rowland.harvard.edu>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S933713AbZHHJGG@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44L0.0908071154530.3063-100000@iolanthe.rowland.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

2009/8/8 Alan Stern <stern@rowland.harvard.edu>:
> On Fri, 7 Aug 2009, Peter Zijlstra wrote:

>> It used to be that _all_ dev->sem instances were taken on suspend or
>> something like that, I think that got fixed a long while back.
>>
>> I'd have to look at what the current locking requirements for dev->s=
em
>> are.
>
> It is supposed to be locked whenever the driver core invokes a probe,
> remove, or PM-related callback. =A0Under some circumstances, the pare=
nt's
> semaphore is supposed to be locked as well. =A0Individual subsystems =
may
> have their own requirements in addition to these.
>
> The ordering requirement is: Don't try to acquire a device's lock if
> you already hold the lock for a non-ancestor device. =A0More generall=
y
> (if more obscurely): If you already hold device A's lock, then don't
> try to acquire the lock for device B unless you already hold the lock
> for A & B's most recent common ancestor.
>

It seems that the following case is very common, and A and B have no
common ancestor, but we can hold device A and B's lock at the same
time, can't we?

Thanks.

device A  comes in one bus:
	device_add()
         ->bus_attach_device()
            ->device_attach():drivers/base/dd.c /*holding device A's lo=
ck*/
               ->...drv->probe()		/*sleep here some time*/

then device B comes in another bus:
	device_add()
         ->bus_attach_device()
            ->device_attach():drivers/base/dd.c /*holding device B's lo=
ck*/
               ->...drv->probe()		/*sleep here some time*/

--=20
Lei Ming
