From: Feng Feng24 Liu <liufeng24@lenovo.com>
Subject: RE: BUG: unable to handle kernel NULL pointer dereference at
 0000000000000038 !//RE: kernel BUG at kernel/locking/rtmutex.c:1027
Date: Thu, 29 Jun 2017 03:06:19 +0000
Message-ID: <2B18E8E1DDAE074A82D1060396451DAE263CCAD6@CNMAILEX04.lenovo.com>
References: <2B18E8E1DDAE074A82D1060396451DAE263CBBD6@CNMAILEX04.lenovo.com>
 <20170626102418.310bb1ce@gandalf.local.home>
 <20170626145436.npgsaz4eyvnh2j2k@linutronix.de>
 <20170626155555.GB8190@jcartwri.amer.corp.natinst.com>
 <2B18E8E1DDAE074A82D1060396451DAE263CC234@CNMAILEX04.lenovo.com>
 <20170627142757.GA1463@jcartwri.amer.corp.natinst.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: Sebastian Andrzej Siewior <sebastian.siewior@linutronix.de>,
        "Steven Rostedt" <rostedt@goodmis.org>,
        Mike Galbraith <efault@gmx.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
To: Julia Cartwright <julia@ni.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail1.bemta8.messagelabs.com ([216.82.243.207]:8286 "EHLO
        mail1.bemta8.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751541AbdF2DJz (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 28 Jun 2017 23:09:55 -0400
In-Reply-To: <20170627142757.GA1463@jcartwri.amer.corp.natinst.com>
Content-Language: zh-CN
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Thanks Julia, I will try it

Thanks
Feng

>-----Original Message-----
>From: Julia Cartwright [mailto:julia@ni.com]
>Sent: Tuesday, June 27, 2017 10:28 PM
>To: Feng Feng24 Liu
>Cc: Sebastian Andrzej Siewior; Steven Rostedt; Mike Galbraith;
>linux-kernel@vger.kernel.org; linux-rt-users@vger.kernel.org
>Subject: Re: BUG: unable to handle kernel NULL pointer dereference at
>0000000000000038 !//RE: kernel BUG at kernel/locking/rtmutex.c:1027
>
>On Tue, Jun 27, 2017 at 05:47:41AM +0000, Feng Feng24 Liu wrote:
>> Hi, Julia
>> 	Thanks for your kindly hit. I will try this patch
>> 	The problem is accidental. I will try to reproduce it.
>> 	BTW, could you help to give the link about the emails which
>> 	discuss about " nsfs: mark dentry with DCACHE_RCUACCESS ". I
>> 	cannot find them(just patch email)
>
>Conversation upstream started with a syzkaller-found problem here:
>
>   https://marc.info/?l=linux-netdev&m=149183505630266&w=2
>
>Hopefully that helps,
>   Julia
