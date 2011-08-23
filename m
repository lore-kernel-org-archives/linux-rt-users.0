From: Andrea Baldini <andrea.baldini@spesonline.com>
Subject: Re: Linux RT patch works on single core - but not booting SMP ARM OMAP4 PandaBoard
Date: Tue, 23 Aug 2011 17:37:41 +0200
Message-ID: <201108231737.42100.andrea.baldini@spesonline.com>
References: <CAFQPvXfMgXWHhRsBRbj_CAcymHbbB9UYjU+yM_L+Fp2cEGMbUg@mail.gmail.com> <CAFQPvXcAM4B2_JN7XbqkXdnf-vJ4G_1z2iobv9tCyfd6LQq_WA@mail.gmail.com> <CAFQPvXe2hgjsW=gYVi1VQx-EgC0fDesQLBc7vQxkc0XrCz6O7A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: frank.rowand@am.sony.com,
	"Rowand, Frank" <Frank_Rowand@sonyusa.com>,
	"linux-rt-users" <linux-rt-users@vger.kernel.org>
To: Sankara Muthukrishnan <sankara.m@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from linuxhost2.fastnet.it ([195.96.193.27]:48100 "EHLO
	linuxhost2.fastnet.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751959Ab1HWQCM (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 23 Aug 2011 12:02:12 -0400
In-Reply-To: <CAFQPvXe2hgjsW=gYVi1VQx-EgC0fDesQLBc7vQxkc0XrCz6O7A@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

In data Wednesday 17 August 2011 21:10:47, Sankara Muthukrishnan ha scritto:
> On Wed, Aug 17, 2011 at 11:54 AM, Sankara Muthukrishnan
> 
> <sankara.m@gmail.com> wrote:
> > The cyclic test results are not acceptable (attached the output of
> > cyclictest). I am seeing maximum latency of 757 us on core-0 and 1905
> > us on core-1. Are you (Is anyone) seeing better results on latency
> > with SMP kernel with RT patch on ARM (OMAP4 processors)? I have seen
> > ~25 us of latency with single core kernel (though I have used a
> > different kernel configuration).
> 
> Never ever mind and sorry for the confusion. I did not realize that
> "Kernel debugging" was enabled in the config Frank had attached. With
> kernel debugging disabled, I see max latencies less than 20 us on both
> cores on panda board with cyclictest (cyclictest -l1000000 -m -Sp99
> -i200 -h60 -q -n) in my quick run and it is exciting to see these
> numbers. Thanks Frank.
> 
> The only other outstanding problem as of now is that the RT kernel
> hanging during boot on panda board (boots sometimes after several
> resets and/or power-cycles).

If i use the omap2plus_defconfig of the 3.0.1 kernel i can't get a bootable 
kernel with RT full preemption.

If i apply the Frank config to the 3.0.1 source tree with RT-patch i get a 
working kernel with full preemption and SMP.

Unless i'm very much mistaken the defconfig of the 3.0.0 which Frank config come 
from is a little bit different from the 3.0.1 version and it gives some 
problems when the RT-patch is applied.

I tried to perform a cyclictest too but i get a segmentation fault when the 
test is executing with SMP testing option enabled.
Did anyone get the same problem?

Andrea

-- 
Andrea Baldini

Elettronica di Processo

 

SPES. S.c.p.a
Via  Lamberto Corsi, 43
60044 Fabriano (AN)
tel. +39 0732 25291
fax +39 0732 2529441

 <mailto:andrea.baldini@spesonline.com> andrea.baldini@spesonline.com

 <http://www.spesonline.com> www.spesonline.com
