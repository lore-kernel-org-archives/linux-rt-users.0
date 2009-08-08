From: Dave Young <hidave.darkstar@gmail.com>
Subject: Re: [RT] Lockdep warning on boot with 2.6.31-rc5-rt1.1
Date: Sat, 8 Aug 2009 11:20:29 +0800
Message-ID: <a8e1da0908072020k45ede762v34b78ea3d3716379@mail.gmail.com>
References: <20090807094608.4b0efea1@torg> <1249657743.32113.733.camel@twins>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Clark Williams <williams@redhat.com>,
	LKML <linux-kernel@vger.kernel.org>,
	RT <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Alan Stern <stern@rowland.harvard.edu>,
	"greg@kroah.com" <greg@kroah.com>,
	"Rafael J. Wysocki" <rjw@sisk.pl>,
	Kay Sievers <kay.sievers@vrfy.org>
To: Peter Zijlstra <peterz@infradead.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-fx0-f228.google.com ([209.85.220.228]:56517 "EHLO
	mail-fx0-f228.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932900AbZHHDU3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 7 Aug 2009 23:20:29 -0400
In-Reply-To: <1249657743.32113.733.camel@twins>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Fri, Aug 7, 2009 at 11:09 PM, Peter Zijlstra<peterz@infradead.org> w=
rote:
> On Fri, 2009-08-07 at 09:46 -0500, Clark Williams wrote:
>> Peter,
>>
>> I'm getting this warning from lockdep when booting on my T60.
>>
>> The two addresses reported (0xffffffff812664a2 and 0xffffffff812664a=
e)
>> actually bracket one call to mutex_lock() in driver_attach() so I'm =
not
>> sure what the complaint is.
>>
>> Clark
>>
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> [ INFO: possible recursive locking detected ]
>> 2.6.31-rc5-rt1.1 #37
>> ---------------------------------------------
>> swapper/1 is trying to acquire lock:
>> =C2=A0(&dev->mutex){+.+...}, at: [<ffffffff812664ae>]
>> __driver_attach+0x48/0x81
>>
>> but task is already holding lock:
>> =C2=A0(&dev->mutex){+.+...}, at: [<ffffffff812664a2>]
>> __driver_attach+0x3c/0x81
>>
>> other info that might help us debug this:
>> 1 lock held by swapper/1:
>> =C2=A0#0: =C2=A0(&dev->mutex){+.+...}, at: [<ffffffff812664a2>]
>> __driver_attach+0x3c/0x81
>
> Oh, that's tglx who's gone wild with sem->mutex conversions.
>
> It used to be that _all_ dev->sem instances were taken on suspend or
> something like that, I think that got fixed a long while back.
>
> I'd have to look at what the current locking requirements for dev->se=
m
> are.
>
> I remember talking to Alan on several occasions about this, and I jus=
t
> went over some of the old emails, but I must say the precise
> requirements stay hidden from me. Also, I'm not sure these emails are
> still representative of the current state.

I think you means this thread:

http://lkml.org/lkml/2008/4/17/305

>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kerne=
l" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml
> Please read the FAQ at =C2=A0http://www.tux.org/lkml/
>



--=20
Regards
dave
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
