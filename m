Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92BBE18FDD5;
	Wed, 10 Jul 2024 11:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720610577; cv=none; b=sKiPWGZRi4luD6T02a7SEtkh/MR0dSDwVF+aXRHr/WDk1cQy1/fec9X/awYau4bk8jeFHvKAd8Z/Sz30SekZP7dn6lQ7E4R1M7jeyTlNisGR4q8eouoLfZ+K5IVF7BLYMx5vC25RuewfXqQgnzDLwSsQUixXcHdLgYyvz0KOKto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720610577; c=relaxed/simple;
	bh=MCcfZbWSzhPegG/ACs7RYwMZqkPgZbAAu1wOaSgm1BQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iitYdxBPTR0Vlq1INZmM4GnskY1eA4MT4PKltyIvVXw55jQIf6sHLuAGUxNiyLgkEWyegByG8c8fDqDwYmrlb+qHCJ71PJ0End/OWGst3YWkWRrWojwODPRrYNnR7Nlv1JzP47Y1usW2nDnBrxO85vbnf0dmYp9sbNFHrtgYlA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lyP6mHgI; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lyP6mHgI"
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-52e9f863c46so6756043e87.1;
        Wed, 10 Jul 2024 04:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720610574; x=1721215374; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7CZIM3swadjLi9UygmpfkohZo/v8gw4/IRQgklum/Gg=;
        b=lyP6mHgIaex4AHv3WjMjgGcfRSlnC7zW/xVMNsePRVUnOBA6hlcC/aNwZcd2yI0GIV
         oBDTuaM1lK6VkcjKWyEh66N7tAiLXdK/zuhR5jSNgxb3YaTAvJ7loqUSIzfzwJexzRss
         uEyq/bcXZrdGpw8hMKoDjS46dKZ78cTvCqxsSDF4w4+w7C8ac58fBPFtrm50tJVvJhCW
         FTp9+X5bwDJiJf8wHwMecLKJo09Ni59wqBUrRv68L+uBHVe/4Rj0W8OrGMuqAlvZDYMp
         q8rZZRI0zb4v5CLgEPkUvc2q4bPfqJcbg884lXkG/wT7B6CIkA70S7LRVAyryCDVSDN6
         ywVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720610574; x=1721215374;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7CZIM3swadjLi9UygmpfkohZo/v8gw4/IRQgklum/Gg=;
        b=ID95zAgx5SxvtfaoLgFG0pRDmFDZHm6lqY6HjMf87D7gEDtwU5UK/N1ksoswH4XgRC
         HaP3Vx8/PdtnFd6KLxE/1Zw9J5EbrA+70UxOQI5CJhYVV5inMqjIKoojfhJWk87E4nNM
         KPaqUhJ3QgH+9s472ncIe+yVKYliY6C2Qi6PsDc1vH5B7JTTWjqojlBRR4R8snGfiiun
         jGGxXc1mzbCSiw8BYomhBk/K/xhqLsEhogIbv4EIBWK1IOIcsyb1GmVHr8N3VIsNCRqZ
         0L/R9M94rrPbrAs4gMfB4K1gOOz1DpDUNed5YvOzMr4et3eu9pE7mXSt+oX52KBKQbMc
         QLjA==
X-Forwarded-Encrypted: i=1; AJvYcCW8V13d+k03oL5+DHCLDny6D3NX/E6Q6A3mTHFP/2gE7Hevbe9/Rzg+uzSVandSUUWLEdRUfPUt/ptWfzgUAdmuoMhOj0qQKVywIhnMWlvrj8FRk3uK+R8oAH6ZZYjyTaAgo/axe3bPRUPYh3V/mpS7e3MtovMwbMtppBM1WNsWios=
X-Gm-Message-State: AOJu0YyJ8ztvUhFTZNDSBUDJnLnM0+P68Zp+qzM0CZr8T4Mp03J3e4A5
	dhhn+Nt0LS2ccHp9uj3zlwWPEh+2Yck/VHgjsRqvTDEa4DAN7HT5cYc7Ud50S+5qqxX4bM+uTTC
	npf7m8K697MHYYjlwdUas8lqy1AI=
X-Google-Smtp-Source: AGHT+IErIIy4dBfKAXYPr/lGgJbvC3B/Y3aNUY2b5lfsmwPl4sL/cK6+FAenoDW3cHp8s1dQmoaP4aYGnRhTYyWuWYc=
X-Received: by 2002:a19:f703:0:b0:52e:9407:ddcd with SMTP id
 2adb3069b0e04-52eb9994b6dmr3216226e87.18.1720610573384; Wed, 10 Jul 2024
 04:22:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJNi4rOGZpG6qK4ctO7yFY-s_uOax49TYNzdMx_GDXATepY4hQ@mail.gmail.com>
In-Reply-To: <CAJNi4rOGZpG6qK4ctO7yFY-s_uOax49TYNzdMx_GDXATepY4hQ@mail.gmail.com>
From: Neeraj upadhyay <neeraj.iitr10@gmail.com>
Date: Wed, 10 Jul 2024 16:52:41 +0530
Message-ID: <CAFwiDX8MWS8WRkvkt=DgEnn6ZxRZWtiyHuc0hHuSzXoGK+Lpig@mail.gmail.com>
Subject: Re: 'rcu_preempt detected stalls on CPUs/tasks...' issue of
 cyclictest on rt-linux
To: richard clark <richard.xnu.clark@gmail.com>
Cc: paulmck@kernel.org, josh@joshtriplett.org, 
	Lai Jiangshan <jiangshanlai@gmail.com>, mathieu.desnoyers@efficios.com, 
	Steven Rostedt <rostedt@goodmis.org>, Mark Rutland <mark.rutland@arm.com>, 
	Linus Torvalds <torvalds@linux-foundation.org>, rcu@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-rt-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Richard,

On Wed, Jul 10, 2024 at 1:56=E2=80=AFPM richard clark
<richard.xnu.clark@gmail.com> wrote:
>
> Hi,
> I am running a Ubuntu 20.04.5 LTS on Nvidia Jetson AGX Orin platform
> with 12-cores as a guestOS, the kernel version is - 6.1.83-rt28.
> Kernel cmdline is:
> 'root=3D/dev/mmcblk0p1 rw rootwait rootfstype=3Dext4 mminit_loglevel=3D4
> console=3DttyTCU0,115200 console=3Dtty0 firmware_class.path=3D/etc/firmwa=
re
> fbcon=3Dmap:0 net.ifnames=3D0'
>
> The cyclictest command 'cyclictest -Smp99 -H 3000
> --histfile=3Dorin_idle_hyp_4h.hist -D 4h' will hang randomly during the
> test, then the minicom console will show below messages:
> ...
>
> [97619.450889] [CPU11-E] rcu: INFO: rcu_preempt detected stalls on CPUs/t=
asks:
> [97619.450894] [CPU11-E] rcu:   1-...!: (0 ticks this GP)
> idle=3Ddc88/0/0x0 softirq=3D0/0 fqs=3D2 (false positive?)
> [97619.450914] [ CPU1-E] NMI backtrace for cpu 1
> [97619.451912] [CPU11-E] rcu: rcu_preempt kthread timer wakeup didn't
> happen for 5251 jiffies! g6029253 f0x0 RCU_GP_WAIT_FQS(5)
> ->state=3D0x402
> [97619.451916] [CPU11-E] rcu:   Possible timer handling issue on cpu=3D1
> timer-softirq=3D342864

This log indicates that jiffies timers are not getting handled on CPU1, due=
 to
which GP kthread was not woken up. Can you check irq, softirq and timer tra=
ces
on CPU1, to see if the softirqs/timers are getting served on this CPU?


- Neeraj

> [97619.451918] [CPU11-E] rcu: rcu_preempt kthread starved for 5252
> jiffies! g6029253 f0x0 RCU_GP_WAIT_FQS(5) ->state=3D0x402 ->cpu=3D1
> [97619.451921] [CPU11-E] rcu:   Unless rcu_preempt kthread gets
> sufficient CPU time, OOM is now expected behavior.
> [97619.451923] [CPU11-E] rcu: RCU grace-period kthread stack dump:
> [97619.451966] [CPU11-E] rcu: Stack dump where RCU GP kthread last ran:
> ...
> This issue doesn't show if run the Ubuntu 20.04.5 LTS with the same
> kernel natively on the Orin board.
>
> Any comments about this or what can I do to triage this issue?
>
