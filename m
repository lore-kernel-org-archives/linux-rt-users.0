From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: Problem: plist_add undefined!
Date: Wed, 21 Dec 2011 22:51:02 -0500
Message-ID: <1324525862.5916.121.camel@gandalf.stny.rr.com>
References: <4EF05465.7050507@unican.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>
To: Monica Puig-Pey <puigpeym@unican.es>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.123]:33256 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752956Ab1LVDvE (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 21 Dec 2011 22:51:04 -0500
In-Reply-To: <4EF05465.7050507@unican.es>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Tue, 2011-12-20 at 10:24 +0100, Monica Puig-Pey wrote:
> Hi there,
>=20
> As I told in previous posts in this list I'm developing drivers for t=
he
>=20
> linux-rt kernel version in Ubuntu 10.04, based on 2.6.31 with rt_pree=
mpt=20
> patch.
>=20
> Currently I'm studying how to use priority lists (linux/plist.h) in a=
=20
> module. I read some pages from the Linux Kernel Development book to=20
> learn how linked list work in the kernel.
>=20
> I made and easy example, shown below, trying to put three elements, w=
ith=20
> their priorities, in a plist_head.
>=20
> Then, I had two problems:
>=20
> * First error:
>=20
>    An error is produced when using the MACROs:
>      - PLIST_HEAD_INIT(head, _lock)
>      - PLIST_NODE_INIT(node, __prio)

Right, the macros are for static declarations. Either global variables
or a variable marked as static:

struct plist_head myhead =3D PLIST_HEAD_INIT(myhead, mylock);

or

int foo() {
	static struct plist_head bar =3D PLIST_HEAD_INIT(bar, mylock);

	[...]
}

or

struct foo bar =3D {
	.zoop =3D PLIST_HEAD_INIT(bar.zoop, mylock),
};


>=20
>    it says :
>=20
>=20
> /home/monica/Escritorio/plists/priolist.c: In function 'init_module':=
=20
> /home/monica/Escritorio/plists/priolist.c:67: error: expected express=
ion=20
> before '.' token
>=20
>=20
>    --> To solve this I used the functions:
>=20
>=20
> - static inline void plist_head_init(struct plist_head *head, struct=20
> spinlock *lock)
>=20
> - static inline void plist_node_init(struct plist_node *node, int pri=
o)

Right, for runtime code you must use these.


>=20
>    But I still have the problem with the MACRO
>=20
>=20
>=20
>=20
> * Second error, problem using plist_add:
>=20
>    It says:
>=20
>=20
> =E2=80=9CWARNING: "plist_add" [/home/monica/Escritorio/plists/priolis=
t.ko]=20
> undefined! =E2=80=9D

Simple, plist_add() isn't exported to modules.

Hmm, none of the plist functions are. I guess it wouldn't hurt to make
them EXPORT_SYMBOL_GPL()

Maybe we'll do that. Is this just for learning or are you planing on
adding a real GPL module to Linux that uses plists. For learning, it ma=
y
not be worth adding these symbols, but if you have a legit reason for
modules to use plists, than I don't see any harm in exporting them.

-- Steve

>=20
>    I made the module GPL, I don't know what am I doing wrong.
>=20
> Does anybody have an idea what is happening?
>=20
> Thanks in advance for any help,
>=20
> Cheers,
>=20


--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
