From: Ingo Molnar <mingo@elte.hu>
Subject: Re: profile_tick not called anymore?
Date: Mon, 26 Mar 2007 16:07:51 +0200
Message-ID: <20070326140751.GB6797@elte.hu>
References: <20070326155759.5dc54703@frecb000686.frec.bull.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Linux RT Users <linux-rt-users@vger.kernel.org>
To: =?iso-8859-1?Q?S=E9bastien_Dugu=E9?= <sebastien.dugue@bull.net>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx2.mail.elte.hu ([157.181.151.9]:36414 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752677AbXCZOIk (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 26 Mar 2007 10:08:40 -0400
Content-Disposition: inline
In-Reply-To: <20070326155759.5dc54703@frecb000686.frec.bull.fr>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


* S=E9bastien Dugu=E9 <sebastien.dugue@bull.net> wrote:

>   I see that the calls to profile_tick() have been commented out in=20
> the different timer handlers. Why is this so?
>=20
>   The only remaining place calling profile_tick() (well, in fact=20
> __profile_tick()) is the NMI watchdog ticker, but I don't enable it o=
n=20
> my box.

i'm using nmi_watchdog=3D2 to do profiling - if it's NMI-driven then th=
e=20
readprofile results are alot more informative.

	Ingo
