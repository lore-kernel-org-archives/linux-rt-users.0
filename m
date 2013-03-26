From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RT LATENCY] 249 microsecond latency caused by slub's
 unfreeze_partials() code.
Date: Tue, 26 Mar 2013 12:52:17 -0400
Message-ID: <1364316737.6345.192.camel@gandalf.local.home>
References: <1363906545.6345.81.camel@gandalf.local.home>
	 <0000013d92c37ff3-5fb85400-bec1-4eda-8ba1-332566884c59-000000@email.amazonses.com>
	 <1364010673.6345.156.camel@gandalf.local.home>
	 <0000013da1f93be3-c3d42ae8-ff34-4c63-8094-77a83291ea19-000000@email.amazonses.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: LKML <linux-kernel@vger.kernel.org>,
	RT <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Clark Williams <clark@redhat.com>
To: Christoph Lameter <cl@linux.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.122]:29653 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751081Ab3CZQwU (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 26 Mar 2013 12:52:20 -0400
In-Reply-To: <0000013da1f93be3-c3d42ae8-ff34-4c63-8094-77a83291ea19-000000@email.amazonses.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Mon, 2013-03-25 at 14:34 +0000, Christoph Lameter wrote:

> You can eliminate the whole thing by setting
> 
> /sys/kernel/slab/<whatever/cpu_partial
> 
> to zero.

Giving you an update.

I did the following:

# ls /sys/kernel/slab/*/cpu_partial | while read f; do
	echo 0 > $f
done


Then ran our test suite for 24 hours, and had a max latency of 135
microseconds. Well within our range for such a machine. Seems this is
definitely the cause of our latencies, as before, we would always
trigger a unacceptable latency within 12 hours.

Thanks for your help!

-- Steve


