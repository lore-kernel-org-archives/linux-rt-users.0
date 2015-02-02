From: Will Deacon <will.deacon@arm.com>
Subject: Re: __HAVE_ARCH_CMPXCHG on ARM?
Date: Mon, 2 Feb 2015 13:39:33 +0000
Message-ID: <20150202133933.GD31847@arm.com>
References: <20150129185618.GA31459@nathan3500-linux-VM>
 <CAM2zO=CVCZFNiSukgcgNNT0==xgLK4w5HF3Pz=dcFmrEHPtLdw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nathan Sullivan <nathan.sullivan@ni.com>,
	Yong Zhang <yong.zhang@windriver.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: Yong Zhang <yong.zhang0@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from foss-mx-na.foss.arm.com ([217.140.108.86]:40579 "EHLO
	foss-mx-na.foss.arm.com" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1755516AbbBBNjl (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 2 Feb 2015 08:39:41 -0500
Content-Disposition: inline
In-Reply-To: <CAM2zO=CVCZFNiSukgcgNNT0==xgLK4w5HF3Pz=dcFmrEHPtLdw@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Fri, Jan 30, 2015 at 08:44:48AM +0000, Yong Zhang wrote:
> On Fri, Jan 30, 2015 at 2:56 AM, Nathan Sullivan <nathan.sullivan@ni.com<mailto:nathan.sullivan@ni.com>> wrote:
> 
> While investigating a performance issue on RT 3.14, I noticed that
> __HAVE_ARCH_CMPXCHG is not defined for ARM.  This causes -rt locks to
> always use the slow path and impacts performance.  ARMv6 and above
> have a cmpxchg implementation already that will work just fine.
> 
> In 2012, Yong Zhang submitted a patch to fix this[1], but it mysteriously
> disappeared afterwards.  I did notice that the s-o-b line has a different
> email address than the windriver one.  Yong, do you mind re-submitting the
> 
> It actually doesn't matter. Anyway feel free to add another s-o-b to
> the patch:
> 
> Signed-off-by: Yong Zhang <yong.zhang@windriver.com<mailto:yong.zhang@windriver.com>>

[...]

> diff --git a/arch/arm/include/asm/cmpxchg.h b/arch/arm/include/asm/cmpxchg.h
> index 7eb18c1..a91b44e 100644
> --- a/arch/arm/include/asm/cmpxchg.h
> +++ b/arch/arm/include/asm/cmpxchg.h
> @@ -127,6 +127,8 @@ static inline unsigned long __xchg(unsigned long x, volatile void *ptr, int size
> 
>  #else  /* min ARCH >= ARMv6 */
> 
> +#define __HAVE_ARCH_CMPXCHG 1

Is it even possible to have CONFIG_SMP=y on an architecture that doesn't
support native cmpxchg? Certainly, the asm-generic cmpxchg.h barfs if
SMP, so couldn't we just change/extend the __HAVE_ARCH_CMPXCHG check in
rtmutex.c to work automatically with SMP architectures? That would help
arm64 too.

Will
