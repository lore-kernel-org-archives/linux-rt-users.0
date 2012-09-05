From: Frank Rowand <frank.rowand@am.sony.com>
Subject: Re: Pthread Condition Variables and Priority Inversion
Date: Wed, 5 Sep 2012 16:59:05 -0700
Message-ID: <5047E749.3040507@am.sony.com>
References: <5047DD91.3030402@linux.intel.com>
Reply-To: <frank.rowand@am.sony.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Thomas Gleixner <tglx@linutronix.de>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: Darren Hart <dvhart@linux.intel.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from tx2ehsobe001.messaging.microsoft.com ([65.55.88.11]:48889 "EHLO
	tx2outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755182Ab2IEX7F (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 5 Sep 2012 19:59:05 -0400
In-Reply-To: <5047DD91.3030402@linux.intel.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 09/05/12 16:17, Darren Hart wrote:
> Hi Michael,
> 
> I've tried many times over the last several years to get proper priority
> inheritance support for pthread condition variables added to glibc.
> Unfortunately, I haven't convinced the powers that be to incorporate the
> proposed fixes. Since the failure scenario involves an opaque type and
> is rather non-intuitive, it was suggested (thanks Frank) that I attempt
> to at least document the behavior.

< snip >

That reminds me...  someone at Plumbers (I'm pretty sure it was Thomas)
told me that the glibc maintainers have become much more responsive,
so maybe I should encourage you to try once again, when you find some
spare time :-), submitting to glibc.

-Frank

