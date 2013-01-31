From: Frank Rowand <frank.rowand@am.sony.com>
Subject: Re: Protection of critical section in PREEMPT_RT
Date: Thu, 31 Jan 2013 11:52:39 -0800
Message-ID: <510ACB87.3080007@am.sony.com>
References: <CAHX1yNTSObcxNrvsBnPw8QzUWTb4zzs_faZZ1bbGU1L8xzgpsQ@mail.gmail.com>	<50FE68EF.8060909@meduna.org> <CAHX1yNTKw8vr2v01Eft1tVV5YrP-7Zw=3fk9iF6YJYfbnBJ9LQ@mail.gmail.com>
Reply-To: <frank.rowand@am.sony.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Stanislav Meduna <stano@meduna.org>,
	"linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
To: Jacky Lam <lamshuyin@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from va3ehsobe001.messaging.microsoft.com ([216.32.180.11]:49793
	"EHLO va3outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751688Ab3AaTxq (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 31 Jan 2013 14:53:46 -0500
In-Reply-To: <CAHX1yNTKw8vr2v01Eft1tVV5YrP-7Zw=3fk9iF6YJYfbnBJ9LQ@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 01/31/13 01:27, Jacky Lam wrote:
> Thanks Stano,
> 
> I am still debugging this driver. But I find very strange that
> sometimes printk() in interrupt handler do not output anything. This
> makes me very difficult to debug. Is it RT patch's expected behaviour?
> Or I am doing something wrong??

If CONFIG_PREEMPT_RT_FULL then printk() from irq context will be buffered
but the console driver will not be called to flush the buffer.  The
next printk() outside irq context will flush the buffer.

-Frank

