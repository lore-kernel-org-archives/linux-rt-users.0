From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: 2.6.24.7-rt16
Date: Mon, 28 Jul 2008 10:12:13 +0200
Message-ID: <488D7F5D.8090400@grandegger.com>
References: <alpine.LFD.1.10.0807252141420.574@apollo.tec.linutronix.de> <alpine.LFD.1.10.0807271719130.574@apollo.tec.linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: LKML <linux-kernel@vger.kernel.org>,
	rt-users <linux-rt-users@vger.kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ingo Molnar <mingo@elte.hu>,
	Clark Williams <williams@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Carsten Emde <ce@ceag.ch>, Luotao Fu <l.fu@pengutronix.de>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.9]:53731 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750720AbYG1IKb (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 28 Jul 2008 04:10:31 -0400
In-Reply-To: <alpine.LFD.1.10.0807271719130.574@apollo.tec.linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi Thomas,

Thomas Gleixner wrote:
> We are pleased to announce the 2.6.24.7-rt16 tree, which can be
> downloaded from the location:
>  
>   http://rt.et.redhat.com/download/
> 
> Information on the RT patch can be found at:
> 
>   http://rt.wiki.kernel.org/index.php/Main_Page
> 
> This is a bugfix update:
> 
>      - remove m68knommu merge artifacts (tglx)
> 
>      - fix x86_64 UP build (Peter Zijlstra)
> 
>      - powerpc ftrace backport (tglx)

Backport? It's not yet available for 2.6.25.

>      - fix long standing NFS missing preemption check (tglx)
> 
>        This is not a MPC5200 specific problem, it affects all
>        architectures, but was not noticed for a long time as the race
>        window is extremly tight.

This fix finally solves my latency issues with the MPC5200, also with 
2.6.25.8-rt7. After 2 hours the latency is still below 150us for both 
versions. Thanks a lot for your effort.

Wolfgang.


