Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB46F1369B1;
	Fri, 26 Jul 2024 08:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721981943; cv=none; b=NxVMyn6iQDBQopTJZdg24ha0sEPnYPrWTXzc8bUPalBYrIWkDOiZgI2KxAFSEPjohwdEvd1UVjB187Gp8/dYf5bK4Jds0loHW55IQyuF9Hx3M43MJPkhybTArDaXZStuAnm2RFjp4UA4WooH25ND27iLJI0tG6zStrPx64SjDBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721981943; c=relaxed/simple;
	bh=xkcA/AaqQxHyJp7OqaGV5sZmOXYqq7K9BkZGSTCRj24=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GyBBTcpAYGI71Kj5rACZepV4nwJm8ZMKUKn3n9uBLfog8fRgCBT85WHKBqUlx/lcTHwVE8eRWWu5O9kjwqF26bk9fl/qs0sVBCu/4rnzMMmqrrKSOfCcARhU00Wt1j2jHExV6k+LCKzsl+uBlKj0A7amBjtFG0xk+omUvW5g0SA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BpraErCO; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BpraErCO"
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2f025b94e07so12081341fa.0;
        Fri, 26 Jul 2024 01:19:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721981940; x=1722586740; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i9EmuhFIr5qoMsRdTnH/lwQP/q2v/2JVaAPDZXbbmYY=;
        b=BpraErCOrqBJiU/sHsC/DS8eDimpPPgS3w0f8lrcugbAe5RwenMC7Y60wl0/4gc/6a
         20SmAnsV5aPsr8Q1l4FwZCcAXfNKgMk4d3ozOPy1E+wv6Ypf1pqh5dfz6+KpbxBdIul9
         fD97tcaIoCa3VbbZVwc9LmJTq07j84Ybatc62Ls8IL6PzaJpkfm/DbYmffP7mH4xYJjB
         RJ8O2qS3F9BPtYDrDxKQok0vlWKdqFkXa5QGV6L/PbPhqW80glxhugKd1UCi7CUEP7bN
         d8LoCt9MbLOCxh+s2IflqCgh7IIIEojhTGljqMhVH5Xx1dTw38vOR1zmtP+U6xueRhdh
         UxcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721981940; x=1722586740;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i9EmuhFIr5qoMsRdTnH/lwQP/q2v/2JVaAPDZXbbmYY=;
        b=TC2WLaxZs2oHJilJBktVO3eHN25ycVeA1bLbrI+rqN4nYRhKiVjpSf/OYL0r+g7lNE
         EHGztUlHUjFfg2ro5281TLOEU7XoJRcDMFcNHdHVAro0m3BH7lBqRwmCQjuyB8DL6Qql
         a2Lme/3kKbPxJTM14pLBz+HuSzrQEmamIb8Focz1ZYG9qmOWOJNJ7q4b6jDkCUJK2xwp
         gX5r3mlp5E9qIADtGsEfHAcVKX5KfrJF2IOQhIlsDnsWQAq/6yruhiT4BbdE9n8badgY
         9VMzQhqH935HdoPbCw6IgaiuPDSvGgXxvzIcsWPd4sQXYdLe5q3nb126DQYqo/CJl0PB
         bnHQ==
X-Forwarded-Encrypted: i=1; AJvYcCV81VNThQUAw0VFVCbc4bt/A8HRoJgX+EZRDFk4BM6wtOxDi08KtemBY4HnYGvboc9r77KbLqLhgyZDdiPunwIsIj1vaPI660PP3YESDSpSt+xVDOaG/DKEFJGxQ6RozKfnFht828syund2Ncha+ObozK2MQ9oNZ+wuxlYHhF2ctHQ=
X-Gm-Message-State: AOJu0YzIrhw/tPTNH7AdJo45hYn0JShC+E7kC25qgYQ3OxSIPVzEKrEc
	movoPz8m1HuGe9T/9DlSQoSuNM7eeiyI8DL1HP8PqMDrLPB59K0EMkMMpYDVRkPy+LmTQ2eK4sZ
	Crncog/80+XEn/sa8tujWzkzvBQhy+w==
X-Google-Smtp-Source: AGHT+IFz9WnQIt5rV3uOgeKouGjePJ53vpFsRJqwiRauTibBrdSjNs5gnSnA5jfaZ9fv+rrgeRq6FU1nNrKGKqVZxzk=
X-Received: by 2002:a05:6512:1248:b0:52c:df83:ad52 with SMTP id
 2adb3069b0e04-52fd60412f3mr3672354e87.36.1721981939724; Fri, 26 Jul 2024
 01:18:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJNi4rOGZpG6qK4ctO7yFY-s_uOax49TYNzdMx_GDXATepY4hQ@mail.gmail.com>
 <CAFwiDX8MWS8WRkvkt=DgEnn6ZxRZWtiyHuc0hHuSzXoGK+Lpig@mail.gmail.com> <CAJNi4rPjsW5ra=MpX918PjZZN+fAsmd0jzGUWYy6nwuEtz4uPg@mail.gmail.com>
In-Reply-To: <CAJNi4rPjsW5ra=MpX918PjZZN+fAsmd0jzGUWYy6nwuEtz4uPg@mail.gmail.com>
From: Neeraj upadhyay <neeraj.iitr10@gmail.com>
Date: Fri, 26 Jul 2024 13:48:48 +0530
Message-ID: <CAFwiDX_p6Uvcy0uQb0T7pRc2hy-iNZTHyyggzT4qBojLftbKzg@mail.gmail.com>
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

Hi,

On Fri, Jul 26, 2024 at 12:46=E2=80=AFPM richard clark
<richard.xnu.clark@gmail.com> wrote:
>
> Hi=EF=BC=8C
>
> On Wed, Jul 10, 2024 at 7:22=E2=80=AFPM Neeraj upadhyay <neeraj.iitr10@gm=
ail.com> wrote:
> >
> > Hello Richard,
> >
> > On Wed, Jul 10, 2024 at 1:56=E2=80=AFPM richard clark
> > <richard.xnu.clark@gmail.com> wrote:
> > >
> > > Hi,
> > > I am running a Ubuntu 20.04.5 LTS on Nvidia Jetson AGX Orin platform
> > > with 12-cores as a guestOS, the kernel version is - 6.1.83-rt28.
> > > Kernel cmdline is:
> > > 'root=3D/dev/mmcblk0p1 rw rootwait rootfstype=3Dext4 mminit_loglevel=
=3D4
> > > console=3DttyTCU0,115200 console=3Dtty0 firmware_class.path=3D/etc/fi=
rmware
> > > fbcon=3Dmap:0 net.ifnames=3D0'
> > >
> > > The cyclictest command 'cyclictest -Smp99 -H 3000
> > > --histfile=3Dorin_idle_hyp_4h.hist -D 4h' will hang randomly during t=
he
> > > test, then the minicom console will show below messages:
> > > ...
> > >
> > > [97619.450889] [CPU11-E] rcu: INFO: rcu_preempt detected stalls on CP=
Us/tasks:
> > > [97619.450894] [CPU11-E] rcu:   1-...!: (0 ticks this GP)
> > > idle=3Ddc88/0/0x0 softirq=3D0/0 fqs=3D2 (false positive?)
> > > [97619.450914] [ CPU1-E] NMI backtrace for cpu 1
> > > [97619.451912] [CPU11-E] rcu: rcu_preempt kthread timer wakeup didn't
> > > happen for 5251 jiffies! g6029253 f0x0 RCU_GP_WAIT_FQS(5)
> > > ->state=3D0x402
> > > [97619.451916] [CPU11-E] rcu:   Possible timer handling issue on cpu=
=3D1
> > > timer-softirq=3D342864
> >
> > This log indicates that jiffies timers are not getting handled on CPU1,=
 due to
> > which GP kthread was not woken up. Can you check irq, softirq and timer=
 traces
> > on CPU1, to see if the softirqs/timers are getting served on this CPU?
> >
> Please ignore this issue. As narrow down this is an issue from
> homemade hypervisor which unmasks the vtimer ctrl.IMASK bit by
> accident, so the vcpu can't get further vtimer interrupt, thus the
> issue happens...
> Thanks
>

Great! Thanks for providing details on the root cause!


- Neeraj

> >
> > - Neeraj
> >
