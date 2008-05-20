From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: Compile warning rtmutex code on 2.6.24.7-rt8 (CC:LKML added)
Date: Tue, 20 May 2008 17:11:07 -0400 (EDT)
Message-ID: <Pine.LNX.4.58.0805201707210.20474@gandalf.stny.rr.com>
References: <3efb10970805201356x4552859bof5f3f4f56f2ba676@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: LKML <linux-kernel@vger.kernel.org>,
	RT <linux-rt-users@vger.kernel.org>
To: Remy Bohmer <linux@bohmer.net>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.124]:44863 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759593AbYETVLJ (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 20 May 2008 17:11:09 -0400
In-Reply-To: <3efb10970805201356x4552859bof5f3f4f56f2ba676@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


On Tue, 20 May 2008, Remy Bohmer wrote:

> Hello Steven,
>
>  Do you recognise these warnings? I do not know (yet) if these are ARM
>  specific...
>
>   CC      kernel/rtmutex.o
>  kernel/rtmutex.c: In function 'rt_write_fastlock':
>  kernel/rtmutex.c:1582: warning: initialization makes pointer from
>  integer without a cast
>  kernel/rtmutex.c: In function 'rt_write_fasttrylock':
>  kernel/rtmutex.c:1622: warning: initialization makes pointer from
>  integer without a cast
>
>  If so, do you have a fix for it?

Ah, I guess ARM is a bit more critical of chpxchg than x86 is.

I'll add a patch for 2.6.24.7-rt9 (which I plan on releasing soon). It
will have some minor clean ups.

-- Steve

