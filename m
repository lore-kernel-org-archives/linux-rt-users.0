From: Klaas van Gend <klaas.van.gend@mvista.com>
Subject: Re: Questions on developing applications...
Date: Fri, 06 Feb 2009 12:32:30 -0800
Message-ID: <498C9E5E.7060708@mvista.com>
References: <296402.26723.qm@web28616.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org
To: Brian Ford <bsfford@yahoo.co.uk>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.158]:57597 "EHLO
	gateway-1237.mvista.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752368AbZBFUce (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 6 Feb 2009 15:32:34 -0500
In-Reply-To: <296402.26723.qm@web28616.mail.ukl.yahoo.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Brian Ford wrote:
> Hi Everyone,
> 
> I'm new to real time linux programming, apologies if these questions are 
> very simple.
> 
> I've recently setup a real time Linux kernel using patch-2.6.24.7-rt26  
> and got the simple "Hello World" program working. However, I'm unable
> to find any guides on how to write more complex software. 
> 
> Can you tell me how to do real time inter process message passing in linux?
> I'm familiar with shared memory and pipes -- is it ok to use these in 
> a real time context?
> 
> Also, I've read that printf may not provide real time performance. 
> (http://rt.wiki.kernel.org/index.php/HOWTO:_Build_an_RT-application)
> If I use printf/printk to a X UI terminal, will the output be deterministic (take a fixed time)?
> 
> I'm also interested in building a cyclic executive scheduler to control individual process. At
> the moment I'm guessing the only way to do this would be to modify the kernel scheduler. 
> Is it possible to do this at the application/process level?

It depends. Do you know about SCHED_FIFO and SCHED_RR ?
It sounds like that may already suit your needs.

If you're not familiar with those, please read up on this - e.g. in
Chapter 4 of Robert Love's book:    http://www.amazon.co.uk/dp/0672327201


-- 
Best regards,

Klaas van Gend

Senior Solutions & Services Architect
MontaVista Software
Phone: (408) 572 7962 (Santa Clara Office)
Phone: +31 40 2801386 (for European calls)
