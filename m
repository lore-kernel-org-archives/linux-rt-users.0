From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RT LATENCY] 249 microsecond latency caused by slub's
 unfreeze_partials() code.
Date: Mon, 25 Mar 2013 14:03:33 -0400
Message-ID: <1364234613.6345.184.camel@gandalf.local.home>
References: <1363906545.6345.81.camel@gandalf.local.home>
	 <0000013d92c37ff3-5fb85400-bec1-4eda-8ba1-332566884c59-000000@email.amazonses.com>
	 <1364010673.6345.156.camel@gandalf.local.home>
	 <0000013da1f93be3-c3d42ae8-ff34-4c63-8094-77a83291ea19-000000@email.amazonses.com>
	 <1364227073.6345.182.camel@gandalf.local.home>
	 <1364228039.6345.183.camel@gandalf.local.home>
	 <0000013da2ace21a-9e87fe8a-75c2-4b7c-b5e1-37ad196ce012-000000@email.amazonses.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: LKML <linux-kernel@vger.kernel.org>,
	RT <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Clark Williams <clark@redhat.com>
To: Christoph Lameter <cl@linux.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.122]:32840 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758261Ab3CYSDf (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 25 Mar 2013 14:03:35 -0400
In-Reply-To: <0000013da2ace21a-9e87fe8a-75c2-4b7c-b5e1-37ad196ce012-000000@email.amazonses.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Mon, 2013-03-25 at 17:51 +0000, Christoph Lameter wrote:
> On Mon, 25 Mar 2013, Steven Rostedt wrote:
> 
> > BTW, what impact does setting all cpu_partial files to zero have on the
> > system?
> 
> Slight slowdown in kfree since the frees are less likely to be batched.

If this makes it more deterministic, and lower worse case latencies,
then it's definitely worth the price.

-- Steve


