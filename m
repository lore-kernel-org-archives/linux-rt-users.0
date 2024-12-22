Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9280A748A
	for <linux-rt-users@vger.kernel.org>; Sun, 22 Dec 2024 10:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734863559; cv=none; b=iieVbRhS+XFXngF+a9vCuB/WFD7UYPD7EteclLoEw7gp+ecj1nGU+fcsA9qR1d8EwVQF/YNBMoPOLG1nXIY8EqyfRciwvxAXJGAthFT4lLkygNjupx2VOL3wM0THygRPlum8y90WSBYrcVZTFSmmOH48lU6AORWU33eC1tRABjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734863559; c=relaxed/simple;
	bh=N7h0qltN0J6L19Ns6uFBQg+GeJcnXi515eQrYo8+F7A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QleS4qyFdVXJ9MrQWtzzeIVRPZYv0tIS2XB7us6Xb/g18darw/xieafzygzc4SGSCe2mP9sAbV3bYm8aMmuUMnzvKwuW9METmmwcusylrllWtKEw/B2Ols6w4eRVN7+Ee2FZ+cQKMUspMZSCSO8NJvSHbb08tSAEh8g1acdlS8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sidebranch.com; spf=fail smtp.mailfrom=sidebranch.com; dkim=pass (2048-bit key) header.d=sidebranch-com.20230601.gappssmtp.com header.i=@sidebranch-com.20230601.gappssmtp.com header.b=uRBGfTyl; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sidebranch.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=sidebranch.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sidebranch-com.20230601.gappssmtp.com header.i=@sidebranch-com.20230601.gappssmtp.com header.b="uRBGfTyl"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-7fd5248d663so2428905a12.0
        for <linux-rt-users@vger.kernel.org>; Sun, 22 Dec 2024 02:32:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sidebranch-com.20230601.gappssmtp.com; s=20230601; t=1734863553; x=1735468353; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N7h0qltN0J6L19Ns6uFBQg+GeJcnXi515eQrYo8+F7A=;
        b=uRBGfTylDZscoiAy7yjZiJKNIrgveM8OJGNeO56lSDiwnsX39Ib3KOO65C0rpZ3717
         gSLzqN/3+FTgT8HRtmV59pMK4IKFHlkb6jUuVJR2ZaV1wBLfTMynHS2vr62PzPtrT9B7
         JTyr5/qprx9MIpN+OHWhcYT3IlVZaq/aYzKnKo0KWtV/9Axl81K35XQvIFRwt/PlGw6a
         4Q4/z9+vST2b2avbfQ7uHEel8ZWXMsetdb7UzxXZIidmtxoMdYpz/JU+gD9ARbhVlXN+
         O7B655TOwU/5PfvmwUeQ7ucWZQ+0PvbILK6MetnNaYoXdRhUBz47e5653HU5iPf6Orwm
         eU/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734863553; x=1735468353;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N7h0qltN0J6L19Ns6uFBQg+GeJcnXi515eQrYo8+F7A=;
        b=sPcSli0rtZOz4ykfjyhodO9KXewlek7xPHVsEylWEFe4D3/MAzB0OxfhBafeDRJtCG
         fAsexGDdjdZIAIh2zaKmCcoUwtKm8HWeu3EKdhnCvuL37aEwC8FO58JaDzSqft6ppOHR
         HOyWAs8asvgpkPY+xoqBtKg5jUgYDv0UqrIA516KwWQQAxSbhLoc9ipLIYJWwGb1rSgR
         spmf2iKiXl5iyRoh9+JQwxCInW8HjRoTT/CWTDrcoAuTui/wSJIJ5GWUq9Ab0OA/dHfs
         VXsR9LN3+Ut6sMRohSAzPYJ9dvt4r23IVluXsSH4SUCVwHZe7QwPxYbbj5sAAf0ZrMYu
         /xlA==
X-Forwarded-Encrypted: i=1; AJvYcCWpLbCHriBCEELSH163JdIn1x7yKSfDHL2TRPkXf25aFDEiUyPeTSJ+qCLEN0xv18pzVjTDrQMfSdNc8oVzCQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywpoal95tIA9MJbWLYodVOJ6NEdsTX0wsRanLvXB2jlLmhhIgoM
	qVD+/j+FdQMCRRCmzEqL/uo0Fc/ZQJH9R9b5jZIR/r6S9943Str/+FEioo3MPzK7QJtdFE1buJN
	37bZEpYhVojx9Q6YPEjliLk8UHuDVqss1UXLn7S4zH7VaUkyJfEBQng==
X-Gm-Gg: ASbGncvfyT5S/rut17yiuw1LaivW7MU/auwKDoSqcjEnPuWWxsI5D3pL0s3mXO4Uc5A
	JJsDA0ILtdNf99hNLzUdFjys7vRWmBKnwRJmWyKH3NK50DSIoAarqUz0A2jhMXWMxNIA=
X-Google-Smtp-Source: AGHT+IE0ws03XcLmCV9qf28XZG7BvUeuvvWtocpbUWsfOy52SOxve1gWmA+YDTjD9Jcwj+a4hBGYhZm3icPILyH3pbg=
X-Received: by 2002:a17:90a:d646:b0:2ee:ab29:1a63 with SMTP id
 98e67ed59e1d1-2f452dfccb7mr12215745a91.3.1734863553617; Sun, 22 Dec 2024
 02:32:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <d445e582-4e49-4135-9d94-f52d72ec5df6@gmx.net> <84bjx6h2kd.fsf@jogness.linutronix.de>
 <cb569b76-e0ac-4063-9956-ab6307594d86@gmx.net>
In-Reply-To: <cb569b76-e0ac-4063-9956-ab6307594d86@gmx.net>
From: Leon Woestenberg <leon@sidebranch.com>
Date: Sun, 22 Dec 2024 11:32:21 +0100
Message-ID: <CAMjhiJjpnP4Nr5YmgntPd43gndBXnh_DOjW_davDVG2fu0F4sQ@mail.gmail.com>
Subject: Re: Raspberry Pi 5 and PREEMPT_RT (6.13.0-rc3)
To: Florian Paul Schmidt <mista.tapas@gmx.net>
Cc: John Ogness <john.ogness@linutronix.de>, linux-rt-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

First of all, you can loo-kup long-term latency plot for PREEMPT_RT on
different systems. I doubt Raspberry Pi 5 differs from Celeron/Atom,
in my experience and from looking at the plots:, but YMMD.

https://www.osadl.org/Latency-plot-of-system-in-rack-2-slot.qa-latencyplot-=
r2s7.0.html?shadow=3D0
https://www.osadl.org/Long-term-latency-plot-of-system-in-rack.qa-3d-latenc=
yplot-rds3.0.html?shadow=3D0

You could consider using isolated CPU cores, which should give you
much lower latencies, if you have full control over the application
logic.

Regards,

Leon.

--=20
Leon Woestenberg
leon@sidebranch.com
T: +31 40 711 42 76
M: +31 6 472 30 372

Sidebranch Embedded Systems
Eindhoven, The Netherlands
http://www.sidebranch.com



On Fri, Dec 20, 2024 at 4:58=E2=80=AFPM Florian Paul Schmidt
<mista.tapas@gmx.net> wrote:
>
> Hi John! Sorry, forgot to hit "reply all". So here it goes again :)
> With a little clarification as well..
>
> On 20/12/2024 15:05, John Ogness wrote:
> > There are various kernel configurations that affect latency. But I am
> > curious... Why do you think a maximum latency of 80us on an $80 board i=
s
> > large?
>
> Simply because 80 us are an "eternity" =F0=9F=98=89 That's like 192000 cy=
cles at
> 2.4Ghz. And also because other slow systems (like that Celeron j4125
> board I have) behave much better even at similar clock speeds (EDIT:
> IIRC). I don't think the price point has anything to do with it really.
>
> EDIT: Don't get me wrong though. 80 us are OK for my use case (audio
> processing) - I just wonder if it might be even better.
>
> > What maximum latencies are you expecting? And why do you think it
> > is not "under control"?
>
> I would _wish_ for latencies in the low tens of microseconds =F0=9F=99=82=
 I do
> not expect anything.
>
> Kind regards,
> FPS
>
>
