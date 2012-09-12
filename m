From: Jon Masters <jcm@redhat.com>
Subject: Re: [PATCH RT] hwlat_detector: Check the outer side of the loop
Date: Wed, 12 Sep 2012 10:57:28 -0400
Message-ID: <5050A2D8.7080908@redhat.com>
References: <1347460451.10751.57.camel@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: LKML <linux-kernel@vger.kernel.org>,
	RT <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Darren Hart <dvhart@linux.intel.com>,
	Clark Williams <clark@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1347460451.10751.57.camel@gandalf.local.home>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On 09/12/2012 10:34 AM, Steven Rostedt wrote:
> The hwlat_detector performs the following test:
>
> 	t1 = ktime_get();
> 	t2 = ktime_get();
>
> 	[ do the checks of t2 - t1 ]
>
> It can detect things like SMIs if it occurs between the t1 and t2
> timestamps, as there will be a large difference between the two.

Oops. Good catch.

Jon.
