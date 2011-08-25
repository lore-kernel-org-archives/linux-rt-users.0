From: Frank Rowand <frank.rowand@am.sony.com>
Subject: Re: Linux RT patch works on single core - but not booting SMP ARM
 OMAP4 PandaBoard
Date: Wed, 24 Aug 2011 19:51:02 -0700
Message-ID: <4E55B896.30600@am.sony.com>
References: <CAFQPvXfMgXWHhRsBRbj_CAcymHbbB9UYjU+yM_L+Fp2cEGMbUg@mail.gmail.com> <CAFQPvXcAM4B2_JN7XbqkXdnf-vJ4G_1z2iobv9tCyfd6LQq_WA@mail.gmail.com> <CAFQPvXe2hgjsW=gYVi1VQx-EgC0fDesQLBc7vQxkc0XrCz6O7A@mail.gmail.com> <201108231737.42100.andrea.baldini@spesonline.com>
Reply-To: <frank.rowand@am.sony.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Sankara Muthukrishnan <sankara.m@gmail.com>,
	"Rowand, Frank" <Frank_Rowand@sonyusa.com>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: Andrea Baldini <andrea.baldini@spesonline.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from tx2ehsobe002.messaging.microsoft.com ([65.55.88.12]:46569 "EHLO
	TX2EHSOBE004.bigfish.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751108Ab1HYCv1 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 24 Aug 2011 22:51:27 -0400
In-Reply-To: <201108231737.42100.andrea.baldini@spesonline.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 08/23/11 08:37, Andrea Baldini wrote:

< snip >

>> The only other outstanding problem as of now is that the RT kernel
>> hanging during boot on panda board (boots sometimes after several
>> resets and/or power-cycles).
> 
> If i use the omap2plus_defconfig of the 3.0.1 kernel i can't get a bootable 
> kernel with RT full preemption.
> 
> If i apply the Frank config to the 3.0.1 source tree with RT-patch i get a 
> working kernel with full preemption and SMP.
> 
> Unless i'm very much mistaken the defconfig of the 3.0.0 which Frank config come 
> from is a little bit different from the 3.0.1 version and it gives some 
> problems when the RT-patch is applied.

Can you send me the config file that gives you a non-bootable kernel?

-Frank

