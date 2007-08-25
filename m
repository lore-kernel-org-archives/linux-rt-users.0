From: Calin Culianu <cculianu@yahoo.com>
Subject: Re: How to talk to DAQ Hardware?
Date: Sat, 25 Aug 2007 12:49:16 -0700 (PDT)
Message-ID: <664539.31533.qm@web36101.mail.mud.yahoo.com>
References: <1188064824.2435.163.camel@dhcp193.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: linux-rt-users@vger.kernel.org
To: Daniel Walker <dwalker@mvista.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from web36101.mail.mud.yahoo.com ([66.163.179.215]:32330 "HELO
	web36101.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1758751AbXHYTtR (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 25 Aug 2007 15:49:17 -0400
In-Reply-To: <1188064824.2435.163.camel@dhcp193.mvista.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


--- Daniel Walker <dwalker@mvista.com> wrote:

> On Sat, 2007-08-25 at 08:45 -0700, Calin Culianu wrote:
> > Hi,
> > 
> > 
> > I'm coming from the RTAI and RTLinux world and I just learned about the
> great
> > strides you guys have made in hard RT.  Anyway, I was wondering --
> currently
> > how would one go about talking to DAQ hardware using the RT_PREEMPT
> patch(es)?
> > Will this "just work" with COMEDI?  What happens when a userspace hard rt
> app
> > calls into a kernel device driver in the simple case of an inb() or outb()
> > instruction?
> 
> PREEMPT_RT doesn't change the way that users call into drivers .. The
> users perspective of things is just same as regular linux .. 
> 
> Daniel
> 
> 

Cool!  That's what I figured but I wanted to double-check.

Now, there is no way to raise the priority of particular driver's ISRs is
there?  So that a specific ISR can preempt anything including a hard realtime
process?

I know in the shared IRQ situation it would introduce lots of jitter but having
really high priority interrupts would be nice.  Is that possible?

Anyway thanks for answering my question -- this basically means I can throw
away rtlinux and use the latest 2.6 kernels with the RT_PREEMPT patches!  :)

-Calin





       
____________________________________________________________________________________
Building a website is a piece of cake. Yahoo! Small Business gives you all the tools to get online.
http://smallbusiness.yahoo.com/webhosting 
