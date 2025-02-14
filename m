Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E192D15573F
	for <linux-rt-users@vger.kernel.org>; Fri, 14 Feb 2025 07:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739518498; cv=none; b=KNbzEP3udaR2Bua61zoZKS2cjblr5/AJsEtW7XbyViQgNJEWC/OzQsMRm0ZgbHBcc3sYI8HUICDGsBmkhSCVqJW4YhUtBX3Ib2S67cu51tRNhXgzAXHIBtzeMYhwqNhmm7VBkQl+sHcF5ACI0jfn64JUPlsQCZwM8662HM4O1+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739518498; c=relaxed/simple;
	bh=qJ6GkLJAaAU7BOaPYa+qUi+qYYDmplgaSVZXD6lV26U=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QLrWlcxtowZr6p+Cu2BZDYul447HJcCDY9quw8gNm9bve0NYj/msWZFeY792OW5GrAAAO+CPlS/psVOzVXlBq4d/HVwdzqtqpkXaePBr3O/yEvtj9a6fZw6Cmo2ieBsnevCpwReHv+kbEbGpht1HZVWWJS+jNA8uSv0W6i/xgsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=efault@gmx.de header.b=PQNHL85W; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=efault@gmx.de header.b="PQNHL85W"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1739518492; x=1740123292; i=efault@gmx.de;
	bh=2TRRHwRk7bDsfCMTOwlHJtrLYmje5Po+Bx2HNExk+U8=;
	h=X-UI-Sender-Class:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Content-Type:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=PQNHL85WkxvFC+vQg7NN8Qq66Rr/ghv+nQd/0ITZf67grZO0P4CEpvB5tg14c1HY
	 uwCSOo1ay7khZU2Wj67rAJGhuqXMOdW5R+JqWh05BIe/O9Ed7hl4FKbvTenumLDEA
	 GBFBEgfu0xEau9JUy/v0HRh5YMUFT0dylB0Yk+3+IOAzjU4CDPB4vn+G/axyl2gjW
	 AfiIoa5vXXdW4DZBl9AkAZFmybVqM1KQmugXAs+WRcoM/kPpl75DJOglz3ozzdG6K
	 V1VxyeCRyVGUz8CYixOIqJd5RSBAUGykVOXUuMT9SccU2l6ouW/hghMq8vmA1x+xE
	 7B6F1k1wGHmvePdoSg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from homer.fritz.box ([91.212.106.158]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MRTRN-1u3w0P155J-00Vh8h; Fri, 14
 Feb 2025 08:34:52 +0100
Message-ID: <a198a7dd9076f97b89d8882bb249b3bf303564ef.camel@gmx.de>
Subject: Re: Lazy preemption on arm64
From: Mike Galbraith <efault@gmx.de>
To: Mark Rutland <mark.rutland@arm.com>, Sebastian Andrzej Siewior
	 <bigeasy@linutronix.de>
Cc: Petr Tesarik <ptesarik@suse.com>, linux-rt-users@vger.kernel.org
Date: Fri, 14 Feb 2025 08:34:51 +0100
In-Reply-To: <Z2FtNgp_OVIy0D36@J2N7QTR9R3>
References: <20241216190451.1c61977c@mordecai.tesarici.cz>
	 <Z2B5y3HiLuRHPfdv@J2N7QTR9R3.cambridge.arm.com>
	 <20241217073151.5aa2352a@mordecai.tesarici.cz>
	 <20241217085031.Wh45Bd2r@linutronix.de> <Z2Fh09GyYx09Mx1_@J2N7QTR9R3>
	 <20241217115931.wjw_HO2V@linutronix.de> <Z2FtNgp_OVIy0D36@J2N7QTR9R3>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:w5zf5U1gb8CTdOPP2NfIgzkVNDVFO78qoCSCpMPMFF7E1C5rnps
 ofArFMQUSv+Cl4lsYFB0pebPeZkPUk+kxmk80AC1Ez65nBGJBuHThUOddoSuZ4EtOKvHZ4R
 uGGe6apf0IgrQiDEel2ki1/oLaiXv4Amo+yo74Fo5QyynQhbXeFSa9/DMLUAqgXwd58nPow
 USlHAsBVBj1ySzFdXArVg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:vy1P6NkoJ9I=;nVuAJUkyo5ZRNyChDbWj0LI9GpK
 4i6RNbs88ysj0nFOg7OwSJtk0yBJ+EO3k9d232KzZRdaFFp2zi7051b8XzzZW6xU74b+Y2h7w
 kHRwc16Q8+NWid67chnmSLreC75U+R9NhKRfUEFBR/GCNq2tMZuEvFlDgJiqccIEUV/7Y61MB
 pqggYC1cg6IO8BQ2Zadl4ml/tgjAGZpr3J2mErgCP7O17rXw79aCGaV0ORB9jWHCY1QWYPeym
 3zuc36tsYsdbIv17Ur8IzhsRuto8ZfGSlmS8ozqPnptrreNu+5hbZ7GQ4adUmxHfSENDfktXb
 XxhHvDhPVzDQKghWZPE9voaNNkYbPzblXTts9ta+6oz5dGranp9Umb3vJs71JXicakiWwc+I9
 HGEW+JnJdFEoeP7MFs4qwuwwwywQDqJ2a+oo6Xa/BWF8osfxaeBlSbKoEctdLyE6BquFDLO60
 3C1lAoAWdXquCjYIsfwfWW50TY/+DbETJYm1PXbL4XaJlA5nONO8nlJMWW4PeTc17JzcKKUz1
 CSvrSRGgYqQ7DZfz5MyM6iBscM/elx3UDxqXiZrqDcTzHz5tE43sAWP3CJYqrc8PUDfOw7/Ux
 9JgAhHsHOVmUt/f5fjU2+sVDjogXAeYftMNWpksto6E+zr2R6g5y9g/kMrVfkFg1sRDt4sHWr
 lCe63KLjGyezd8lpC+oItphui1Ij1kzwNNFn2+IDIicfnbk/4GRHqAPPkNJorOeArzX4gTTpx
 SS+dqsOz1tIvyDGJyQeXQIFV4VowkI/alV0FKE2Gl/3B3D60fBaWvXUWMgdTJOIgqVe5JFyFu
 CiZ3GQzauvYmaDghBxnzR7IxpCtWBXpaNBkRSPPL+KBHSoMTCkfu7CW3g1jZ2xY8W8Ny7ABPN
 jyPjHlcJmMCLMMazvT+rMPxGGJ6LuRM8skhlLclO5sN9UW7klxQn5O9ZGBqRah1HBOADr9sGk
 vMYR4sJ6PW4lrIdSIgop/YibFlLD13I0WPF4E6WAffOI2PUpHLXrkbBaspU69JMcTCYw2rn7E
 t5SUD4KaumXTpmbG0WYubNH3s44twdlmVTofm9CofHbELcrgb5G0DOkJKLZ54HvFFQ3nUh5fP
 uCIhdApEihTvGMo0SFJvAlWvbheOEWKCEYLODLKfQ4IoDjPuA1xrxrYIgncC9hi5/8h4qfzMp
 6pwH4rv4kJpNCX4Nv/c6IjUgHy7KEvfRq3Wh3PTFxGBEbK1drn48J1Ac3iy63dg482aU2yX/W
 2SM8JmAa+yVZTS9mcg4nNEqoc0v+u5JCbXy+FT3HDofbcehwb+Adq/Nynjp978ni8booV8fjj
 c7cSNvj97duDYa4SIy0n1qKbMcANWG01bnAlcu9KgPDiqFcx1ovFp6tm9lcZn8gMJe67BWAWY
 r51Uqt9+hUAXa+D/UvCSAJUbsUisXAkXPmvBu3h4F/qTh2LK6/lwogNZejlTdbrzTnAuZRPHD
 KsmuLnA==

Greetings,

On Tue, 2024-12-17 at 12:23 +0000, Mark Rutland wrote:
> On Tue, Dec 17, 2024 at 12:59:31PM +0100, Sebastian Andrzej Siewior wrot=
e:
> > On 2024-12-17 11:34:43 [+0000], Mark Rutland wrote:
> > > On Tue, Dec 17, 2024 at 09:50:31AM +0100, Sebastian Andrzej Siewior =
wrote:
> > > > This bits below are actually the same ones I made last week. I sto=
pped
> > > > there because it was late and I didn't find GENERIC_ENTRY nor a
> > > > TIF_NEED_RESCHED check in arm64 so I paused. Where is this?
> > >
> > > Currently arm64 doesn't use GENERIC_ENTRY; people are working on tha=
t
> > > (see the link above), but it's likely to take a short while. IIUC
> > > there's no strict dependency on GENERIC_ENTRY here, unless I'm missi=
ng
> > > something?
> >
> > No, not really, that is perfect.
> >
> > > For TIF_NEED_RESCHED, arm64 relies upon the core code to call
> > > set_preempt_need_resched() (e.g. via preempt_fold_need_resched()) to
> > > fold that into thread_info::preempt::need_resched. That's checked by
> > > arm64_preempt_schedule_irq(), which reads thread_info::preempt_count=
,
> > > which is unioned with thread_info::preempt::{count,need_resched} suc=
h
> > > that the two fields can be checked together.
> >
> > All sounds fine. Now, if that bit is set, we need schedule() before
> > returning to userland. I didn't it initially but now I did:
> >
> > diff --git a/arch/arm64/kernel/entry-common.c b/arch/arm64/kernel/entr=
y-common.c
> > index b260ddc4d3e9a..2e2f13ce076da 100644
> > --- a/arch/arm64/kernel/entry-common.c
> > +++ b/arch/arm64/kernel/entry-common.c
> > @@ -132,7 +132,7 @@ static void do_notify_resume(struct pt_regs *regs,=
 unsigned long thread_flags)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0do {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0local_irq_enable();
> > =C2=A0
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0if (thread_flags & _TIF_NEED_RESCHED)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0if (thread_flags & _TIF_NEED_RESCHED | _TIF_NEED_RESC=
HED_LAZY)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0schedule();
> > =C2=A0
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0if (thread_flags & _TIF_UPROBE)
> >
> > With that piece we should be fine.
>
> Yep, I had that in my HACK patch:
>
> =C2=A0 https://lore.kernel.org/linux-rt-users/20241217115931.wjw_HO2V@li=
nutronix.de/T/#m12eece66786a3a207e4e952bdf58570ab75c6a89

Posting this for mainline inclusion was suggested, but I don't see
waiting for GENERIC_ENTRY as having any meaningful impact for the
general case, everyone's used to whatever preemption model they've been
using.  OTOH, not having PREEMPT_LAZY for RT users has been having at
least some impact, which your patch can alleviate, so I'll post the
fixed up and lightly tested version here... including something
resembling a changelog in case anyone disagrees about submission, but
is too lazy to write the way better one they most definitely should :)

=46rom 16ae3c84d8e1691fe670dbfb4c643cab4fa2065f Mon Sep 17 00:00:00 2001
From: Mark Rutland <mark.rutland@arm.com>
Date: Mon, 16 Dec 2024 18:32:44 +0000
Subject: [PATCH] HACK: arm64: enable PREEMPT_LAZY

GENERIC_ENTRY is not yet implemented for arm64, but is in the pipe.
Meanwhile, the below can serve to bridge the gap, particularly for
those building/running PREEMPT_RT kernels, where lazy preemption
markedly improves SCHED_OTHER load component throughput.

Mike: testdrive, _TIF_WORK_MASK fixlet and changelog.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Mike Galbraith <efault@gmx.de>
=2D--
 arch/arm64/Kconfig                   |    1 +
 arch/arm64/include/asm/thread_info.h |   16 +++++++++-------
 arch/arm64/kernel/entry-common.c     |    2 +-
 3 files changed, 11 insertions(+), 8 deletions(-)

=2D-- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -39,6 +39,7 @@ config ARM64
 	select ARCH_HAS_NMI_SAFE_THIS_CPU_OPS
 	select ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE
 	select ARCH_HAS_NONLEAF_PMD_YOUNG if ARM64_HAFT
+	select ARCH_HAS_PREEMPT_LAZY
 	select ARCH_HAS_PTE_DEVMAP
 	select ARCH_HAS_PTE_SPECIAL
 	select ARCH_HAS_HW_PTE_YOUNG
=2D-- a/arch/arm64/include/asm/thread_info.h
+++ b/arch/arm64/include/asm/thread_info.h
@@ -59,11 +59,12 @@ void arch_setup_new_exec(void);

 #define TIF_SIGPENDING		0	/* signal pending */
 #define TIF_NEED_RESCHED	1	/* rescheduling necessary */
-#define TIF_NOTIFY_RESUME	2	/* callback before returning to user */
-#define TIF_FOREIGN_FPSTATE	3	/* CPU's FP state is not current's */
-#define TIF_UPROBE		4	/* uprobe breakpoint or singlestep */
-#define TIF_MTE_ASYNC_FAULT	5	/* MTE Asynchronous Tag Check Fault */
-#define TIF_NOTIFY_SIGNAL	6	/* signal notifications exist */
+#define TIF_NEED_RESCHED_LAZY	2	/* Lazy rescheduling needed */
+#define TIF_NOTIFY_RESUME	3	/* callback before returning to user */
+#define TIF_FOREIGN_FPSTATE	4	/* CPU's FP state is not current's */
+#define TIF_UPROBE		5	/* uprobe breakpoint or singlestep */
+#define TIF_MTE_ASYNC_FAULT	6	/* MTE Asynchronous Tag Check Fault */
+#define TIF_NOTIFY_SIGNAL	7	/* signal notifications exist */
 #define TIF_SYSCALL_TRACE	8	/* syscall trace active */
 #define TIF_SYSCALL_AUDIT	9	/* syscall auditing */
 #define TIF_SYSCALL_TRACEPOINT	10	/* syscall tracepoint for ftrace */
@@ -85,6 +86,7 @@ void arch_setup_new_exec(void);

 #define _TIF_SIGPENDING		(1 << TIF_SIGPENDING)
 #define _TIF_NEED_RESCHED	(1 << TIF_NEED_RESCHED)
+#define _TIF_NEED_RESCHED_LAZY	(1 << TIF_NEED_RESCHED_LAZY)
 #define _TIF_NOTIFY_RESUME	(1 << TIF_NOTIFY_RESUME)
 #define _TIF_FOREIGN_FPSTATE	(1 << TIF_FOREIGN_FPSTATE)
 #define _TIF_SYSCALL_TRACE	(1 << TIF_SYSCALL_TRACE)
@@ -100,10 +102,10 @@ void arch_setup_new_exec(void);
 #define _TIF_NOTIFY_SIGNAL	(1 << TIF_NOTIFY_SIGNAL)
 #define _TIF_TSC_SIGSEGV	(1 << TIF_TSC_SIGSEGV)

-#define _TIF_WORK_MASK		(_TIF_NEED_RESCHED | _TIF_SIGPENDING | \
+#define _TIF_WORK_MASK		(_TIF_NEED_RESCHED | _TIF_NEED_RESCHED_LAZY | \
 				 _TIF_NOTIFY_RESUME | _TIF_FOREIGN_FPSTATE | \
 				 _TIF_UPROBE | _TIF_MTE_ASYNC_FAULT | \
-				 _TIF_NOTIFY_SIGNAL)
+				 _TIF_NOTIFY_SIGNAL | _TIF_SIGPENDING)

 #define _TIF_SYSCALL_WORK	(_TIF_SYSCALL_TRACE | _TIF_SYSCALL_AUDIT | \
 				 _TIF_SYSCALL_TRACEPOINT | _TIF_SECCOMP | \
=2D-- a/arch/arm64/kernel/entry-common.c
+++ b/arch/arm64/kernel/entry-common.c
@@ -132,7 +132,7 @@ static void do_notify_resume(struct pt_r
 	do {
 		local_irq_enable();

-		if (thread_flags & _TIF_NEED_RESCHED)
+		if (thread_flags & (_TIF_NEED_RESCHED | _TIF_NEED_RESCHED_LAZY))
 			schedule();

 		if (thread_flags & _TIF_UPROBE)

