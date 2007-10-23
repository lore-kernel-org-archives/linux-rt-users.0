From: Paul Jackson <pj@sgi.com>
Subject: Re: [PATCH -v2 4/7] RT overloaded runqueues accounting
Date: Mon, 22 Oct 2007 21:17:09 -0700
Message-ID: <20071022211709.7be79fea.pj@sgi.com>
References: <20071023025900.927578809@goodmis.org>
	<20071023032916.651749224@goodmis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
	torvalds@linux-foundation.org, akpm@linux-foundation.org,
	mingo@elte.hu, dmitry.adamushko@gmail.com, ghaskins@novell.com,
	a.p.zijlstra@chello.nl
To: Steven Rostedt <rostedt@goodmis.org>,
	Paul Menage <menage@google.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from netops-testserver-4-out.sgi.com ([192.48.171.29]:49658 "EHLO
	relay.sgi.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751484AbXJWERO (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 23 Oct 2007 00:17:14 -0400
In-Reply-To: <20071023032916.651749224@goodmis.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Steven wrote:
> +void cpuset_rt_set_overload(struct task_struct *tsk, int cpu)
> +{
> +	cpu_set(cpu, task_cs(tsk)->rt_overload);
> +}

Question for Steven:

  What locks are held when cpuset_rt_set_overload() is called?

Questions for Paul Menage:

  Does 'tsk' need to be locked for the above task_cs() call?

  Background concern -- one of the things that I like to think has
  allowed cpusets to be useful to others is the careful documentation
  of its locking requirements.  I hope that the cgroup infrastructure,
  and the portions of the cpuset code, such as this task_cs() call,
  that were adapted to work with cgroups, have their locking needs
  documented as well.  I suspect that there is still some presence of
  stale cpuset locking comments, and perhaps an absence of complete
  comments on new cgroup locking needs.  My recollection is that this
  is already on your todo list -- I'm just being annoying here ;).

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
