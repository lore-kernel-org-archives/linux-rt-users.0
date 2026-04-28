Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBD0F436377
	for <linux-rt-users@vger.kernel.org>; Tue, 28 Apr 2026 13:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777384339; cv=none; b=SMSyUolqMlOaX1U9uyfypCrcThXSDqYyza0ZzTNAt3e9CrOf/YtVErRjUdCj3RTNgiHXlFoAdx6fEe2f9kmMf3W1lSldjSzGkmyTpqcLgjB+HrnItnf1C73hEohLitsXW90XIeEAcDpMFPMWtTdyXLkal6Od7tCeWDy4O7Tpj3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777384339; c=relaxed/simple;
	bh=21XDmDmPmMTTfRyTSMfjXThIbXhA1JvgrhkuZIDeydk=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=bDDAcM2n/MNJNZ0FViUwa3AC2a56U7LGgI4QMX7rOOO8A/U3YBZ6rQ1zhMCUDGFC6H7R4/R2xQhqppHIJez1jWaWTJiYkmgiK7c5yk3E4/gOiKYCDh8kqAIRVHiMH/drnefnJSREpyObVEcs68Oh/wgE/BwT5D+9RWys0/3uEOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JRiYmqvB; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JRiYmqvB"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-483708b697cso15842525e9.3
        for <linux-rt-users@vger.kernel.org>; Tue, 28 Apr 2026 06:52:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777384336; x=1777989136; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BM0jneOzcGki1By6OSv+rP4a8j/Jg20bgwZ6/7pxqZk=;
        b=JRiYmqvBXYgj+ALycypid/5nl23kWESaWNIdBnndIppzV87sWvVjlWNcjgnVM3PHId
         xn7DrHslOCD16uzfi+TUsDcq1yrxraIFSxi3HJuQ0KeiUfs+gm2Y6V2KdVFKRZ4nHgR/
         v/RV4rKBZof6wsoDtYdFmLpuypqenKuWx8J6PacL0smjXITk888DeTPrS89hxvqcFdu3
         mh5i6LJR8PF4r+tgOEW7077BfjgxhfzXxd+AmKs+oAZQn1WP7a6SyCsGucmF7EuocW3m
         d72fR9hP6ketYqkhpjmjYws+fyE0mTsJi3ZWo598LBdltzoRwuCPkxZmLd8OR8CyyCtb
         W1KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777384336; x=1777989136;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BM0jneOzcGki1By6OSv+rP4a8j/Jg20bgwZ6/7pxqZk=;
        b=TYPhxcSwjBzQdDnwfIsgW7QMZbd4dWn5Fqw17VPS5CobP835KP2u4m67WlzJfpKsim
         ujcZImUa59xlCQrnD9Rnw0WowlKJf81s55bpEiCEYPj2c91K1xN6h7BbyRg+FG+Qly3+
         acWqP15+uNx5Eb9dFuN9l9kL0tcOmhsMW9aegeG1GDUkqN6pgCm+lnBc3JXPJMU5qOjs
         xtIAk3U/ooeBoL2ZCrMEOukkNoZ9C7SgPmhylOW2SqR0bhAUavyUcqQExDoqRF5UG7Uz
         jF4d4+rsiVOKLkTo9gqTrqGUPWkdc2HW2Rj0qbPA+dIvaYXNT3Z9Y5ZCD9kxgygYaY5+
         aPRg==
X-Gm-Message-State: AOJu0YwpKiGScxV5JJ12WJ9+SC2z1jA9e2Uonlqy/QJhQwNcHvQWKHb7
	XMV8z/8KMIrHEnQXYMH0XUBuBkvYnz/YN51tFsL+R03TYU1zLz2e4wkSU2xWRw==
X-Gm-Gg: AeBDietUmXOAATlbvWDPUnWEDxRxagM0ZrBjAdcGbCdZhDyXZiiMsn2DYL6Lf2iFsfq
	5tYYoWFG2FNoBZ/DCPjUN0SXWnSUbTsny9haVFt+qZbc7STWGb2Uw+uyBDRybYwsPJc9ThNLEmX
	e0aZDYf+svzofYNth70rxj+RftRmfaq58X3FD872+twctTPMSEaJ+5pfBDL2xOO//y/Fv9puM0L
	4ozesMej/4ZMUMnBVza91p60IGWgg7W9iTzsL/rQt5lfbfnRJZUYOUdeORWtfgX8Ea7MPII4hR+
	LKI9PiB+dOr/Ilq70zKT7IhecO2epHV5kMcOw29FwChuXc1fbnEPdfN/2bkVTYhhdr3Tr0X9eq1
	7CV3jS+yebtMaYjJ6cCwN+W+8YbZim4aesFH00Bwkb6oNjpJoBUelKwuUcC7QXd4KZy2xgv8Jn3
	4Uhe7i2tbodYLUaw2WWN1IA6W9QJCaCI0aokw2dLRkfy4jlBJZOqgGV8Vjxojq7A5mwI6Qg8T6x
	d9n+aYZ5M9UeHt4WCKTRzsqpAnFUVxe
X-Received: by 2002:a05:600c:3acd:b0:489:e696:127d with SMTP id 5b1f17b1804b1-48a76f82973mr32277825e9.5.1777384336071;
        Tue, 28 Apr 2026 06:52:16 -0700 (PDT)
Received: from [192.168.0.110] (dslb-084-060-164-183.084.060.pools.vodafone-ip.de. [84.60.164.183])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a773aeb6dsm69824255e9.5.2026.04.28.06.52.15
        for <linux-rt-users@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Apr 2026 06:52:15 -0700 (PDT)
Message-ID: <ceba9f1b-0694-44ec-bdc9-a443d2127102@gmail.com>
Date: Tue, 28 Apr 2026 15:52:08 +0200
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: linux-rt-users@vger.kernel.org
From: Tobias Jakobi <tobias.jakobi.lr@gmail.com>
Subject: Question about SCHED_DEADLINE and cgroupv2/cpuset interaction
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi there,

I'm currently pondering on an odd behaviour that I'm seeing when using 
SCHED_DEADLINE in combination with cgroupv2/cpuset.

A bit about my setup. The hardware is a Raspi CM4 module on some custom 
mainboard.

Kernel is rpi-6.12.y from here: https://github.com/raspberrypi/linux
Although I don't think that this matters much. There's barely any 
difference between vanilla and the Raspi fork when it comes to the 
scheduler. I've also tried this whole thing out with rpi-6.18.y, but I'm 
getting the same behavior there.
Kernel config is nothing special, except for the fact that 
CONFIG_PREEMPT_RT=y.

root@cm4-fat:~# uname -a
Linux cm4-fat 6.12.81+ #1 SMP PREEMPT_RT Tue Apr 14 13:06:22 CEST 2026 
aarch64 GNU/Linux

Anyway, for our application (in the sense of "how do we use the CM4 
module") we have partitioned the CPU resources into two groups. CPUs 0 
and 1 are for all the "menial" tasks, and CPUs 2 and 3 are for 
everything real-time. We use systemd slices for the partitioning, i.e. 
systemd does the cpuset controller setup for us.

Basically it's this setup: 
https://documentation.suse.com/sle-rt/15-SP7/html/SLE-RT-all/cha-shielding-with-systemd.html

We have assigned CPUs 0 and 1 to the machine and the user slice.

Also we have some kernel cmdline arguments that might be relevant for 
this: irqaffinity=0-1 isolcpus=2-3 nohz_full=2-3

For the RT work we have these slices.

root@cm4-fat:/etc/systemd/system# cat workload.slice
[Slice]
AllowedCPUs=2-3

root@cm4-fat:/etc/systemd/system# cat workload-core2.slice
[Slice]
AllowedCPUs=2

Note that core2 is a child of workload, i.e. on the cgroup level it 
looks like this.

root@cm4-fat:~# find /sys/fs/cgroup/ -name workload\*.slice
/sys/fs/cgroup/workload.slice
/sys/fs/cgroup/workload.slice/workload-core2.slice

So what's exactly this problem I'm seeing? It's this here.

root@cm4-fat:~# systemd-run --slice=workload-core2.slice --pty chrt 
--sched-runtime 100000 --sched-period 200000 --deadline 0 echo this works
Running as unit: run-p676-i976.service; invocation ID: 
d59dc443f66f46a6ba2dfd125e04f830
Press ^] three times within 1s to disconnect TTY.
chrt: failed to set pid 0's policy: Operation not permitted

What works however is this here.

root@cm4-fat:~# systemd-run --slice=workload.slice --pty chrt 
--sched-runtime 100000 --sched-period 200000 --deadline 0 echo this works
Running as unit: run-p670-i970.service
Press ^] three times within 1s to disconnect TTY.
this works

I double checked the slice settings, and they apply.

root@cm4-fat:~# systemd-run --slice=workload.slice --pty bash -c 'grep 
Cpus_allowed_list /proc/$BASHPID/status'
Running as unit: run-p727-i1027.service
Press ^] three times within 1s to disconnect TTY.
Cpus_allowed_list:      2-3

Once again for the core2 slice.

root@cm4-fat:~# systemd-run --slice=workload-core2.slice --pty bash -c 
'grep Cpus_allowed_list /proc/$BASHPID/status'
Running as unit: run-p732-i1032.service
Press ^] three times within 1s to disconnect TTY.
Cpus_allowed_list:      2

This really puzzled here. Why would this work for AllowedCPUs=2-3, but 
not for AllowedCPUs=2?

I then dove in the documentation and the code, trying to understand 
where the -EPERM was coming from. I finally decided to disable the 
bandwidth check that the kernel performs.

root@cm4-fat:~# echo -1 > /proc/sys/kernel/sched_rt_runtime_us
root@cm4-fat:~# systemd-run --slice=workload-core2.slice --pty chrt 
--sched-runtime 100000 --sched-period 200000 --deadline 0 echo this works
Running as unit: run-p760-i1060.service
Press ^] three times within 1s to disconnect TTY.
this works

And voila, suddenly everything works. I fail to understand though why 
the bandwidth check fails here. I mean, 100000 / 200000, that's fifty 
percent, so the check should pass.

And apparantly the ratio itself doesn't seem to have any effect. I 
enabled the check again and reduced the runtime so that the ratio is 
just 5%. Still the same.

root@cm4-fat:~# echo 950000 > /proc/sys/kernel/sched_rt_runtime_us
root@cm4-fat:~# systemd-run --slice=workload-core2.slice --pty chrt 
--sched-runtime 1000 --sched-period 200000 --deadline 0 echo this works
Running as unit: run-p838-i1138.service
Press ^] three times within 1s to disconnect TTY.
chrt: failed to set pid 0's policy: Operation not permitted

I looked around some more, made sure that CONFIG_RT_GROUP_SCHED=n, but 
the more I think about, the more I get the impression that I totally 
misunderstand how the bandwidth check works.

To be explicit, by bandwidth check I mean the line that is found in 
section 4.1. here: 
https://www.kernel.org/doc/Documentation/scheduler/sched-deadline.rst

Would be nice if someone could shed some light on this. Thanks in advance!

With best wishes,
Tobias Jakobi

