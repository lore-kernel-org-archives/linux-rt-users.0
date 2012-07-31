From: Frank Rowand <frank.rowand@am.sony.com>
Subject: Re: [PATCH RT 05/12] slab: Prevent local lock deadlock
Date: Tue, 31 Jul 2012 14:52:25 -0700
Message-ID: <50185399.4060104@am.sony.com>
References: <20120718223910.898476857@goodmis.org>			 <20120718223957.856443728@goodmis.org> <5011DD9B.1030901@am.sony.com>		 <1343697755.27983.17.camel@gandalf.stny.rr.com>		 <50174158.4000408@am.sony.com>	 <1343701935.27983.18.camel@gandalf.stny.rr.com>	 <50182B44.8090100@am.sony.com> <1343761902.27983.67.camel@gandalf.stny.rr.com>
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
Received: from tx2ehsobe002.messaging.microsoft.com ([65.55.88.12]:56902 "EHLO
	tx2outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753640Ab2GaVwt (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 31 Jul 2012 17:52:49 -0400
In-Reply-To: <1343761902.27983.67.camel@gandalf.stny.rr.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 07/31/12 12:11, Steven Rostedt wrote:
> On Tue, 2012-07-31 at 12:00 -0700, Frank Rowand wrote:
> 
>>> Yeah, my root fs is on the sdcard. Did you get this bug every time or
>>> was it sporadic?
>>
>> I get it every boot.
> 
> Can you try it with an SD card? I can set it up for nfs as well, but
> that would take a bit of time.

That would turn into a project for me, not likely to get to it soon.
But I'll put it on my "try to get to" list.

-Frank

