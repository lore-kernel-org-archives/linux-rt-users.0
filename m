From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: arm and ppc plattforms
Date: Fri, 20 Apr 2007 18:02:30 +0200
Message-ID: <4628E416.7050003@grandegger.com>
References: <1177066595.5648.33.camel@localhost.localdomain> <20070420110819.GN9554@pengutronix.de> <f87351060704200423n45dc5b66h73a399a4df1bfd68@mail.gmail.com> <20070420113411.GO9554@pengutronix.de> <4628C75F.1080407@dutchspace.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org
To: Johan Borkhuis <j.borkhuis@dutchspace.nl>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.9]:52938 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2993261AbXDTP7m (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 20 Apr 2007 11:59:42 -0400
In-Reply-To: <4628C75F.1080407@dutchspace.nl>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Johan Borkhuis wrote:
> Robert Schwebel wrote:
>> You'll probably have no luck with ARCH=ppc, our port runs with
>> ARCH=powerpc (and still has some crude hacks inside).   
> I am in the same situation: I have a board (MVME3100, PPC8540) that uses 
> the ARCH=ppc, but I have some strict realtime requirements. As far as I 
> understand from the discussions on this list (and on other places) the 
> ARCH=ppc will be dropped in favor of ARCH=powerpc, and the -rt patch 
> will not support the ppc-architecture.

Not dropped but almost frozen. Already today there is little interest in 
maintaining the ppc tree. And for real-time preemption and the 
high-resolution timers the generic IRQ and timer layer seems now 
mandatory, which is not available for ppc. What is mainly missing for 
PowerPC is the support of clock events to get the high-resolution timers 
working.
Pengutronix has a temporary solution for that. See Robert's mail:

http://www.mail-archive.com/linux-rt-users@vger.kernel.org/msg00343.html

> But before I start working on the powerpc-version of the BSP I would 
> like to know how stable the patch runs on powerpc (and specifically on 
> ppc85xx), and how good the realtime performance of the patch is on 
> powerpc. Are there any (recent) performance measurements available for 
> the patch on a powerpc platform?

I think MPC 85xx is well supported and in arch/powerpc/configs there are 
already a few MPC85xx boards available.

> Also a question that is not directly related to this list, but maybe 
> someone can help me with it. Is there some information available on 
> porting a BSP from ppc to powerpc? I was not able to find information on 
> this except for the fact that the ppc architecture will be dropped, but 
> no information on what impact this has on a BSP.

Unfortunately, porting takes some effort, especially because of the 
mandatory Open Firmware flattened device tree (DTF). Please read 
Documentation/powerpc/booting-without-of.txt for further information. 
But there are already examples for the MPC85xx. There are more new 
things like the generic IRQ and timer layer, but that should be already 
available for your boards. For more details, please ask on the 
linuxppc-embedded ML.

Wolfgang.
