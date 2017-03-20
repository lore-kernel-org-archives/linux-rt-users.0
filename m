From: Wargreen <wargreen@lebib.org>
Subject: Re: Radeon driver hang with 4.9.0-rt
Date: Mon, 20 Mar 2017 14:48:32 +0100
Message-ID: <717676b4-5773-f7a2-bbde-ae523df0ba43@lebib.org>
References: <1389032467.26259129.1487907530442.JavaMail.zimbra@redhat.com>
 <48ef9ca7-0c7e-730f-e8c2-6b07e75018b6@lebib.org>
 <CAObZbXS1AsJ7MPfNacZLnCvzCzmFcpyHDNge9sOd-AhyB1CbvQ@mail.gmail.com>
 <20170302211013.GC2723@jcartwri.amer.corp.natinst.com>
 <c5ac6b81-6b61-2923-afc7-c594a5ab34bb@lebib.org>
 <20170306173353.GJ29100@jcartwri.amer.corp.natinst.com>
 <26d68eb9-746d-26ae-cbfe-28a8b4e5a3e6@lebib.org>
 <20170306190707.GL29100@jcartwri.amer.corp.natinst.com>
 <e1193ceb-af77-b561-5b84-c08915e7859e@lebib.org>
 <fb9e1287-7042-9b46-1730-1e622eac99cc@lebib.org>
 <20170317181219.5vr4obmtiod7euuk@linutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="f2iWAXTH0epfNPE7RHb1gGjakdQ6Q5OuP"
Cc: linux-rt-users@vger.kernel.org
To: unlisted-recipients:; (no To-header on input)
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from lebib.org ([89.234.152.46]:58316 "EHLO lebib.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753442AbdCTNsy (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 20 Mar 2017 09:48:54 -0400
Received: from [10.13.10.42] (81-64-127-34.rev.numericable.fr [81.64.127.34])
        by lebib.org (Postfix) with ESMTPSA id C6B2B2B7AF16
        for <linux-rt-users@vger.kernel.org>; Mon, 20 Mar 2017 14:48:33 +0100 (CET)
In-Reply-To: <20170317181219.5vr4obmtiod7euuk@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--f2iWAXTH0epfNPE7RHb1gGjakdQ6Q5OuP
Content-Type: multipart/mixed; boundary="5BiLQl7vRLc2qm0GSWEhGWHIM0AHCuo9J";
 protected-headers="v1"
From: Wargreen <wargreen@lebib.org>
Cc: linux-rt-users@vger.kernel.org
Message-ID: <717676b4-5773-f7a2-bbde-ae523df0ba43@lebib.org>
Subject: Re: Radeon driver hang with 4.9.0-rt
References: <1389032467.26259129.1487907530442.JavaMail.zimbra@redhat.com>
 <48ef9ca7-0c7e-730f-e8c2-6b07e75018b6@lebib.org>
 <CAObZbXS1AsJ7MPfNacZLnCvzCzmFcpyHDNge9sOd-AhyB1CbvQ@mail.gmail.com>
 <20170302211013.GC2723@jcartwri.amer.corp.natinst.com>
 <c5ac6b81-6b61-2923-afc7-c594a5ab34bb@lebib.org>
 <20170306173353.GJ29100@jcartwri.amer.corp.natinst.com>
 <26d68eb9-746d-26ae-cbfe-28a8b4e5a3e6@lebib.org>
 <20170306190707.GL29100@jcartwri.amer.corp.natinst.com>
 <e1193ceb-af77-b561-5b84-c08915e7859e@lebib.org>
 <fb9e1287-7042-9b46-1730-1e622eac99cc@lebib.org>
 <20170317181219.5vr4obmtiod7euuk@linutronix.de>
In-Reply-To: <20170317181219.5vr4obmtiod7euuk@linutronix.de>

--5BiLQl7vRLc2qm0GSWEhGWHIM0AHCuo9J
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

It seem than my mail was not distributed by Majordomo. Maybe to big attac=
hements ?

So here this mail without the files, but there remain disponible to :=20
http://kalaj.darktech.org/~wargreen/logs/radeon/2448_syslog.log
http://kalaj.darktech.org/~wargreen/logs/radeon/2448_stack.log



Hello, thanks for your interest !

On 17/03/2017 19:12, Sebastian Andrzej Siewior wrote:

> Wargreen, how long does it take to trigger this issue for you?
> What is it, that you do to trigger this? What is _exactly_ the thing yo=
u
> do?

The common point each time it's an action with the GUI, for exemple
trigger the gnome's hot corner or launch a 3D game. This time just
log-in into my gnome session, and it hang when the fade of the desktop
should happen. (sorry for my english)

> Could you please additionally also do
> 	echo t > /proc/sysrq-trigger
>
> once this happens? And please make sure your dmesg buffer big enough to=

> handle the output (and if not, please increase CONFIG_LOG_BUF_SHIFT).

Attached, the log with sysrq "d", "t" and the /proc/PID/stack output.

> It seems that the first logs you uploaded kalaj.darktech.org had to
> frame pointers enabled but in the recent logs you included here in this=

> thread you had them enabled. Good. Please keep them enabled.

If needed for debuging, i can re-build the kernel with others options.

> Please attach the logs to the email and do not paste them since they ge=
t
> reformatted and it is hard to read them.
>
>> Thanks for your help !

Again !

> Sebastian
> --
> To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


--5BiLQl7vRLc2qm0GSWEhGWHIM0AHCuo9J--

--f2iWAXTH0epfNPE7RHb1gGjakdQ6Q5OuP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJHBAEBCAAxFiEEhe8tJb5+nGkdrJsqDnSv7tOnn7gFAljP3bATHHdhcmdyZWVu
QGxlYmliLm9yZwAKCRAOdK/u06efuJViD/9BCR1N6Xja3sFZymw68pO0G81I7ouu
baT3tFpX8nZZh8HYtIvA9/Cj0eK/UeGM73ZPeai5H85Ety9NUIX/ytXtX08XwG0R
XZswpYlpXyv8nC6YXIY14PsD2Hvbsh1/Ec8yGt/4w8W4eUkQNw1vKotypaNcT1o/
tP3fNsY9G2PcnktVXoM8uffYudzF6ZoD/ncsFDWxiyxo8Dvalu7PqYV5jPsRALS6
sJf4sT1zArfxqSuM/Q2BLLnQwXkfV5KhUQnZcNNg++cgRiNY4BzCxCs9h1NxzZoX
qx8xUKmWPKeVSdsfbiz8DiHqe2hLqnKAkeH0j3rjflYBwFN6h25lHznbJxad+H1I
lK79bCbaEa8VJmBdq/nK+G5jrWvUH6RxwhmoDwocE0vFhGip7XNyBxaSF3/vksvr
r2NBFAk0DvecOv7kwtsFEKojDi6NeSLylDw/eZYcny82CfbLTQHQEfALozBH5aY6
N9+YFXnEXFDZOgodpalOswFY5eDaCay/OKo/W1c+69PW2CEjv6BURDZw2tviOO9+
r5UP7L2sbZxKVQLuq1NcFgag4XWpivNj+1TqotuiEV2qcKWfqeRMBWkhYOFE3DDn
q25GXFvtK42p4pd5dKuEupaIcVFaCGebeTRfKEaDioa39kANrl2Ce0yKu+4UdNFj
sYwunfFxhxUfwQ==
=RcDc
-----END PGP SIGNATURE-----

--f2iWAXTH0epfNPE7RHb1gGjakdQ6Q5OuP--
