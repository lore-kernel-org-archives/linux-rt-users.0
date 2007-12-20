From: "Jaswinder Singh" <jaswinderlinuxrt@gmail.com>
Subject: Re: [patch 2/3] Enable setting of IRQ-thread priorities from kernel cmdline (repost:CC to LKML)
Date: Thu, 20 Dec 2007 17:32:23 +0530
Message-ID: <1985e0f60712200402p78d453ffs240e02a8cd4bbd51@mail.gmail.com>
References: <20071219194551.315868746@bohmer.net>
	 <47697882.2275420a.3951.ffff92ed@mx.google.com>
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
To: "Remy Bohmer" <linux@bohmer.net>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.225]:35669 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761423AbXLTMCZ (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 20 Dec 2007 07:02:25 -0500
Received: by nz-out-0506.google.com with SMTP id s18so1756083nze.1
        for <linux-rt-users@vger.kernel.org>; Thu, 20 Dec 2007 04:02:24 -0800 (PST)
In-Reply-To: <47697882.2275420a.3951.ffff92ed@mx.google.com>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 12/20/07, Remy Bohmer <linux@bohmer.net> wrote:
>  	struct task_struct	*thread;
> +	int                     rt_prio;
>  	wait_queue_head_t	wait_for_handler;

int rt_prio or unsigned int rt_prio, which one is better.

Thank you,

Jaswinder SIngh.
