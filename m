From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH RT 1/3] rt: Move migrate_disable up in trylocks
Date: Fri, 2 May 2014 09:06:26 -0400
Message-ID: <20140502090626.1467f8f2@gandalf.local.home>
References: <20140501004757.583708392@goodmis.org>
	<20140501005004.241785945@goodmis.org>
	<5363451B.8080300@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	John Kacur <jkacur@redhat.com>,
	Paul Gortmaker <paul.gortmaker@windriver.com>,
	Mike Galbraith <umgwanakikbuti@gmail.com>,
	Nicholas Mc Guire <der.herr@hofr.at>,
	Clark Williams <williams@redhat.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5363451B.8080300@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Fri, 02 May 2014 09:11:23 +0200
Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:

> On 05/01/2014 02:47 AM, Steven Rostedt wrote:
> 
> Could this wait until it appears in the development release?

I would need to delay the release then as I wont release a kernel that
fails the cpu stress test.

I don't have a problem with delaying this though.

-- Steve
