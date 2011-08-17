From: Frank Rowand <frank.rowand@am.sony.com>
Subject: Re: Linux RT patch works on single core - but not booting SMP ARM
 OMAP4 PandaBoard
Date: Wed, 17 Aug 2011 12:46:07 -0700
Message-ID: <4E4C1A7F.4080106@am.sony.com>
References: <CAFQPvXfMgXWHhRsBRbj_CAcymHbbB9UYjU+yM_L+Fp2cEGMbUg@mail.gmail.com>	<CAFQPvXfAhvw+TGmHC910ObkAmt2ZE_QsyGxWWAByzvVYf3+R+g@mail.gmail.com>	<4E4AB90E.10805@am.sony.com>	<4E4ACD2D.80802@am.sony.com> <CAFQPvXcAM4B2_JN7XbqkXdnf-vJ4G_1z2iobv9tCyfd6LQq_WA@mail.gmail.com>
Reply-To: <frank.rowand@am.sony.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Cc: "Rowand, Frank" <Frank_Rowand@sonyusa.com>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: Sankara Muthukrishnan <sankara.m@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ch1ehsobe002.messaging.microsoft.com ([216.32.181.182]:38253
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752974Ab1HQTqg (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 17 Aug 2011 15:46:36 -0400
In-Reply-To: <CAFQPvXcAM4B2_JN7XbqkXdnf-vJ4G_1z2iobv9tCyfd6LQq_WA@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 08/17/11 09:54, Sankara Muthukrishnan wrote:

< snip >

> posted in this thread and the SMP kernel is booting fine now. I have
> applied the following high-resolution timer patch that is posted in
> the OMAP mailing list:
> 
> ************ PATCH START **************

Thanks for the pointer to the patch!

< snip >

> The cyclic test results are not acceptable (attached the output of
> cyclictest). I am seeing maximum latency of 757 us on core-0 and 1905
> us on core-1. Are you (Is anyone) seeing better results on latency
> with SMP kernel with RT patch on ARM (OMAP4 processors)? I have seen
> ~25 us of latency with single core kernel (though I have used a
> different kernel configuration).

I haven't done any performance testing yet.

> 
> PS: The kernels that I build especially with RT patch don't boot the
> first time on the panda board. Sometimes, it takes 2 or 3 resets and
> sometimes 10 to 15 times. When it hangs, it always hangs right after
> "Uncompressing Linux... done, booting the kernel." It looks like it is
> probably due to some race conditions in kernel during initial boot. I
> am hoping it is not a hardware issue. Has anyone else been
> experiencing flakiness and early hangs on panda board?

The panda has been booting consistently for me.

But I'm having problems getting SMP to boot on other ARM boards (a
silent fail, like your panda).  My realview SMP fails with plain
3.0.0 (I have not tried with the RT patches added).  I ported support
for the NaviEngine (out of tree, yuchh) forward, and am debugging
SMP boot failure on that now.  I don't know if the problem is due
to my quick and dirty porting method, or something else.

-Frank

