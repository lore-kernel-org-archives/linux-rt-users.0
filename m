From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: 3.2-rt build issue with CONFIG_DEBUG_ATOMIC_SLEEP
Date: Fri, 03 May 2013 17:15:14 -0400
Message-ID: <1367615714.7373.21.camel@gandalf.local.home>
References: <20130503033019.GB5011@beefymiracle.amer.corp.natinst.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
To: Josh Cartwright <josh.cartwright@ni.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.122]:3811 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760851Ab3ECVPQ (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 3 May 2013 17:15:16 -0400
In-Reply-To: <20130503033019.GB5011@beefymiracle.amer.corp.natinst.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Thu, 2013-05-02 at 22:30 -0500, Josh Cartwright wrote:
> Hey Steven-
>=20
> It looks like commit 78563280521 ("sched: Check for idle task in
> might_sleep()") in the v3.2-rt stable branch has a dependency on
> is_idle_task() being defined, which doesn't exist in 3.2.
>=20
> This causes build breakages with CONFIG_DEBUG_ATOMIC_SLEEP:
>=20
>   kernel/sched.c: In function =C3=A2=C2=80=C2=98__might_sleep=C3=A2=C2=
=80=C2=99:
>   kernel/sched.c:8942:7: error: implicit declaration of function =C3=A2=
=C2=80=C2=98is_idle_task=C3=A2=C2=80=C2=99 [-Werror=3Dimplicit-function=
-declaration]
>=20
> Fortunately, upstream commit c4f30608435 (shown below) is nice and
> contained, and can be cherry-picked cleanly.
>=20

Thanks, I'll apply it to my next release.

-- Steve


--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
