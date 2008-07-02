From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: 2.6.24-rc8-rt1: Strange latencies on mpc5200 powerpc - RCU issue?
Date: Wed, 02 Jul 2008 10:09:35 +0200
Message-ID: <486B37BF.6030107@grandegger.com>
References: <47976D06.1010900@grandegger.com> <479DF0A1.3000906@pengutronix.de> <479DF711.5090406@grandegger.com> <479F186A.4020004@pengutronix.de> <479F2C3C.1020203@grandegger.com> <20080130010716.GB16069@linux.vnet.ibm.com> <47A032E9.4080105@grandegger.com> <20080130102255.GA24890@linux.vnet.ibm.com> <47A0552D.20605@grandegger.com> <20080130105715.GE24890@linux.vnet.ibm.com> <20080130111559.GC20089@pengutronix.de> <486A3EBB.6030905@grandegger.com> <Pine.LNX.4.58.0807011036510.26650@gandalf.stny.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
	Luotao Fu <l.fu@pengutronix.de>,
	LKML <linux-kernel@vger.kernel.org>,
	RT <linux-rt-users@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
	Thomas Gleixner <tglx@linutronix.de>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.9]:53219 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751023AbYGBIJC (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 2 Jul 2008 04:09:02 -0400
In-Reply-To: <Pine.LNX.4.58.0807011036510.26650@gandalf.stny.rr.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Steven Rostedt wrote:
> On Tue, 1 Jul 2008, Wolfgang Grandegger wrote:
>> I continue this thread because it's still not understood why enabling
>> CONFIG_RCU_TRACE is necessary to get reasonable latencies on the
>> MPC5200. It might also explain, why I get much worse latencies with
>> 2.6.25.8-rt7.
> 
> Have you tried turning on ftrace?

Hm, is it available for PowerPC? I have not found yet how to enable it.

Wolfgang.
