From: Carsten Emde <Carsten.Emde@osadl.org>
Subject: Re: 2.6.31.12-rt20:  BUG: sleeping function called from invalid
 context at kernel/rtmutex.c:684
Date: Tue, 16 Feb 2010 00:38:14 +0100
Message-ID: <4B79DAE6.9010500@osadl.org>
References: <f1abefc50f3730ba8ff4b099170c9a85.squirrel@webmail.sonic.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org
To: ulmo@sonic.net
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from toro.web-alm.net ([62.245.132.31]:54076 "EHLO toro.web-alm.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932090Ab0BOXkQ (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 15 Feb 2010 18:40:16 -0500
In-Reply-To: <f1abefc50f3730ba8ff4b099170c9a85.squirrel@webmail.sonic.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 02/14/2010 07:26 PM, ulmo@sonic.net wrote:
> I'm getting plenty of dmesg errors in 2.6.31.12-rt20, a stock 2.6.31.12
> with rt20 patch applied.  Reviewing lkml (google pointed me that way, not
> surprisingly), I see that it's been happening variously for a few years.
Triggered from different places.

> My first theory is that it is started by X somehow.  I noted the "tainted"
> in the output, so I do have to mention I have nvidia driver 190.53-r1
> installed.  It happened first at 3266.451642 seconds kernel running, at
> Feb 13 13:25:04.  Looking for processes aged that much, I see that "kdm"
> started at 13:23, and some others:
> [..]
> It happened well after I loaded the nvidia driver, but perhaps using it is
> what causes it, since it happened first two minutes after starting X.  The
> fact that the kernel ran for 3266.451641 seconds without trouble then
> suddenly starts having lots of them when X starts indicates that X is very
> related to the problem.
You did a perfect job. Based on the evidence you provided, your
assumption appears correct that the nvidia driver is triggering kernel
BUG messages. However, fixing this bug requires access to the driver
sources which Nvidia refuses to provide. Alternatively, a company may
decide to provide appropriate documentation to let a community write a
Linux driver. But Nvidia fails to do so as well. Many people decide not
to buy from such manufacturers.

Open source support for ATI Radeon graphic boards is much better now.
The X1950 Pro, for example, perfectly runs Compiz, Torcs and other 3D
applications on 2.6.31.12-rt20 and does not interfere with the real-time
capabilities of the kernel. If you are lucky, you may get one at an
online marketplace for less than 30 bucks.

	Carsten.
