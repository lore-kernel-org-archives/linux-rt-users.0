From: Dong Liu <dliu.cn@gmail.com>
Subject: Re: cpu stall and hyperthread
Date: Thu, 12 Jul 2012 16:27:47 -0400
Message-ID: <4FFF3343.5030701@gmail.com>
References: <4FEBCDDE.60503@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:43567 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755270Ab2GLU1q (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 12 Jul 2012 16:27:46 -0400
Received: by bkwj10 with SMTP id j10so2596447bkw.19
        for <linux-rt-users@vger.kernel.org>; Thu, 12 Jul 2012 13:27:45 -0700 (PDT)
In-Reply-To: <4FEBCDDE.60503@gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

I installed the exact same system on a machine. This time the CPU is 
Core 2 Quad Q9650.

With 3.2.18-rt29, this system is very stable. I haven't encountered a 
single CPU stall problem.

So it seems to me that the combination of PREEMPT_RT, i7 and KVM is not 
the right combination :( It always causes cpu stall.

Thanks,

Dong
