From: Brian Ford <bsfford@yahoo.co.uk>
Subject: Questions on developing applications...
Date: Wed, 4 Feb 2009 11:50:07 +0000 (GMT)
Message-ID: <296402.26723.qm@web28616.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from n26.bullet.mail.ukl.yahoo.com ([87.248.110.143]:25778 "HELO
	n26.bullet.mail.ukl.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751188AbZBDL5C convert rfc822-to-8bit
	(ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 4 Feb 2009 06:57:02 -0500
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi Everyone,

I'm new to real time linux programming, apologies if these questions are 
very simple.

I've recently setup a real time Linux kernel using patch-2.6.24.7-rt26  
and got the simple "Hello World" program working. However, I'm unable
to find any guides on how to write more complex software. 

Can you tell me how to do real time inter process message passing in linux?
I'm familiar with shared memory and pipes -- is it ok to use these in 
a real time context?

Also, I've read that printf may not provide real time performance. 
(http://rt.wiki.kernel.org/index.php/HOWTO:_Build_an_RT-application)
If I use printf/printk to a X UI terminal, will the output be deterministic (take a fixed time)?

I'm also interested in building a cyclic executive scheduler to control individual process. At
the moment I'm guessing the only way to do this would be to modify the kernel scheduler. 
Is it possible to do this at the application/process level?

Thanks in advance for your help,

Brian


      

