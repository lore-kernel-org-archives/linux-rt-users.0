From: Nathan Grennan <linux-rt-users@cygnusx-1.org>
Subject: Re: [ANNOUNCE] RT for v2.6.34.8 now available.
Date: Fri, 04 Mar 2011 19:05:50 -0800
Message-ID: <4D71A88E.2060608@cygnusx-1.org>
References: <4D71668F.9050201@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
	linux-kernel@vger.kernel.org
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from okcforum.org ([173.8.189.10]:34654 "EHLO mail.okcforum.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752049Ab1CEDFw (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 4 Mar 2011 22:05:52 -0500
In-Reply-To: <4D71668F.9050201@windriver.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 03/04/2011 02:24 PM, Paul Gortmaker wrote:
> As a value add to the 2.6.34 long term release, I'm happy to also
> announce the availability of 2.6.34-RT.
>
> You can find it in the v2.6.34-rt branch at:
>
>    git://git.kernel.org/pub/scm/linux/kernel/git/paulg/rt-patches.git
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

I tried compiling this, and it quickly failed. Ideas?

I did this on a Fedora 14 x86_64 system with gcc-4.5.1-4.fc14.x86_64.


Here is what I did:

1. Downloaded 2.6.34.8 tarball and extracted it
2. git clone -b v2.6.34-rt=20
git://git.kernel.org/pub/scm/linux/kernel/git/paulg/rt-patches.git
3. cat ../rt-patches/series | xargs -i cat ../rt-patches/{} | patch -p1=
=20
(Applied just fine)
4. Copied an 2.6.31-rt configuration to .config
5. Ran make oldconfig
6. make bzImage


CHK include/linux/version.h
CHK include/generated/utsrelease.h
HOSTCC scripts/basic/fixdep
HOSTCC scripts/basic/docproc
HOSTCC scripts/basic/hash
CC kernel/bounds.s
GEN include/generated/bounds.h
CC arch/x86/kernel/asm-offsets.s
GEN include/generated/asm-offsets.h
CALL scripts/checksyscalls.sh
HOSTCC scripts/genksyms/genksyms.o
HOSTCC scripts/genksyms/lex.o
HOSTCC scripts/genksyms/parse.o
HOSTLD scripts/genksyms/genksyms
CC scripts/mod/empty.o
HOSTCC scripts/mod/mk_elfconfig
MKELF scripts/mod/elfconfig.h
HOSTCC scripts/mod/file2alias.o
HOSTCC scripts/mod/modpost.o
HOSTCC scripts/mod/sumversion.o
HOSTLD scripts/mod/modpost
HOSTCC scripts/selinux/genheaders/genheaders
HOSTCC scripts/selinux/mdp/mdp
HOSTCC scripts/kallsyms
HOSTCC scripts/conmakehash
CC init/main.o
init/main.c: In function =91do_one_initcall=92:
init/main.c:740:10: warning: =91calltime.tv64=92 may be used uninitiali=
zed=20
in this function
CHK include/generated/compile.h
CC init/version.o
CC init/do_mounts.o
In file included from include/linux/suspend.h:8:0,
from init/do_mounts.c:6:
include/linux/mm.h: In function =91pte_lock_init=92:
include/linux/mm.h:1125:2: error: implicit declaration of function =91k=
malloc=92
include/linux/mm.h:1125:12: warning: assignment makes pointer from=20
integer without a cast
include/linux/mm.h: In function =91pte_lock_deinit=92:
include/linux/mm.h:1137:2: error: implicit declaration of function =91k=
free=92
In file included from include/linux/security.h:36:0,
from init/do_mounts.c:8:
include/linux/slab.h: At top level:
include/linux/slab.h:144:6: warning: conflicting types for =91kfree=92
include/linux/mm.h:1137:2: note: previous implicit declaration of=20
=91kfree=92 was here
In file included from include/linux/slab.h:172:0,
from include/linux/security.h:36,
from init/do_mounts.c:8:
include/linux/slab_def.h:128:52: error: conflicting types for =91kmallo=
c=92
include/linux/mm.h:1125:14: note: previous implicit declaration of=20
=91kmalloc=92 was here
make[1]: *** [init/do_mounts.o] Error 1
make: *** [init] Error 2
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
