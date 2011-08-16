From: Frank Rowand <frank.rowand@am.sony.com>
Subject: Re: Linux RT patch works on single core - but not booting SMP ARM
 OMAP4 PandaBoard
Date: Tue, 16 Aug 2011 13:03:57 -0700
Message-ID: <4E4ACD2D.80802@am.sony.com>
References: <CAFQPvXfMgXWHhRsBRbj_CAcymHbbB9UYjU+yM_L+Fp2cEGMbUg@mail.gmail.com> <CAFQPvXfAhvw+TGmHC910ObkAmt2ZE_QsyGxWWAByzvVYf3+R+g@mail.gmail.com> <4E4AB90E.10805@am.sony.com>
Reply-To: <frank.rowand@am.sony.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Sankara Muthukrishnan <sankara.m@gmail.com>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: "Rowand, Frank" <Frank_Rowand@sonyusa.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from tx2ehsobe003.messaging.microsoft.com ([65.55.88.13]:41497 "EHLO
	TX2EHSOBE006.bigfish.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752810Ab1HPUET (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 16 Aug 2011 16:04:19 -0400
In-Reply-To: <4E4AB90E.10805@am.sony.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 08/16/11 11:38, Frank Rowand wrote:
> On 08/16/11 10:06, Sankara Muthukrishnan wrote:
>> Hello everyone,
>>

< snip >

> 
> SMP Panda is booting fine for me on a slightly older version: 3.0.0-rt6
> 
> gcc 4.3.3
> 
> Config is attached.
> 
> I used make omap2plus_defconfig then tweaked a few items:

< snip >

And 3.0.1-rt11 also boots SMP CONFIG_PREEMPT_RT_FULL on panda board for
me, with the same recipe I gave for 3.0.0-rt6.

-Frank

