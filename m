From: John Sigler <linux.kernel@free.fr>
Subject: Re: Pin-pointing the root of unusual application latencies
Date: Thu, 26 Jul 2007 17:16:24 +0200
Message-ID: <46A8BAC8.9000306@free.fr>
References: <469600F7.3060603@free.fr> <20070723095357.GA886@elte.hu> <46A4B7C2.1070304@free.fr> <20070723160442.GA7995@elte.hu> <46A5B8E3.4060004@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
	linux-net@vger.kernel.org
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtp4-g19.free.fr ([212.27.42.30]:49437 "EHLO smtp4-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754320AbXGZPQm (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 26 Jul 2007 11:16:42 -0400
In-Reply-To: <46A5B8E3.4060004@free.fr>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

[ Adding linux-net to the mix ]

John Sigler wrote:

> ( check_dektec_in-1095 |#0): new 271 us user-latency.
> ( check_dektec_in-1095 |#0): new 275 us user-latency.
> ( check_dektec_in-1095 |#0): new 290 us user-latency.
> ( check_dektec_in-1095 |#0): new 297 us user-latency.
> ( check_dektec_in-1095 |#0): new 345 us user-latency.
> ( check_dektec_in-1095 |#0): new 358 us user-latency.
> ( check_dektec_in-1095 |#0): new 384 us user-latency.
> ( check_dektec_in-1095 |#0): new 392 us user-latency.
> ( check_dektec_in-1095 |#0): new 395 us user-latency.
> ( check_dektec_in-1095 |#0): new 396 us user-latency.
> ( check_dektec_in-1095 |#0): new 1031 us user-latency.
> ( check_dektec_in-1095 |#0): new 1100 us user-latency.
> ( check_dektec_in-1095 |#0): new 1105 us user-latency.
> ( check_dektec_in-1095 |#0): new 1106 us user-latency.
>=20
> Here's the function trace for the 1106-=B5s latency:
>=20
> http://linux.kernel.free.fr/latency/1106-us-trace.txt
>=20
> These two lines repeat ~2000 times for ~800 =B5s:
>=20
> softirq--4     0....  272us : __lock_text_start (rt_run_flush)
> softirq--4     0....  272us : rt_spin_unlock (rt_run_flush)
>=20
> With a pair of the following in the middle:
>=20
> softirq--4     0....  670us : call_rcu (rt_run_flush)
> softirq--4     0D..1  670us : __rcu_advance_callbacks (call_rcu)

Could someone explain why the kernel is "spinning" in rt_run_flush.
http://lxr.linux.no/source/net/ipv4/route.c#L692
What is the kernel trying to do?

Is the kernel in the following loop?

701         for (i =3D rt_hash_mask; i >=3D 0; i--) {
702                 spin_lock_bh(rt_hash_lock_addr(i));
703                 rth =3D rt_hash_table[i].chain;
704                 if (rth)
705                         rt_hash_table[i].chain =3D NULL;
706                 spin_unlock_bh(rt_hash_lock_addr(i));

Line 702 would be __lock_text_start (rt_run_flush)
Line 706 would be rt_spin_unlock
Is that correct?

And this would be done 2000 times because rt_hash_mask=3D2000?

Regards.
