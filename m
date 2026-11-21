Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795260783;
	b=Y2otGKYeXtvVMxwT+D7yWCvpFB90m0r0FjozWtPiqtTlWCW2CwJvfa5f5tU+OrkY31NK
	 0jqFJv/9QFSmI7j0KVW/EevxHn8VTVPsG+TqMG36YI7qX7zgX3I4vrEJh5f1C9+bW4xMl
	 yi4Exy7wNgkh7jUxTnHHs8Pt5ui1aEFCo2Qb5DLG0ewOJGtuj35DvV8beJTqeHhY32Aqp
	 wFSCdAm4nr5g5V5O2WDfQW1xIuvAwegzqbj91VdxXawB+w75OHCyJsDxE4WKW8DaC7IQx
	 OVXF3KD4dSYDmJqR0bBmTYCKV1WEsB8b/pKnPXym7uEFxXKmJOP0DLDbf4nUUtU9TqA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795260783;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=KK9UBGoOXxDgxdIHhYwv6EiDDgCB6dEuVsqhbAuDLYA=;
	b=KKVYz4zmCSQNjHKezmpawGjHwjNn7dzNOTr0/sskfBe3LVmvxy43c6LZfJi+Gh5q92R/
	 eg3FSduu3RePWBDGfDSrE1PiPK5D+llJXlZe0UcVMjec7TRn/hkFh2DBVcrX5RIlG5+rv
	 1JyQofiJiPmCRo8GY6QThNE+iP5r2h0+AggdlXd7glGTDF2T5uNoQKEtne7eeCncTcbn6
	 XLcGY2VmWBhN7Pu7FfWR8kpKr64ytRZzM9KdGMDfItZJ0b9NphaIcu//7ASqq41EIEII4
	 5k9j8hxeXtJwi7DyLCfsep8YdM7zluSUKR5y68d/REVr450B5VZ2uY2/J6f0f7M0SYA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bVOx2BaF;
	arc=none smtp.remote-ip=209.85.216.53
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A558606A336
	for <linux-rt-users@vger.kernel.org>; Sat, 21 Nov 2026 11:33:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5A558606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bVOx2BaF
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-3b44bdcea8aso345454a91.1
        for <linux-rt-users@vger.kernel.org>; Sat, 21 Nov 2026 03:33:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795260783; x=1795865583; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=KK9UBGoOXxDgxdIHhYwv6EiDDgCB6dEuVsqhbAuDLYA=;
        b=bVOx2BaF0j1A8v2xP5IWCF6AoWR9qXDMiCGDhBgRGmRIG0RKog6xiWH9E0mOFqiBQd
         AihY6i83Z/8/+8U91DTM++idZIj3nqbaBtXCtsLQdeBZdUZ2pBfpCocgTds5bFC/ZL0b
         +h9K5SKZIasYAxZayoIixsW/dQZur+T8aCGPLWIrbCITx1a4qiOJRidi3oSEwuovAAJs
         7DR55VoSYvH30UMi9g9rtq0PMJgxucZC4e7vdqD5Z/Kn+2U4JdRP06ZnQu9wIz0I0h5H
         /NkG/BCrL0D9WrY1VJMkl1q5psXzyZiW6NjfQa3eZLEu6Xcvi7Vw5XUiyPK20J7ODMA8
         7s9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795260783; x=1795865583;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KK9UBGoOXxDgxdIHhYwv6EiDDgCB6dEuVsqhbAuDLYA=;
        b=itdIgwt1rTuyYOpak25na6kzOJkXf4NFIOqHf3k+IsYNVag8nK1hA/w9o/nWBmeb5U
         TGLFLVLjToLpEFiAMcUeIJKtELnEzq2YHd7uKiARsVkXYz8lNl1zZYzJjpl0epzt6+VN
         7Q//CDwb+vyFNm4EkI03zGsYd0LtrrmbiaW5tq2/MyOCAMmNA7V51GwD5v6vKqUefMB6
         vBgjcXtaPJYOuXdwnmdOhLUkW0pnByKQkOqHw1yAw3SZihFWHeo07tLJkzaBPgNr+4lj
         Jt1AqNWZXKfeIwKDm5ZJbRp6iILqaML/sIBo8y2Pl5hCxPn4012RnRWkqejmFYIs2dis
         3ZWg==
X-Forwarded-Encrypted: i=1; AL+hErGJOyB5oXaww1ZOjaxbUVqEder4QiqU9pttHjCsqrYeyMoIBgILyhl6SSzBTdzwpU3IFDVtU4w6i4Gj5Sgh4Q==@vger.kernel.org
X-Gm-Message-State: APuU4Z8LdWIrF+Z1sNu5d5beH2nDAT25kb9zmybAMpK8nKxxiFTlolGm
	HOGNv3Bkqx4Be0AnRx8vmgRxho4pvIySsQuANg3R/YXo6YmV6JJNzpIa
X-Gm-Gg: AZFdTZecG81xmDQWaxl+cGvVgCRM9m4kDjjTTAAH3ym9VmliXURH04VGxSuWKfdlzrn
	1hxlcYa5JHB7csFP8B4zHM/tThiibK9s/QHB+WCRTQlPO2ei5p7EoXoSp/GzvSsZJdtazx+l4s9
	MRxwvnlKTZeKV977ZdQuLGLpgqSm01jMghlZ7AdLYgZH6kf/9sU3jH18w+mJJIjLkqdD3ZnOa+g
	LRVI9DN2gWX5629ySNAwfn2L1mPpwp8gU+oi4vjJ1uESB8i2RmcFGffVSNGaQEnxU8lVQW7tWac
	2c/RsYxX2KNuJJSldljc4B2N/u18150fNWuZF2KRU1qQAp53PhX3E3YD/28snfHVOmAZWzU7Efm
	8pyhvR5IXIvJAlbq/XcGT5zwlMmjH8CRft+CHzDmm17YSivxLVpV3Oqk9f2Bo2ZM8P/HUSDAwgo
	11yXabGmmacLamFIbu8zrwfA75gkSgorBgicU6ig9AEYpoTnJ9AibAX0ZnoMEnvSuFBV6Ih5x1d
	Pf1avQLsdrrgTlCJlh+s3k1f1eA5qo+2gJaqblUgaozGL2PAmYTuYJLGAYJd4mXa0mplUmmz9O+
	EREPR4ZL2Jbtb5V85QtBR1VEsSiR9/8MzC9MuVtQPw5i
X-Received: by 2002:a17:90b:390b:b0:3b1:d40:2c4e with SMTP id 98e67ed59e1d1-3b41c56f34amr3999717a91.0.1795260782587;
        Sat, 21 Nov 2026 03:33:02 -0800 (PST)
Received: from [127.0.1.1] ([2408:840d:6830:46f1:7c60:7a01:9164:e1a0])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b405ecb486sm11111223a91.16.2026.11.21.03.32.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2026 03:33:01 -0800 (PST)
From: Chaosheng Qu <chaosheng.qu.linux@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Martin King <martin3kx@gmail.com>, Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, Thorsten Leemhuis <regressions@leemhuis.info>, regressions@lists.linux.dev, linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Subject: [PATCH] sched/rt: push a queued task when its priority is boosted
Date: Sat, 21 Nov 2026 19:31:27 +0800
Message-ID: <179526068763.97100.12205093734161349836@gmail.com>
In-Reply-To: <20261015084615.05957ae3@gandalf.local.home>
References: <CAEB5A_91hob8ddOhW=PrO1=O7GrFmSxY3r1-_Ard6x8KHHuJGA@mail.gmail.com> <20260814183652.611e7ecf@gandalf.local.home> <6db9c47f-a1f8-49dd-9e80-f9014d75f9e8@leemhuis.info> <20260903092037.5b739980@gandalf.local.home> <20261015061915.126442-1-chaosheng.qu.linux@gmail.com> <20261015084615.05957ae3@gandalf.local.home>
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

A PI boost can raise a queued task above everything that is runnable on
other CPUs while it still cannot run on its own rq, because the task
currently running there has equal or higher priority.  prio_changed_rt()
only calls resched_curr() in that case.  The task then waits for the
current task to schedule out.

The pull side does not necessarily rescue it: pull_rt_task() only picks a
task whose affinity includes the pulling CPU, so a task whose mask
excludes the CPUs that just became idle is unreachable until the running
task leaves on its own.  With RT_PUSH_IPI off this is the difference
between a millisecond migration and a wait for the hog to finish.

Queue a push when the priority of a queued, non-current RT task goes up.
push_rt_task() already declines to move a task that is not pushable and
skips the reschedule path when the task is higher priority than the
current one, so the extra callback only acts when a migration target
exists.

Signed-off-by: Chaosheng Qu <chaosheng.qu.linux@gmail.com>
---
Steve,

This is the fix we discussed in October.  The case that matters is the
queued task that the pull side cannot reach because its mask excludes the
CPUs that just became idle.

Numbers from a 4-vCPU QEMU guest (TCG; KVM is not available here), non-RT
kernel, RT_PUSH_IPI off.  L is FIFO 10 with mask {cpu1,cpu3}, X is FIFO 99
hogging cpu1, W is FIFO 90 on cpu2 and blocks on L's PI mutex, R is FIFO 60
on cpu3:

   baseline: 1/5 rescued, 802.8 / 1161.0 / 1311.8 / 30.2 / 1280.0 ms
   patched:  5/5 rescued,  13.8 / 1.1 / 0.2 / 0.2 / 0.8 ms

The reproducer is a small static C program; I can post it if useful.

 kernel/sched/rt.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 85303add7..db93bfff7 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -2499,6 +2499,19 @@ prio_changed_rt(struct rq *rq, struct task_struct *p, u64 oldprio)
 		 */
 		if (p->prio < rq->donor->prio)
 			resched_curr(rq);
+
+		/*
+		 * A (PI) boost can make @p the highest priority
+		 * pushable task on this rq while it still cannot run
+		 * here, because the running task is of equal or higher
+		 * priority. If @p's affinity excludes the CPUs that
+		 * become idle, the pull side cannot pick it and it may
+		 * stay queued until the current task schedules out.
+		 * Trigger a push for the new priority.
+		 */
+		if (oldprio > p->prio && p->nr_cpus_allowed > 1 &&
+		    p->prio >= rq->donor->prio)
+			rt_queue_push_tasks(rq);
 	}
 }
 
-- 
2.43.0


