From: "Jaswinder Singh" <jaswinderlinuxrt@gmail.com>
Subject: Re: 2.6.23-rc9-rt2
Date: Mon, 8 Oct 2007 20:04:24 +0530
Message-ID: <1985e0f60710080734y4897a8e1ke253b6d4273146ec@mail.gmail.com>
References: <1191536413.5210.19.camel@localhost.localdomain>
	 <1985e0f60710070635l7016bad1t9c4d4cb1a966534f@mail.gmail.com>
	 <Pine.LNX.4.58.0710080951270.4846@gandalf.stny.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: LKML <linux-kernel@vger.kernel.org>,
	RT <linux-rt-users@vger.kernel.org>,
	"Ingo Molnar" <mingo@elte.hu>,
	"Thomas Gleixner" <tglx@linutronix.de>
To: "Steven Rostedt" <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.249]:24016 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751894AbXJHOe0 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 8 Oct 2007 10:34:26 -0400
Received: by an-out-0708.google.com with SMTP id d31so136624and
        for <linux-rt-users@vger.kernel.org>; Mon, 08 Oct 2007 07:34:25 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.58.0710080951270.4846@gandalf.stny.rr.com>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hi Steve,

On 10/8/07, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> --
> On Sun, 7 Oct 2007, Jaswinder Singh wrote:
>
> > Do you have any plans to support nested or reentrant Interrupt Handling schemes.
> >
>
> Hi Jaswinder,
>
> Not sure what you mean by this, since interrupt handlers are run as
> threads and are fully preemptible.
>

I think by nested or reentrant interrupt handling technique you can
further reduce latencies.
what you think.

Can we can get guaranteed realtime throughput by using these realtime patch.

Thank you,

Jaswinder SIngh.
