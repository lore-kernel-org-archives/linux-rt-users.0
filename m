From: Ming Lei <tom.leiming@gmail.com>
Subject: Re: [RT] Lockdep warning on boot with 2.6.31-rc5-rt1.1
Date: Sat, 8 Aug 2009 16:33:18 +0800
Message-ID: <d82e647a0908080133g7aa3e62fqcc52054ba57a32f1@mail.gmail.com>
References: <20090807094608.4b0efea1@torg> <1249657743.32113.733.camel@twins>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
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
Received: from rv-out-0506.google.com ([209.85.198.239]:41940 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751504AbZHHIdS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 8 Aug 2009 04:33:18 -0400
In-Reply-To: <1249657743.32113.733.camel@twins>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

2009/8/7 Peter Zijlstra <peterz@infradead.org>:
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
>> =A0(&dev->mutex){+.+...}, at: [<ffffffff812664ae>]
>> __driver_attach+0x48/0x81
>>
>> but task is already holding lock:
>> =A0(&dev->mutex){+.+...}, at: [<ffffffff812664a2>]
>> __driver_attach+0x3c/0x81
>>
>> other info that might help us debug this:
>> 1 lock held by swapper/1:
>> =A0#0: =A0(&dev->mutex){+.+...}, at: [<ffffffff812664a2>]
>> __driver_attach+0x3c/0x81
>
> Oh, that's tglx who's gone wild with sem->mutex conversions.

Maybe we can introduce some mutex interfaces which bypass lockdep valid=
ation
temporarily to allow driver core to convert to mutex from sema if lockd=
ep
can't validate tree-structured lock orderings.

Thanks.

--
Lei Ming
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
