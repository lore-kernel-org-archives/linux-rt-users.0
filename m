From: trem <tremyfr@yahoo.fr>
Subject: Re: 2.6.24.7-rt10
Date: Sun, 25 May 2008 02:51:17 +0200
Message-ID: <g1adb2$217$1@ger.gmane.org>
References: <1211608265.14697.105.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-kernel@vger.kernel.org
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from main.gmane.org ([80.91.229.2]:40099 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754449AbYEYAyI (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 24 May 2008 20:54:08 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1K04Ur-0002PD-Ai
	for linux-rt-users@vger.kernel.org; Sun, 25 May 2008 00:54:01 +0000
Received: from atoulouse-256-1-172-228.w90-50.abo.wanadoo.fr ([90.50.219.228])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-rt-users@vger.kernel.org>; Sun, 25 May 2008 00:54:01 +0000
Received: from tremyfr by atoulouse-256-1-172-228.w90-50.abo.wanadoo.fr with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-rt-users@vger.kernel.org>; Sun, 25 May 2008 00:54:01 +0000
In-Reply-To: <1211608265.14697.105.camel@localhost.localdomain>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Steven Rostedt a =E9crit :
> We are pleased to announce the 2.6.24.7-rt10 tree, which can be
> downloaded from the location:
>=20
>   http://rt.et.redhat.com/download/
>=20
> Information on the RT patch can be found at:
>=20
>   http://rt.wiki.kernel.org/index.php/Main_Page
>=20
> Changes since 2.6.24.7-rt9
>=20
>   - ported latest ftracers (Steven Rostedt)
>=20
>   - vdso vsyscall generic (Luis Goncalves)
>=20
>   - git-ignore update (Hiroshi Shimamoto)
>=20
>   - lockstat updates (Peter Zijlstra)
>=20
>   - Adjust pi_lock in wakeup waiters (Peter Morreale)
>=20
>   - optimize rt_spin wakeup (Peter Morreale)
>=20
>   - all archs use task->oncpu (Gregory Haskins)
>      [modified use in header by Steven Rostedt]
>=20
>   - remove redundant try_to_take_lock (Peter Morreale)
>=20
>   - fastpath try_to_take_lock on steal (Steven Rostedt)
>=20
>   - ticket FIFO spinlocks (Nick Piggin)
>=20
> to build a 2.6.24.7-rt10 tree, the following patches should be applie=
d:
>=20
>   http://www.kernel.org/pub/linux/kernel/v2.6/linux-2.6.24.tar.bz2
>   http://kernel.org/pub/linux/kernel/v2.6/patch-2.6.24.7.bz2
>   http://rt.et.redhat.com/download/patch-2.6.24.7-rt10.bz2
>=20
>=20
> *** Note ***
>=20
>   2.6.25.x-rt4 with updates will be coming out shortly
>=20
> *** Note ***
>=20
>=20
>=20
> And like always, my RT version of Matt Mackall's ketchup will get thi=
s
> for you nicely:
>=20
>   http://people.redhat.com/srostedt/rt/tools/ketchup-0.9.8-rt3
>=20
>=20
> The broken out patches are also available.
>=20
>=20
>=20
> -- Steve
>=20
>=20
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-rt-us=
ers" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20

I've got a problem with the compilation when compiling kernel/rcupreemp=
t_trace.o :

kernel/rcupreempt_trace.c: In function =91rcupreempt_trace_init=92:
kernel/rcupreempt_trace.c:539: erreur: implicit declaration of function=
 =91marker_arm=92
kernel/rcupreempt_trace.c: In function =91rcupreempt_trace_cleanup=92:
kernel/rcupreempt_trace.c:577: erreur: too few arguments to function =91=
marker_probe_unregister=92
kernel/rcupreempt_trace.c:583: erreur: too few arguments to function =91=
marker_probe_unregister=92
make[1]: *** [kernel/rcupreempt_trace.o] Erreur 1


I think that markers-upstream.patch can't be used with rcu-preempt-trac=
e-markers-1.patch and
rcu-preempt-trace-markers-2.patch.


trem

--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
