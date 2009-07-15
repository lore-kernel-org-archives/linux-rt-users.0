From: "Bjoern B. Brandenburg" <bbb@cs.unc.edu>
Subject: Re: RFC for a new Scheduling policy/class in the Linux-kernel
Date: Wed, 15 Jul 2009 00:25:26 -0400
Message-ID: <20090715002526.camdiuc3k48go0sk@webmail3.isis.unc.edu>
References: <200907102350.47124.henrik@austad.us>
	<1247336891.9978.32.camel@laptop> <4A594D2D.3080101@ittc.ku.edu>
	<1247412708.6704.105.camel@laptop> <1247499843.8107.548.camel@Palantir>
	<4A5B61DF.8090101@nortel.com> <1247568455.9086.115.camel@Palantir>
	<4A5C9ABA.9070909@nortel.com>
	<alpine.LRH.2.00.0907141109190.16818@anderson.cs.unc.edu>
	<1247589099.7500.191.camel@twins>
	<alpine.LRH.2.00.0907141234280.16818@anderson.cs.unc.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>,
	Chris Friesen <cfriesen@nortel.com>,
	Raistlin <raistlin@linux.it>,
	Douglas Niehaus <niehaus@ittc.ku.edu>,
	Henrik Austad <henrik@austad.us>,
	LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
	Bill Huey <billh@gnuppy.monkey.org>,
	Linux RT <linux-rt-users@vger.kernel.org>,
	Fabio Checconi <fabio@gandalf.sssup.it>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ted Baker <baker@cs.fsu.edu>,
	Dhaval Giani <dhaval.giani@gmail.com>,
	Noah Watkins <jayhawk@soe.ucsc.edu>,
	KUSP Google Group <kusp@googlegroups.com>,
	Tommaso Cucinotta <cucinotta@sssup.it>,
	Giuseppe Lipari <lipari@retis.sssup.it>,
	Bjoern Brandenburg <bbb@cs.unc.edu>, shinpei@ny.ics.keio.ac.jp,
	yamasaki@ny.ics.keio.ac.jp
To: "James H. Anderson" <anderson@cs.unc.edu>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mxp3.isis.unc.edu ([152.2.2.161]:38418 "EHLO mxpm.isis.unc.edu"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751619AbZGOFqz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 15 Jul 2009 01:46:55 -0400
In-Reply-To: <alpine.LRH.2.00.0907141234280.16818@anderson.cs.unc.edu>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Quoting "James H. Anderson" <anderson@cs.unc.edu>:
> Ted Baker did some work on an algorithm called EDZL
> (EDF until zero laxity) that is essentially a hybrid of these two
> algorithms.  In simulations we've done (not based on real implementat=
ions),
> EDZL exhibits really low tardiness (almost non-existent).  EDZL may
> give you the benefits of using laxities where useful and be easier
> to implement (but that's just my guess)

EDZL has nice properties but may be hard to implement efficiently=20
because it requires (a lot of) fine-grained timers.  However, Shinpei=20
Kato and Nobuyuki Yamasaki (CC'ed) presented an EDZL-derived scheduler=20
called EDCL at RTCSA'08 that has similar performance guarantees but=20
only does priority promotions at the release and completion times of=20
jobs (hence, no additional timers are required).

  Global EDF-based Scheduling with Efficient Priority Promotion
  Shinpei Kato and Nobuyuki Yamasaki
  Proceedings of the 14th International Conference on Embedded and
  Real-Time Computing Systems and Applications, pages 197-206. IEEE, 20=
08.
  http://www.ny.ics.keio.ac.jp/members/shinpei/papers/rtcsa08.pdf

I know that Shinpei and friends implemented EDCL on top of LITMUS^RT,=20
but I never got around to incorporating the patches into the "official"=
=20
LITMUS^RT patch. (Sorry, Shinpei!)

Regarding the comments about the availability of academic papers (which=
=20
were also voiced repeatedly at OSPERT'09), I'd like to point out that=20
you can find almost any recent paper by searching for the title with=20
scholar.google.com and clicking on the "All XYZ versions" link... most=20
researches make PDFs available on their homepages.

- Bj=F6rn


--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
