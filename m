From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH v2 1/4] Implement {read,update}_persistent_clock.
Date: Mon, 15 Oct 2007 22:07:10 +0400
Message-ID: <4713AC4E.4050002@ru.mvista.com>
References: <1190345162.620000.305760830507.qpush@thor>	 <Pine.LNX.4.58.0709261502590.4465@gandalf.stny.rr.com>	 <46FAB56E.8080509@ru.mvista.com> <1190858397.11034.22.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Steven Rostedt <rostedt@goodmis.org>, linuxppc-dev@ozlabs.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Paul Mackerras <paulus@samba.org>,
	Realtime Kernel <linux-rt-users@vger.kernel.org>
To: benh@kernel.crashing.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.155]:10812 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1759155AbXJOSG5 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 15 Oct 2007 14:06:57 -0400
In-Reply-To: <1190858397.11034.22.camel@pasglop>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Benjamin Herrenschmidt wrote:

>>>I'm about to release a new -rt patch based on -rc8. This patch series
>>>blew up totally in trying to get it applied. I'm leaving it out, so after
>>>I release the next series, could you update these patches.

>>    No wonder here: the -rt patch already has much of this code since around 
>>2.6.21.  They have been submitted by me, mostly... and this patchset is 
>>against the Linus' tree.

> Proper approach is to rip off what is altready in -rt there and replace
> it with Tony patch set.

    Tony's patchset is broken at places compared to what is in -rt. So that 
would be proper *double standard* approach. :-/

> Ben.

WBR, Sergei
