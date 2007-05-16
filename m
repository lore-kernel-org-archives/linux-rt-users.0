From: Nicholas Mc Guire <der.herr@hofr.at>
Subject: Re: [Celinux-dev] Rt-preempt testing best practices
Date: Wed, 16 May 2007 05:22:45 +0200 (CEST)
Message-ID: <Pine.LNX.4.60.0705160511090.649@rtl14.hofr.at>
References: <464A4FC4.6030606@am.sony.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: CE Linux Developers List <celinux-dev@tree.celinuxforum.org>,
	linux-rt-users@vger.kernel.org, RTWG@LIST.CELINUXFORUM.ORG
To: Tim Bird <tim.bird@am.sony.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from [194.112.174.227] ([194.112.174.227]:44418 "EHLO mail.hofr.at"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1759504AbXEPF1G (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 16 May 2007 01:27:06 -0400
In-Reply-To: <464A4FC4.6030606@am.sony.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

>
> I'm writing to tell you about a project I'm working on.
> I'm trying to collect as much information as I can about
> testing real time performance of Linux.
>
> I've started a wiki page at:
> http://tree.celinuxforum.org/CelfPubWiki/RealtimeTestingBestPractices
> (which is on CELF's wiki)
>
The tests noted in the LKML post on this page are very problematic, ping 
- -f is not testing RT at all, it keeps the kernel in a very small active
page set thus reducing page related penalties, the while loop using dd
is also not too helpfull as it will de-facto run only in memory and cause
absolutely no disk/mass-storage related interaction (try the same with
mount -o remount,sync /  first and it will be devastating ! (limited to 
ext2/ext3/ufs))

The big problem with RT tests published is that they are all looking at 
the good case, they are loading the system but assuming successfull 
operations. The worst cases pup up when you run in the error paths of the 
kernel - then a trivial application can induce very large jitter in the 
system (run crashme in the background and rerun the tests...)

Also lmbench can give a statistic view of things (and not even that very 
precisely in some case i.e. context switch measurements are flawed) so 
this is not of much help for descision makers which variant to use - it 
does not help if the average performance is good but the mobile phone or 
mp3 klicks at 1s intervales "deterministically" - so I guess RT benchmarks 
need a notion of usage-profile to be of value.


> However, I think this material would be better placed
> on the Linux RT wiki at: http://rt.wiki.kernel.org/index.php/Main_Page
> Does anyone have any problem with me moving the content to there,
> and continuing my attempt to document this on that site?
>

Note that this page is dedicated to RT-preempt and will most likely not 
cover the other variants of RT Linux availabe - so it might well be a
good idea to maintain an independant page but cross-link them ?

> Note that there's some duplication of content with other
> pages on the RT wiki.  I'll try to clean this up during the move.
>
> Any comments or suggestions are welcome.
>
> If you have done RT testing, and especially if you have published
> information I can look at (and link to), please contact me.

There are a number of publications related to both benchmarking and 
analysis of hardware related artefacts (cache,BTB,TLB,etc.) which were 
published at the real-time Linux Workshops - should I collect them 
together and send you those as tar.bz2 or just the links ?

hofrat
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFGSnkHnU7rXZKfY2oRAhAkAJ9OYUionz+BULkA90ezFz7QRcHAvACgofnY
nZbizb6oIon3AYr5dSJ0ubk=
=gPtS
-----END PGP SIGNATURE-----
