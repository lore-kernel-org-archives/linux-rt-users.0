From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [patch 2/3] cyclictest: Convert the offset of the alignment
 option to microseconds
Date: Tue, 2 Jun 2015 23:33:49 +0200 (CEST)
Message-ID: <alpine.DEB.2.11.1506022332290.20347@nanos>
References: <20150526190333.510838769@glx-um.de> <20150526190443.640221319@glx-um.de> <alpine.LFD.2.10.1505272324180.13094@riemann> <47e6a4612898bdcbcf3073f27ab93708@tglx.de> <alpine.LFD.2.10.1506021458180.13306@riemann> <alpine.DEB.2.11.1506022247320.20347@nanos>
 <alpine.LFD.2.10.1506022307210.13306@riemann>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Anna-Maria Gleixner <anna-maria@glx-um.de>,
	linux-rt-users@vger.kernel.org,
	Clark Williams <williams@redhat.com>
To: John Kacur <jkacur@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:53260 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751570AbbFBVdr (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 2 Jun 2015 17:33:47 -0400
In-Reply-To: <alpine.LFD.2.10.1506022307210.13306@riemann>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Tue, 2 Jun 2015, John Kacur wrote:
> Yeah, my guess as to why her patches are failing was wrong, but they are 
> failing. Maybe it's a wordwrap problem. When I try with patch -p1 < 
> annas-patch, I get this.
> 
>  patch -p1 < ~/patches/anna/align_measurement_threads.patch 
> patching file src/cyclictest/cyclictest.c
> Hunk #1 FAILED at 185.
> patch: **** malformed patch at line 64: par->prio);

Fair enough. Let her resend then.

Thanks,

	tglx
