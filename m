Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.216.42
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795187403;
	b=iXBtkpampORDuoBG27W8Wa4tunMWDcxz1IOrLVB9XLpitAgYpKCKWrL/o2G7MpGBe1Eh
	 ObAnGsJSj8Yy8mFicw3qfHHUdT7PtXnM32UySEUiTxrXrCVzl9kDCKfLfdT/3XO03ByjV
	 jZCVGwfeobuVQM1MwUch/eYxDTufRf96vcpD+JnF620HJNbPbJ+4FPlA3oQB01+bnSAIL
	 x+HjOdMrWf07XOhWy1tivy+v7Rf918L9/vav5SrOsR24u0TiEHm4fBxmtqoBTe4R8CVwK
	 gSX29V1ycRSjc8L3eZevVcwACrRIWZ64QQzXaZUPeJUwqeLzzdgu9fcO0753NmqotsA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795187403;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=kUpp3qHcaoqYe6Oxe72jvoVM6sTucTkiCbMI/ubBdR0=;
	b=ehcbEvBMesWI0tmOJJL0Pg4DQKPzDnOIstJfAmb/vEAAfCZbusDBYx1mVICGGKCxcpk8
	 XbIXDemKXGlfWacUKlXdQqMyMqgw7vdp9NIwdOJNEmAR2cCA3oJv4PV/rSjwyD/vTswIV
	 GnTiGId70tkwC5uN3wuppJf7hTOqBXvFGqHOiV2wKa4Bdcqp71G3q0RJDFw3ld3czn8Vb
	 L1kN12VdO4qSfH2+0ycOhrOtXzXpwZHJm6qgtQGUFOw6WKGlwGuoIsBQIo91PXTMEkgjF
	 LGMxBH15BI98gzJ4G0olK1LMgPuUCyPRsX6oJh6ylNHly1HMBrJZ7MvwEDjxsiDDfvQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qkpFkXFy;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.216.42
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D45C606A333
	for <linux-rt-users@vger.kernel.org>; Fri, 20 Nov 2026 15:10:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4D45C606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qkpFkXFy
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-3b08cf16decso672344a91.0
        for <linux-rt-users@vger.kernel.org>; Fri, 20 Nov 2026 07:10:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795187402; cv=none;
        d=google.com; s=arc-20260327;
        b=YWkFAIU4iAoYsgyHUIT4MZ39dGMtD0UryZIrSSgBvDwABaqC0rYMY6e8meO1CdUZSy
         FU0H9IdnAGN7RZ7CszCL2JEz99+m1Z5vrz5en6CeozGdk82M/GddbKhOokYdKeaTHkze
         /gRNBq9dtl2bKURRWaX4iMKCaOQJsmWu+wtCtqvTkKlcqMUTmUStn+fzUAhjfhniF05d
         I1zAE9GRzFXYgIHZQhFPZEsnaXZtFiWTKe71jg5QFFvNT737plBj0L87TRxTWcMI3+ls
         Z6Uqr857RXuDLULTJQKQkVZFV4mRxso1A2KMB2rtRip3BDiDQs+577GBk+0E4LjBllAF
         WggA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=kUpp3qHcaoqYe6Oxe72jvoVM6sTucTkiCbMI/ubBdR0=;
        fh=6LWTrBD7wBlvxN6WIBaCo15UwYnN13iUCtCBDxzag6Q=;
        b=e1cSGMllHN3NyoI5C+/kcRa4nZbt2uyqBxONLsP0AOMVz5ArLxDHgIRCp3VLSKCoeq
         srL5XRQU1dO6sBpduv89VDNN1rdSGVd+HW0neG7pRn4n0LaNYxtxovl6HivCa4DQWeoZ
         65cxt0iUSh24Wv5c9hkj56/IsO1JAM4Z264THztNq5f2xtsoegDzi0CX6Dg6VRN0pCc0
         EMO7CFgAfc5PxSbpzU0J/KvdckzZuW2S2Pga5oSEX0fuDeZYsSKShoa/iyjcqpiM8RwB
         Z7kYCFwWd7H8O5oIhiulEVydHxEWNkkvwZLqDZiaN6pF2ZUW11707WVsbpgfqvlARoy5
         ESQg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795187402; x=1795792202; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=kUpp3qHcaoqYe6Oxe72jvoVM6sTucTkiCbMI/ubBdR0=;
        b=qkpFkXFyXIEotYNu1HZlWsiL3YsoG7En0GO3i2de+ucOQDWPedxNZKQo4HsYq94l/C
         8kbzdi4s3QxHs04Ry1xrpJi1KLHAR55FpS2bjKwL74+DSyHgZo0fHpB73ODAJ47G2/74
         dTP33cZ2/SJQsbfmAqiRybp9BLaqUh7F7Y9LiRoUuAJqTXUxyiOqk2SY50vfUiFeA2P0
         FyGQTwW+JRL15vPeWIV1BGaRxSC1L3fWf0P03rNYA9/LFJoORfwqgjSwnjpAY2fLukr5
         8hfDn7/kvcsi2b2OQhrzKl06wSSUFIDdswPJviLo6CCXVXg/gXOp2czpIPjB/J8deF1D
         4qFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795187402; x=1795792202;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=kUpp3qHcaoqYe6Oxe72jvoVM6sTucTkiCbMI/ubBdR0=;
        b=JmrJczGh0eYQ6cmalzOlVbETya6kbQWOh3MjgE/2LWzNdn+KYO3lNtZfnvjqX+Khe5
         urDx3ka4ucBdWn193fH9U+MA4s3np/VBycDoGr6XCmqWPq0l9PxE5UqOtSP8seB3XPC4
         5LSJ8nFmX2DBKqcauoCqDg3Hys+r7TCe8k6D/rzMqfd2+cg+Bpz4tci2yXpRQ7DKI+mJ
         5VNr385iAuvUyAjUwgZ/lrJIE/+wsMb269whVQaLWMzRs/PkS4ciBPfVWhEbHAX1tu4+
         lI8iHceR7NufYFiK7cMMB/C0Pd7jOqScI3uR2pKHJHtIA2PaZfhz11qa8PtaQMfiy8ZN
         eTpg==
X-Forwarded-Encrypted: i=1; AL+hErHa8BSC+5D3IpuzlV+cn1cSFU4hJs1Y68MmszRcz92etnfrqLKBCS2bXP/dn2oRJ+lK3j3blCxlX49bqYnDRw==@vger.kernel.org
X-Gm-Message-State: APuU4Z8qTh9Wn2pC6vTZKH+rOiw3eB1zt2VS71MfKUEFdPk/ClCsVYrJ
	U+3sNQ9TXvmJVbYYKGIcHvjh9Sl3j4icEuX3yZf0Jff6ZJFStYhUiSHexjD4qetSEoBjozDd5Yv
	bVsZ/27ZUFkqg7MOjxXxS8dKb10D1NFS/M4dA
X-Gm-Gg: AZFdTZeBTEHeZexon2kfDccgcMncD1t8HBPwBGg+A4IFqjATkomSo575CogPe+ZESJ/
	oRx0LPNr2CfQIN3G9Yj8q7RG8oskICem5nR/zH/WPTqmZiJE4nkR6H1pWULPZDBj9ZuPxvZjKxb
	LeYtC9FV/FMdkGpJj70qIuWnhtMd0wQ7LiahXN3ctnx/OEBs3RJNaW1wGzGLIk4gTbIHzC4/6Q2
	o49pporlgtCCPQhQ98exx8vkePjHY9z6YftowT7Eoy2GuNWR2GLCtYx6EgrwCHfNhN/Ml+5a3iy
	/LI0D3Ei9vYDsxuDgjz6j1Hu68WFa4sQTioVGDQFSkbFOjSGvmF/aQVBF4cE9Qk6kGnaZpX1FYz
	ZPnYesq0ClH149cVr77C/3V3QFLoF1YUXUm8JRmZIMabyiEPWGXn+cko5ab5jA/roUkk=
X-Received: by 2002:a17:90b:3a4d:b0:3b0:91ce:6726 with SMTP id
 98e67ed59e1d1-3b41c8db487mr3145864a91.21.1795187402472; Fri, 20 Nov 2026
 07:10:02 -0800 (PST)
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Post: <mailto:linux-rt-users@vger.kernel.org>
List-Help: <mailto:linux-rt-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rt-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: Florent Carli <fcarli@gmail.com>
Date: Fri, 20 Nov 2026 16:09:51 +0100
X-Gm-Features: AclHuK-zBsB39c3smGA1HgYvvn2IKUa7TGYhpz-IYPnNRniIYEWx37QeH8vS3OA
Message-ID: <CAJuRqcD2=42CTQk2PSHofSmt+=H=qKT-x-ZXD76TwVshaepBAw@mail.gmail.com>
Subject: [REGRESSION] 6.12.y, 6.18.y: fair server runs SCHED_OTHER ahead of
 SCHED_FIFO on an idle CPU (fixed in 6.19)
To: stable@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, linux-rt-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

As I understand it, the fair server is deferred: it should run
SCHED_OTHER tasks ahead of RT tasks only when RT tasks have kept the
CPU busy for most of a period (about 950 ms out of 1 s), so that fair
tasks do not starve.

On 6.12.y and 6.18.y, I see it run SCHED_OTHER tasks ahead of RT tasks
on a CPU where nothing starves. My setup is a PREEMPT_RT system (Debian
trixie, 6.12.117 rt) with a time critical SCHED_FIFO 98 thread on an
isolated CPU. That CPU is idle most of the time. The thread wakes up
every 300 us and runs for a few us. From time to time, a SCHED_OTHER
task that wakes up on that CPU runs ahead of the FIFO thread, for as
long as it wants to run: a container health check (bash) delayed the
FIFO thread by 3.4 ms this way.

6.19.y and later do not show this.

My reading of the 6.12.y code: about one second after the last fair
activity on the CPU, the zero-laxity timer fires and replenishes the
server with dl_defer_running = 1. Idle time then drains its runtime,
and dl_server_update_idle_time() clears dl_defer_running after about
50 ms of idle. A fair task that wakes up inside those ~50 ms runs under
the server, ahead of any FIFO task, until it sleeps.

Reproducer, as root, on an isolated CPU with nothing else on it:

  CPU=22
  python3 - "$CPU" <<'EOF' &
  import os, sys, time
  os.sched_setaffinity(0, {int(sys.argv[1])})
  while True:
      time.sleep(1.02)
      end = time.monotonic() + 0.003
      while time.monotonic() < end:
          pass
  EOF
  cyclictest -m -p 98 -a $CPU --mainaffinity=0 -t 1 -i 200 -D 30 -q

--mainaffinity matters: cyclictest's main thread is SCHED_OTHER, and
when it stays on $CPU its activity every ~60 ms keeps pushing the
server's period out and hides the problem. Any other fair activity on
the CPU more often than every ~950 ms does the same.

Results, sleep between 1.00 and 1.04 s, 3 ms spin. Max FIFO latency,
and wake-ups later than 500 us:

  bare metal, 6.12.117 Debian rt         3001 us, 10 per 20 s
  (10 ms spin instead of 3 ms)           9986 us
  KVM guest on dedicated host CPUs:
  6.12.117 Debian rt                     3000 us, 10 per 20 s
  6.12.118, vanilla PREEMPT_RT           2900 us, 8 in 270 s
  6.12.118 + v6.12-rt queue              3000 us, 14-15 per 30 s
  6.18.15 Debian rt                      3000 us, 10 per 20 s
  6.19.14, 7.3.4 Debian rt               < 25 us, 0
  all of the above with
  fair_server/cpuN/runtime = 0           < 25 us, 0

The lazy preemption patches of the -rt queue make the window much
easier to hit, but vanilla 6.12.118 is affected too.

The fix went into 6.19:

  e636ffb9e31b ("sched/deadline: Fix dl_server time accounting")
  f5a538c07df2 ("sched/deadline: Fix dl_server stop condition")
  1e0a2ba7afb1 ("sched: Provide idle_rq() helper")
  ca1e8eede4fc ("sched/deadline: Fix server stopping with runnable tasks")

None of them carries a stable tag, and only 1e0a2ba7afb1 applies
cleanly to 6.12.y or 6.18.y.

I have a backport of the four to 6.12.118, with small adaptations
(rq->donor does not exist in 6.12, so rq->curr is used). With it, the
reproducer shows no late wake-up, both on vanilla 6.12.118 and with the
-rt queue, and the starvation guard still works: under a SCHED_FIFO
busy loop, a SCHED_OTHER task on the same CPU still gets 4.7 to 4.9%
of it, as without the backport (0% with the server runtime at 0).

Would you take this series for 6.18.y and 6.12.y? I can send the 6.12.y
backport as patches and prepare the 6.18.y one, or leave it to the
authors if they prefer.

Until then, writing 0 to /sys/kernel/debug/sched/fair_server/cpuN/runtime
on the isolated CPUs avoids the problem.

Thanks,
Florent.
