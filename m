From: Frank Rowand <frank.rowand@am.sony.com>
Subject: Re: [PATCH RT 2/2][RFC] let RCU stall messages escape with CONFIG_PREEMPT_RT_FULL
Date: Mon, 10 Dec 2012 11:08:54 -0800
Message-ID: <50C63346.8000802@am.sony.com>
References: <50BED1DA.7070907@am.sony.com> <50BED305.9090308@am.sony.com> <20121210142914.GP2516@linux.vnet.ibm.com>
Reply-To: <frank.rowand@am.sony.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
	"tglx@linutronix.de" <tglx@linutronix.de>,
	"dipankar@in.ibm.com" <dipankar@in.ibm.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>
To: "paulmck@linux.vnet.ibm.com" <paulmck@linux.vnet.ibm.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from va3ehsobe010.messaging.microsoft.com ([216.32.180.30]:34467
	"EHLO va3outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751595Ab2LJTJB (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 10 Dec 2012 14:09:01 -0500
In-Reply-To: <20121210142914.GP2516@linux.vnet.ibm.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 12/10/12 06:29, Paul E. McKenney wrote:
> On Tue, Dec 04, 2012 at 08:52:21PM -0800, Frank Rowand wrote:
>>
>> The printk()s in RCU stall warnings do not get flushed to the console
>> on ARM.  Add the oops_in_progress flag back into the special trylock case in
>> console_trylock_for_printk(), and set the flag using "bust_spinlocks(1)".
>> This allows the printk() output to be flushed to the console.
>>
>> Signed-off-by: Frank Rowand <frank.rowand@am.sony.com>
> 
> Is bust_spinlocks(1) appropriate for all architectures, or should this
> be conditioned on architectures that need oops_in_progress to be set?
> 
> 							Thanx, Paul

Good question.  I don't know if the architectures that do not set
oops_in_progress do not need it, or if they just overlooked it.
I'll have to look a little bit deeper.

-Frank

