From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: 2.6.23.1-rt5 (was 2.6.23-rt1 trouble)
Date: Tue, 30 Oct 2007 15:28:48 -0400 (EDT)
Message-ID: <Pine.LNX.4.58.0710301526480.30690@gandalf.stny.rr.com>
References: <1192154640.15992.10.camel@localhost.localdomain>         
 <38542.213.58.131.130.1192445349.squirrel@www.rncbc.org> <471648B8.1030007@rncbc.org>
 <47234EA1.4050006@rncbc.org> <Pine.LNX.4.58.0710271203170.28617@gandalf.stny.rr.com>
 <47239A37.8000401@rncbc.org> <472781E3.7010103@rncbc.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Ingo Molnar <mingo@elte.hu>,
	Thomas Gleixner <tglx@linutronix.de>,
	Gregory Haskins <ghaskins@novell.com>
To: Rui Nuno Capela <rncbc@rncbc.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:56014 "EHLO
	ms-smtp-02.nyroc.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759590AbXJ3T3v (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 30 Oct 2007 15:29:51 -0400
In-Reply-To: <472781E3.7010103@rncbc.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


--
On Tue, 30 Oct 2007, Rui Nuno Capela wrote:

>
> still in trouble with 2.6.23.1-rt5 :(
>
> .config:
>   http://www.rncbc.org/datahub/config-2.6.23.1-rt5.0
>
> serial console capture:
>   http://www.rncbc.org/datahub/console-2.6.23.1-rt5.0-1.log

"NVRM: loading NVIDIA UNIX x86 Kernel Module  100.14.19  Wed Sep 12
 14:12:24 PDT 2007"

Is that the nVidia module? Showing a date of Sept 12th also makes this
look suspicious.

If this is the case, could you run without that module to see if we get
the same freezes.

Thanks,

-- Steve

>
> one thing about SysRq-T: while in the middle of a freeze it just doesn't
> dump anything, just the 'SysRq : Show State' line. you can see that
> several times on the console output above.
>
> only when it is somewhat recovering, as said, by making some last resort
> measures like SysRq-E as in 'SysRq: terminate All Tasks' for instance,
> then SysRq-T will dump something. my guess is that this later dump will
> be moot :/
>
> back to production with 2.6.22.1-rt9 ;)
> --
> rncbc aka Rui Nuno Capela
> rncbc@rncbc.org
>
>
