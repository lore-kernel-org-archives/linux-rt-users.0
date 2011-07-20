From: Geunsik Lim <leemgs1@gmail.com>
Subject: Re: [ANNOUNCE] 3.0-rc7-rt0
Date: Wed, 20 Jul 2011 18:48:52 +0900
Message-ID: <CABiHV1StrBWgXXfnTDwofJfrM3w_8qs-Bath=NJ902mfjnqPPA@mail.gmail.com>
References: <alpine.LFD.2.02.1107200153070.2702@ionos>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@elte.hu>, Carsten Emde <ce@ceag.ch>,
	Clark Williams <williams@redhat.com>,
	"Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
	Kumar Gala <galak@gate.crashing.org>,
	Ralf Baechle <ralf@linux-mips.org>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:38743 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751146Ab1GTJsx convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 20 Jul 2011 05:48:53 -0400
In-Reply-To: <alpine.LFD.2.02.1107200153070.2702@ionos>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Wow.. Its' good news for RT guys that are trying to research and develo=
p
soft-realtime system based on latest Linux version. :)
Thank you for a lot of efforts for Real-time Linux for a long time.

On Wed, Jul 20, 2011 at 9:37 AM, Thomas Gleixner <tglx@linutronix.de> w=
rote:
> Dear RT Folks,
>
> I'm pleased to announce the first drop of the 3.0-rc7 based RT
> patch.
>
> It's been quite a while since 2.6.33-rt, but I went through a very
> painful experience while trying to get a 2.6.38-rt stabilized. The
> beast insisted on destroying filesystems with reproduction times
> measured in days and the total refusal to reveal at least a
> minimalistic hint to debug the root cause. Staring into completely
> useless traces for months is not a very pleasant pastime.
>
> That's the very first problem in the RT history which I gave up on.
>
> [The truth: Linus avoiding the final 2.6.42 release made all my
> =C2=A0ultimate plans go down the drain ... ]
>
> Though while trying to analyse the problem I had plenty of time to
> twist my brain around the existing RT approach and its shortcomings.
>
> The main issue which RT is fighting with is the ever growing per cpu
> variable usage and the assumptions which are built around it. The
> existing RT approach to work around this with PER_CPU_LOCKED
> constructs and hand the CPU number around simply does not work anymor=
e
> because the number of sites which need to be patched is way too large
> and the resulting mess in the code is neither acceptable nor
> maintainable.
>
> After lenghty and fruitful discussions with Peter Zijlstra - thanks a
> lot Peter! - we finally agreed on trying a totally different approach
> to tackle these issues: disabling migration over spinlock and get_cpu
> sections. This had been discussed before, but nobody ever considered
> to sit down and make it work.
>
> This keeps the semantics which are expected by the per cpu users,
> while keeping the regions preemptible. As a side effect, it allows us
> to run softirq handlers directly from irq threads on local_bh_enable
> which was a long desired feature to lower the performance impact of
> RT.
>
> Changing this required a major refactoring of the RT patch queue,
> which took some time as I had to go through every single patch, fold
> fixes back into the right places and sort them into various categorie=
s:
>
> =C2=A0- Mainline ready (raw lock annotations, infrastructure patches,=
 code
> =C2=A0 restructuring...)
>
> =C2=A0- Preparatory (_rt()/_nort() variants of preempt_*(), local_irq=
_*(),
> =C2=A0 BUG*(), WARN*() and the annotations in various places)
>
> =C2=A0- Base patches (Reworking the slab/page_alloc code, bit_spinloc=
k
> =C2=A0 replacements, migrate disable infrastructure ...)
>
> =C2=A0- Full RT patches (sleeping spinlocks and the resulting fixups =
here
> =C2=A0 and there)
>
> In course of that exercise I weeded out a lot of historically grown
> hackery and dropped stuff which was not essential for getting it up
> and running. Thanks to Carsten for reintegrating the tracer addons
> which he's using for the OSADL test farm:
>
> =C2=A0https://www.osadl.org/?id=3D1042
>
> I probably have missed a few bits and pieces, but the overall outcome
> is stable and survived testing on various systems. The latency
> behaviour with cyclictest is on par with 33-rt at least on x86_64/32.
>
> The overall patch size has shrunk significantly and the readability
> (except for the missing changelogs in various patches) is at an
> acceptable level.
>
> If you download the quilt tarball, you'll find various sections:
>
> - upstream fixes: Stuff broken upstream which we managed to trip
> =C2=A0over. This section contains real weird stuff from simple fixes,=
 over
> =C2=A0mainline code which claims to contain (complete bogus) RT suppo=
rt up
> =C2=A0to an archaeologic bug in the floppy driver code.
>
> =C2=A08 patches (size 8892)
> =C2=A07 files changed, 59 insertions(+), 51 deletions(-)
>
> - upstream submitted: Stuff which is on LKML already and needs some
> =C2=A0follow up.
>
> =C2=A04 patches (size 9741)
> =C2=A04 files changed, 81 insertions(+), 119 deletions(-)
>
> - upstream ready: Stuff which needs a bit polishing and upstream
> =C2=A0submission
>
> =C2=A079 patches (size 232566)
> =C2=A0192 files changed, 1204 insertions(+), 1097 deletions(-)
>
> - upstream needs work: Stuff which should go upstream, but needs some
> =C2=A0or lots of care.
>
> =C2=A07 patches (size 164120)
> =C2=A049 files changed, 3292 insertions(+), 253 deletions(-)
>
> - the real rt stuff:
>
> =C2=A0125 patches (size 280665)
> =C2=A0162 files changed, 4327 insertions(+), 592 deletions(-)
>
> The overall patch is now:
> =C2=A0223 patches (size 680054)
> =C2=A0374 files changed, 8950 insertions(+), 2099 deletions(-)
>
> Compared that to 2.6.33-rt:
> =C2=A0462 patches (size 1396505)
> =C2=A0690 files changed, 15994 insertions(+), 5123 deletions(-)
>
> That's a significant reduction in size and impact. Some of it is due
> to the new approach, but we also got quite a lot of the infrastructur=
e
> patches upstream in the last few kernel releases. Thanks to all folks
> who have helped to get that done, especially to Peter Zijlstra for
> getting the preemptible mmu gather problem and lots of the scheduler
> issues which we discovered in RT over time sorted out!!!
>
> What's new in 3.0-rt ?
>
> =C2=A0- No more split soft interrupt threads. We need to analyze whet=
her
> =C2=A0 this is a good decision.
>
> =C2=A0- softirq handling from the end of interrupt threads and on all
> =C2=A0 thread sites where a nested local_bh disabled section ends
>
> =C2=A0- SPARSE interrupts and IOMMU interrupt remapping work now
>
> =C2=A0- Split config option CONFIG_PREEMPT_RT into CONFIG_PREEMPT_RT_=
BASE
> =C2=A0 and CONFIG_PREEMPT_RT_FULL. RT_BASE covers some of the more co=
mplex
> =C2=A0 changes (e.g. mm/* where we substitute interrupt disabled sect=
ions
> =C2=A0 with per cpu locks and the bit_spinlock to spinlock conversion=
).
> =C2=A0 RT_BASE allows us to test and verify these changes independent=
ly of
> =C2=A0 the big RT_FULL modifications. That's mainly a debugability an=
d
> =C2=A0 maintainability issue.
>
> What's the state:
>
> =C2=A0 We've done quite some testing on x86 32/64 bit and basic tests=
 on
> =C2=A0 some ARM/MIPS/POWERPC platforms. Thank God, no file system eat=
ing so
> =C2=A0 far :)
>
> =C2=A0 Given the fact that it is a major rewrite it's amazinlgy stabl=
e and
> =C2=A0 I consider it to be the best -rt1 release we ever had. That do=
esn't
> =C2=A0 mean that there are no bugs, since it has not had the proper t=
est
> =C2=A0 coverage yet.
>
> =C2=A0 Thanks to Carsten, Clark and Peter for all the help to get thi=
s far!
>
> Want to help?
>
> =C2=A0 Many people offered help in the past and I had to turn them do=
wn so
> =C2=A0 far as refactoring that stuff really is not a task which can b=
e
> =C2=A0 shared easily. Though now is the point where I can use all the=
 help
> =C2=A0 you promised to provide.
>
> =C2=A0 What's needed?
>
> =C2=A0 - Testing, testing, testing ... you know the drill (good bug
> =C2=A0 =C2=A0 reports are 98% of the solution)
>
> =C2=A0 - Compare and analyze the performance/troughput impact of the =
new
> =C2=A0 =C2=A0 approach with 33-rt
>
> =C2=A0 - Help mainlining the "upstream ready section"
>
> =C2=A0 =C2=A0 That means reviewing the patches, cleaning them up, fix=
ing the
> =C2=A0 =C2=A0 changelogs, submitting them through the proper channels=
 ...
>
> =C2=A0 =C2=A0 Please do not blindly pick any of these patches and sub=
mit them
> =C2=A0 =C2=A0 to mailing lists w/o doing the above. Also please coord=
inate on
> =C2=A0 =C2=A0 the #linux-rt IRC channel on oftc.net so redundant and
> =C2=A0 =C2=A0 conflicting work can be avoided
>
> =C2=A0 - Help getting the "upstream needs work" section into shape
>
> =C2=A0 =C2=A0 All of these patches need a close look and (especially =
the
> =C2=A0 =C2=A0 hwlatency detector) major cleanups. Please coordinate w=
ith the
> =C2=A0 =C2=A0 patch authors and lookout for previous discussions of s=
ome of
> =C2=A0 =C2=A0 those on LKML.
>
> =C2=A0 - Tend to the FIXME annotations in the RT stuff section
>
> =C2=A0 =C2=A0 I have annotated some places with /* FIXME ... comments=
=2E These
> =C2=A0 =C2=A0 sections are not for the faint hearted and need some se=
rious
> =C2=A0 =C2=A0 review and thought.
>
> =C2=A0 - Help with the RCU modifications
>
> =C2=A0 =C2=A0 That's an easy one. We have a volunteer signed up for t=
his
> =C2=A0 =C2=A0 involuntarily already. Thanks Paul!
>
> =C2=A0 - Twist your brain around the schedulability impact of the
> =C2=A0 =C2=A0 migrate_disable() approach.
>
> =C2=A0 =C2=A0 A really interesting research topic for our friends fro=
m the
> =C2=A0 =C2=A0 academic universe. Relevant and conclusive (even short =
notice)
> =C2=A0 =C2=A0 papers and/or talks on that topic have a reserved slot =
in the
> =C2=A0 =C2=A0 Kernel developers track at the Realtime Linux Workshop =
in Prague
> =C2=A0 =C2=A0 in October this year.
>
> Enough marketing, here comes the real stuff.
>
> =C2=A0Patch against 3.0-rc7 can be found here:
>
> =C2=A0 =C2=A0http://www.kernel.org/pub/linux/kernel/projects/rt/patch=
-3.0-rc7-rt0.patch.bz2
>
> =C2=A0The split quilt queue is available at:
>
> =C2=A0 =C2=A0http://www.kernel.org/pub/linux/kernel/projects/rt/patch=
es-3.0-rc7-rt0.tar.gz
>
> There is no git tree for now.
>
> I'm not yet convinced that moving RT to git was a good idea as quilt
> allows me to move stuff around in a way more flexible manner. So for
> now no git version until someone comes up with a brilliant idea which
> allows me to keep my workflow sane (do not even try to suggest stgit =
&
> co!).
In my opinion, many developers will want to use  -rt tree based on git
like previous -tip tree for rt patch. :)
=46or example, http://git.kernel.org/?p=3Dlinux/kernel/git/tip/linux-2.=
6-tip.git
>
> That said, have fun and make sure that you have the fire extinguisher
> ready when you start using this!
>
> Thanks,
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0tglx
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kerne=
l" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml
> Please read the FAQ at =C2=A0http://www.tux.org/lkml/
>



--=20
Regards,
Geunsik Lim ( Samsung Electronics )
Blog : http://blog.naver.com/invain/
e-Mail: geunsik.lim@samsung.com
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 leemgs@gmail.com , leemgs1@gma=
il.com
--
To unsubscribe from this list: send the line "unsubscribe linux-kernel"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at=C2=A0 http://vger.kernel.org/majordomo-info.html
Please read the FAQ at=C2=A0 http://www.tux.org/lkml/
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
