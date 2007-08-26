From: Calin Culianu <cculianu@yahoo.com>
Subject: Re: How to talk to DAQ Hardware?
Date: Sat, 25 Aug 2007 19:08:03 -0700 (PDT)
Message-ID: <42568.15578.qm@web36109.mail.mud.yahoo.com>
References: <1188092771.2435.170.camel@dhcp193.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: linux-rt-users@vger.kernel.org
To: Daniel Walker <dwalker@mvista.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from web36109.mail.mud.yahoo.com ([66.163.179.223]:27413 "HELO
	web36109.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S933724AbXHZCIF (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 25 Aug 2007 22:08:05 -0400
In-Reply-To: <1188092771.2435.170.camel@dhcp193.mvista.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


--- Daniel Walker <dwalker@mvista.com> wrote:

> > process?
> 
> ISR's are kernel threads, and you can change the priority of them .. If
> you look 'ps' or 'top' you'll notice some processes that looks like,

Wow, thanks for the thorough answer.  So basically interrupts come in from
hardware, are dispatched by waking up a thread.. and then the thread decides to
call a device driver's ISR or not?  So if another lower priority interupt calls
in, the thread is woken up but processing resumes again in the
previously-running higher priority thread?  I guess I should just read the
sources..

Anyway thanks for anwering my questions.  Now I must rave:

I seriously think you guys are AMAZING -- or at least your work on this is.  I
am so happy to be rid of RTLinux.  I liked RTAI, but it was really horribly
unstable and the API was all over the place.  So I was forced to use RTLinux.

RTLinux was not free, unless you used an ancient version that only really ran
on 2.4 kernels.

This RT patch is amazing.  I really want to say.. KUDOS.  You guys are my
heroes!  I have been pulling my hair out for 6 years now with sub-standard open
RTOS's like RTAI and RTLinux and having this done "the right way" by you guys
feels awesome..  I know RTAI had userspace realtime for some time but its
administration and configuration was messy and buggy and RTLinux's userspace
realtime was not open.  In the end it always felt like a hack somehow.. And if
you called into libraries or kernel facilities that weren't hard-rt.. BOOM,
your app exploded!  So kludgy..

Thanks again!!

-Calin



      ____________________________________________________________________________________
Luggage? GPS? Comic books? 
Check out fitting gifts for grads at Yahoo! Search
http://search.yahoo.com/search?fr=oni_on_mail&p=graduation+gifts&cs=bz
