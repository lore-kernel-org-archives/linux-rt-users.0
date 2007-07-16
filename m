From: Arjan van de Ven <arjan@infradead.org>
Subject: Re: [Question] Hooks for scheduler tracing (CFS)
Date: Mon, 16 Jul 2007 12:52:37 -0700
Message-ID: <1184615557.2698.3.camel@laptopd505.fenrus.org>
References: <3efb10970707161246se06ab22i32872cfe6fa4f2f6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: LKML <linux-kernel@vger.kernel.org>,
	RT-Users <linux-rt-users@vger.kernel.org>,
	mathieu.desnoyers@polymtl.ca, Ingo Molnar <mingo@elte.hu>
To: linux@bohmer.net
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from pentafluge.infradead.org ([213.146.154.40]:37210 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758288AbXGPTxT (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 16 Jul 2007 15:53:19 -0400
In-Reply-To: <3efb10970707161246se06ab22i32872cfe6fa4f2f6@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Mon, 2007-07-16 at 21:46 +0200, Remy Bohmer wrote:
> So I was wondering if anybody knows some tool/kernel mechanism which
> can do this?
> If not, I will build a kernel extension for it myself (new extension
> to 'latency_trace' ?)

systemtap has been able to do such things for me in the past...

-- 
if you want to mail me at work (you don't), use arjan (at)
linux.intel.com
Test the interaction between Linux and your BIOS via
http://www.linuxfirmwarekit.org
