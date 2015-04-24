From: Mike Galbraith <umgwanakikbuti@gmail.com>
Subject: Re: [PATCH RT 3.18] irq_work: Provide a soft-irq based queue
Date: Fri, 24 Apr 2015 11:59:37 +0200
Message-ID: <1429869577.3587.4.camel@gmail.com>
References: <552FC1FE.4020406@siemens.com> <552FC6B1.1040000@linutronix.de>
	 <552FC72A.8060709@siemens.com> <20150416111041.66043164@gandalf.local.home>
	 <552FD55F.8000105@siemens.com> <552FE320.6050601@siemens.com>
	 <1429517036.3226.9.camel@gmail.com> <1429769505.3419.9.camel@gmail.com>
	 <55389632.50308@siemens.com> <1429772482.3419.40.camel@gmail.com>
	 <55389B67.3000703@siemens.com> <1429773566.3419.42.camel@gmail.com>
	 <20150423170026.0de65c90@gandalf.local.home>
	 <1429858489.3461.28.camel@gmail.com> <553A062D.6090608@siemens.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	RT <linux-rt-users@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
To: Jan Kiszka <jan.kiszka@siemens.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <553A062D.6090608@siemens.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Fri, 2015-04-24 at 11:00 +0200, Jan Kiszka wrote:

> The approach looks good to me, but the commit log deserves a rework now.

Yeah.  While you're at it, you should change my chop to an ack or a
tested-by too, as it's your patch, I just rearranged a bit.

	-Mike
