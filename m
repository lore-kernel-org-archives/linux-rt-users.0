From: raz ben yehuda <raziebe@013.net>
Subject: Re: Subject: PATCH : offline scheduler ( some refer to it as a CPU
	isolation )
Date: Sun, 19 Apr 2009 13:09:33 +0300
Message-ID: <1240135773.3395.18.camel@raz>
References: <1240081024.3534.3.camel@raz>
 <c384c5ea0904181823m42a180d7p34d57ad8212ccc54@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7BIT
Cc: raz ben yehuda <raziebe@013.net>, linux-rt-users@vger.kernel.org
To: Leon Woestenberg <leon.woestenberg@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mxout12.netvision.net.il ([194.90.6.37]:40013 "EHLO
	mxout12.netvision.net.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752057AbZDSHJf (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 19 Apr 2009 03:09:35 -0400
Received: from [192.168.2.102] ([217.132.154.72]) by mxout12.netvision.net.il
 (Sun Java System Messaging Server 6.2-8.04 (built Feb 28 2007))
 with ESMTPA id <0KIC0031A6KFIJB0@mxout12.netvision.net.il> for
 linux-rt-users@vger.kernel.org; Sun, 19 Apr 2009 10:09:51 +0300 (IDT)
In-reply-to: <c384c5ea0904181823m42a180d7p34d57ad8212ccc54@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


On Sun, 2009-04-19 at 03:23 +0200, Leon Woestenberg wrote:
> Raz,
> 
> On Sat, Apr 18, 2009 at 8:57 PM, raz ben yehuda <raziebe@013.net> wrote:
> > offsched is a platform aimed to assign a service to an off-lined processor.
> > Motivation is explained in:
> > http://sos-linux.svn.sourceforge.net/viewvc/sos-linux/offsched/trunk/Documentation/OFFSCHED.pdf
> 
> I quickly glanced over but could not find a comparison with other methods?
> 
> 
> Suppose I run /bin/init with a certain CPU affinity (not covering all
> CPUs) and then run my own specific service on the remaining CPUs, how
> would this differ from your approach?
First , not all services are children of init. there are workqueues,
kernel daemons, softirqs and so on. offlet provides hard real time,in
the sense that one can pre-determine how long an operation cost, it is
NMI mode after all. Also, this is why i chose to implement a 1us timer,
because i can do it.
> >From what I quickly gathered, you are running parts of the kernel
> space on the second CPU set, or is that too simple a statement?
I am running **no kernel** on the offloaded processors, but offsched code, 
and the rest of the processors run the "kernel". 
> 
> Looks like a very fresh approach, nice project!
Thank you. i appreciate it.  
> Regards,

