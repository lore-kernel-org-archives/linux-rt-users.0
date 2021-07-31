Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3B36C4338F
	for <linux-rt-users@archiver.kernel.org>; Sat, 31 Jul 2021 08:51:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8637060FE7
	for <linux-rt-users@archiver.kernel.org>; Sat, 31 Jul 2021 08:51:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232591AbhGaIvo (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Sat, 31 Jul 2021 04:51:44 -0400
Received: from mout.gmx.net ([212.227.15.15]:53285 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232211AbhGaIvn (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Sat, 31 Jul 2021 04:51:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1627721452;
        bh=sG6pQw8zNTAy56K9va8IBzRlPwzMASSpdw6+jHEgqh4=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=ZOoMqDi/x+cbldl4oDrS0Fn0X8rCf0USnJuMyWpM1PVHWUZJRyQ8Oa78HLWbw0vfi
         fWJUOLr06B88ykKJGoJ0btP/35qO1tDSOQi0EaFucI/fatDjGtx5SDicvPxZI6rpte
         1QJzNdOs48sT45J7/UFBvliaNpdD/56v7VRrwe4M=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from homer.fritz.box ([185.191.218.109]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N49lD-1n9JXR1Mll-0105cM; Sat, 31
 Jul 2021 10:50:52 +0200
Message-ID: <9e2492721004fb98b144ec61002b2d525ac2c0d6.camel@gmx.de>
Subject: Re: v5.14-rc3-rt1 losing wakeups?
From:   Mike Galbraith <efault@gmx.de>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>
Date:   Sat, 31 Jul 2021 10:50:51 +0200
In-Reply-To: <4fb6dc706d0fdde718943b48b1d564ec12c97f03.camel@gmx.de>
References: <20210730110753.jvli6alm63h5lefy@linutronix.de>
         <2ae27233ab091d09a7d1e971a47144b40dd51fa0.camel@gmx.de>
         <87pmuzsf1p.ffs@tglx>
         <a2cd339c0e440cb5beed788d66a19a636b2e39a1.camel@gmx.de>
         <4fb6dc706d0fdde718943b48b1d564ec12c97f03.camel@gmx.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.3 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:pC/H2IfOV1HycqlF4d9i6QWhBJwI/UuvikoLeP4IOLlSRGBeDKg
 GO+4inwpJ6GHbqlca740iKO3BdiPYfUfttJR9qdswX7mEl2asGjePK0u7EpUxpcWtOBHxkM
 fwJOzoJXfNIKkfjK+F4ntg5FFbGV3G5xz65WP2WYyG7+DVk8PGL8Ur82BEZJg7DVRBVZa+q
 gUGaYpmiM+p5s/H0Wpp2A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:fb+0MyGjoyQ=:F4p4ZZoj9x1/Fer/XWjzD+
 3+LYbgM6OVzmsivkOyhRId61Dzg+LtlemQ1zR9k+9TykjqYXfkp4NhnhZMS0i+9yemwPtObS6
 CxyHgO9i7nrxTQEzQXcFQTCzeh2UCRjKWYnFraG2a9LMWLx+TJ79bFj9aiydUcItp8SObkm3O
 oKIXOUTBGZK7Whlfhf8Lwt4/I4AZJ2jYQkQQd/0tFytN+6K71iLLsKuvkSfRYnogtdYF0+wOn
 y6F+ERZGSzcmQk1UqB3zJ2p9sPrdUlLzmWtZgXCd5c3KJmyN8Y1HPeimMCuirLsfyXosbKjZO
 +jQwgZAP5784zDAA9wWb/vKDvh8zGICKXJQ+Zh1rEonVesQ+JKCJ+U9qTQ9gPr1vEuV4NmzCR
 UrVI26C8S6T0hpTAOYAiL/zH6VYteoj3gYSRZ+/vuoFYXCZrwMKoKm/dPIeaZvCpAzu1/vWpA
 hXHnZQEZR2dy9hxxdAqqbto9JX4WdmGauzsIjxKYepYuuccwrWJeLiCUfrMT16CZ73kUweJzp
 iXTZvWQB2vyr8crQSK3oJEJIDEDq4ulBOJ3VhuzgBTUpTu2BW1JoV5WBiRORs4qyc88VZ1Vdp
 4ih9A0nFVs//0nDl8posYB2QZp9mkI4vsqe1m8Z1tud2ez6VkkCuIuyjB5B7S1jtIww/E64Pw
 8I12H+h5+WjyN1uZs24Ih6O1jPxdM8KzyabYPm1dUriqiL8M860dRY1xqc7LNmayBMn8vCNzr
 QqX6UQzLTk7PsCefPiIar1LyiBiRMPk34lEIVno5BZvUGW9TXfe0gN9Ge6/Roct14EjBXUStD
 9txTlAUTqvR2Cv1jjSWVTUNnFV/i9/YVMu5IrD46W/jN8nYRKhHBMuKSAlf3r2K17oUHAEiOV
 4bXna8ZcaBW3Q1MjFZB6YKb1BJsuN3o3EwyCB6nQ9RdSaB4lZCDS8Fs5LcsUSMRaJ1CTOhMCi
 rKAxY2zze4bm42YH+KR7pUeuJLpgZy+Glw4kr2+n3JsvMPjtYzFy3va3ZCcFuVtBFjgzrajfM
 EP6i4dNAUwCw20IlQoNFornjHOp6/YmFN48RDIPbo47Yyy4BZ+7/2DAP0amLrqQKb5oznJ2u5
 DmBVqSc/iX9m1BZkwGkpNQ4C4xRdTwbiDKU
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Sat, 2021-07-31 at 05:33 +0200, Mike Galbraith wrote:
> On Sat, 2021-07-31 at 03:03 +0200, Mike Galbraith wrote:
> > On Fri, 2021-07-30 at 22:49 +0200, Thomas Gleixner wrote:
> > >
> >
> > > Which graphics driver is in use on that machine?
> >
> > The all too often problem child nouveau, but I don't _think_ it's
> > playing a roll in this, as nomodeset hangs as well.=C2=A0 I'll stuff i=
t into
> > lappy (i915) to double check that.
>
> Hm, lappy doesn't seem to want to hang.=C2=A0 i915 isn't virgin, it need=
ing
> a couple bandaids, but I doubt my grubby fingerprints matter.

Hours later i915 lappy is still working fine.

The problem is not my nvidia/nouveau desktop box. Taking KVM images
over to lappy on a USB SSD, the same QXL vbox that hangs with desktop
box as host also hangs with lappy as host.. a host that's still running
the very same kernel, the same build in fact (all instances are), just
fine.

	-Mike

