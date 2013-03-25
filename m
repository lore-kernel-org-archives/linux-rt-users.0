From: Christoph Lameter <cl@linux.com>
Subject: Re: [RT LATENCY] 249 microsecond latency caused by slub's
 unfreeze_partials() code.
Date: Mon, 25 Mar 2013 17:51:11 +0000
Message-ID: <0000013da2ace21a-9e87fe8a-75c2-4b7c-b5e1-37ad196ce012-000000@email.amazonses.com>
References: <1363906545.6345.81.camel@gandalf.local.home> <0000013d92c37ff3-5fb85400-bec1-4eda-8ba1-332566884c59-000000@email.amazonses.com> <1364010673.6345.156.camel@gandalf.local.home> <0000013da1f93be3-c3d42ae8-ff34-4c63-8094-77a83291ea19-000000@email.amazonses.com>
 <1364227073.6345.182.camel@gandalf.local.home> <1364228039.6345.183.camel@gandalf.local.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: LKML <linux-kernel@vger.kernel.org>,
	RT <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Clark Williams <clark@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1364228039.6345.183.camel@gandalf.local.home>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Mon, 25 Mar 2013, Steven Rostedt wrote:

> BTW, what impact does setting all cpu_partial files to zero have on the
> system?

Slight slowdown in kfree since the frees are less likely to be batched.
