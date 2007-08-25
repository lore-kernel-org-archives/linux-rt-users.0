From: Daniel Walker <dwalker@mvista.com>
Subject: Re: How to talk to DAQ Hardware?
Date: Sat, 25 Aug 2007 11:00:24 -0700
Message-ID: <1188064824.2435.163.camel@dhcp193.mvista.com>
References: <154208.12082.qm@web36102.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org
To: Calin Culianu <cculianu@yahoo.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.158]:25329 "EHLO
	gateway-1237.mvista.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756214AbXHYSHc (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 25 Aug 2007 14:07:32 -0400
In-Reply-To: <154208.12082.qm@web36102.mail.mud.yahoo.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Sat, 2007-08-25 at 08:45 -0700, Calin Culianu wrote:
> Hi,
> 
> 
> I'm coming from the RTAI and RTLinux world and I just learned about the great
> strides you guys have made in hard RT.  Anyway, I was wondering -- currently
> how would one go about talking to DAQ hardware using the RT_PREEMPT patch(es)?
> Will this "just work" with COMEDI?  What happens when a userspace hard rt app
> calls into a kernel device driver in the simple case of an inb() or outb()
> instruction?

PREEMPT_RT doesn't change the way that users call into drivers .. The
users perspective of things is just same as regular linux .. 

Daniel
