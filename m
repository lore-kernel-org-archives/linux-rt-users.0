From: "Remy Bohmer" <linux@bohmer.net>
Subject: Re: [patch 3/3] Enable setting of IRQ-thread priorities from kernel cmdline. (repost:CC to LKML)
Date: Thu, 20 Dec 2007 13:50:49 +0100
Message-ID: <3efb10970712200450p6b100e63gd4a3b547cec5c986@mail.gmail.com>
References: <20071219194551.315868746@bohmer.net>
	 <47697888.143f420a.5466.ffff89ba@mx.google.com>
	 <1985e0f60712200359k6194b0fdn25ead9b5c0835c95@mail.gmail.com>
	 <3efb10970712200425x4b0ffadcpd2ffa3223eda7b3d@mail.gmail.com>
	 <1985e0f60712200445o4f854cdep6eebf1726737229b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Steven Rostedt" <rostedt@goodmis.org>,
	"Arnaldo Carvalho de Melo" <acme@ghostprotocols.net>,
	"Ingo Molnar" <mingo@elte.hu>,
	"Juergen Beisert" <jbe@pengutronix.de>,
	"Darren Hart" <dvhltc@us.ibm.com>, linux-rt-users@vger.kernel.org,
	"Sven-Thorsten Dietrich" <sdietrich@novell.com>,
	LKML <linux-kernel@vger.kernel.org>
To: "Jaswinder Singh" <jaswinderlinuxrt@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.224]:48469 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757711AbXLTMuu (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 20 Dec 2007 07:50:50 -0500
Received: by wr-out-0506.google.com with SMTP id c49so2332324wra.1
        for <linux-rt-users@vger.kernel.org>; Thu, 20 Dec 2007 04:50:49 -0800 (PST)
In-Reply-To: <1985e0f60712200445o4f854cdep6eebf1726737229b@mail.gmail.com>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

> By default, all softirq-threads or IRQs will be RT task but if there
> is some option user can switch it to NON-RT task then it will be good.

Okay, understood.
I will think about how to add that too. But, probably we can add it
seperately from this patchset.

Kind Regards,

Remy


2007/12/20, Jaswinder Singh <jaswinderlinuxrt@gmail.com>:
> Hello Remy,
>
> On 12/20/07, Remy Bohmer <linux@bohmer.net> wrote:
> > So, Is this a serious requirement? Should this be possible?
>
> I have noticed this problem:
> root@192.168.1.253:~# cat /proc/loadavgrt
> 1.00 1.00 1.00 0/52 1158
> root@192.168.1.253:~# cat /proc/loadavg
> 0.00 0.00 0.02 1/52 1159
> root@192.168.1.253:~#
>
> So I am curious, if possible, user can switch softirq-threads or IRQs
> RT tasks to non-RT tasks for slow hardware or least important hardware
> for NON-RT tasks. So this will improve RT behaviour.
>
> By default, all softirq-threads or IRQs will be RT task but if there
> is some option user can switch it to NON-RT task then it will be good.
>
> Thank you,
>
> Jaswinder Singh.
>
