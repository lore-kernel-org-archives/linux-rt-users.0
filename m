From: Nicholas Mc Guire <der.herr@hofr.at>
Subject: Re: real time linux - which to use?
Date: Thu, 10 Jun 2010 15:16:29 +0200
Message-ID: <20100610131629.GA7998@opentech.at>
References: <AANLkTilcpfJLRqKzsN0n6Vx_EGHO7Q56uaOWBPYYaPx7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>
To: Neel Mehta <neelmehta89@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hofr.at ([212.69.189.236]:37979 "EHLO mail.hofr.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753557Ab0FJNYW (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 10 Jun 2010 09:24:22 -0400
Content-Disposition: inline
In-Reply-To: <AANLkTilcpfJLRqKzsN0n6Vx_EGHO7Q56uaOWBPYYaPx7@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Thu, 10 Jun 2010, Neel Mehta wrote:

> Hi. I am new to real time linux os. I need to set up one. I came
> across two realtime linux os/kernels/patches, and there may be more. I
> came across?http://www.rtlinuxfree.com/?and?https://www.rtai.org/.
>

regarding RTLinux/RTAI, RTLinux is dead so if one of those to then RTAI

Alternatives are the Xenomain and Xenomai-Solo and of course RT-Preempt
 
> Are there more such patches? Is anyone better? What do people use
> normally? I need to set up realtime linux to get results from sensors
> every periodic intervals. I want this to be hard realtime. Any help
> will be greatly appreciated. Instructions or links for compilation
> will also be very helpful.
>

a bit of background with respect to bandwidth needs, periods involved and
architecture would be helpfull to give you some hints. There is no 
"one-fits-all" solution around...

hofrat
