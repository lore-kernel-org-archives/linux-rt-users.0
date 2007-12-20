From: "Jaswinder Singh" <jaswinderlinuxrt@gmail.com>
Subject: Re: [patch 3/3] Enable setting of IRQ-thread priorities from kernel cmdline. (repost:CC to LKML)
Date: Thu, 20 Dec 2007 19:10:08 +0530
Message-ID: <1985e0f60712200540m1e499a77qaaff18d832c4b8f0@mail.gmail.com>
References: <20071219194551.315868746@bohmer.net>
	 <3efb10970712200425x4b0ffadcpd2ffa3223eda7b3d@mail.gmail.com>
	 <1985e0f60712200445o4f854cdep6eebf1726737229b@mail.gmail.com>
	 <200712201418.17378.jbe@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org, "Remy Bohmer" <linux@bohmer.net>,
	"Steven Rostedt" <rostedt@goodmis.org>,
	"Arnaldo Carvalho de Melo" <acme@ghostprotocols.net>,
	"Ingo Molnar" <mingo@elte.hu>, "Darren Hart" <dvhltc@us.ibm.com>,
	"Sven-Thorsten Dietrich" <sdietrich@novell.com>,
	LKML <linux-kernel@vger.kernel.org>
To: "Juergen Beisert" <jbe@pengutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.226]:40732 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763437AbXLTNkJ (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 20 Dec 2007 08:40:09 -0500
Received: by nz-out-0506.google.com with SMTP id s18so1782576nze.1
        for <linux-rt-users@vger.kernel.org>; Thu, 20 Dec 2007 05:40:08 -0800 (PST)
In-Reply-To: <200712201418.17378.jbe@pengutronix.de>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

hello Juergen,

On 12/20/07, Juergen Beisert <jbe@pengutronix.de> wrote:
> On Thursday 20 December 2007 13:45, Jaswinder Singh wrote:
> > So I am curious, if possible, user can switch softirq-threads or IRQs
> > RT tasks to non-RT tasks for slow hardware or least important hardware
> > for NON-RT tasks. So this will improve RT behaviour.
>                     ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> Why?
>
> IMHO: Simply decrease the RT priority of less important IRQs or increase all
> other more important IRQs. IRQs are always more important than other
> processes in a system, also in non RT systems.
>

In RT Kernel we have :-
RT Tasks and Non-RT tasks.

So we can also support :-
RT softirq-threads/IRQs and non-RT softirq-threads/IRQs

So RT softirq-threads/IRQs for RT Tasks
and non-RT softirq-threads/IRQs for non-RT Tasks.

OR also remove Non-RT tasks from RT Kernel and simply decrease the RT
priority of less important task as per your suggestions.

Thank you,

Jaswinder Singh.

> Juergen
> --
> Dipl.-Ing. Juergen Beisert | http://www.pengutronix.de
>  Pengutronix - Linux Solutions for Science and Industry
>     Handelsregister: Amtsgericht Hildesheim, HRA 2686
>          Vertretung Sued/Muenchen, Germany
>    Phone: +49-8766-939 228 |  Fax: +49-5121-206917-9
>
