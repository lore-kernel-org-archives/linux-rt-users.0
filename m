From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: v3.18-RT
Date: Mon, 6 Jun 2016 09:01:36 +0200
Message-ID: <16d5e3f2-dd20-c802-37aa-86eab553fcfc@linutronix.de>
References: <FCC5AC80E299464B82E1345E2C10FC9D8098CE51@S1P5DAG4C.EXCHPROD.USA.NET>
 <20160603163732.GD4496@linutronix.de>
 <FCC5AC80E299464B82E1345E2C10FC9D8099ACF6@S1P5DAG4C.EXCHPROD.USA.NET>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Cc: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
To: David Hauck <davidh@netacquire.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:59022 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751039AbcFFHBk (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 6 Jun 2016 03:01:40 -0400
In-Reply-To: <FCC5AC80E299464B82E1345E2C10FC9D8099ACF6@S1P5DAG4C.EXCHPROD.USA.NET>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 06/03/2016 07:15 PM, David Hauck wrote:
> Hi Sebastian,

Hi David,

>  
> On Fri, 3 Jun 2016 at 09:38:00, Sebastian Andrzej Siewior wrote:
>> I am not aware of any lockup on v3.18-RT tree. I just tried a few boot up on two of machines and it looks good.
>> Don't have currently any control on anything >4 cores.
> 
> Thx. We've done further testing and see that v3.18.9 does not suffer the same problem.
> 
> I also have some dump information (all "unable to handle kernel paging request") and was wondering what the best way to pass this along to the list might be? Would a compressed archive of the (4) log files be OK to send along?

That "unable to handle kernel paging request" shouldn't be much. Please
send it to the list. The first BUG backtrace is the important one.
Also if you say that the v3.18.9 based RT tree worked could please try
v3.18.13-rt10? If so then you could the git tree

  https://git.kernel.org/cgit/linux/kernel/git/rt/linux-stable-rt.git/

and start a bisect between v3.18.13-rt10 and v3.18.29-rt30?

> -David
>  
>>> Thanks in advance,
>>> -David

Sebastian

