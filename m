From: Daniel Walker <dwalker@mvista.com>
Subject: Re: v2.6.22.1-rt5
Date: Mon, 23 Jul 2007 14:30:26 -0700
Message-ID: <1185226226.2573.147.camel@imap.mvista.com>
References: <20070723210236.GA25104@elte.hu>  <46A51D9E.8040104@rncbc.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
	linux-rt-users@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>
To: Rui Nuno Capela <rncbc@rncbc.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.158]:30049 "EHLO
	gateway-1237.mvista.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755221AbXGWVmF (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 23 Jul 2007 17:42:05 -0400
In-Reply-To: <46A51D9E.8040104@rncbc.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Mon, 2007-07-23 at 22:29 +0100, Rui Nuno Capela wrote:
> Ingo Molnar wrote:
> > we are pleased to announce the v2.6.22.1-rt5 kernel (collected and=20
> > assembled by Thomas), which can be downloaded from the usual place:
> >  =20
> >   http://redhat.com/~mingo/realtime-preempt/
> >  =20
> > more info about the -rt patchset can be found in the RT wiki:
> >   =20
> >   http://rt.wiki.kernel.org
> >=20
> > Changes since -rt4:
> >=20
> >  - MM fix: PCP pages locking (Peter Zijlstra)
> >=20
> >  - yield() fix: remove stale RCU-unlock (Daniel Walker)
> >=20
> >  - dont do check_pgt_cache() in idle (found by Daniel Walker)
> >=20
> >  - moved 8 patches, created 6 new patches out of larger patches to=20
> >    make the -rt queue more bisectable (Daniel Walker)
> >=20
> >  - cleanup (Daniel Walker)
> >=20
> >  - fix the latency tracer under paravirt
> >=20
> > to build a 2.6.22.1-rt5 tree, the following patches should be appli=
ed:
> >  =20
> >   http://kernel.org/pub/linux/kernel/v2.6/linux-2.6.22.1.tar.bz2
> >   http://redhat.com/~mingo/realtime-preempt/patch-2.6.22.1-rt5
> >  =20
> > 	Ingo
> > -
>=20
> Maybe I was too quick, but `make all` on is failing here:
>=20
> ...
> In file included from arch/i386/mm/pgtable.c:16:
> include/linux/quicklist.h: In function =E2=80=98quicklist_alloc=E2=80=
=99:
> include/linux/quicklist.h:50: warning: unused variable =E2=80=98q=E2=80=
=99
> include/linux/quicklist.h: In function =E2=80=98__quicklist_free=E2=80=
=99:
> include/linux/quicklist.h:79: error: =E2=80=98per_cpu__quicklist=E2=80=
=99 undeclared
> (first use in this function)
> include/linux/quicklist.h:79: error: (Each undeclared identifier is
> reported only once
> include/linux/quicklist.h:79: error: for each function it appears in.=
)
> include/linux/quicklist.h:79: warning: type defaults to =E2=80=98int=E2=
=80=99 in
> declaration of =E2=80=98type name=E2=80=99
> include/linux/quicklist.h:79: error: invalid type argument of =E2=80=98=
unary *=E2=80=99
> make[1]: *** [arch/i386/mm/pgtable.o] Error 1
> make: *** [arch/i386/mm] Error 2

Yeah, the quicklist patch wasn't fully tested .. The delta patch below
is what I had to change to get it working ..

Signed-Off-By: Daniel Walker <dwalker@mvista.com>

diff -u linux-2.6/include/linux/quicklist.h linux-2.6.22.1/include/linu=
x/quicklist.h
--- linux-2.6/include/linux/quicklist.h
+++ linux-2.6.22.1/include/linux/quicklist.h
@@ -47,7 +47,6 @@
=20
 static inline void *quicklist_alloc(int nr, gfp_t flags, void (*ctor)(=
void *))
 {
-	struct quicklist *q;
 	void **p =3D NULL;
 	int cpu;
=20
@@ -66,6 +65,7 @@
 static inline void __quicklist_free(int nr, void (*dtor)(void *), void=
 *p,
 	struct page *page)
 {
+	int cpu;
 	struct quicklist *q;
 	int nid =3D page_to_nid(page);
=20
@@ -76,11 +76,11 @@
 		return;
 	}
=20
-	q =3D &get_cpu_var(quicklist)[nr];
+	q =3D &get_cpu_var_locked(quicklist, &cpu)[nr];
 	*(void **)p =3D q->page;
 	q->page =3D p;
 	q->nr_pages++;
-	put_cpu_var(quicklist);
+	put_cpu_var_locked(quicklist, cpu);
 }
=20
 static inline void quicklist_free(int nr, void (*dtor)(void *), void *=
pp)
diff -u linux-2.6/mm/quicklist.c linux-2.6.22.1/mm/quicklist.c
--- linux-2.6/mm/quicklist.c
+++ linux-2.6.22.1/mm/quicklist.c
@@ -80,7 +80,7 @@
 	struct quicklist *ql, *q;
=20
 	for_each_online_cpu(cpu) {
-		ql =3D per_cpu(quicklist, cpu);
+		ql =3D per_cpu_var_locked(quicklist, cpu);
 		for (q =3D ql; q < ql + CONFIG_NR_QUICK; q++)
 			count +=3D q->nr_pages;
 	}
