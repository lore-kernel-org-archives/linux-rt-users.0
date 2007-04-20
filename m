From: Johan Borkhuis <j.borkhuis@dutchspace.nl>
Subject: Re: arm and ppc plattforms
Date: Fri, 20 Apr 2007 15:59:59 +0200
Message-ID: <4628C75F.1080407@dutchspace.nl>
References: <1177066595.5648.33.camel@localhost.localdomain> <20070420110819.GN9554@pengutronix.de> <f87351060704200423n45dc5b66h73a399a4df1bfd68@mail.gmail.com> <20070420113411.GO9554@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from kirk.dutchspace.nl ([82.161.242.14]:54635 "EHLO
	kirk.dutchspace.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1767109AbXDTO1y (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 20 Apr 2007 10:27:54 -0400
Received: from [10.21.30.78] (snitkin.dutchspace.nl [10.21.30.78])
	by kirk.dutchspace.nl (8.11.7p1+Sun/8.10.2) with ESMTP id l3KDxPN19322
	for <linux-rt-users@vger.kernel.org>; Fri, 20 Apr 2007 15:59:25 +0200 (MEST)
In-Reply-To: <20070420113411.GO9554@pengutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Robert Schwebel wrote:
> You'll probably have no luck with ARCH=ppc, our port runs with
> ARCH=powerpc (and still has some crude hacks inside). 
>   
I am in the same situation: I have a board (MVME3100, PPC8540) that uses 
the ARCH=ppc, but I have some strict realtime requirements. As far as I 
understand from the discussions on this list (and on other places) the 
ARCH=ppc will be dropped in favor of ARCH=powerpc, and the -rt patch 
will not support the ppc-architecture.

But before I start working on the powerpc-version of the BSP I would 
like to know how stable the patch runs on powerpc (and specifically on 
ppc85xx), and how good the realtime performance of the patch is on 
powerpc. Are there any (recent) performance measurements available for 
the patch on a powerpc platform?

Also a question that is not directly related to this list, but maybe 
someone can help me with it. Is there some information available on 
porting a BSP from ppc to powerpc? I was not able to find information on 
this except for the fact that the ppc architecture will be dropped, but 
no information on what impact this has on a BSP.

Kind regards,
    Johan Borkhuis
