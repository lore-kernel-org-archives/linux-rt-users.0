From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: patch-2.6.33.9-rt31 problem
Date: Wed, 11 Jul 2012 08:43:52 -0400
Message-ID: <1342010632.14828.28.camel@gandalf.stny.rr.com>
References: <4FFC915C.80202@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 7bit
Cc: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
To: Dong Liu <dliu.cn@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.122]:19389 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754494Ab2GKMny (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 11 Jul 2012 08:43:54 -0400
In-Reply-To: <4FFC915C.80202@gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Tue, 2012-07-10 at 16:32 -0400, Dong Liu wrote:
> Hi All,
> 
> Because I could not find a solution for the cpu stall problem on kernel 
> 3.2.18-rt29. I thought I might try an older kernel. So I download 
> linux-2.6.33.9 and patch-2.6.33.9-rt31. But 2.6.33 doesn't have 
> vhost_net, so I ported vhost_net from 2.6.34 back to 2.6.33.9.
> 
> The kernel was patched and built successfully. But when I boot, I got 
> kernel NULL pointer dereference error. After the error, my system seems 
> stable, I can start KVM client without CPU stalls. But very frequently, 
> processes will locked up for long time, the wchan displayed by ps is 
> either sync_page or synchronize_rcu. It looks that rcu still causes 
> problem in the rt-kernel.
> 
> The dmesg out of NULL pointer is attached.

Um, when you get one of those 'kernel NULL pointer' crashes, the system
is not in a good state. If the crash happened to a task that holds a
mutex or worse a spinlock, it will never release it. That means, any new
task that tries to take that same mutex or spinlock, will just block and
sit there.

Thus, those processes that are stuck at either sync_page or
synchronize_rcu, are probably waiting for that processes to release a
mutex, or finish something else that it will never do.

Basically, once you see a NULL pointer dereference, it's time to save
the dmesg and reboot the box.

-- Steve


