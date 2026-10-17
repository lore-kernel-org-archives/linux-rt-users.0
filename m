Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 719BD4854F0
	for <linux-rt-users@vger.kernel.org>; Sat, 17 Oct 2026 12:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792239275; cv=none; b=t40d9PXglGWEFqBDvuUt4s0sxKhWCHhYky5HUgB+KMzml6OXB0H7R0DX7QgYhDDZJACyRCB/dpYfMfby3FF9ggLLDkzF3HQLIhN5KbgtMxkHAuECanaMurP+QZ6ZhSOv+eEqyqGj63F6Pf+O+MvVpynkO59WWmAruar1Wn//RCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792239275; c=relaxed/simple;
	bh=YSk8+ZJeyU6lUWnetAhWqjXfnDgXJ+FhsYf+NkXzx/M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LCa/EvCrpjF9qbenqOEV1pUgzq+Lqgnm86cGBiAKP9L3ZaFLDo/J8P2cY/XaGdQoze1QYMFw5AgsdgE6Zmjol/4MwvxEB4BgI1jVJSEk2ajCCHxOeNyKdRLZQ4XWWIwBlaK2hceQP3uiPwS+STFxhC6VUerTA0Bv5uOKIrzhxM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YaoTpNAF; arc=none smtp.client-ip=74.125.82.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YaoTpNAF"
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-17bc533fda3so854985c88.1
        for <linux-rt-users@vger.kernel.org>; Sat, 17 Oct 2026 05:14:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792239273; x=1792844073; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Z66yztvANzuR9me/cFTc8jCAnqYHFfuYz2a0mwZJbfI=;
        b=YaoTpNAFQmAnFqbV9HyNnLhoSSxYBMSfworzXbO2Ar/m6gpRDmr7fpGiuWPLRkQ64S
         Eh8DSO+x8FZdhP886JD9C9z0IkNvrQacpO+1Mw1OnV2fiWHayvAN6CVJYIp1pYiRL/Uf
         fPCExMElGAFlisVZ5ocjdfa3W8cOmeE4nP9fxAIktDM1QfM/VNE/DScREtUxRIy+ckOH
         qrfQrIWxROe6uPgm3A1DizQbTVv6pu+sConfaZD7WPbOeQl77XYPqJE8/p3k23ptUu1o
         HC/BKPwcKHoxp57QDYV4rMNXgNPP3QTAs/TX37KtAOW91QTL6N97OFA6Jtxm0mQ2RIKM
         7lQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792239273; x=1792844073;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Z66yztvANzuR9me/cFTc8jCAnqYHFfuYz2a0mwZJbfI=;
        b=1SpCpPAyIBFi1LAynEdCTWTLXQCfB84s7NqGMDwqzE8Mp3SfS3rdOiVysujI8Pe2AU
         +k9JdfLjI42C0ZDThnD2U71m+ZopVtSwOf0QMgyvAdor3Orf/R6oTX59dYHzB44h8pza
         ikgxeq92iidp8pq45Qh1PIxkBaZqbgifIpUCaof/cGcYErLlzzf+XKohieOyE8DO+55N
         rRm7hCJ4Np0Q5q/01r9i2yXQqVQhsLScD0jT7ztpLibmZs/Etr7GoGEsPkPBEAbo3l1V
         PLE6k6WUhFO45LnHsITTLZuk9uLUgayrd2ql/jvVJCC36MvKJK1Rc0j/dtLrvnWaZ4yy
         dl7w==
X-Forwarded-Encrypted: i=1; AKwUvBy/NPCfnsSNnCHguUJ/78OGkahGQU8zZOwlrQK0mEdMHJLZhDrOHMaXnDbLIpkku04HOd5hzFuEeA11ZUsONA==@vger.kernel.org
X-Gm-Message-State: AFq9FYIIgWGAo9zhMD/VqkswRYtXQWUbt6AZnhIhL+DUnztOnZRRe+14
	QN0WFXl7ewpyrdp7mj57U6nsroTLI4Cu/MLJdnfpIECeryX1/uCBuGiJ
X-Gm-Gg: AYBFou1KD0xZUeGiFgYoZyuNRxD85lWTaBcyrwn6qry4Au6k0l4n8Rp0Lp7wQIs52S4
	WUxtJd9DUoBh8Eug9ECWHcEga9l6xIGBLiQuEwYI5oMbTPGoMR5mvJIzratJaq6TGd+4YVsEZwp
	/rOJ/vEId8KfE6mLhUn8vkpV6rbn7r9ahHsFNcTTCUCHbXtYppfFcUD7+6UO1XPLRa7Zeglzck8
	Sg4te2n3BdIxwzL1Bu+CaLbgw4JH8v3CAaIjDNL09zHjZC7N6VEUAMHD7ChW116t2ra4W5UDKQv
	/G/Z6rP0jVVUPWQwH7lL/kQUtZKHItsRypaA+BUfn9kKezsjb2+uvDeydyYmBwRPRxYykRQR+a0
	I3GHC9OysL6eA0sKp+/sQ2BEJfkjx4v/jMKcZ7oPaVPCS++GM/eB964vITLIOxqtzOjyzVILqkZ
	fPKT4SGucrmhlg/JfmPCsab9QVTVnc3UMGcJr55mWxAFldzQXkb6nmnf2Z1kEm40/XLcMyPreO3
	3eH8e31fKBUMLNXKfys5YhXeGrIE/0a6h+cjspg8yYir7c=
X-Received: by 2002:a05:701b:4651:20b0:137:5b9d:cf87 with SMTP id a92af1059eb24-1850714476fmr3704983c88.0.1792239273223;
        Sat, 17 Oct 2026 05:14:33 -0700 (PDT)
Received: from chaosheng-ASUS-TUF-Gaming-F16-FX607JV-FX607JV.lan ([183.242.161.82])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-18314ef8ed8sm13101116c88.3.2026.10.17.05.14.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2026 05:14:32 -0700 (PDT)
From: Chaosheng Qu <chaosheng.qu.linux@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Peter Zijlstra <peterz@infradead.org>
Cc: Martin King <martin3kx@gmail.com>,
	Thorsten Leemhuis <regressions@leemhuis.info>,
	regressions@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-rt-users@vger.kernel.org
Subject: [PATCH] sched/rt: queue a push when a queued RT task is boosted
Date: Sat, 17 Oct 2026 20:14:23 +0800
Message-ID: <20261017121423.393837-1-chaosheng.qu.linux@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261015061915.126442-1-chaosheng.qu.linux@gmail.com>
References: <CAEB5A_91hob8ddOhW=PrO1=O7GrFmSxY3r1-_Ard6x8KHHuJGA@mail.gmail.com> <20260814183652.611e7ecf@gandalf.local.home> <6db9c47f-a1f8-49dd-9e80-f9014d75f9e8@leemhuis.info> <20260903092037.5b739980@gandalf.local.home> <20261015061915.126442-1-chaosheng.qu.linux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Steve, Peter, Martin,

Two things: a correction to my previous message, and a patch that follows
from your suggestion.

First, the correction. In my last mail I quoted this trace pair to argue
that the non-PUSH push only happens when the hog leaves:

  hog-113 [001] d..3. 50.615178: sched_migrate_task: comm=owner prio=9 orig_cpu=1 dest_cpu=3
  hog-131 [001] d..2. 70.614471: sched_switch: prev_comm=hog prev_state=X

The second line is wrong. It does not appear in any of my logs; I
assembled it from a different run and mislabelled the timestamps. The
first line is real (aff-multi.log, the 4 s dwell run). It does not change
the conclusion - in the 1.5 s dwell runs the owner still resumes at a
median of 1499.6 ms and 0/8 meet a 100 ms bound - but the quoted trace was
not what I said it was, and I would rather correct that now than have it
found later.

Second, the instrumented follow-up you asked for. I put kprobes on
pull_rt_task(), push_rt_task(), push_rt_tasks(), prio_changed_rt(),
enqueue_pushable_task(), pick_next_pushable_task() and
find_lock_lowest_rq(), on the same 4-vCPU non-PREEMPT_RT config. The
picture is tighter than what I described before:

- pull is reached, and immediately. On the boost, waiter blocks, cpu2
  goes idle, and pull_rt_task(cpu2) runs between 5 and 99 us later. It
  comes back empty. The reason it comes back empty is the affinity test in
  task_is_pushable(): pick_highest_pushable_task(src_rq=cpu1,
  this_cpu=cpu2) requires cpu2 to be in the boosted task's cpus_mask. In
  my scenario the mask is {1,3}, so it is not. When I widen the mask to
  {1,2} the very same code pulls the owner to cpu2 within 2 us, so the
  affinity test is the whole difference.
- push is not queued at the boost. prio_changed_rt() runs, and nothing
  queues a push from it. I kept the full trace for three clean runs: in
  all three the first balancer event after the boost is pull_rt_task(cpu2)
  at +5..+99 us, there is no push_rt_task()/push_rt_tasks() for the whole
  1.5 s dwell, and the owner never migrates - it just waits the hog out.
  Being precise, OFF is not "never pushes": in other runs a push does
  appear on cpu1, but it is entered from the hog's own scheduling path
  (the trace attributes it to the hog thread), not from the boost, and it
  lands whenever that path next happens to run - which is why the few
  runs that do escape land anywhere between 62 ms and 1.2 s. Across all my
  OFF runs (n=17) only one met a 100 ms bound; the median is 1498.5 ms.

So the non-PUSH path loses the task because both sides miss it: pull
cannot select it (affinity), and push is not requested at the boost. That
matches what you wrote - the boost should trigger another analysis of RT
migration, and we do not do that.

The patch below does exactly that: when a queued, non-current RT task's
priority is raised, ask its rq for a push. The push selects a target from
the task's own cpus_mask via find_lowest_rq(), which is the selection the
pull side could not make. rt_mutex_setprio() already ends with
__balance_callbacks(), so the callback runs inside the same rq->lock
section, on the same path as the existing rt_queue_pull_task().

A/B on the same tree, same config, same probe, only this patch different:

  OFF, mask {1,3}       before: 1/17 timely, median 1498.5 ms
                        after: 13/13 timely, median 4.8 ms (0.6-59.6)
  no boost (control)    before: 0/2 migrated, median 1498.2 ms
                        after: 0/3 migrated, median 1499.2 ms
  ON (RT_PUSH_IPI)      before: 3/3, median 3.06 ms
                        after: 5/5, median 0.72 ms

The control row is the one I would look at: with no boost there is no
legal target (cpu3's spare at FIFO 60 is more urgent than the owner at
FIFO 10), so the new push finds nothing and I did not observe any
migration, same as before the patch. The patch only acts when a real
migration opportunity exists.

With the patch, the mechanism is visible in trace:

  waiter-109 [002] 51.667482: prio_changed_rt
  waiter-109 [002] 51.667695: push_rt_tasks
  waiter-109 [002] 51.667739: pick_next_pushable_task
  waiter-109 [002] 51.667955: find_lock_lowest_rq
  waiter-109 [002] 51.669068: sched_migrate_task: comm=owner prio=9 orig_cpu=1 dest_cpu=3

Caveats, since this is a first cut: measured only on a KASAN +
PROVE_LOCKING debug config, only non-PREEMPT_RT, only this synthetic
topology, not on Martin's REAPER workload. I did compile-test the UP
build (build_policy.o, CONFIG_SMP=n) and it builds; the PREEMPT_RT
combination I could not build here because this tree has no RT patch set,
so it is untested.
One scope note: prio_changed_rt() is reached from sched_change_end() for
ordinary sched_setscheduler()/sched_setattr() priority changes as well,
not just PI boosts, so this would also queue a push when a queued RT task
is raised by userspace. That case looks symmetric to me but I have not
A/B'd it; say the word if you would rather gate this on pi_top_task. I
have not flipped any default and I am not proposing to.

One more thing, in case it is useful, and it may be the real reason
nobody has touched this: the prio_changed_rt() push omission is not
recent. I walked the function through 15 revisions back to 2007 and none
of them queued a push, so this looks like it has been there since the
non-PUSH fallback was introduced, which is consistent with your guess
that the PUSH path was covering for it.

Happy to respin, narrow it, or drop it if the direction is wrong.

Thanks,
Chaosheng


A PI boost can leave a queued RT task stuck on a runqueue it cannot run
on. The pull side cannot help: pull_rt_task() on another CPU only picks
tasks whose affinity includes that CPU, so when the boosted task's
cpus_mask excludes the CPU that just went idle it is never selected. The
push side is never asked either: prio_changed_rt() only queues a pull.

In a four-vCPU non-PREEMPT_RT guest with RT_PUSH_IPI off, a FIFO-10 task
holding a PI mutex, boosted to FIFO 90 by a waiter on another CPU while a
FIFO-99 hog keeps its own CPU busy, stayed queued for the whole 1.5 s
dwell while a FIFO-60 spare sat idle on a CPU that was in its mask. With
RT_PUSH_IPI on the same setup resumed in under 6 ms.

Queue a push from prio_changed_rt() when a queued, non-current RT task has
its priority raised. The push selects its target from the task's own
cpus_mask, which is exactly the selection the pulling CPU cannot make.
RT_MUTEXES already arranges for __balance_callbacks() to run inside the
same rq->lock section, so this is the same delivery path as the existing
rt_queue_pull_task().

With no boost present there is no legal target and the push finds
nothing, so behaviour is unchanged.

Signed-off-by: Chaosheng Qu <chaosheng.qu.linux@gmail.com>
---
 kernel/sched/rt.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 85303add7..13d505470 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -2499,6 +2499,17 @@ prio_changed_rt(struct rq *rq, struct task_struct *p, u64 oldprio)
 		 */
 		if (p->prio < rq->donor->prio)
 			resched_curr(rq);
+
+		/*
+		 * A boost can create a migration opportunity that the pull
+		 * side cannot reach: pull_rt_task() on another CPU only picks
+		 * tasks whose affinity includes that CPU, so a task that gets
+		 * boosted while its CPUs are busy can stay queued until it
+		 * becomes current. Queue a push on this rq instead, which
+		 * selects a target from the task's own affinity.
+		 */
+		if (p->prio < oldprio && rq->rt.overloaded)
+			rt_queue_push_tasks(rq);
 	}
 }
 
-- 
2.43.0
