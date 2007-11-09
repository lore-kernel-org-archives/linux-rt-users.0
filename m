From: Bernhard Kuhn <kuhn@l1nuxh4ck3r.de>
Subject: Re: Priority Ceiling for SMP?
Date: Fri, 09 Nov 2007 16:37:17 +0100
Message-ID: <47347EAD.50904@l1nuxh4ck3r.de>
References: <473346DF.3080108@l1nuxh4ck3r.de> <200711082329.17959.lhenriques@netvisao.pt> <47345F0F.3000709@l1nuxh4ck3r.de> <200711091432.21649.lhenriques@netvisao.pt>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users@vger.kernel.org
To: =?ISO-8859-1?Q?Lu=EDs_Henriques?= <lhenriques@netvisao.pt>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.160]:44008 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763682AbXKIPgW (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 9 Nov 2007 10:36:22 -0500
In-Reply-To: <200711091432.21649.lhenriques@netvisao.pt>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Lu=EDs Henriques wrote:

> http://www-md.e-technik.uni-rostock.de/ma/gol/rtsys/articulos/YCS159.=
pdf

Thanks for this link. This paper teached me the right keywords
to feed Google and i stumbled over this one:

https://drum.umd.edu/dspace/bitstream/1903/630/1/CS-TR-3252.ps

However, it seems like this "Multiprocessor Priority Ceiling Protocol"
doesn't allow nested locking and thus is not applicable to -rt :-(


> I would like, however, to add that telling "our OS avoids dead-locks =
by=20
> design" is also not enough for SIL certification -- you need to prove=
 this,

True, but you only need to do it once for the OS and not
for all applications developed on top of it, afterwards


> which might be as difficult as implementing your system without these=
=20
> mechanisms (they tend to add high complexity to the kernel).

This depends into which level of detail the SIL certifier likes
to dig :-)


> BTW and just for curiosity: anyone's aware of any application running=
 on top=20
> of a Linux kernel that has been SIL (or similar) certified?  I guess =
that you=20
> need a fully qualified kernel for SIL, right?

IIRC, you can claim yourself that your system reaches SIL1 or SIL2.
(it's a little bit like the "CE" sign). The fun starts at SIL3
and SIL4, where you get your system certified by somebody else.


> To sum up: most of the priority-inversion/dead-lock avoidance mechani=
sms=20
> (we've been discussing PI and PC but probably there are much more...)=
 have=20
> advantages and disadventages which are widely known and documented.  =
The=20
> conclusion, I guess, is that no "magic" solution exists and the appli=
cations=20
> system architects will need to choose one or more (or none!) of the a=
vailable=20
> mechanisms.

Agreed.


> My personal opinion is that, no matter what mechanism you select, if =
your=20
> developing critical software you will _always_ need to perform static=
=20
> schedulability analysis of your system and never rely on PI or PC.

Basically agreed, however, this can be a very challenging activity
for a highly dynamic system like Linux :-)

regards

Bernhard
