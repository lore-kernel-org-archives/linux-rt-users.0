From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: PATCH[2.6.32] softirq patch
Date: Wed, 3 Sep 2014 00:07:48 +0200 (CEST)
Message-ID: <alpine.DEB.2.10.1409022332030.3333@nanos>
References: <9dcf49abe0cd0e331df7b5faa37265ca@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-rt-users@vger.kernel.org, shaiju_sada@yahoo.com
To: Sadasivan Shaiju <sshaiju@mvista.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:39962 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754583AbaIBWHv (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 2 Sep 2014 18:07:51 -0400
In-Reply-To: <9dcf49abe0cd0e331df7b5faa37265ca@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Mon, 11 Aug 2014, Sadasivan Shaiju wrote:
> I  work for Montavista (Cavium Inc) as  a  Technical  Lead .

Weird, IIRC semiconductor companies switched to Lead Free about 8
years ago.

> I want to push some of the kernel patches to rt community (2.6.32
> kernel 2.6.33 rt patch)

See Documentation/SubmittingPatches #9

 "If the patch does not apply cleanly to the latest kernel version,
  Linus will not apply it."

Neither do I. I really give a shit about a Frankenkernel cobbled
together by MVista based on 2.6.32 plus a unknown shitload of crap and
2.6.33-whatever-random-patch-version duct-taped on it.

>  , so  that  It  will  go  to  the  main line

The only way it will go is to /dev/null

> These patches  are reviewed  and approved  by  our system Architect.  I

Congratulations. Print the approval and pin it to your cubicle wall. 

> request  you to  include  in the main line . 

You can request a Pony and you wont get it.

> These issues were reported by our customer CISCO.

Who cares and how is that relevant to the problem at hand?
 
> Problem Description:
> >From time to time, the following warning appears in the kernel logs on
> x86, OCTEON Plus and Octeon II:

Great, so anything else than those three is not affected.
 
> NOHZ: local_softirq_pending 08
> 
> Root Cause:
> In run_ksoftirqd, _local_bh_enable() is used to enable bottom half.
> This does not kick off softirq processing.

That's a real new information, perhaps not ....

See Documentation/SubmittingPatches #2

> How Solved:
> In run_ksoftirqd, _local_bh_enable() has been replaced with
> local_bh_enable() to
> enable softirq processing .

See Documentation/SubmittingPatches #2
 
> Here  I  am attaching  the  patch  for  the  above  bug .   If  any

See Documentation/SubmittingPatches #7

> questions  please  contact  me  at    sshaiju@mvista.com
> (shaiju_sada@yahoo.com)

Aside of failing to submit a proper patch:

If this is MVistas answer to the concerns I raised in the last year,
then please tell those who tasked you to waste your time on providing
completely useless shit to those, who provided the technology on which
that useless shit is based on, that they are on the wrong track.

Thanks,

	tglx

