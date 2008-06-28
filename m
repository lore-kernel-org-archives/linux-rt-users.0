From: trem <tremyfr@yahoo.fr>
Subject: Re: 2.6.24.7-rt14
Date: Sat, 28 Jun 2008 15:19:22 +0200
Message-ID: <g45dvm$pvt$1@ger.gmane.org>
References: <1214256117.8701.13.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-kernel@vger.kernel.org
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from main.gmane.org ([80.91.229.2]:58914 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751988AbYF1NXO (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 28 Jun 2008 09:23:14 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1KCaOU-0008TO-JA
	for linux-rt-users@vger.kernel.org; Sat, 28 Jun 2008 13:23:10 +0000
Received: from atoulouse-256-1-67-205.w86-205.abo.wanadoo.fr ([86.205.194.205])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-rt-users@vger.kernel.org>; Sat, 28 Jun 2008 13:23:10 +0000
Received: from tremyfr by atoulouse-256-1-67-205.w86-205.abo.wanadoo.fr with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-rt-users@vger.kernel.org>; Sat, 28 Jun 2008 13:23:10 +0000
In-Reply-To: <1214256117.8701.13.camel@localhost.localdomain>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi

I've done some test with cyclictest on -rt13 and -r14, and I'm surprise=
 of the result.
To do this test, I've installed a -rt13 and -rt14 on a box, rebooted on=
 a kernel,
and run this command (no other command). Of course, the .config is the =
same for both kernel.



On -rt13, I've got this :

[trem@localhost rt-tests]$ sudo ./cyclictest -t 1 -p 80 -n -i 10000 -l =
100000
1.00 0.97 0.69 1/158 4177         =20

T: 0 ( 4177) P:80 I:10000 C: 100000 Min:      1 Act:    2 Avg:    2 Max=
:      10



On -rt14, I4ve got this :
[trem@localhost rt-tests]$ sudo ./cyclictest -t 1 -p 80 -n -i 10000 -l =
100000
1.00 0.97 0.70 1/158 4132         =20

T: 0 ( 4125) P:80 I:10000 C: 100000 Min:      1 Act:    6 Avg:    2 Max=
:      17



The Max is clearly higher on -rt14.

regards,
Philippe (trem)



Steven Rostedt a =E9crit :
> We are pleased to announce the 2.6.24.7-rt14 tree, which can be
> downloaded from the location:
>=20
>   http://rt.et.redhat.com/download/
>=20
> Information on the RT patch can be found at:
>=20
>   http://rt.wiki.kernel.org/index.php/Main_Page
>=20
> Changes since 2.6.24.7-rt13
>=20
>   - rwlock pi_lock fixes on waking up multiple readers (Steven Rosted=
t)
>=20
>   - revert adaptive locks from RCU (Thomas Gleixner)
>      [ for some reason, using RCU causes some latency spikes, this
>        may be a sign of something going wrong in RCU itself ]
>=20
>   - rwlock mutex owner fix for waking up reader with readers held (St=
even Rostedt)
>=20
>   - rwlock remove waiter from pi_list on above fix (Steven Rostedt an=
d
>                                                     Thomas Gleixner)
>=20
>   - rwlock replace macro with inline (Thomas Gleixner)
>=20
>   - rwlock pending namespace updates (Thomas Gleixner)
>=20
>   - rwlock debug check (Thomas Gleixner)
>=20
>   - futex fix fault (Thomas Gleixner)
>=20
>   - x86_64 fix copy user (Linus Torvalds)
>=20
> to build a 2.6.24.7-rt14 tree, the following patches should be applie=
d:
>=20
>   http://www.kernel.org/pub/linux/kernel/v2.6/linux-2.6.24.tar.bz2
>   http://kernel.org/pub/linux/kernel/v2.6/patch-2.6.24.7.bz2
>   http://rt.et.redhat.com/download/patch-2.6.24.7-rt14.bz2
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

--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
