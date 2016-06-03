From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: v3.18-RT
Date: Fri, 3 Jun 2016 18:37:32 +0200
Message-ID: <20160603163732.GD4496@linutronix.de>
References: <FCC5AC80E299464B82E1345E2C10FC9D8098CE51@S1P5DAG4C.EXCHPROD.USA.NET>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
To: David Hauck <davidh@netacquire.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:52848 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752469AbcFCQhf (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 3 Jun 2016 12:37:35 -0400
Content-Disposition: inline
In-Reply-To: <FCC5AC80E299464B82E1345E2C10FC9D8098CE51@S1P5DAG4C.EXCHPROD.USA.NET>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

* David Hauck | 2016-05-31 18:42:08 [+0000]:

>Hi,
Hi,

>We've been working to integrate/support a new system board and have noticed boot-up stalls running 3.18.29-rt30 (in particular when the kernel is configured with PREEMPT_RT_FULL - as diagnostics markers, PREEMPT_RT_RTB and non-RT appear to be fine). The boot-up stalls appear fairly frequently - approximately once every 8-10 cold boots - and occur very early in the boot process. The SHB board houses dual Xeon E5-2680 v3 parts (i.e., 2x12 cores for a combined 24 cores).
>
>My question is regarding the v3.18 tip (currently v3.18.34) and whether an RT release for this version might be worthwhile to try. We'd consider moving to a v4 test branch, but ultimately we'd like to test a new v3.18 in order to determine impact in the field. I hesitate to ask this but am wondering if anyone might have some feedback on the time frame for an RT refresh on the v3.18 tip?

I am not aware of any lockup on v3.18-RT tree. I just tried a few boot
up on two of machines and it looks good. Don't have currently any
control on anything >4 cores.

>Thanks in advance,
>-David

Sebastian
