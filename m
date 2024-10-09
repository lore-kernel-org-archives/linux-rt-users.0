Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF20C17332C
	for <linux-rt-users@vger.kernel.org>; Wed,  9 Oct 2024 19:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728501055; cv=none; b=Woc88Vw6NstVe+ZPmU8HLBS1m2sabB6E/skiTMTU0e4JVIOiVXAGL6DAYJ3HagmtwIifVuk3mPnfxM1LRNWfv3uhQwvAIGiidfu5IQYMXJNoS20cvqolllvBYNDivfezgzsgTrm2b22hg8wDYnOKi/pua7WylhwLir49CtELxQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728501055; c=relaxed/simple;
	bh=BzhNPCbzIv6v9TzYC58F9+pOCdbpCHtKgTTtqt7p6lg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TFr+s9+TxQN4DAAwuFXfKTpzXTv+Yq3/rEq2UTBhfQpi8ZpgudFPo39kCmX44pZBTAd0DGFl0O/8k0cQ4Ywrls3OIlb+qfol9LctbqfGCBYGKIbvxYX/rgqejZ27gKrRO7crjt5uvDFb2ohrM5hYMldnXfDiGU04BCIZhzR9tqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aurora.tech; spf=pass smtp.mailfrom=aurora.tech; dkim=pass (2048-bit key) header.d=aurora.tech header.i=@aurora.tech header.b=lIBxFfbz; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aurora.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aurora.tech
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aurora.tech header.i=@aurora.tech header.b="lIBxFfbz"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5c721803a89so62734a12.1
        for <linux-rt-users@vger.kernel.org>; Wed, 09 Oct 2024 12:10:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=aurora.tech; s=google; t=1728501052; x=1729105852; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0Yvy9fG7niiY0BiI9Biem6v1874AFZwOUX/xSiuhag8=;
        b=lIBxFfbzK68O6IgBHHuMRypsm+eWi0ioJPi03UTvatrK7s0GyRcJFX+O2kO4n2EIhg
         P5NfaUrJfOuXAGXs2f0i1Tyn6+v83jgGo6UrHduRDGj/K1dtaXUWO2LkzU0y5ynXWBHm
         aGy7VgLU4MDoVZ5uQ/Xb94kmPFnZ1ursEzm9NblBwjSWkDYVeVP/DfXkVda9ciRzknfM
         1zfM0w/IsYKyNVMAR4s859LTmgHRokaZ5wsN/WLyRaU05CkLR50hsIzOKB6U8DSDF9O8
         hZJAR2UqNYm0hBfRioCoWTC8Ct94uJsYHkerSFyqEAvLhnd2OdB5P/FwbquRDER/TIjF
         INiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728501052; x=1729105852;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0Yvy9fG7niiY0BiI9Biem6v1874AFZwOUX/xSiuhag8=;
        b=GQfz3YgD6EsxAy0yaYf/GQOpb7WWMNp1BncT2vqFdM2mq8N5Wu5M4cjaoXGXei6i0A
         +uzrNLEtH8Gk8HiQPwtddMVwdVJ8HPG14aNQ5LF6U4ePRuX4qVhYF4ocTCWi2QgRGHVp
         SuDIt1UiIwmRoaYe5yPQ2mlxGkMjaYI6gqZEnphIwYYI9ALGkbhkTo4ruHIqo09SXwwX
         F+rQfJ3dUs6KTsxSNxMPLLmCCltcf8suA6rkOTCQEhmA2DHox5KQL8ic8ReNgAwlmd9Z
         eQrX02IUmK8pXh8CdSvkxksDW2q03QqtZzb93uXRn84twuIAXsokMOzvCD0cEgPCfSsz
         AEgQ==
X-Gm-Message-State: AOJu0Yxaafhs68zbH/URfCZsUrOadWW+cWWWiL+SBatVsP0L4+9yC0O8
	F5+XyjvomYTd82iCV+0ybu26hwSevCODvos2K02uN/7Gac2mno2ztPmwF8VrAaiLymGvAaIcqS4
	HZyE4coCkN1eZxqdQAidPe2FiNcwjkErYdaPm+3sUD1eVoYZJUDc=
X-Google-Smtp-Source: AGHT+IFPfFsPYmIZMqRdAQZsnp8+76VWDVUbow+Tc9Aafc5ybjp/I43NlLIGkyWHwrJYSQakvF22xxHEZ6oEM97QQGY=
X-Received: by 2002:a05:6402:3881:b0:5c0:ac1d:b970 with SMTP id
 4fb4d7f45d1cf-5c91d7221e3mr2818925a12.32.1728501052217; Wed, 09 Oct 2024
 12:10:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <f2da9d69-09a6-4086-953b-a24f355f0033@chaudron-nautique.fr>
In-Reply-To: <f2da9d69-09a6-4086-953b-a24f355f0033@chaudron-nautique.fr>
From: Alison Chaiken <achaiken@aurora.tech>
Date: Wed, 9 Oct 2024 12:10:40 -0700
Message-ID: <CAFzL-7vvEjkyyD4NfJWqeqxmsgq05ZMh2Bx6cPqitEsM3WpkCg@mail.gmail.com>
Subject: Re: kernel module and priority or affinity
To: Le Chaudron Nautique <vanvan@chaudron-nautique.fr>
Cc: linux-rt-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Le Chaudron Nautique <vanvan@chaudron-nautique.fr> wrote:
> after a lot of reading, I believe I'm still missing something concerning
> "priority" level (or is it my understanding of the kernel ?).

Welcome to the PREEMPT_RT community.   The best resource for getting started is
the RT wiki: https://wiki.linuxfoundation.org/realtime/start   When
you post to ask questions, it's a good idea to mention which kernel
version and which architecture you're using.

> I would like to set up the reading of an encoder (via GPIO) and the
> triggering of an output with RT to be able to define the max speed.
> Every thing else can be non-RT
>
> If it write a kernel module (I used the site of embetronix for that) to
> manage the GPIO interrupts and output, what is the "priority" of this
> module (since interrupts are priority 50 I assume ? I believe we can't
> change this value)

Interrupt threads are by default assigned the SCHED_FIFO priority 50
by the kernel.  The thread(s) created by  the module will run as
SCHED_OTHER unless you set SCHED_FIFO from userspace with "man 1
chrt."   The priority can be manipulated with either "man 1 taskset"
or good old "nice."   View the threads with, for example,

     $ ps -elFy | grep "\["

> If I use cpu isolation / interruts cpu affinity, is that equivalent to
> dedicate a cpu to this module ? Or will it still sometimes be "busy"
> with other cpus ?
>
> If I am not mistaken, it is not possible to manage affinity between
> kernel module and cpu, it is only for the treads or interrupt by masking ?

There are many complex and subtle approaches that you can try, but
odds are good since your use case sounds simple that some combination
of chrt and taskset will solve your problem.  If not, read the RT wiki
carefully about other possibilities.

>
> Thanks for your help.
>
> Mathieu

Good luck,
Alison Chaiken
Aurora Innovation
