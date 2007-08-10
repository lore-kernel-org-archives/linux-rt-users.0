From: Arnaldo Carvalho de Melo <acme@ghostprotocols.net>
Subject: Re: How to control IRQ thread priority from inside the driver
Date: Fri, 10 Aug 2007 13:43:39 -0300
Message-ID: <20070810164339.GO3375@ghostprotocols.net>
References: <200708081514.31864.jbe@pengutronix.de> <200708081409.28105.dvhltc@us.ibm.com> <200708091610.58134.jbe@pengutronix.de> <200708091128.44043.dvhltc@us.ibm.com> <3efb10970708100421s1f058d45qa7c9c7b265c0933d@mail.gmail.com> <Pine.LNX.4.58.0708101112490.20808@gandalf.stny.rr.com> <3efb10970708100900q6f799f4cmd72d9f6abc27f7fe@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Darren Hart <dvhltc@us.ibm.com>, Ingo Molnar <mingo@elte.hu>,
	Juergen Beisert <jbe@pengutronix.de>,
	linux-rt-users@vger.kernel.org
To: Remy Bohmer <linux@bohmer.net>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ag-out-0708.google.com ([72.14.246.249]:30502 "EHLO
	ag-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965017AbXHJQns (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 10 Aug 2007 12:43:48 -0400
Received: by ag-out-0708.google.com with SMTP id 35so1133158aga
        for <linux-rt-users@vger.kernel.org>; Fri, 10 Aug 2007 09:43:48 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <3efb10970708100900q6f799f4cmd72d9f6abc27f7fe@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Em Fri, Aug 10, 2007 at 06:00:28PM +0200, Remy Bohmer escreveu:
> Hello Steven,
> 
> > Perhaps adding in a new command line interface (We may need to extend the
> > command line size limit). Where one could do
> > irq_priority_map=10-51,21-40,...  Where the first number is the irq number
> > followed by the irq priority. We can also do something similar to
> > softirqs.
> >
> > Would something like that satisfy your needs?
> 
> Yeah, it would at least suit my needs :-)
> But, the irq-numbers to be defined is hardware specific, and even
> board specific on X86. Maybe someone wants to give a certain interrupt
> handler a different priority, but not a certain IRQ-number to keep it
> possible to use 1 target image usable on multiple boards with  1
> single kernel and 1 single config.
> How to define that on a kernel commandline is still a question to me...

Well, we could use the IRQ name, as given in:

        if (request_irq(pdev->irq, megasas_isr, IRQF_SHARED, "megasas", instance)) {


So it would be something like:

irq_pmap=megasas:90,eth0:40,50

With the last one being the default, if different than the kernel
default, not having the ':' would mean default.
 
- Arnaldo
