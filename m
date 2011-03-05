From: "Madovsky" <infos@madovsky.org>
Subject: Re: [ANNOUNCE] RT for v2.6.34.8 now available.
Date: Fri, 4 Mar 2011 23:40:09 -0500
Message-ID: <C5082FFD23CA4818B8B21711D880976E@e1705>
References: <4D71668F.9050201@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1;
	format=flowed	reply-type=original
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: "linux-rt-users" <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ip-67-205-80-138.static.privatedns.com ([67.205.80.138]:14834
	"EHLO node250.e-blokos.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751061Ab1CEEkK (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 4 Mar 2011 23:40:10 -0500
Received: from e1705 (localhost.localdomain [127.0.0.1])
	by node250.e-blokos.com (8.14.3/8.14.3) with SMTP id p254e9dT030321
	for <linux-rt-users@vger.kernel.org>; Fri, 4 Mar 2011 23:40:09 -0500
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi Paul,

I get same(?) error on Fedora10 64bits

  CHK     include/linux/version.h
  CHK     include/generated/utsrelease.h
  CALL    scripts/checksyscalls.sh
  CHK     include/generated/compile.h
  CC      init/do_mounts.o
In file included from include/linux/suspend.h:8,
                 from init/do_mounts.c:6:
include/linux/mm.h: In function =E2pte_lock_init=E2:
include/linux/mm.h:1125: error: implicit declaration of function =E2kma=
lloc=E2
include/linux/mm.h:1125: warning: assignment makes pointer from integer=
=20
without=20
a cast
include/linux/mm.h: In function =E2pte_lock_deinit=E2:
include/linux/mm.h:1137: error: implicit declaration of function =E2kfr=
ee=E2
In file included from include/linux/security.h:36,
                 from init/do_mounts.c:8:
include/linux/slab.h: At top level:
include/linux/slab.h:144: warning: conflicting types for =E2kfree=E2
include/linux/mm.h:1137: warning: previous implicit declaration of =E2k=
free=E2=20
was h=20
ere
In file included from include/linux/slab.h:172,
                 from include/linux/security.h:36,
                 from init/do_mounts.c:8:
include/linux/slab_def.h:128: error: conflicting types for =E2kmalloc=E2
include/linux/mm.h:1125: error: previous implicit declaration of =E2kma=
lloc=E2=20
was h=20
ere
make[1]: *** [init/do_mounts.o] Error 1
make: *** [init] Error 2


thanks

=46ranck

----- Original Message -----=20
=46rom: "Paul Gortmaker" <paul.gortmaker@windriver.com>
To: <linux-rt-users@vger.kernel.org>
Cc: <linux-kernel@vger.kernel.org>; <lwn@lwn.net>
Sent: Friday, March 04, 2011 5:24 PM
Subject: [ANNOUNCE] RT for v2.6.34.8 now available.


> As a value add to the 2.6.34 long term release, I'm happy to also
> announce the availability of 2.6.34-RT.
>
> You can find it in the v2.6.34-rt branch at:
>
>  git://git.kernel.org/pub/scm/linux/kernel/git/paulg/rt-patches.git
>
> as a repository of patches.  The v2.6.34-rt branch contains the lates=
t
> RT patches against the latest v2.6.34.8 kernel release. (The master
> branch currently stops at v2.6.34 flat, i.e. 2.6.34.0 so to speak.)
>
> I've also created over 400 known working RT enabled bisection points
> between 33 and 34 that you can make use of for testing.  The details
> on how/why those exist follows - read on if it is of interest to you.
>
> Note that all credit of the thinking and engineering of the RT stuff
> lies with the original patch authors -- to be clear, I'm just doing
> the grunt work of a carry forward here.
>
> Have fun with it, maybe drop me a note if you find it useful etc.
>
> Paul.
>
>
> The carry forward process:
> ---------------------------
>
> This warrants some notes, since (a) it has strong consequence on how
> you can diagnose/bisect problems that were not in 33-rt but may exist
> in 34-rt and (b) we've recently seen people who wonder how to do a
> similar task and I think they *really* underestimate the complexities
> and sheer effort of trying to do any sort of RT carry-forward.
>
> For those who track these things, you will know that the most recent
> release of RT was based on v2.6.33, and in turn, it was created by
> merging forward the mainline kernel.org v2.6.33 content into the olde=
r
> v2.6.31 RT tree.  There was no rebase.
>
> With that detail, some of you are probably now going "Aha, now I know
> why he created that merge-free v2.6.33 based RT tree some weeks ago."
> (see: http://www.spinics.net/lists/linux-rt-users/msg06310.html )
>
> Step one was that I needed the RT commits rebased against 33 (and not=
 31)
> as my starting point for rebasing RT onto v2.6.34 -- see the above
> link for details on the significant work involved with that.
>
> There are roughly 500 RT patches, and literally 10,000+ commits betwe=
en
> v2.6.33 and v2.6.34.  So if one was to move things ahead all in one g=
o,
> there can be roughly 5 million things that can go wrong.  Maybe some =
sharp
> person can move those ahead all in one shot, and then figure out the
> resulting inevitable runtime breakage, but that isn't me.  After all,=
 a
> man has to know his limitations, and I'm pretty much just a patch mon=
key.
>
> Knowing that the RT patches applied (and worked) on base X, but fail =
to
> apply or fail to work on X+N (where N is small) can be very empowerin=
g
> to a dumb person like me.  It reduces the problem space *immensely* a=
nd
> it lets you focus on what changed and caused the problem/conflict.  W=
ith
> that in mind, I saw no choice but to undertake what would have been t=
he
> equivalent of recreating history, had a continuous integration betwee=
n
> the two streams taken place during the 33 --> 34 dev cycle.
>
> What this means in concrete terms, is incrementally applying, updatin=
g,
> and testing the 500-odd RT patches at successive points along the 100=
00
> commits found in the 33 --> 34 development cycle.  But assuming you
> agree with that logic, what does a person choose/use as increments?
>
> At a 1st guess, a person might suggest choosing the rcN tags (where w=
e
> have N=3D1,2,... 7) as places for these incremental tests.  The probl=
em
> is that the granularity is too coarse -- just for N=3D1 means you hav=
e
> already jumped over 6000 commits ahead, and so you are still facing
> being lost for the same reason 10000 commits left you lost before.
>
> At the opposite end of the scale is a brute force approach, where a
> person tries applying/updating/testing the RT patch on *each* of the
> 10,000 development commits. Sounds like it might work, but no.  The
> problem here is that the kernel development history is non-linear
> in time.  See the git FAQ on why bisects can drag you back in time, i=
f
> you've never personally encountered this yourself.  A lot of people
> are surprised by this when they first encounter it.
>
> My approach was to adopt a semi-brute force approach.  During the dev
> cycle of any kernel, Linus merges the content from various subsystem
> maintainers.  Each of these merge points represents a point where
> you are guaranteed to not be "rewound in time", should you choose it
> as a bisect point.  Using git, these points can easily be identified.
>
> There happens to be ~400 of them, so the 10,000 development commits g=
et
> "digested" at an average rate of a humanly manageable number of about=
 25
> commits each -- something that a stupid person like me has a chance t=
o
> be able to diagnose/debug without going insane.  You will find that t=
here
> is an un-annotated tag for each of these merges in the patch reposito=
ry.
> You really should use these for bisecting your own problems/issues.
>
> On each of these, I've done a patch test, a compile test (x86, x86-64=
,
> ppc, arm) and a boot test (x86, x86-64, ppc-SMP) to ensure that I've =
not
> done a colossal screw-up.  I've probably still screwed *something* up=
,
> but at least I've ensured some level of continuing sanity with these =
tests
> being done across these integration points.
> --
> --
> To unsubscribe from this list: send the line "unsubscribe linux-rt-us=
ers"=20
> in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html=20

--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
