From: =?UTF-8?B?SsO8cmdlbiBNZWxs?= <mell@hedrich-winders.com>
Subject: Re: Which version of preempt_realtime to use?
Date: Wed, 28 Jan 2009 20:32:47 +0100
Message-ID: <4980B2DF.5030106@hedrich-winders.com>
References: <1232366467.31686.10.camel@localhost.localdomain>	 <49748567.30201@osadl.org>  <4974E686.60105@hedrich-winders.com> <1232610029.26807.8.camel@localhost.localdomain>
Reply-To: mell@hedrich-winders.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Carsten Emde <Carsten.Emde@osadl.org>,
	linux-rt-users@vger.kernel.org
To: esn@terma.com
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from dispoweb.ifw.uni-hannover.de ([130.75.23.4]:44381 "EHLO
	ketschua.hedrich-winders.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751069AbZA1Tct (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 28 Jan 2009 14:32:49 -0500
In-Reply-To: <1232610029.26807.8.camel@localhost.localdomain>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Esben,
> On Mon, 2009-01-19 at 21:45 +0100, J=C3=BCrgen Mell wrote:
>  =20
>>> Esben,
>>>
>>>  =20
>>>      =20
>>>> I am going to suggest that we use preempt_realtime for a _real_ pr=
oject
>>>> (i.e. costumers will depend on it). We will run on standeard x86 (=
maybe
>>>> x86_64) hardware and will only need serial interfaces for realtime
>>>> purposes. Security is not an issue. Which version of preempt_realt=
ime
>>>> should I pick?
>>>>    =20
>>>>        =20
>>> The latest and greatest *and* most stable version is 2.6.24.7-rt26.=
 As
>>> far as I know (but maybe others know better), there are no unresolv=
ed
>>> issues with this "Latest Stable". The kernel release 2.6.24 may not
>>> contain sufficient architecture support for PPC and ARM, but the la=
rge
>>> majority of x86 based processors and chipsets is well supported.
>>>
>>> Please report, if anything does not work as expected.
>>>  =20
>>>      =20
>> The only thing which is missing for me from the 2.6.24.7-rt series i=
s
>> the patch
>> "x86-fpu-fix-config_preempt-y-corruption-of-application-s-fpu-stack.=
patch"
>> , GIT commit
>>  870568b39064cab2dd971fe57969916036982862 from mainline 2.6.25. This
>> might cause trouble with applications which are using floating point
>> arithmetics. Otherwise I am using the 2.6.24.7-rt series on a machin=
e
>> control for a 16 axes machine and it is working mostly well. There a=
re
>> only some points where I get big delays (up to some milliseconds) wi=
th
>> my timer routine, where normally delays are below 50 microseconds. U=
p to
>> now I could not find the application ( X ??) which is causing this.
>>
>> Bye,
>>            J=C3=BCrgen
>>
>>    =20
Thomas Gleixner, Carsten Emde and OSADL helped to track down the
problem. The latency occurs while the X server is calling cache
invalidate instructions in the drm code. According to Thomas, this is a
known problem and might be addressed in later kernel versions. Thomas i=
s
clarifying the situation with the drm developers.

=46or the time being, I disabled the i810 drm driver and switched to th=
e
standard framebuffer device. My test machine is running now for two day=
s
with a maximum latency detected by cyclictest of 110 micro-seconds (38
=C2=B5s average), which is completely suitable for my application. The
performance impact of the frame buffer driver versus the i810 driver is
not too bad so I can live pretty well with this solution.

Many thanks to Thomas, Carsten and the people at OSADL for their help!

Bye,
              J=C3=BCrgen

--=20
J=C3=BCrgen Mell (Software-Entwicklung)           mell@hedrich.com
Tel.:  +49-511-762-18226                     http://www.hedrich.com
=46AX :  +49-511-762-18225
Mobil: +49-160-7428156
-----------------------------------------------------------------------=
---------
HEDRICH winding systems GmbH
An der Universit=C3=A4t 2 (im PZH)
D-30823 Garbsen (GERMANY)
-----------------------------------------------------------------------=
---------
Gesch=C3=A4ftsf=C3=BChrer: Karsten Adam, Markus Gerth, Friedrich Frech
Handelsregister: Wetzlar, HRB 4768
Steuernr.: 020/235/20110                     USt-IdNr.: DE 258258279
-----------------------------------------------------------------------=
---------=20

--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
