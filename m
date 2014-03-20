From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH]sched/rt: Do not try to push tasks if pinned task
 switches to RT
Date: Thu, 20 Mar 2014 14:21:39 -0400
Message-ID: <20140320142139.04a40e66@gandalf.local.home>
References: <4451359470707@web16g.yandex.ru>
	<20140312061833.3a43aa64@gandalf.local.home>
	<20140312103942.GB5321@opentech.at>
	<3618231394627028@web10g.yandex.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Nicholas Mc Guire <der.herr@hofr.at>,
	Peter Zijlstra <peterz@infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Ingo Molnar <mingo@kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: Kirill Tkhai <tkhai@yandex.ru>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <3618231394627028@web10g.yandex.ru>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Wed, 12 Mar 2014 16:23:48 +0400
Kirill Tkhai <tkhai@yandex.ru> wrote:

> > would there not need to be a check for p->migrate_disable ?
> > push_rt_task() is not checking and so a high prio RT task
> > preemting a low prio RT task in a migrate_disable() section
> > would actually push it off this cpu ? atleast I did not
> > find why that would not happen.
> 
> Hi, Nicholas!
> 
> p is not rq->curr, so its p->migrate_disable state is already updated and
> it can't be pushed (nr_cpus_allowed == 1 and it's not pushable).
> 
> (If I understand right, that you worry about this).
> 

Correct. If p has migrate_disabled set and scheduled out, then when it
gets scheduled out, its cpu affinity gets set to only the current cpu
and nr_cpu_allowed to 1. No need to check here if p->migrate_disabled is
set.

-- Steve
