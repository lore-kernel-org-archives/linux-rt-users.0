From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: network bug in 3.6.11.7
Date: Tue, 20 Aug 2013 13:21:55 -0400
Message-ID: <20130820132155.1b9caff3@gandalf.local.home>
References: <20130820171514.GA16405@tsunami.ccur.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>
To: Joe Korty <joe.korty@ccur.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.122]:16933 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751343Ab3HTRV4 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 20 Aug 2013 13:21:56 -0400
In-Reply-To: <20130820171514.GA16405@tsunami.ccur.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Tue, 20 Aug 2013 13:15:14 -0400
Joe Korty <joe.korty@ccur.com> wrote:

> Hi Steve,
> I get the following warnings when compiling 3.6.11.7-rt39:
> 
>   net/core/sock.c:212: warning: excess elements in array initializer
>   net/core/sock.c:212: warning: (near initialization for 'af_family_key_strings')
>   net/core/sock.c:228: warning: excess elements in array initializer
>   net/core/sock.c:228: warning: (near initialization for 'af_family_slock_key_strings')
>   net/core/sock.c:244: warning: excess elements in array initializer
>   net/core/sock.c:244: warning: (near initialization for 'af_family_clock_key_strings')
> 
> I traced it down to the patch
>   "net/core/sock.c: add missing VSOCK string in af_family_*_key_strings"
> 
> This is really a fixup to a much larger patch (6,000 lines) in mainline
> called "VSOCK: Introduce VM Sockets", which was not backport to 3.6.11.7.
> 
> It might be best for 3.6.11.7 to to drop the VSOCK fixup patch.
> 

Thanks for reporting! I'll drop that patch.

-- Steve
