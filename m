From: Mike Galbraith <umgwanakikbuti@gmail.com>
Subject: Re: [PATCH RT 0/4] Linux 3.12.22-rt35-rc1
Date: Thu, 03 Jul 2014 07:28:46 +0200
Message-ID: <1404365326.5137.76.camel@marge.simpson.net>
References: <20140702171414.482562827@goodmis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	John Kacur <jkacur@redhat.com>,
	Paul Gortmaker <paul.gortmaker@windriver.com>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140702171414.482562827@goodmis.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


On Wed, 2014-07-02 at 13:14 -0400, Steven Rostedt wrote: 
> Dear RT Folks,
> 
> This is the RT stable review cycle of patch 3.12.22-rt35-rc1.
> 
> Please scream at me if I messed something up. Please test the patches too.

[PATCH RT 5/4] sched: Do not clear PF_NO_SETAFFINITY flag in select_fallback_rq() ?

-Mike
