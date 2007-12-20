From: "Jaswinder Singh" <jaswinderlinuxrt@gmail.com>
Subject: Re: [patch 3/3] Enable setting of IRQ-thread priorities from kernel cmdline. (repost:CC to LKML)
Date: Thu, 20 Dec 2007 17:29:27 +0530
Message-ID: <1985e0f60712200359k6194b0fdn25ead9b5c0835c95@mail.gmail.com>
References: <20071219194551.315868746@bohmer.net>
	 <47697888.143f420a.5466.ffff89ba@mx.google.com>
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
Received: from nz-out-0506.google.com ([64.233.162.229]:33607 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751917AbXLTL72 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 20 Dec 2007 06:59:28 -0500
Received: by nz-out-0506.google.com with SMTP id s18so1755438nze.1
        for <linux-rt-users@vger.kernel.org>; Thu, 20 Dec 2007 03:59:28 -0800 (PST)
In-Reply-To: <47697888.143f420a.5466.ffff89ba@mx.google.com>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 12/20/07, Remy Bohmer <linux@bohmer.net> wrote:
> The RT-patch originally creates all its softirq-threads at
> priority 50.

Is it possible to run softirq-threads or IRQs as a non-realtime tasks
in RT kernel.

If yes, then how.

Thank you,

Jaswinder Singh.
