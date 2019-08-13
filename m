Return-Path: <SRS0=IBCX=WJ=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B423C433FF
	for <linux-rt-users@archiver.kernel.org>; Tue, 13 Aug 2019 09:53:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EACBE20665
	for <linux-rt-users@archiver.kernel.org>; Tue, 13 Aug 2019 09:53:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727984AbfHMJxI (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 13 Aug 2019 05:53:08 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33669 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727615AbfHMJxI (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 13 Aug 2019 05:53:08 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1hxTUI-0001OL-8C; Tue, 13 Aug 2019 11:53:06 +0200
Date:   Tue, 13 Aug 2019 11:53:06 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Paul Thomas <pthomas8589@gmail.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        dunc.mcphie@gmail.com, Anders Roxell <anders.roxell@linaro.org>
Subject: Re: poor cyclictest results with 5.0 series rt for arm64
Message-ID: <20190813095306.xqgq3uusdpj7dhy7@linutronix.de>
References: <CAD56B7fdr5w0Pk5WHVWXa1ORyM=i+Ew66O+8buBwH0geeX+X0Q@mail.gmail.com>
 <alpine.DEB.2.21.1907162221350.1767@nanos.tec.linutronix.de>
 <CAD56B7eF_KhWvg=m6iy5YSJF-81v-zcmX7+8Kd0wGMrALHwU1A@mail.gmail.com>
 <alpine.DEB.2.21.1907170111160.1767@nanos.tec.linutronix.de>
 <CAD56B7eswTRxbeA8foXyVVZ7Bd+_y40dtOLkHxuAf4kVge7VDg@mail.gmail.com>
 <alpine.DEB.2.21.1907171001150.1767@nanos.tec.linutronix.de>
 <alpine.DEB.2.21.1907171009280.1767@nanos.tec.linutronix.de>
 <alpine.DEB.2.21.1907171101150.1767@nanos.tec.linutronix.de>
 <alpine.DEB.2.21.1907171220400.1767@nanos.tec.linutronix.de>
 <CAD56B7eomeb5Lr2juFWtZmtqSx3SkPijW03QZz8xv39He26PrA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAD56B7eomeb5Lr2juFWtZmtqSx3SkPijW03QZz8xv39He26PrA@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2019-07-17 18:28:51 [-0400], Paul Thomas wrote:
> On Wed, Jul 17, 2019 at 6:21 AM Thomas Gleixner <tglx@linutronix.de> wrote:
> >
> > On Wed, 17 Jul 2019, Thomas Gleixner wrote:
> > > On Wed, 17 Jul 2019, Thomas Gleixner wrote:
> > >
> > > The one below should fix it for real.
> >
> > That still has an issue which needs deeper investigation. Just keep the
> > offending patch reverted for now.
> 
> OK, sounds good.

could you please try the following hunk?

diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index 6808cd9526c67..63c6960262861 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -648,7 +648,8 @@ alternative_if ARM64_HAS_IRQ_PRIO_MASKING
 	orr	x24, x24, x0
 alternative_else_nop_endif
 
-	cbnz	x24, 2f					// preempt count != 0
+	cbz	x24, 1f					// (need_resched + count) == 0
+	cbnz	w24, 2f					// count != 0
 
 	ldr	w24, [tsk, #TSK_TI_PREEMPT_LAZY]	// get preempt lazy count
 	cbnz	w24, 2f					// preempt lazy count != 0

> -Paul

Sebastian
