From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: Compilation fails
Date: Thu, 21 Jun 2012 08:47:01 -0400
Message-ID: <1340282821.27036.132.camel@gandalf.stny.rr.com>
References: <4FE20F1E.3010306@albentia.com> <4FE2BE4F.6080000@c-s.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 7bit
Cc: Iratxo Pichel Ortiz <ipichel@albentia.com>,
	linux-rt-users@vger.kernel.org, David Garcia <dgarcia@albentia.com>
To: leroy christophe <christophe.leroy@c-s.fr>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.122]:15464 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759526Ab2FUMrF (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 21 Jun 2012 08:47:05 -0400
In-Reply-To: <4FE2BE4F.6080000@c-s.fr>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Thu, 2012-06-21 at 08:25 +0200, leroy christophe wrote:
> Hi
> 
> I had the same problem with
> * Kernel 3.4.2
> * Patch 3.4.2 rt 10
> * make for a mpc8xx custom board
> 
> As far as I remember I added an #include to <asm/bug.h> in 
> include/linux/spinlock.h and it worked

Either should work, but since only spinlock_rt.h references BUG(), it
should go in that file.

-- Steve


