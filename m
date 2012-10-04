From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH RT] softirq: Init softirq local lock after per cpu
 section is set up
Date: Thu, 04 Oct 2012 11:29:44 -0400
Message-ID: <1349364584.6755.20.camel@gandalf.local.home>
References: <1349362924.6755.18.camel@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 7bit
Cc: RT <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Clark Williams <clark@redhat.com>,
	John Kacur <jkacur@redhat.com>, Carsten Emde <cbe@osadl.org>,
	vomlehn@texas.net
To: LKML <linux-kernel@vger.kernel.org>, stable-rt@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1349362924.6755.18.camel@gandalf.local.home>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Thu, 2012-10-04 at 11:02 -0400, Steven Rostedt wrote:

> By moving the softirq_early_init() right after setup_per_cpu_areas(),
> the kernel boots fine.
>
> Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
> 

Bah, I forgot to Cc stable-rt.

Cc: stable-rt@vger.kernel.org

-- Steve
