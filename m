From: Esben Nielsen <esn@terma.com>
Subject: Re: Which version of preempt_realtime to use?
Date: Thu, 22 Jan 2009 08:40:29 +0100
Message-ID: <1232610029.26807.8.camel@localhost.localdomain>
References: <1232366467.31686.10.camel@localhost.localdomain>
	 <49748567.30201@osadl.org>  <4974E686.60105@hedrich-winders.com>
Reply-To: esn@terma.com
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Carsten Emde <Carsten.Emde@osadl.org>,
	linux-rt-users@vger.kernel.org
To: mell@hedrich-winders.com
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from asgaard.lystrup.terma.com ([193.163.1.112]:52213 "EHLO
	asgaard.terma.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753929AbZAVHoJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 22 Jan 2009 02:44:09 -0500
In-Reply-To: <4974E686.60105@hedrich-winders.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Mon, 2009-01-19 at 21:45 +0100, J=C3=BCrgen Mell wrote:
> >
> > Esben,
> >
> >  =20
> >> I am going to suggest that we use preempt_realtime for a _real_ pr=
oject
> >> (i.e. costumers will depend on it). We will run on standeard x86 (=
maybe
> >> x86_64) hardware and will only need serial interfaces for realtime
> >> purposes. Security is not an issue. Which version of preempt_realt=
ime
> >> should I pick?
> >>    =20
> > The latest and greatest *and* most stable version is 2.6.24.7-rt26.=
 As
> > far as I know (but maybe others know better), there are no unresolv=
ed
> > issues with this "Latest Stable". The kernel release 2.6.24 may not
> > contain sufficient architecture support for PPC and ARM, but the la=
rge
> > majority of x86 based processors and chipsets is well supported.
> >
> > Please report, if anything does not work as expected.
> >  =20
> The only thing which is missing for me from the 2.6.24.7-rt series is
> the patch
> "x86-fpu-fix-config_preempt-y-corruption-of-application-s-fpu-stack.p=
atch"
> , GIT commit
>  870568b39064cab2dd971fe57969916036982862 from mainline 2.6.25. This
> might cause trouble with applications which are using floating point
> arithmetics. Otherwise I am using the 2.6.24.7-rt series on a machine
> control for a 16 axes machine and it is working mostly well. There ar=
e
> only some points where I get big delays (up to some milliseconds) wit=
h
> my timer routine, where normally delays are below 50 microseconds. Up=
 to
> now I could not find the application ( X ??) which is causing this.
>=20
> Bye,
>            J=C3=BCrgen
>=20

Which GIT-tree are you refering to?

Is there at all an up-to-date GIT repository with preempt realtime?

Esben

--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
