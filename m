Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFF87158A26
	for <linux-rt-users@vger.kernel.org>; Wed, 24 Jul 2024 14:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721830013; cv=none; b=URN7phkAfMnPrOBO2mmTCel4o4fLVwyltZW+GHvQBWX/hsZMHZOUe7SrTvxnu5MALMCsA4Kk5R5Kzr/HYqm5H7UPP3JHtk3o6w259+qoLmyUHIqlxQ77X0HxJZt+vndOIuXHa4hiNh/bkyWAZEVYI7EDJeAwIwZ87EoEZnov0XA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721830013; c=relaxed/simple;
	bh=UtZo+Mp5ePUV65mmk+S+8UOESU/Ss93dL1lZkIYUsfg=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=BOKrOAW2RGvSj1GGwsG/tV80p9HHGdozUYiqIqqyBgXU4cQfEvDYO7UfTTXdarZdzVPrry5/k6OJtXlk052kg0xqlspWXwlGLwpOuMcUiVwmIIJ0wMT7sUYTxcqJGKFZlEeuL2d4u1Iz6wqfhz8HhrdG1K/Q3Au/ChlS1NQL40U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sidebranch.com; spf=fail smtp.mailfrom=sidebranch.com; dkim=pass (2048-bit key) header.d=sidebranch-com.20230601.gappssmtp.com header.i=@sidebranch-com.20230601.gappssmtp.com header.b=lUWbFYfD; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sidebranch.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=sidebranch.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sidebranch-com.20230601.gappssmtp.com header.i=@sidebranch-com.20230601.gappssmtp.com header.b="lUWbFYfD"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1fc5239faebso14397405ad.1
        for <linux-rt-users@vger.kernel.org>; Wed, 24 Jul 2024 07:06:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sidebranch-com.20230601.gappssmtp.com; s=20230601; t=1721830006; x=1722434806; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=faIUB0IUc4P0RRYXIbbTWtLyw9izOYCtfVSEyL4w4Uo=;
        b=lUWbFYfDZrVZ0/zyGgb3m2hN2MMT9BaW5rUNEsAl0d3zSaSRtq95SmUmroRmhpBR+9
         jwCkOqWYXa4Q2fjbzwo4eHtN6NOg5zjUVmRORE86D6CHWR0ju9Mn6W6diNWfUEethd5D
         idxsyk71HuZPRjJ7802a8Mv+joNdxVCPJ/UfOQxUHmvz+M13IS6iEnPlyifPLmzunN6l
         mHb5a/8CBPM4gboYzfRAqCioevpOzW872cysH4XjRvJBpMbkNdKQJg0Oh25aqTnCGUwl
         +esEC4lOfvLx1JZgan+Q7nJ4uoKbT++/dUtOn9L9hTaIonBvdnFu86xVynqqk9bs8mnT
         DOwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721830006; x=1722434806;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=faIUB0IUc4P0RRYXIbbTWtLyw9izOYCtfVSEyL4w4Uo=;
        b=uihYTrsEcjrYTtbaaeo3QqpoZPqpVTDe7R/4wxmz0ZtE4QqfkaRbgavqHab48opUff
         Oyl0hcKgJMeK2PhCEtSD+uIq39Q0JYRlAluI3KP/5UN0FuWgpucq85CzVpBhrOHvII1j
         pDn5C7Zw2/JCXnG/6S/Yg31Zs+ds7Qf85lghl3NpcDNfV+IeSHaLjBnNLUd4Ars7INzl
         /MViPyJ+jg7e2Bz5KR/kBXA99Sruk8UNAOlCmYBg4qu4sekGu5XYuzVacFWSpumDIT+K
         Qm/0l034moihhAV2LjrvXUVCJF17dnvbPh3AxBoXlWTnw0AA8SwS9SpW8H9qLR0TEkyM
         ktpQ==
X-Gm-Message-State: AOJu0Yyldj68Xumf6o2VkYH/0rfq+x5Jd8dJNCu34RO79etLnfMbkwVz
	Kf94Gtb8qD6tC9bEPweVPixzYsU6jZ/bPx4n8md8FrzssOtGZUtzyx7c4bPa3rgJl9cML/z1QDt
	9psNiLP3hiRKACRlrV4Z+bx2wu51X3BancZ61ySVZj/yr8iP+9TQ=
X-Google-Smtp-Source: AGHT+IFOfGpzDBanSer68PzEiiYIJs1mFH8sAHB326gmBDwR1ZjLSLVopQj1verQXqTg+neaPExnLO4iVr6A5oBdy7Y=
X-Received: by 2002:a17:90b:4d8e:b0:2c9:9b65:af4d with SMTP id
 98e67ed59e1d1-2cdae338319mr3153349a91.7.1721830005921; Wed, 24 Jul 2024
 07:06:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Leon Woestenberg <leon@sidebranch.com>
Date: Wed, 24 Jul 2024 16:06:34 +0200
Message-ID: <CAMjhiJiqfz67Aba8KAKTHjO7TjGADvM2S0qDVrGfF+XkT5DeAw@mail.gmail.com>
Subject: rcuc/ thread on isolated CPU
To: linux-rt-users <linux-rt-users@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hello all,

I am seeing an rcuc "osnoise" on an isolated CPU (#4) that should have
(per-cpu) rcuc offloaded to, and polled by, other CPUs.

Note this is with vmlinuz-6.9.10-rt5.

I did not expect "rcuc/4" to actually run on CPU #4.

Then I found the email thread "Wakes of the rcuc/ thread on isolated
CPUs." and also tried with rcutree.nohz_full_patience_delay=1000.

What could be the misconfiguration or issue?

[    0.011004] Kernel command line: [    0.000000] Command line:
BOOT_IMAGE=/boot/vmlinuz-6.9.10-rt5 <...>
isolcpus=domain,managed_irq,2-7,10-15 nohz_full=2-7,10-15
rcu_nocbs=2-7,10-15 rcu_nocb_poll
rcutree.nohz_full_patience_delay=1000 <...>
[    0.033362] rcu: Offload RCU callbacks from CPUs: 2-7,10-15.
[    0.033362] rcu: Poll for callbacks from no-CBs CPUs.

sudo LD_LIBRARY_PATH=/usr/local/lib64 /usr/local/usr/bin/rtla osnoise
top -a 20 -c 4 -e osnoise; cat osnoise_trace.txt
cat osnoise_trace.txt
# tracer: osnoise
#
#                                _-------=> irqs-off
#                               / _------=> need-resched
#                              | / _-----=> need-resched-lazy
#                              || / _----=> hardirq/softirq
#                              ||| / _---=> preempt-depth
#                              |||| / _--=> preempt-lazy-depth
#                              ||||| / _-=> migrate-disable
#                              |||||| /
               MAX
#                              ||||| /
            SINGLE      Interference counters:
#                              |||||||               RUNTIME
NOISE  %% OF CPU  NOISE    +-----------------------------+
#           TASK-PID      CPU# |||||||   TIMESTAMP    IN US       IN
US  AVAILABLE  IN US     HW    NMI    IRQ   SIRQ THREAD
#              | |         |   |||||||      |           |
|    |            |      |      |      |      |      |
       osnoise/4-1553    [004] dNh11   181.384695: irq_noise:
local_timer:236 start 181.384689739 duration 4120 ns
          rcuc/4-64      [004] d..3.   181.384707: thread_noise:
rcuc/4:64 start 181.384702999 duration 3180 ns
       osnoise/4-1553    [004] ....1   181.384708: sample_threshold:
start 181.384686979 duration 20360 ns interference 2

Regards,

Leon.
