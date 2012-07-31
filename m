From: Frank Rowand <frank.rowand@am.sony.com>
Subject: Re: [PATCH RT 05/12] slab: Prevent local lock deadlock
Date: Tue, 31 Jul 2012 12:00:20 -0700
Message-ID: <50182B44.8090100@am.sony.com>
References: <20120718223910.898476857@goodmis.org>		 <20120718223957.856443728@goodmis.org> <5011DD9B.1030901@am.sony.com>	 <1343697755.27983.17.camel@gandalf.stny.rr.com>	 <50174158.4000408@am.sony.com> <1343701935.27983.18.camel@gandalf.stny.rr.com>
Reply-To: <frank.rowand@am.sony.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 7bit
Cc: "Rowand, Frank" <Frank_Rowand@sonyusa.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>,
	"chris.pringle@miranda.com" <chris.pringle@miranda.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Carsten Emde <C.Emde@osadl.org>, John Kacur <jkacur@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from co1ehsobe004.messaging.microsoft.com ([216.32.180.187]:36583
	"EHLO co1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753628Ab2GaTAi (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 31 Jul 2012 15:00:38 -0400
In-Reply-To: <1343701935.27983.18.camel@gandalf.stny.rr.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 07/30/12 19:32, Steven Rostedt wrote:
> On Mon, 2012-07-30 at 19:22 -0700, Frank Rowand wrote:
>> On 07/30/12 18:22, Steven Rostedt wrote:
>>> On Thu, 2012-07-26 at 17:15 -0700, Frank Rowand wrote:
>>>
>>>>
>>>> Config is from arch/arm/configs/omap2plus_defconfig
>>>> plus:
>>>>
>>>>    CONFIG_USB_EHCI_HCD=y
>>>>    CONFIG_USB_NET_SMSC95XX=y
>>>>    CONFIG_PREEMPT_RT_FULL=y
>>>>
>>>
>>> Interesting, I just booted my panda board against 3.0.36-rt58 with that
>>> config and these three set, and I didn't get this error.
>>
>> I don't know if it makes any difference, but my root fs is nfs mounted.
>>
>> I'll try to look at this some more tomorrow.
>>
> 
> Yeah, my root fs is on the sdcard. Did you get this bug every time or
> was it sporadic?

I get it every boot.

-Frank

