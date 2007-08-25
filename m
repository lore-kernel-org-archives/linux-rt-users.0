From: Calin Culianu <cculianu@yahoo.com>
Subject: How to talk to DAQ Hardware?
Date: Sat, 25 Aug 2007 08:45:05 -0700 (PDT)
Message-ID: <154208.12082.qm@web36102.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from web36102.mail.mud.yahoo.com ([66.163.179.216]:39785 "HELO
	web36102.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751462AbXHYPvq (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 25 Aug 2007 11:51:46 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hi,


I'm coming from the RTAI and RTLinux world and I just learned about the great
strides you guys have made in hard RT.  Anyway, I was wondering -- currently
how would one go about talking to DAQ hardware using the RT_PREEMPT patch(es)?
Will this "just work" with COMEDI?  What happens when a userspace hard rt app
calls into a kernel device driver in the simple case of an inb() or outb()
instruction?

I am hoping I can use this patch to do some basic input/output from a data
acquisition card that is driver by COMEDI -- using just synchronous acquisition
and output (basically writing to registers on the card, etc.. no IRQ's).

Will this work?

Thanks..

PS: I also posted on the comedi mailing list but wanted to ask you guys too.

Thanks again,

-Calin



       
____________________________________________________________________________________
Yahoo! oneSearch: Finally, mobile search 
that gives answers, not web links. 
http://mobile.yahoo.com/mobileweb/onesearch?refer=1ONXIC
