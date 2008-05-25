From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: 2.6.24.7-rt10
Date: Sun, 25 May 2008 07:36:39 -0400 (EDT)
Message-ID: <Pine.LNX.4.58.0805250735410.3977@gandalf.stny.rr.com>
References: <1211608265.14697.105.camel@localhost.localdomain>
 <g1adb2$217$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org
To: trem <tremyfr@yahoo.fr>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.125]:63485 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754863AbYEYLgm (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 25 May 2008 07:36:42 -0400
In-Reply-To: <g1adb2$217$1@ger.gmane.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>



On Sun, 25 May 2008, trem wrote:
>
> I've got a problem with the compilation when compiling kernel/rcupreempt_trace.o :
>
> kernel/rcupreempt_trace.c: In function ?rcupreempt_trace_init?:
> kernel/rcupreempt_trace.c:539: erreur: implicit declaration of function ?marker_arm?
> kernel/rcupreempt_trace.c: In function ?rcupreempt_trace_cleanup?:
> kernel/rcupreempt_trace.c:577: erreur: too few arguments to function ?marker_probe_unregister?
> kernel/rcupreempt_trace.c:583: erreur: too few arguments to function ?marker_probe_unregister?
> make[1]: *** [kernel/rcupreempt_trace.o] Erreur 1
>
>
> I think that markers-upstream.patch can't be used with rcu-preempt-trace-markers-1.patch and
> rcu-preempt-trace-markers-2.patch.
>

Or more correctly, the rcu-preempt-markers patches can't be used with
markers-upstream.patch ;-)

I'll port that over, since it will need to be ported anyway.

-- Steve

