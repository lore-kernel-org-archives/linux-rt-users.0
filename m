From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH RT] dont calculate hweight in update_migrate_disable
Date: Fri, 28 Mar 2014 10:35:33 +0100
Message-ID: <20140328093533.GA14842@linutronix.de>
References: <20140324121848.GA18300@opentech.at>
 <20140324101800.3f978842@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Nicholas Mc Guire <der.herr@hofr.at>,
	linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	tglx@linutronix.de, Peter Zijlstra <peterz@infradead.org>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20140324101800.3f978842@gandalf.local.home>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

* Steven Rostedt | 2014-03-24 10:18:00 [-0400]:

>On Mon, 24 Mar 2014 13:18:48 +0100
>Nicholas Mc Guire <der.herr@hofr.at> wrote:
>
>> Proposal for a minor optimization in update_migrate_disable - its only a few 
>> instructions saved but those are in the hot path of locks so it might be worth
>> it
>Reviewed-by: Steven Rostedt <rostedt@goodmis.org>

Applied.

>
>-- Steve

Sebastian
