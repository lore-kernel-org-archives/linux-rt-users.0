From: Rui Nuno Capela <rncbc@rncbc.org>
Subject: Re: v2.6.22.1-rt5
Date: Mon, 23 Jul 2007 22:29:02 +0100
Message-ID: <46A51D9E.8040104@rncbc.org>
References: <20070723210236.GA25104@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>
To: Ingo Molnar <mingo@elte.hu>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtpa1.netcabo.pt ([212.113.174.16]:28527 "EHLO
	exch01smtp04.hdi.tvcabo" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754783AbXGWV3K (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 23 Jul 2007 17:29:10 -0400
In-Reply-To: <20070723210236.GA25104@elte.hu>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Ingo Molnar wrote:
> we are pleased to announce the v2.6.22.1-rt5 kernel (collected and=20
> assembled by Thomas), which can be downloaded from the usual place:
>  =20
>   http://redhat.com/~mingo/realtime-preempt/
>  =20
> more info about the -rt patchset can be found in the RT wiki:
>   =20
>   http://rt.wiki.kernel.org
>=20
> Changes since -rt4:
>=20
>  - MM fix: PCP pages locking (Peter Zijlstra)
>=20
>  - yield() fix: remove stale RCU-unlock (Daniel Walker)
>=20
>  - dont do check_pgt_cache() in idle (found by Daniel Walker)
>=20
>  - moved 8 patches, created 6 new patches out of larger patches to=20
>    make the -rt queue more bisectable (Daniel Walker)
>=20
>  - cleanup (Daniel Walker)
>=20
>  - fix the latency tracer under paravirt
>=20
> to build a 2.6.22.1-rt5 tree, the following patches should be applied=
:
>  =20
>   http://kernel.org/pub/linux/kernel/v2.6/linux-2.6.22.1.tar.bz2
>   http://redhat.com/~mingo/realtime-preempt/patch-2.6.22.1-rt5
>  =20
> 	Ingo
> -

Maybe I was too quick, but `make all` on is failing here:

=2E..
In file included from arch/i386/mm/pgtable.c:16:
include/linux/quicklist.h: In function =E2=80=98quicklist_alloc=E2=80=99=
:
include/linux/quicklist.h:50: warning: unused variable =E2=80=98q=E2=80=
=99
include/linux/quicklist.h: In function =E2=80=98__quicklist_free=E2=80=99=
:
include/linux/quicklist.h:79: error: =E2=80=98per_cpu__quicklist=E2=80=99=
 undeclared
(first use in this function)
include/linux/quicklist.h:79: error: (Each undeclared identifier is
reported only once
include/linux/quicklist.h:79: error: for each function it appears in.)
include/linux/quicklist.h:79: warning: type defaults to =E2=80=98int=E2=
=80=99 in
declaration of =E2=80=98type name=E2=80=99
include/linux/quicklist.h:79: error: invalid type argument of =E2=80=98=
unary *=E2=80=99
make[1]: *** [arch/i386/mm/pgtable.o] Error 1
make: *** [arch/i386/mm] Error 2
=2E..

=2Econfig is from previous -rt4:
http://www.rncbc.org/datahub/config-2.6.22.1-rt4.0

Bye now.
--=20
rncbc aka Rui Nuno Capela
rncbc@rncbc.org
