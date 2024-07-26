Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4870423D2;
	Fri, 26 Jul 2024 07:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721978168; cv=none; b=UBf2628y9dshMeAX6YGr8jiemM0EZ0gcmqoviO7TPK8QiUOLOWrih8fQ3mU61mwHk/jPFKAOJpnzuWu6jjg8dgso3uZBfhcpLbN9I52tboRlBYzKZJroj4aRO/+VKh25IactIXX9QbcVQaPDmQB8H6OtCi4/pzVsXQ06ZN/Pu1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721978168; c=relaxed/simple;
	bh=RCEkIohcJGbvaopUENgR78NGrOAkPJylY2hyG/ru+SM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uCqCrJimnoEdoDnUDvTZ3nzeKa1WVgACvCmLDxV8L75Y33xxArbJ5nuBJEdkC7h1/xKuR/Lc0KzTNkGW5CDZxG9KjF1wsVbfPuoqlwvJkBKQSQn98RyZHUlEayWENMvmZWVT7Zs9eT+cJ1+dTFGt0Wzaf3ZGIXE/gK1BF6f6Z9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SN7BeXFL; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SN7BeXFL"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3686b554cfcso933758f8f.1;
        Fri, 26 Jul 2024 00:16:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721978166; x=1722582966; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I636jWxvDq1TyMMv30d0V+K6V+eyZrgqANpNdLLzOCo=;
        b=SN7BeXFLGfTS9PM85pIfo4JPsYRK5vGgdRlwlOE9eZisDf5fv3GL+yBYJgxNYA/TUf
         teTOtx7pKsjXjyOHZJ7h9ktcxvhBoPzZjTpCAp8hUbGWAxzvh5g8cdCHXO5rjSaPkxGm
         371YqqskvcwjF/jhRN2eNphmX0cdiPPluKzkx/pn2e2+5R61sIuk7TeOW9jEOW9ysHtP
         K1HiiiPX1WWzb7Qu13S/1p6qMNIRFPHDyWPOGnYDp3hLvuWcokypHUEdn0iVuQPBU3eD
         KiFE5MaKX0PH4iHfCDFh5ni3Fk0U58zWhF/7nvhhmBYH5kICgqbEgewQRyrSLLKMZfH9
         M/LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721978166; x=1722582966;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I636jWxvDq1TyMMv30d0V+K6V+eyZrgqANpNdLLzOCo=;
        b=TCz0oi6F+ABrZq6vZKFwkvbe0GQ8DeFJonM1rPXVg3eP3SnQzN8gNY1xcfxdS2IV7w
         vn8c4hekq4NcpATnIqm9g7gAmaOY1BZ58fuDbLXYhH95etOmdrG9VhITjp6LIowlx1KX
         ja6sZj/3NL1icEaCX/Xfi/lhySHVsatxK7BmFx95D+U/lY7SNzzWJUSa/YUJpq5NSviL
         Uss0DibhtfAMaDXj19mLdVVBgYjCvldp02vlgNDta4EQUK31rJzcvFvc5mD1ltdsKcuW
         23Jz87LQdsZlRYgH+XRh1UYYU+Nzwu8wcW0nJm+tpSMtegYrbh9mWNHxUTWzyMJ4tc2s
         U0Cg==
X-Forwarded-Encrypted: i=1; AJvYcCUBMzN5BYpl5LMJdBI9xJxev7AS5sw18ni8R09Zp6HMt7H4mQ94DltlaunkEiWTYiTkoFM4wtbU47WbBDGp1GCPbyL8x5aoRNQDcgodiwb8FJP0f+4LMPwRIG+LEt5mVXc/X8QaIqmUpFDOlAZKSWYAnIBAtW9ozw48rA6O+EFgaaY=
X-Gm-Message-State: AOJu0Yy/kFP4l2fEcviYvOGWUhdbaMiTG0xmPTLMngtSUX1/JbADlOWY
	B7qb3F6Y03aqlPWDekj6ksmt31QBXk6afYMShRy5xUxFiKgQrn9IJpKvakDyDeIQCK6hTkAegoP
	p+bg/TJv7xJHlGO1pzxXt1L2ID3M=
X-Google-Smtp-Source: AGHT+IGtuRMSDjIq4gnv5Ia2GJqPnyDJ1Q85rObQOJR0ck0pJhjyrLhAQI41n2YGP0YPoAcJxz+W2UGD/cBYp/tS3fw=
X-Received: by 2002:a05:6000:2a5:b0:368:7a04:7f5e with SMTP id
 ffacd0b85a97d-36b319fb0afmr3041360f8f.32.1721978165206; Fri, 26 Jul 2024
 00:16:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJNi4rOGZpG6qK4ctO7yFY-s_uOax49TYNzdMx_GDXATepY4hQ@mail.gmail.com>
 <CAFwiDX8MWS8WRkvkt=DgEnn6ZxRZWtiyHuc0hHuSzXoGK+Lpig@mail.gmail.com>
In-Reply-To: <CAFwiDX8MWS8WRkvkt=DgEnn6ZxRZWtiyHuc0hHuSzXoGK+Lpig@mail.gmail.com>
From: richard clark <richard.xnu.clark@gmail.com>
Date: Fri, 26 Jul 2024 15:16:01 +0800
Message-ID: <CAJNi4rPjsW5ra=MpX918PjZZN+fAsmd0jzGUWYy6nwuEtz4uPg@mail.gmail.com>
Subject: Re: 'rcu_preempt detected stalls on CPUs/tasks...' issue of
 cyclictest on rt-linux
To: Neeraj upadhyay <neeraj.iitr10@gmail.com>
Cc: paulmck@kernel.org, josh@joshtriplett.org, 
	Lai Jiangshan <jiangshanlai@gmail.com>, mathieu.desnoyers@efficios.com, 
	Steven Rostedt <rostedt@goodmis.org>, Mark Rutland <mark.rutland@arm.com>, 
	Linus Torvalds <torvalds@linux-foundation.org>, rcu@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-rt-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi=EF=BC=8C

On Wed, Jul 10, 2024 at 7:22=E2=80=AFPM Neeraj upadhyay <neeraj.iitr10@gmai=
l.com> wrote:
>
> Hello Richard,
>
> On Wed, Jul 10, 2024 at 1:56=E2=80=AFPM richard clark
> <richard.xnu.clark@gmail.com> wrote:
> >
> > Hi,
> > I am running a Ubuntu 20.04.5 LTS on Nvidia Jetson AGX Orin platform
> > with 12-cores as a guestOS, the kernel version is - 6.1.83-rt28.
> > Kernel cmdline is:
> > 'root=3D/dev/mmcblk0p1 rw rootwait rootfstype=3Dext4 mminit_loglevel=3D=
4
> > console=3DttyTCU0,115200 console=3Dtty0 firmware_class.path=3D/etc/firm=
ware
> > fbcon=3Dmap:0 net.ifnames=3D0'
> >
> > The cyclictest command 'cyclictest -Smp99 -H 3000
> > --histfile=3Dorin_idle_hyp_4h.hist -D 4h' will hang randomly during the
> > test, then the minicom console will show below messages:
> > ...
> >
> > [97619.450889] [CPU11-E] rcu: INFO: rcu_preempt detected stalls on CPUs=
/tasks:
> > [97619.450894] [CPU11-E] rcu:   1-...!: (0 ticks this GP)
> > idle=3Ddc88/0/0x0 softirq=3D0/0 fqs=3D2 (false positive?)
> > [97619.450914] [ CPU1-E] NMI backtrace for cpu 1
> > [97619.451912] [CPU11-E] rcu: rcu_preempt kthread timer wakeup didn't
> > happen for 5251 jiffies! g6029253 f0x0 RCU_GP_WAIT_FQS(5)
> > ->state=3D0x402
> > [97619.451916] [CPU11-E] rcu:   Possible timer handling issue on cpu=3D=
1
> > timer-softirq=3D342864
>
> This log indicates that jiffies timers are not getting handled on CPU1, d=
ue to
> which GP kthread was not woken up. Can you check irq, softirq and timer t=
races
> on CPU1, to see if the softirqs/timers are getting served on this CPU?
>
Please ignore this issue. As narrow down this is an issue from
homemade hypervisor which unmasks the vtimer ctrl.IMASK bit by
accident, so the vcpu can't get further vtimer interrupt, thus the
issue happens...
Thanks

>
> - Neeraj
>
