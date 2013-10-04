From: Kirill Tkhai <tkhai@yandex.ru>
Subject: Re: [ANNOUNCE] 3.10.10-rt7
Date: Fri, 04 Oct 2013 17:11:42 +0400
Message-ID: <476411380892302@web20m.yandex.ru>
References: <20130829184228.GD15360@linutronix.de> <537051377882968@web17h.yandex.ru> <20131004122703.GC19953@linutronix.de> <448111380891453@web20m.yandex.ru> <524EBD29.5010100@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from forward8.mail.yandex.net ([77.88.61.38]:45670 "EHLO
	forward8.mail.yandex.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752754Ab3JDNTA (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 4 Oct 2013 09:19:00 -0400
In-Reply-To: <524EBD29.5010100@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

04.10.2013, 17:05, "Sebastian Andrzej Siewior" <bigeasy@linutronix.de>:
> On 10/04/2013 02:57 PM, Kirill Tkhai wrote:
>
>> =9AYes, I now. I added IRQ_FORCED_THREADING to Kconfig. My hardware
>> =9Arequires additional changes at arch/sparc and it's in a process o=
f porting
>> =9Aon 3.10 so I can't say if everything works on sparc or not yet.
>
> So if you marked NMIs and so as non-threaded you can send this patch =
to
> Dave, too :)

It's not standard interrupt controller, so it's useless for mainline. I=
t maybe,
later we'll go to upstream, not ready for now.

>> =9AThe other required fix to make sparc64 compilable is deletion of =
rwsem leftovers.
>> =9AI sent it to mainline sparc:
>>
>> =9Ahttps://git.kernel.org/cgit/linux/kernel/git/davem/sparc.git/comm=
it/arch/sparc?id=3D61d9b9355b0d427bd1e732bd54628ff9103e496f
>>
>> =9AIt seems it's resonable to add it to the patch too.
>
> Since it is queued for mainline let me make your life easier and pick
> it up for -RT, too.

Ok, thanks :)
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
