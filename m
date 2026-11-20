Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795198809;
	b=hWrUBf9QHPH5WmV9ztJ7lF3UC3lxjMgvfZphRVtowXT4mgmHzRtT50YMW14qRgdDrQh2
	 9LTqqkU3naiyRjIlSKsA6EsGc6JzISybbEG0ARqDFGIgW+vrRN8lqV2ewy7AFJUyjNKMo
	 RtaxV8MvsRo9xDq241hkufta7ZDmyQhHEelxGtO1qs7PrAzKc5vD5P7cVNU5T9vq7Vu2u
	 OOcKDJWGhfVVTIFxRT5Gi3wUF3t5YXE8q/ZVbSrLYAA4KVsdLk7orcIfi+7Il3GCgz+cA
	 aYgjtdSzULCemhFuJewsVhp7uYaNrgki4Li9ycR+lSdHDv8YgUMI3PwYWUVxmmzl01A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795198809;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Z0Ms4EWmpH8O95SfcyZ1/RL/Upfl9qBeaFcIpXoItCQ=;
	b=N9ZQrOWcacOAtldqLGsx9TocizBDvrZYTzX4JxJBDxRqgLXzjAQ3sPDokVjawiHkNrTh
	 7EInCPsrYT3HB/Ld/bPDovi9gXgatnFdj6t1E08wApfG8Do/LDzlMm3uoQ7sG7+3HEkhE
	 Eh9YOUGpS+1QLtTQ0zz9WXHkm2vvhpgn/suYblcb25eVg1gUBCxDP/icxMMc3OzcmmyMp
	 gDrOseVRLDDUsTyWS6jAdf4VR6dVzQsi+e9QI0C709shlVhWUUtkEg+PJ+VjLdBx1j/zJ
	 lIYETD/kpdkTCmi0IXY14wpevOwkx+Z+WIUtiiiPjqRJ1VnlN2DEryKtQzPH/5y5svQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TwWop+l8;
	arc=none smtp.remote-ip=209.85.221.50
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5366C606A89D
	for <linux-rt-users@vger.kernel.org>; Fri, 20 Nov 2026 18:20:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5366C606A89D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TwWop+l8
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-4ad6219f7d8so533671f8f.0
        for <linux-rt-users@vger.kernel.org>; Fri, 20 Nov 2026 10:20:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795198806; x=1795803606; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Z0Ms4EWmpH8O95SfcyZ1/RL/Upfl9qBeaFcIpXoItCQ=;
        b=TwWop+l8PNa4D1dwENFcUvehnaprPSLedFZhwVNrUdqzfG/sQ3MKhgtAv861M7H9UW
         RfnSZWlgXh6tJQbOKpQLOiHh/FQGkFEUJLtAm/MJVGaEk/isxhg3RlsAfss5Bh3Zb5ar
         bEAMtTY5Xr07JC3pYyFbcs1K1iDKjKGQCgT119BCXVBa7Y7KTqe1cz5iFH+np0tVr/z6
         hjgr+viQSW7TXQo0F++SdnmEFglafGtUrWfxN8DGSHYDrT1dDUOSCstDhJI/rprErbqa
         SfERl5r4RUE48KeCGb4c6lE87wVdRbl5eH0ufF/FyPWeAVneGjKG+C6HYDc9SuoWR7A6
         LrKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795198806; x=1795803606;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Z0Ms4EWmpH8O95SfcyZ1/RL/Upfl9qBeaFcIpXoItCQ=;
        b=sslQBmajH/K4rrKJiOs3Mz1EgGQvcF+gt5yaJ2A/tLWrEo72pkgacRymC66BqKn2F9
         lHLOxG5d1J8O7m/W29g38hlox3ZKCnbxWdz1vnKw3HD+MiC05AUuHFEvH5/v3ADOnmZ3
         HaTfUNi1NwNEggU01gk31ymcO2SHLxtIE+POytUSi2kFpO+8PVDcviLy+yN4wIzkhi4T
         ilZr29AWTLpkq/mBJ0lS7KsE0Ve3pD/HoIw1Nm8YFrVcQiJKsdt/RqsDLHHLlcx6+Zgj
         oY82rJbAhfLMZWXyInnoETpkVF6qekfbpnS0DBXmLd0cZI9aKHzhSOrt0NwfRObYpCq1
         uyHA==
X-Forwarded-Encrypted: i=1; AL+hErFd7lKIdZeyF+7u6FIek6KZXPbUpVO3uSQn++XddZ7uDWHGni/QgDikGR4s0YA7Zsg8SZZ0dg4iKgzsknX5Sg==@vger.kernel.org
X-Gm-Message-State: APuU4Z92p95v5Qbsm+1J/d0Q6xdPuijmk+0UUEVvEPr35aaNkU/uVSNU
	+glO2tGm68jomVnF2/6hUgk9PaW2ixTkKjT32nMiR9DlDQDf/teJXd0p
X-Gm-Gg: AYBFou2jd8tRsSdDU3AAHhgh+VCdPd0DH7SH8ui54R3ON+kyQb0AkTbRrbkKzoU6ldS
	FiyHkAJRQ2TfACaq7pupy+uwywViaCHjv80AiVt5DP5LALAykYq9l225vyJTsFeKGJzcvBs7aZX
	d6RHzb1w98bP10uJqdsfIGOn83SdxdK9M51JepxLvwJ/IL36ZdhiBO6ZTiM9++spcBWrMueVreY
	Z/8Xb63iNRNfpjWfV/Er8dncWtoGBUAn9nfeBkbe6Zd6CxRK7WBK4u04B/1BIFyOrPdkWXQsMqa
	fHnoDGxVPVNv0dqPc1jsNJOaPmAF52nc8EIxE1hg8NGU9ftmMR+mqKRBJJ4QGl77BavT0KzK5te
	2GjnZnAFN5OLp04nlXd+t85aTtLuHTFNHPlxrVGUGfjjJyWme5kLbmlMuIyfiyplKF+havqJMlG
	RlkZTPgeUSBFjjD6FNASZD2ROGRdCOb32tqrOvBnV2CVRb3d6ZRn8/tMIBUN/3E1NgoM/iK6Gbr
	o2DaRRPyJRcLMduGcNgJ5R9ve4Rc7YA61oStBl/I2zRzbsPxBVDJj/keaReQnKRAgiZOeqioCCx
	Oy7i6QN+xEdIo1oR7wbEPOxLJfPxS4VwUcEA/BTkXhpvRgBCvvvYWXHKcNvtw8E4Up4SAwdfdxH
	7I4Yg4+GxRAF4Ws7VJn9u1oyr5g==
X-Received: by 2002:a05:600c:4e87:b0:4a7:6bc7:f778 with SMTP id 5b1f17b1804b1-4bb88938d38mr93238985e9.30.1795198805501;
        Fri, 20 Nov 2026 10:20:05 -0800 (PST)
Received: from mbp-de-florent.lan (37.170.0.109.rev.sfr.net. [109.0.170.37])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb895eec06sm34789565e9.2.2026.11.20.10.20.04
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 20 Nov 2026 10:20:05 -0800 (PST)
From: Florent Carli <fcarli@gmail.com>
To: stable@vger.kernel.org
Cc: Juri Lelli <juri.lelli@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Gabriele Monaco <gmonaco@redhat.com>,
	linux-rt-users@vger.kernel.org
Subject: [PATCH 6.12.y 0/4] sched/deadline: dl_server fixes from 6.19
Date: Fri, 20 Nov 2026 19:19:45 +0100
Message-Id: <20261120181949.7528-1-fcarli@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <awB-5usPb2QZXt37@jlelli-thinkpadt14gen4.remote.csb>
References: <awB-5usPb2QZXt37@jlelli-thinkpadt14gen4.remote.csb>
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Post: <mailto:linux-rt-users@vger.kernel.org>
List-Help: <mailto:linux-rt-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rt-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

This is the 6.12.y backport of the dl_server fixes discussed in the
parent thread: on 6.12.y, the deferred fair server can run a
SCHED_OTHER task ahead of SCHED_FIFO tasks on an almost idle CPU.
The same four commits are requested for 6.18.y, where they cherry-pick
cleanly.

Adaptations for 6.12 (noted in each patch):

 - 1/4: rq->donor does not exist in 6.12, rq->curr is used.
 - 3/4: rq->ttwu_pending only exists with CONFIG_SMP in 6.12.
 - 4/4: context conflict in dl_server_start(), which still
   initializes the fair server in 6.12.

2/4 applies as is. The series builds and boots on v6.12.118 with the
Debian 6.12 rt config (PREEMPT_RT).

Tests, KVM guest, reproducer from the parent thread (3 ms spin),
sleep 1.00, 1.02 and 1.03 s, 90 s per run, late = FIFO wake-up later
than 500 us:

  v6.12.118                      8 late wake-ups in 270 s, ~2900 us
  v6.12.118 + this series        0 in 270 s, max 15 us

With the v6.12-rt queue on top (as Debian ships it), which makes the
window much easier to hit, an equivalent backport (same code, the
idle_rq() helper added without moving available_idle_cpu()) went from
14 to 15 late wake-ups per 30 s to 0.

Starvation check (SCHED_OTHER task on the CPU of a SCHED_FIFO 50 busy
loop, 4.5 s window): 4.9% of the CPU with this series, 4.7% without,
0% with the fair_server runtime at 0.

Thanks,
Florent

Gabriele Monaco (1):
  sched/deadline: Fix server stopping with runnable tasks

Peter Zijlstra (3):
  sched/deadline: Fix dl_server time accounting
  sched/deadline: Fix dl_server stop condition
  sched: Provide idle_rq() helper

 include/linux/sched.h   | 16 ++++----
 kernel/sched/deadline.c | 89 +++++++++++++++++++++++++++--------------
 kernel/sched/fair.c     |  9 +----
 kernel/sched/idle.c     | 16 +++++++-
 kernel/sched/sched.h    | 31 +++++++++++++-
 kernel/sched/syscalls.c | 32 +--------------
 6 files changed, 116 insertions(+), 77 deletions(-)


base-commit: b869a5313cbfe7102873d3de318ddb68675146d0
-- 
2.39.3 (Apple Git-146)

