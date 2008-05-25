From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH -rt] fix for compiling 2.6.24.7-rt10 without CONFIG_FTRACE
Date: Sat, 24 May 2008 20:47:39 -0400 (EDT)
Message-ID: <Pine.LNX.4.58.0805242047130.3977@gandalf.stny.rr.com>
References: <Pine.LNX.4.58.0805240221080.1841@gandalf.stny.rr.com>
 <48387154.8070204@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Steven Rostedt <srostedt@redhat.com>,
	LKML <linux-kernel@vger.kernel.org>,
	RT <linux-rt-users@vger.kernel.org>
To: Clark Williams <clark.williams@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.124]:55921 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754507AbYEYArk (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 24 May 2008 20:47:40 -0400
In-Reply-To: <48387154.8070204@gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


On Sat, 24 May 2008, Clark Williams wrote:

> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
> Steven,
>
> If you build a debugging kernel and don't have CONFIG_FTRACE turned on, -rt10 dies
> when compiling arch/x86/kernel/x8664_ksyms_64.c, because ktime_t isn't defined in the
> prototypes at the bottom of include/linux/ftrace.h. Patch to fix attached.
>

Ah, you sent me this before, but I thought it was fixed with the new
ftrace. Sorry, I'll re-apply it.

Thanks.

-- Steve

