From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH v2 1/4] Implement {read,update}_persistent_clock.
Date: Wed, 17 Oct 2007 16:45:26 +0400
Message-ID: <471603E6.9040608@ru.mvista.com>
References: <1190345162.620000.305760830507.qpush@thor>	 <Pine.LNX.4.58.0709261502590.4465@gandalf.stny.rr.com>	 <46FAB56E.8080509@ru.mvista.com>	 <Pine.LNX.4.58.0709261543080.5123@gandalf.stny.rr.com>	 <1190836713.23376.41.camel@chaos>  <4713ABDA.2000506@ru.mvista.com> <1192497543.19073.0.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Thomas Gleixner <tglx@linutronix.de>, linuxppc-dev@ozlabs.org,
	Paul Mackerras <paulus@samba.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Realtime Kernel <linux-rt-users@vger.kernel.org>
To: benh@kernel.crashing.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.155]:31120 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753874AbXJQMpP (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 17 Oct 2007 08:45:15 -0400
In-Reply-To: <1192497543.19073.0.camel@pasglop>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hello.

Benjamin Herrenschmidt wrote:

>>   Eh... poor you. Tony got clockevent driver reengineered for no apparent 
>>reason.  And he's introduced the jiffy drift by deleting the main loop from 
>>timer_interrupt(). Yet this borken version was preferred to what was known 
>>working since about 2.6.18 and included into 2.6.21-rt patchset.  I don't like 
>>that policy. Will you be pushing fixes from -rt to PowerPC, or will it fall on 
>>my shoulders now?

> Possibly because whatever implementation existed before was never
> provided in a mergeable form

    The fact that vDSO calls were removed out of the necessity (because having 
the broken TOD stuff removed was better than to leave it in place producing 
inexact results) doesn't mean that everything in the patches provided was 
broken and of no use.  Yet you want everything removed in favor of somewhat 
dubious implementation.

> and pushed to -rt bypassing the powerpc architecture maintainer ?

    There was no bypassing, everything was submitted publicly via this list. 
The -rt patch (via the hrtimers patchset) was the place to merge the hrtimers 
code at thiat time, and nobody showed any interest in making the code better, 
i.e. amending vDSO stuff, for months... (The question also is why Tony was 
submitting his patches also to linux-rt-users while they were known not to 
apply to the -rt patch.)

> Ben.

WBR, Sergei
