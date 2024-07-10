Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AD76126F1E;
	Wed, 10 Jul 2024 08:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720599986; cv=none; b=hHR3wnPNhahf1gQ49IjbE+lE/7R4MmDpQzolNarbLTj4iifjksmk3TsH9U8ggsaIHOuFEUJeYs0MoGxh+Jcq5SEhDlRIXEeqwl8kWrtSYaCD4jw5uBcvn7f3fbE+qMKJR9qjIOTK7pN+I8ZFmvManM07a7iagp41DIj0lb0u4vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720599986; c=relaxed/simple;
	bh=mhUbyhxNbtwDNd98Iv/UPDo+8zNh7NImfXpbZvaVDPA=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=p6arVk6HWcHLUKRgsFHGwF0MA/35OCFaTWXJiLvaF40K5RCGVyG/YyzjGjIZz6e0nL2fPbAbk+v0I11m40M1B/LOboXjh7AEd/jZQ+JrI6xquUqt0KFWuvsvgs7yrR+2qhZmwjQP4ed4eX1SynPo/us9PAkHdznqWUkcJfPcAv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fXRE+2Ip; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fXRE+2Ip"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-36796a9b636so4108395f8f.2;
        Wed, 10 Jul 2024 01:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720599983; x=1721204783; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=v9XRlS47aqf4yXL61p/y8Gu0BFUgxG7tE6brhjNimcA=;
        b=fXRE+2Ip0JYezEthfYeLjku6G/AYefue6he3P5JyFuP0JOQsR4NBfWoFcCMim7SQIb
         XDRwQopzrBSMMuF2vQadBB2EGohaILNaUX4gfnXlwcmLEDJfcSQowWQeEJwxaODlZCls
         FfFd2McwnZFiXLAMMm9HFvln0WUG/72AIP2wiNWeHMVObt3ZF8RreTbDHF7T3WKsKEbL
         r61ojFoAURFsFIwzB+VnQRzEVWzaMQP0IB67MTLhpDss92ZJTUHM1Y+jf69Di4tZWnJ7
         /PMZZxwWUf8FOwp6Fs7n7p0biXu7xQIDQMUalldmu+dc9KrahE9C/ouZKQmvpd8zpbbH
         fCGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720599983; x=1721204783;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=v9XRlS47aqf4yXL61p/y8Gu0BFUgxG7tE6brhjNimcA=;
        b=opEU0t5Ozej79KoESpXZMrnO2PA0jribo5h+0PQk5zRxF2/x+osyggvUFm+1LPS6xZ
         3vLrAekrqbSTC6xq6HxmkoC5Ivj9/mgKErvEug7IsD5pedl8NLkhvVqNgxgnsWHT9cnW
         FJ0ytUJ1/UzEv4Aumkntw7UsrRZAZxmoxJwjaWCGtyjKc2YbsC4Wi+1lDBaNgHzaOBJx
         wisCvdBzVdDN78hkD6WalZxYwGBdEJDNU4m50fX+h3/La/MrwYKdrgZVgD768keGjidq
         zmGpkLU0tF4tCi6Cw4pcWQugv2JkeewpkJWxOHnPiooQ3AyF2PfOLtMj2P9apjiSIa+G
         stvw==
X-Forwarded-Encrypted: i=1; AJvYcCW2tSYSV1qFRXR/h9GrCKXNdN0gAKM/rpNraZGSMN5O7qURqYPxpea8jOOoI3Ozm0j76qM0kI8yDCGptuWt30Qia/zehvnvHBXEcCRYTAbGtL/jLlqYZLhgIySluXKvWonBMhOK8RmXivP0fsj+vo53EtoePUeE7Hv1rcrzgkC+QkI=
X-Gm-Message-State: AOJu0Yy8kDC5p0A2JFxWuBuA7XNkpdetPVYUoX8n1yH+6DJarNW+XRSy
	nv9itx0j80vPGjx6P3w+Zv/vhg4qhfCRonLTMMUWeWOWVRsm4CZx9XFEHNe+lMoMdRogZDCoQB4
	jVQTSpkgTG+/WGs4qdVSTMr1T9ik=
X-Google-Smtp-Source: AGHT+IFq7fqFpgTUktFNR3KjEHVvUwerVv9xL948nmX8KPjEqoQXZy79MIrW9lTfhGp8hJ28nyELwY0Y8zDn8rKuacg=
X-Received: by 2002:a5d:5847:0:b0:366:f001:78d5 with SMTP id
 ffacd0b85a97d-367cea46c97mr4276328f8f.13.1720599983351; Wed, 10 Jul 2024
 01:26:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: richard clark <richard.xnu.clark@gmail.com>
Date: Wed, 10 Jul 2024 16:26:11 +0800
Message-ID: <CAJNi4rOGZpG6qK4ctO7yFY-s_uOax49TYNzdMx_GDXATepY4hQ@mail.gmail.com>
Subject: 'rcu_preempt detected stalls on CPUs/tasks...' issue of cyclictest on rt-linux
To: paulmck@kernel.org, josh@joshtriplett.org
Cc: Lai Jiangshan <jiangshanlai@gmail.com>, mathieu.desnoyers@efficios.com, 
	Steven Rostedt <rostedt@goodmis.org>, Mark Rutland <mark.rutland@arm.com>, 
	Linus Torvalds <torvalds@linux-foundation.org>, rcu@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-rt-users@vger.kernel.org, richard clark <richard.xnu.clark@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Hi,
I am running a Ubuntu 20.04.5 LTS on Nvidia Jetson AGX Orin platform
with 12-cores as a guestOS, the kernel version is - 6.1.83-rt28.
Kernel cmdline is:
'root=/dev/mmcblk0p1 rw rootwait rootfstype=ext4 mminit_loglevel=4
console=ttyTCU0,115200 console=tty0 firmware_class.path=/etc/firmware
fbcon=map:0 net.ifnames=0'

The cyclictest command 'cyclictest -Smp99 -H 3000
--histfile=orin_idle_hyp_4h.hist -D 4h' will hang randomly during the
test, then the minicom console will show below messages:
...

[97619.450889] [CPU11-E] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
[97619.450894] [CPU11-E] rcu:   1-...!: (0 ticks this GP)
idle=dc88/0/0x0 softirq=0/0 fqs=2 (false positive?)
[97619.450914] [ CPU1-E] NMI backtrace for cpu 1
[97619.451912] [CPU11-E] rcu: rcu_preempt kthread timer wakeup didn't
happen for 5251 jiffies! g6029253 f0x0 RCU_GP_WAIT_FQS(5)
->state=0x402
[97619.451916] [CPU11-E] rcu:   Possible timer handling issue on cpu=1
timer-softirq=342864
[97619.451918] [CPU11-E] rcu: rcu_preempt kthread starved for 5252
jiffies! g6029253 f0x0 RCU_GP_WAIT_FQS(5) ->state=0x402 ->cpu=1
[97619.451921] [CPU11-E] rcu:   Unless rcu_preempt kthread gets
sufficient CPU time, OOM is now expected behavior.
[97619.451923] [CPU11-E] rcu: RCU grace-period kthread stack dump:
[97619.451966] [CPU11-E] rcu: Stack dump where RCU GP kthread last ran:
...
This issue doesn't show if run the Ubuntu 20.04.5 LTS with the same
kernel natively on the Orin board.

Any comments about this or what can I do to triage this issue?
