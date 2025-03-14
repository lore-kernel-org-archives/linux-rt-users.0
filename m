Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B7B22010EF
	for <linux-rt-users@vger.kernel.org>; Fri, 14 Mar 2025 14:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741963768; cv=none; b=Mq4rBMJS7ZBXezN9VcNHYAnskhEpkQs+hba6GCAgYWfZYqySkpi51S9joV8Q7akbGbPOxc/I6KGHYjaZ0WEu77zWbiAC4lBCtdj5j+YUYe1GevxRjnlkKmTixRgemm8HMXTwThumx80pT4NfcVIkqhfm5rzFuDCyl0fzvsV0I5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741963768; c=relaxed/simple;
	bh=IRUxkLTRzEnwATzvAd/TSqejy026thbqXZyoR8zCq1A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JHGSBVFSJMcwp3FEytGf7ob3fDzOcWuqnSk/kqleKHZU91h+w3b1Mqrj9Ib4/d/f68Z+zKce7mMU1JPnPNXHMqlLaoJgqlVl1uuB/FkTXDS/jRV7vnrUgIhuR0roWQ83gb2qqYvPxi1cbkuvkmhKTEDqaOHGIGYkOb/OOCUy3NE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smile.fr; spf=pass smtp.mailfrom=smile.fr; dkim=pass (1024-bit key) header.d=smile.fr header.i=@smile.fr header.b=peV32rsw; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smile.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smile.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=smile.fr header.i=@smile.fr header.b="peV32rsw"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3912fdddf8fso2133625f8f.1
        for <linux-rt-users@vger.kernel.org>; Fri, 14 Mar 2025 07:49:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1741963764; x=1742568564; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IRUxkLTRzEnwATzvAd/TSqejy026thbqXZyoR8zCq1A=;
        b=peV32rswkKoJCAWRIZV8122HNOkFTr5yOiQi42q/uWV63K/yEQPanm7dXr+z810jxv
         0ilLPbWOsz8lDO0lLd6k2B8scv09KosBAyzI7NihzW8SVJO4wg/IKZ+mho7P7OQaMrgG
         MKDTqJh69tsGoErnGCoQAhG1e7qpe012kEdd0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741963764; x=1742568564;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IRUxkLTRzEnwATzvAd/TSqejy026thbqXZyoR8zCq1A=;
        b=d96/n9A1A8xWv+lUmxtVF0zcaxZZVGoKZQW2oCmIP3sQAxmEugvjyYXcfAV1MT8OQL
         CItbZLHJ2N32X1m/6B+gSQrNeN8HCb6M2jAlgzECHzXpwje+O0ZI2QCugGDmJCzPJ6P1
         zahLQKW0BNaligOyj48xLKytmEov9wqqaWSM2KFfw8qE7wlmLATqXyrUowCW656le4lo
         wfGId2PUrERHYRPgnv0mjEi9YWNH2K6YdUP/mFKsl4e2rVrKGKEmeJOSCfpiv69CE8/f
         IDQ8LbUUnu7jrjh5Vz11ZFHUUrBKp9CeSbjNMl35eebwaogGoQcFBl1P8k2PG7RERbdh
         WpWQ==
X-Gm-Message-State: AOJu0YzjoZKScqherg9NPyf4JP5IK2FtSHjaRD5e8+JUq0ra/mr0N0Uv
	PwDHhy6YGV4Vmr/qbFNJbkN5JUkIsT1l0vxljV6lzXYdq3K0Xhm3fV9jwL+5I2I7MnXR342MKEM
	rCksrjr/+Celf1m4shCfvI08RVr13NE5uElTwDQ==
X-Gm-Gg: ASbGncs498MfpvLzJjNQ8ycKylvj1F/55ZeZzzn0gyk6u5zBAA70J29ztm6jAq/4Vey
	Nsr2IrngL0+pyzUyiYW+/VjRvtZyI1/M1dF/uqbyBCf9m4U6jS1xHXubC3l1X60pemmE8T98VeT
	O4xg/UP+S0wIJJu+6MGawjXgXFux+ZIyC18gBFrTXOQBVNflqtYDtw/YDxwL8=
X-Google-Smtp-Source: AGHT+IHuxg/UKupnJKX2+MgNL2fYcHdUdGm2UEO1QBt9hHjJZbidvco2bb26l/zVel0ZkT0D+fX1GNhMGHLLydrIStU=
X-Received: by 2002:a05:6000:1a8c:b0:38d:ae1e:2f3c with SMTP id
 ffacd0b85a97d-3971dbe80bemr4151345f8f.25.1741963763785; Fri, 14 Mar 2025
 07:49:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Z8GTjqgDe_5EkE3t@P-ASN-ECS-830T8C3.local> <20250228142828.wQvZ_Tpm@linutronix.de>
In-Reply-To: <20250228142828.wQvZ_Tpm@linutronix.de>
From: Yoann Congal <yoann.congal@smile.fr>
Date: Fri, 14 Mar 2025 15:48:57 +0100
X-Gm-Features: AQ5f1JqNVSs2yJ8efBDjTiK3BpALs9hZmzybomHUjIWHmaPb8j-rNnn3PliOJw0
Message-ID: <CAMSfU+52bD40i8zp+6RsO6ckhT65GgxxNVAFO0wW+YDDoz5r2w@mail.gmail.com>
Subject: Re: "BUG: scheduling while atomic" with nested KVM and LVM snapshots
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Linux RT Users ML <linux-rt-users@vger.kernel.org>, 
	Florent Carli <florent.carli@rte-france.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le ven. 28 f=C3=A9vr. 2025 =C3=A0 15:28, Sebastian Andrzej Siewior
<bigeasy@linutronix.de> a =C3=A9crit :
>
> On 2025-02-28 11:44:30 [+0100], Yoann Congal wrote:
> > Hello Linux RT users,
> Hi,
>
> > I got a setup running nested KVM virtual machines on PREEMPT RT kernels
> > (all 6.12.12 RT kernels from Debian):
> > The "physical hypervisor" runs "virtual host" VMs which runs guests VMs=
.
> >
> > When using LVM snapshots on the "virtual host" (ie the middle one), I
> > randomly get a "BUG: scheduling while atomic" trace in the
> > ext4->dm_snapshot callstack (full trace bellow). It seems to happen mor=
e
> > often when the whole system is loaded. There are multiple BUG traces
> > each time with slightly different stacks, the deepest common function i=
s
> > do_origin in [dm_snapshot] [0].
> >
> > Does that ring a bell?
> > Do you have an advice on how to debug or even fix this?
>
> dm_exception_table_lock() is a bit spinlock. This needs to be replaced
> somehow. I have no idea yet.

Hello Sebastian,

Thanks for your answer.

If I understood correctly, this "BUG: scheduling while atomic" message
is not the same as a BUG_ON() macro and has less side effects :
* tainting the kernel
* might panic depending on the configuration
* signal potential high latencies for realtime workload
* But does not kill the current thread (like BUG_ON() does)

So, as long as we don't use dm_snapshot during realtime workload
(which might cause high latencies and "scheduling while atomic") we
should be okay.

Does that sound right to you?

Regards,
--=20
Yoann Congal
Smile ECS
