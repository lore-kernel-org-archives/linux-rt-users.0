Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 513E321FF24
	for <linux-rt-users@vger.kernel.org>; Thu, 19 Jun 2025 11:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750331975; cv=none; b=gmMoUyf3ZILzaT1ZKaJPQxjVirmbeXBRyp89lD/xR48HJHLUfbdcBOX5MCPmXafaPSI3xzGXD5fE/6PMXgVl+UCJPlEz8oEAAcZ031800wUepf4k3c0Olb9SVLgtc/rbfYQ6Th/fxud1LOnuEC8SPAKuntGHGHHDVsgP5ayLZkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750331975; c=relaxed/simple;
	bh=HpOYdabnRAy4NFx530kxe2z6yuiZJXft2UHwEBkMNFw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MPCV7isg1F2Skrjm7Ws7RcyhuzL3gDjtq5rnU4TfVpFfZq8D4MPjW/SgcnQ3IkdnO2j301wUKCqv4iJsGpbcXeD1otKJGQlonLTfJPU+9ObXFTVNk/ktZsEJ6yyLsGVix7Js7hLG2qtTPvsiAHXulFPfMtYA+6Bncbaj0SfHsFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m01o4zdI; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m01o4zdI"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3a365a6804eso442464f8f.3
        for <linux-rt-users@vger.kernel.org>; Thu, 19 Jun 2025 04:19:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750331973; x=1750936773; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4UyV2KmHDhR3+LKSinMUBIA77mraLozwZvJHSD3NOqI=;
        b=m01o4zdIG4S93u0wjNg1SAJU2SPNGZxQjpR3c3dElbKeKE2QKKZPQKVT864dwUIbZB
         g3T87oMyviscGLreM3MDCLUPD6YSbCsF51Gnmv0eJayePQcuz3n2JZ22SYV0FI+wGBa7
         y14yMhsBLpO0L/pk7G//PSkEdA7lmEy4R4nl8MmmWa9Jnhr2TkBBr7eLAzss88P+FLzE
         TjD51lg/negRdCoC5j5+eXQ7A4A0onBrUbBnZHCH4uNpbFnTvV62YKd1SCRV6JhyGAL1
         eROLYkBrv6UgyBjbeOnsAWQa/rncqZC/INytCRjN4jRr8uSfnYZK5F9QhXgHZ18Rp8PX
         NhLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750331973; x=1750936773;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4UyV2KmHDhR3+LKSinMUBIA77mraLozwZvJHSD3NOqI=;
        b=EBo8TZTzwxkB4g4CTEL1bk1SOz5lQfMgIUsgEdNWrI3NUpUnYv7zNkm3rZE7l+N8pF
         t4rE79RQ0sBgmEoWOw7eeIOy0xPNQOaFH3jfE+/gP4DyNDZpDqKRXj4rhdvbvEsptAXy
         xuy88pmxqfxymF9mQjnrJzqKFQEqVwkWfE/YwfI+hrzP8Ehx79iNVemlClqo+83UsCSj
         ZJl2AfmCFuUVf843LLL6T23eFAIOBkuZLd639HDVhSaIHfFkU4UQQzXUDGVmAIMo3I76
         w20wDI1zxhgjJdMHTl0aZtdwMeU+WpsxzlR947MOVrlZJJdeUBBtVr4GZFnR8rUz7ZbX
         lTDw==
X-Gm-Message-State: AOJu0Yw4RowYhd7ycxi8xThshwvV8GX817uNqV+5Fg6W/7U24UWLYI7W
	s/2F/chPo8i+Sg2xUBNkbB3Xz3L77ZslPOYyb6wKja2TF6Blz9qGdrouEwaJB4UhuHKrPH6rpYg
	RByaQ0fv//asNMhpxI2YnuT8xo3A/quOyaoZCnhM=
X-Gm-Gg: ASbGncuoSgFwYtZB+gMJ0gtwusFNnMCExC1trqck6UrOuOLnj6ZiWbf4pRY1AAzoWk4
	BUA9MjO/zuaspsJLGYmtZqJZbhZ/H9mnFXlZUyQwfsdb8F5OwbKjswweBWQcQaGk6O16Qdka2qz
	fKO0Vm2OEIfRBYMs9C6zY/WjHrV1stdOHQZPtJ8M/L8YXU68KsnBsi8z968kxVFW6Xgr9ieYZkW
	UHa8g==
X-Google-Smtp-Source: AGHT+IHOrLpuHARZS5o+Bw/hYSaA98JkDofILaHn6rlqDBdpcQ4uwJ+uD/Vf9vORGH+B0ZvykxU0SIwDEh1yWNP/488=
X-Received: by 2002:a05:6000:4304:b0:3a5:1f2:68f3 with SMTP id
 ffacd0b85a97d-3a572e2e049mr18716299f8f.46.1750331972412; Thu, 19 Jun 2025
 04:19:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAC_kJhQcdP5=0fcWAuXaJ=3Hxx1TwX5WR-UgS=EHuQeqckhZmg@mail.gmail.com>
 <20250617100521.6EW6IWXh@linutronix.de> <CAC_kJhQZpZoUjavRsSVHuXL5k3-3u6+wdL9=h8Pbv3qWvzeOiw@mail.gmail.com>
 <20250618121656.wjpoNGAT@linutronix.de>
In-Reply-To: <20250618121656.wjpoNGAT@linutronix.de>
From: Michael Schanne <michael.schanne@gmail.com>
Date: Thu, 19 Jun 2025 07:19:23 -0400
X-Gm-Features: Ac12FXzR7O81_Iz7p5zfehlX7Zn1Z-1z4YI3enNjlUWGlaU9BF3f8WhRG87j-Pg
Message-ID: <CAC_kJhTQ635vwtj6c7UpvM3BwNb+baMASbeo8t2zT5m5UfEYHw@mail.gmail.com>
Subject: Re: liveloock using PREEMPT_RT with i915 driver
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-rt-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> So you are not using clock_nanosleep() but something like a POSIX timer?

No, I was using timerfd_create() and then calling read() in a loop in
my timer thread.  Is it recommended to use clock_nanosleep() instead?

-Mike


On Wed, Jun 18, 2025 at 8:16=E2=80=AFAM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> On 2025-06-18 07:34:25 [-0400], Michael Schanne wrote:
> > I found my issue, I am using several SCHED_FIFO threads, one was spinni=
ng
> > waiting on a timer to update, another thread which was supposed to upda=
te
> > the timer count is higher priority, but with the RT patch applied there=
 is
> > also a ktimers thread set to RT priority 1, so it was never getting a
> > chance to run and my timer would never fire.  I adjusted the ktimers th=
read
> > to a higher priority and things started working again.  This thread doe=
s
> > not exist in the vanilla kernel even with CONFIG_PREEMPT_RT enabled, so
> > that is why I wasn't seeing it there.  The i915 driver was a red herrin=
g.
>
> Okay not the i915.
> The ktimers thread wakes only SCHED_OTHER tasks. The SCHED_FIFO/RR
> threads should be woken up directly (without the need of the ktimers
> thread).
> So you are not using clock_nanosleep() but something like a POSIX timer?
>
> > Thanks,
> > Mike
>
> Sebastian
