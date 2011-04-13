From: Jeremy Jongepier <jeremy@autostatic.com>
Subject: Re: [ANNOUNCE] 2.6.33.9-rt31
Date: Wed, 13 Apr 2011 17:19:19 +0200
Message-ID: <4DA5BEF7.5000009@autostatic.com>
References: <alpine.LFD.2.00.1104111723020.4501@localhost6.localdomain6> <4DA582AE.9020706@autostatic.com> <4DA5A786.8060001@siemens.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from pony.ic.uva.nl ([145.18.40.181]:52493 "EHLO pony.ic.uva.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757130Ab1DMPTW (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 13 Apr 2011 11:19:22 -0400
Received: from [146.50.80.232] (pch080232.hum.uva.nl [146.50.80.232])
	by pony.ic.uva.nl (8.13.1/8.13.1) with ESMTP id p3DFJJTj015707
	for <linux-rt-users@vger.kernel.org>; Wed, 13 Apr 2011 17:19:19 +0200
In-Reply-To: <4DA5A786.8060001@siemens.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 04/13/2011 03:39 PM, Jan Kiszka wrote:
> A nouveau hacker recently explained to me that it's fairly hard to
> backport their improvements to older kernels as they heavily depend on
> infrastructure changes. That likely explains why you don't see many
> stable fixes or a nouveau-compat package.
> 
> If you can live with the nvidia driver, I can share a patch that makes
> it build&work for me (Quadro FX 880M).
> 
> Jan

Hello Jan,

2.6.33-rt29 worked just fine for me, the trouble started with
2.6.33-rt30. Apparently it lacks nouveau code compared to rt29. Luckily
a maintainer of a multimedia distro picked this up and fixed this issue
by reintegrating the missing nouveau code from rt29 into rt30. He's
preparing a rt31 kernel so hopefully he manages to pull this off again.
Thanks for the offer though, but I prefer using the nouveau driver.

Best,

Jeremy
