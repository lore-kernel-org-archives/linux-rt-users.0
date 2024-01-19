Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE88B3C465
	for <linux-rt-users@vger.kernel.org>; Fri, 19 Jan 2024 15:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705678721; cv=none; b=TyLCSmoFNDGZYzJZ+kLuomYPKajt86gtRvokx0LyJWAFq2q5kCqwnkmib6LMEyvcbS5Jde3ehxL3zsF4wDJIcTj58aIL/p2aab5yYa+fnOUVfxRG98iPkAYsCuh1U4SR5umujS7e6SfWMcPF61SL63nZp/oOmZ/dlxxNDPMnPVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705678721; c=relaxed/simple;
	bh=MosZV9lVhWYTyvToq2HaedYAqa5mFygLJXjg/i/h1qU=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=lkvi25H8WLLLWGhFRrI3/UsxPlLeSjbgPaJst/4wcGEBedkNGEt4S8FkFgCrk6NEsJGPwrbEytwvo6VcG4Un1CpFNeJuJpuOGWWkFQrUD/fMlqs5m4OgOKcVW9L8ODPhS8hQECYO6GUbGilALc8vFY+GfZc2fAtrHhntX58SSnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sidebranch.com; spf=fail smtp.mailfrom=sidebranch.com; dkim=pass (2048-bit key) header.d=sidebranch-com.20230601.gappssmtp.com header.i=@sidebranch-com.20230601.gappssmtp.com header.b=iznJwE5e; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sidebranch.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=sidebranch.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sidebranch-com.20230601.gappssmtp.com header.i=@sidebranch-com.20230601.gappssmtp.com header.b="iznJwE5e"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-5ce2aada130so648889a12.1
        for <linux-rt-users@vger.kernel.org>; Fri, 19 Jan 2024 07:38:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sidebranch-com.20230601.gappssmtp.com; s=20230601; t=1705678715; x=1706283515; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=mHwmOLetONlhFKNXUrmDVsbt6fHM7mIObnLlN3NRPqU=;
        b=iznJwE5eLgxtxLzAUFBesS5XTjlQEmtOHt0WNPhXvkh67dThMQNyln1bm14guV4bU2
         4FY2bAtfHKEejNKifK2lLThU+PRFH8PQNl6XGrjvpGl0wZyZcozxJkkkmzCZKd9D0UDs
         wz7yG4TyTcw21NuP44RW27/WiZs3QddMQboXFzmpJpmQZjRhZ4AWv5nM7rNAio//hw9w
         KpBRprAgH+HSwaF7qEyrKWZqlYLx3K5lZ1B1dSYtTHyjkav+fEvGUfbFrYw+97lschtD
         YYZ1qbCSYKo3pIp/rX0HEYvcLOOLb0pq4Y6QYA7ZVqXelvrYQ6Fu2UqG1mPE+jPwlmKM
         ke8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705678715; x=1706283515;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mHwmOLetONlhFKNXUrmDVsbt6fHM7mIObnLlN3NRPqU=;
        b=OLCv7VhoBEpIor5URib7R7ZxP7g8CM+UGdCPi+28YYbk3BxiWKC5HFlL4I4ykwX4qz
         t4CQ5vtTditjPKuQjijTy+App9xrqIVucNbeAoD+AumFZDNx9RPW4yPqyn1WOvNcfh8o
         V0FpKXVigSARLKnQCuTse6i3R2IzaRwkWRIbPUEoul6u2niBQwmqr9A81X9XdAp4oLGb
         2T5dV1t6VsVZ1W5Oybk9vYhCnCEL/EI2oDSUo19c94nSmGFmH9c0vFFbTVq/eQjfM8V6
         bbgMRZioHLNPADnWb8qYYHt+N9D8KRaMvGK4l32rJvftK4dfRENAJf21Z2zgw/3yUssm
         zq0g==
X-Gm-Message-State: AOJu0YzIxoB8eE1yrqBSJtR+JwWcmEuRuhWIAIyUnf9PLxX6PTRzBchT
	oh7iTKuFaDpFNcxdDWwaZsuPEphV9TCCvMxwM3d/1Jh3uz5T030vYUpEo1zLPWRpkoVqLWCfPHT
	26/KebnF2+/annF311FtZh3FkopT9vn83M2EBLCYpeqmxNK4ZLm+3SA==
X-Google-Smtp-Source: AGHT+IHjV2nzaa4wWcMD2hvk5148K0jCGyCYh4iSIU4+ALJtLYo4sXbr82EfZEW0Mwi0yi76pqv3nGrpestAxikK74Y=
X-Received: by 2002:a17:90b:148:b0:28c:7ca2:ee49 with SMTP id
 em8-20020a17090b014800b0028c7ca2ee49mr2022016pjb.54.1705678715542; Fri, 19
 Jan 2024 07:38:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Leon Woestenberg <leon@sidebranch.com>
Date: Fri, 19 Jan 2024 16:38:23 +0100
Message-ID: <CAMjhiJj0PnBrZdujKWnF43TmLB37L-bfs99nyDi+j2p+Nv1enQ@mail.gmail.com>
Subject: Unexpected rcuc osnoise on PREEMPT_RT with "rcu_nocbs=all rcu_nocb_poll"
To: linux-rt-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello all,

On 6.1.71-rt21 (PREEMPT_RT against vanilla) I am trying to find the
root cause of an "rcuc" thread scheduled in on an isolated core (CPU
#4).
The isolated core should run a single non-kernel user-space-busy-loop
thread (SCHED_OTHER, not FIFO or RR).

tsc=reliable isolcpus=domain,managed_irq,4-7 nohz_full=4-7
rcu_nocbs=all rcu_nocb_poll
/proc/irq/*/smp_affinity and cpumasks in
/sys/devices/virtual/workqueue/ all show 000f or less (CPUs 0-3)

Using osnoise I see rcuc/4 popping up as a cause of noise, but my
kernel command line should prevent that, right?

I see this in the kernel boot log, and I wonder if this is related to my issue:

[    0.063518] rcu:     RCU_SOFTIRQ processing moved to rcuc kthreads.

tree.c:102:static bool use_softirq = !IS_ENABLED(CONFIG_PREEMPT_RT);

Could this cause the rcuc threads to become active, even with the
"rcu_nocbs=all rcu_nocb_poll" setting?


Thanks, Leon.


[    0.063516] rcu: Preemptible hierarchical RCU implementation.
[    0.063517] rcu:     RCU restricting CPUs from NR_CPUS=8192 to nr_cpu_ids=16.
[    0.063518] rcu:     RCU priority boosting: priority 1 delay 500 ms.
[    0.063518] rcu:     RCU_SOFTIRQ processing moved to rcuc kthreads.
[    0.063519]     No expedited grace period (rcu_normal_after_boot).
[    0.063519]     Trampoline variant of Tasks RCU enabled.
[    0.063519]     Rude variant of Tasks RCU enabled.
[    0.063520]     Tracing variant of Tasks RCU enabled.
[    0.063520] rcu: RCU calculated value of scheduler-enlistment delay
is 25 jiffies.
[    0.063521] rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=16
[    0.066896] NO_HZ: Full dynticks CPUs: 4-7.
[    0.066897] rcu:     Offload RCU callbacks from CPUs: 0-15.
[    0.066898] rcu:     Poll for callbacks from no-CBs CPUs.
[    0.066901] rcu: srcu_init: Setting srcu_struct sizes based on contention.
[    1.145094] rcu: Hierarchical SRCU implementation.
[    1.145094] rcu:     Max phase no-delay instances is 1000.


--
Leon Woestenberg
leon@sidebranch.com
T: +31 40 711 42 76
M: +31 6 472 30 372

Sidebranch Embedded Systems
Eindhoven, The Netherlands
http://www.sidebranch.com
