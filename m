Return-Path: linux-rt-users-owner@vger.kernel.org
Received: from mail.ableton.net ([62.96.12.117]:53373 "EHLO mail.ableton.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726146AbeJLC7D (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 11 Oct 2018 22:59:03 -0400
From: Diez Roggisch <diez.roggisch@ableton.com>
Subject: Re: freezing system
Date: Thu, 11 Oct 2018 19:30:29 +0000
Message-ID: <D15849DD-3D29-447E-87FF-6F09B848DB43@ableton.com>
References: <53E9713C-8920-41A7-A9D6-4E5169C77CF2@ableton.com>,<20181011190133.GF21426@jcartwri.amer.corp.natinst.com>
In-Reply-To: <20181011190133.GF21426@jcartwri.amer.corp.natinst.com>
Content-Language: de-DE
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>
To: Julia Cartwright <julia@ni.com>
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>

Thanks to both of you. I admit I did this kind of prematurely. I=92ll give =
removing the flag a shot next week!

Cheers,

Diez=20

Von meinem iPad gesendet

> Am 11.10.2018 um 21:01 schrieb Julia Cartwright <julia@ni.com>:
>=20
> Hello Diez-
>=20
>> On Thu, Oct 11, 2018 at 04:30:36PM +0000, Diez Roggisch wrote:
>> Hi,
>>=20
>> during work on a driver I encountered a behaviour I can't explain and
>> would like to hear the opinion of the experts here.
>>=20
>> We work with the rasperry PI 3 (in it's compute module incarnation,
>> but that shouldn't make a difference for this discussion).
>>=20
>> It is hooked up to a microcontroller via SPI, and because the uC needs
>> to signal that it is ready to receive data, we strung an IRQ line to a
>> GPIO on the pi.
>>=20
>> In the driver I register an ISR for that GPIO which signals a
>> wait_queue_head_t with wake_up. The ISR is allocated with
>> IRQF_NO_THREAD because this is on our critical path and should be as
>> fast as possible.
>=20
> Can you reproduce the hanging behaviour without IRQF_NO_THREAD?
>=20
> In general, the signalling/wakeup of wait queues is not allowed from
> hardirq context (like what would happen if you've passed IRQF_NO_THREAD
> at the time you register your handler).  If there's ever contention on
> the waitqueue's internal spin_lock on RT, the handler will end up trying
> to schedule() in a non-schedulable context.  This might lead to a
> complete hang like you're seeing.
>=20
> Good luck,
>   Julia
