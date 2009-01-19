From: =?ISO-8859-1?Q?J=FCrgen_Mell?= <mell@hedrich-winders.com>
Subject: Re: Which version of preempt_realtime to use?
Date: Mon, 19 Jan 2009 21:45:58 +0100
Message-ID: <4974E686.60105@hedrich-winders.com>
References: <1232366467.31686.10.camel@localhost.localdomain> <49748567.30201@osadl.org>
Reply-To: mell@hedrich-winders.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: esn@terma.com, linux-rt-users@vger.kernel.org
To: Carsten Emde <Carsten.Emde@osadl.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from dispoweb.ifw.uni-hannover.de ([130.75.23.4]:36262 "EHLO
	ketschua.hedrich-winders.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753272AbZASU4S (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 19 Jan 2009 15:56:18 -0500
In-Reply-To: <49748567.30201@osadl.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

>
> Esben,
>
>  =20
>> I am going to suggest that we use preempt_realtime for a _real_ proj=
ect
>> (i.e. costumers will depend on it). We will run on standeard x86 (ma=
ybe
>> x86_64) hardware and will only need serial interfaces for realtime
>> purposes. Security is not an issue. Which version of preempt_realtim=
e
>> should I pick?
>>    =20
> The latest and greatest *and* most stable version is 2.6.24.7-rt26. A=
s
> far as I know (but maybe others know better), there are no unresolved
> issues with this "Latest Stable". The kernel release 2.6.24 may not
> contain sufficient architecture support for PPC and ARM, but the larg=
e
> majority of x86 based processors and chipsets is well supported.
>
> Please report, if anything does not work as expected.
>  =20
The only thing which is missing for me from the 2.6.24.7-rt series is
the patch
"x86-fpu-fix-config_preempt-y-corruption-of-application-s-fpu-stack.pat=
ch"
, GIT commit
 870568b39064cab2dd971fe57969916036982862 from mainline 2.6.25. This
might cause trouble with applications which are using floating point
arithmetics. Otherwise I am using the 2.6.24.7-rt series on a machine
control for a 16 axes machine and it is working mostly well. There are
only some points where I get big delays (up to some milliseconds) with
my timer routine, where normally delays are below 50 microseconds. Up t=
o
now I could not find the application ( X ??) which is causing this.

Bye,
           J=FCrgen

--=20
J=FCrgen Mell (Software-Entwicklung)           mell@hedrich.com
Tel.:  +49-511-762-18226                     http://www.hedrich.com
=46AX :  +49-511-762-18225
Mobil: +49-160-7428156
-----------------------------------------------------------------------=
---------
HEDRICH winding systems GmbH
An der Universit=E4t 2 (im PZH)
D-30823 Garbsen (GERMANY)
-----------------------------------------------------------------------=
---------
Gesch=E4ftsf=FChrer: Karsten Adam, Markus Gerth, Friedrich Frech
Handelsregister: Wetzlar, HRB 4768
Steuernr.: 020/235/20110                     USt-IdNr.: DE 258258279
-----------------------------------------------------------------------=
---------=20

--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
