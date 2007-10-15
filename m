From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH v2 1/4] Implement {read,update}_persistent_clock.
Date: Mon, 15 Oct 2007 22:05:14 +0400
Message-ID: <4713ABDA.2000506@ru.mvista.com>
References: <1190345162.620000.305760830507.qpush@thor>	 <Pine.LNX.4.58.0709261502590.4465@gandalf.stny.rr.com>	 <46FAB56E.8080509@ru.mvista.com>	 <Pine.LNX.4.58.0709261543080.5123@gandalf.stny.rr.com> <1190836713.23376.41.camel@chaos>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Tony Breeds <tony@bakeyournoodle.com>, linuxppc-dev@ozlabs.org,
	Paul Mackerras <paulus@samba.org>,
	Realtime Kernel <linux-rt-users@vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.155]:10796 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1759302AbXJOSFC (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 15 Oct 2007 14:05:02 -0400
In-Reply-To: <1190836713.23376.41.camel@chaos>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hello.

Thomas Gleixner wrote:

>>>    No wonder here: the -rt patch already has much of this code since around
>>>2.6.21.  They have been submitted by me, mostly... and this patchset is
>>>against the Linus' tree.

>>That would explain it ;-)

>>I was searching the linux-rt-users mailing list for any patches, and
>>pulled in any that looked legit. These happen to in that mailing list too.

> I'll sort that out along with the other hrt updates.

   Eh... poor you. Tony got clockevent driver reengineered for no apparent 
reason.  And he's introduced the jiffy drift by deleting the main loop from 
timer_interrupt(). Yet this borken version was preferred to what was known 
working since about 2.6.18 and included into 2.6.21-rt patchset.  I don't like 
that policy. Will you be pushing fixes from -rt to PowerPC, or will it fall on 
my shoulders now?

> 	tglx

WBR, Sergei
