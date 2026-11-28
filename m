Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.3
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795845096;
	b=drhnq/WUP7TplqEZvfBhYKyY0cc4EpS+1IKnyi3nkJu0cVocrqrZFtbeCUZ3bR5SiPrL
	 FUQWR8WMuZJYCyOXpsiCONgQCLHULL+QcLAHUrjlNc6ftqR/uNZsTHpZ0iL7VB25TYzM8
	 mBTwzxE6ENRS5eC450HSkrGcC5V0q3i+nVvFKq0dM6UlWP9GxkhDfxD0xROSaQp7rU4pR
	 2sNUW1QE5wCkq+h148dXqZSxqxPDfvYkZcxo19R+ceaay1ogHlI0M8VtJW80g0lw6ZGHg
	 1TkdZShU2drszabbafWPdDF5R4qBFezCcf+iM/5/Q0JZVR2X8NKYm9y5oaPksZjC+zw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795845096;
	h=DMARC-Filter:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=xLisQ8fK2j6GbzDEjaVHMdpoYENNCtntIZVkkTX+jFU=;
	b=tded5CT0yJzUwmgIXRUh1ShUTTXnA0gU1rG0rYw/B54Ehi1tlJM6ZrTmM3O9Xgnz0RQQ
	 atKj33lzKR+Zrgtr5qDvEnomUpmrfvysatHi12V1H4om1xn4xNnIFAxVCg5vZGmomaXaI
	 4WSfafnUFV/n3MHafrMNdeTiToDvbVcwiNE4pu7IepS9WORukkM3wZCPTap7uAKW8H3JO
	 akCjx+Od/e7oAGBJMdZpyX+8j+E/I3XtXx4ibMQJZ7+ZsTF2g+fiYhH7q445wTwGU5E/2
	 ZSuh6suR5ufDkIJYAlQxj7X5UbmBK/hEanYdDw8ZN7TFQpRN4saJT83Ztkp5+iTDusw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b="SGaQA/io";
	arc=none smtp.remote-ip=220.197.31.3
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4F1D606A31C;
	Sat, 28 Nov 2026 05:51:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C4F1D606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=SGaQA/io
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version:
	Content-Type; bh=xLisQ8fK2j6GbzDEjaVHMdpoYENNCtntIZVkkTX+jFU=;
	b=SGaQA/ioMptE49DZ965muEZzuXvWNfqkN6Xtx9rahVIPTZrc4UGuWmKW0T5sK0
	fyvXu/VLhcSWGgFUvvQ7rCgPvkTeB12NMUj/P88QiMn7MLabhivw2Drdxg0W+LoD
	T/AQHVrX1TMUF6CWThDz5+VYu+BTyCXIwI6UDoHpOYEMo=
From: Chaosheng Qu <quchaosheng000406@163.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Steven Rostedt <rostedt@goodmis.org>, Martin King <martin3kx@gmail.com>, Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, Thorsten Leemhuis <regressions@leemhuis.info>, regressions@lists.linux.dev, linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Subject: Re: [PATCH] sched/rt: push a queued task when its priority is boosted
Date: Sat, 28 Nov 2026 13:30:20 +0800
Message-ID: <1795844918.22303.56574936672463@163.com>
In-Reply-To: <20261124120829.53F8ppqc@linutronix.de>
References: <20261015084615.05957ae3@gandalf.local.home> <179526068763.97100.12205093734161349836@gmail.com> <20261124120829.53F8ppqc@linutronix.de>
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Post: <mailto:linux-rt-users@vger.kernel.org>
List-Help: <mailto:linux-rt-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rt-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDnj41JawprmJ4oKg--.51208S3
X-Coremail-Antispam: 1Uf129KBjvJXoW7uFWDKw4UGFWrXF47trW5ZFb_yoW8tFyrp3
	y8K34Y9r1kCrWxKrn2qw4xXa4UJws3Jr47Jr97trWUCwn8XF1F9F1v9r1agF4xKrn2qFWF
	qF4vg3yDWa4UX3JanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UxnYwUUUUU=
X-CM-SenderInfo: xtxfxtprvkv0bjqqikiqw6il2tof0z/xtbC-wpKv2sKa0oOEwAA3d

Thanks -- you are right on both counts, and the first one is a hole in the
patch as posted.

prio_changed_rt() only reaches resched_curr() when the boosted task outranks
the donor; my changelog was too short there.

The pushable entry is the real problem.  @p is already on
rq->rt.pushable_tasks (enqueue_task_rt() added it when it was queued, and
nothing removes it while it stays queued), but the plist node and
rq->rt.highest_prio.next still hold the priority it had at enqueue time:
plist_node_init(&p->pushable_tasks, p->prio) and
enqueue/dequeue_pushable_task() are the only places that touch either.  So
after a boost, pick_next_pushable_task() can hand back another task, and the
stale highest_prio.next also hides @p behind the
src_rq->rt.highest_prio.next >= this_rq->rt.highest_prio.curr filter in the
pull path.  A push queued without re-adding the entry can therefore do
nothing.

v2 re-adds the entry at the new priority before queuing the push:

	if (oldprio > p->prio && p->nr_cpus_allowed > 1) {
		dequeue_pushable_task(rq, p);
		enqueue_pushable_task(rq, p);
		if (p->prio >= rq->donor->prio)
			rt_queue_push_tasks(rq);
	}

The p->prio >= rq->donor->prio guard is only there to skip the case
resched_curr() already handles: if the boost makes @p outrank the donor, the
local reschedule runs it and a push would be wasted work.

On RT_PUSH_IPI, your reading of the pull path is right.  pull_rt_task()
walks rq->rd->rto_mask and pick_highest_pushable_task(src_rq, this_cpu) only
accepts a task whose cpus_mask contains the pulling CPU (task_is_pushable()
in sched.h).  With the feature on, pull_rt_task() does not pull at all: it
calls tell_cpu_to_push() and the overloaded CPU pushes, so the source rq
chooses the destination through find_lowest_rq() using the task's own
cpus_mask, never the identity of the idle CPU.  That is why the same
workload migrates with RT_PUSH_IPI on and sits behind the hog with it off --
the affinity filter moves from "can this idle CPU take it" to "which allowed
CPU is lowest priority".

The reproducer is a 4-vCPU QEMU guest (TCG; no KVM here), non-RT kernel,
RT_PUSH_IPI off.  I can post it separately if Martin wants to run it before
v2 goes out.

Thanks,
Chaosheng

