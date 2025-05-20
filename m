Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 091262F2E
	for <linux-rt-users@vger.kernel.org>; Tue, 20 May 2025 14:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747751450; cv=none; b=MUAFpE724xKrRNXp6766oKKqCDbqHocA1+DYYnkRvLYyIvwyZ+uuL4voY79rbaDhSa3HJyOcjfGPmeWy00bGXwJTDsdpOXmHhfjgm2fixfSUH0NJqJsPuYxwQLOsKNd0mPjMbJ8DAgCkp01p0WueTzJZWWBFPJzgMcM+2pEnbPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747751450; c=relaxed/simple;
	bh=vvg5bf2eD9fU8+FGc5yw3Yd5Gh+vy9fi1Az4yIABAPY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=twcnixIQuT5zoZpUtmPia8dHA3rb4y3GTzSY2tZv9dzc/HMusDSUaT4+Vonfmo1uK2hhWHQ9xYQa6qvggXcRQibi40zagarguDSZifjV1hd3PhJK8uhCMeEZoDEZVBxQW3Qes6wFfElIzSzuirH//PzoBH2+xiaJwH+41ds6zLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WXlM7Voe; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WXlM7Voe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747751447;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vvg5bf2eD9fU8+FGc5yw3Yd5Gh+vy9fi1Az4yIABAPY=;
	b=WXlM7Voe8GdOuuMysNKLqnE8z91BOwbnwKippJPt1OypQnoay8pGVglI2KcG1h1JYO/0Kb
	CyFT+bxtY0gaYEieHFTKRIKvg5c+aH27wfl42ukjRNsyV8rhN1Rz2H0waEE/FHW88nGEqK
	GngBUT+J/OhK1BXaOMg+SizXn7BxQJI=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-298-Kx__SANePHKB2XZlVfyYSA-1; Tue, 20 May 2025 10:30:43 -0400
X-MC-Unique: Kx__SANePHKB2XZlVfyYSA-1
X-Mimecast-MFC-AGG-ID: Kx__SANePHKB2XZlVfyYSA_1747751442
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-70cc94b91b3so41287677b3.1
        for <linux-rt-users@vger.kernel.org>; Tue, 20 May 2025 07:30:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747751442; x=1748356242;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vvg5bf2eD9fU8+FGc5yw3Yd5Gh+vy9fi1Az4yIABAPY=;
        b=wsIFzli5kHEzpiWMPdpdnBqCpC3ePCeK9W7SSnKZIDrbECJ10Ix1OT10ESeeVTp/2P
         Qz2UxHPTBG6UWs69C+VvmfVcp4976ygNsE5exnQPk/QGodeAbfxPH2Qxgsoa5BZnOTVr
         iu6Mz/NqiMiyYxvPPjDim+aOM8U1SK3jhBEq8N/VTyGbEsxsaVTTakg3oPhv+2LQVxyQ
         /HK2KreK6Twu1dGx/TyShiNICMlhIAEfwTISTrR6faFcBX2kVSgt7yYjdUObKdPkjTDX
         MX+Nnl3zgwxcoReuzX4onidQmExGzRKd+tx3OXKJc84h0Tm0U6EUoA1IYEtstVR+vbqD
         Y2FA==
X-Forwarded-Encrypted: i=1; AJvYcCX5OIeqre8F2Lxri0+yVR0nd6X1ZpnjdqqN2xu2/m4n80qSWIV1k8qjB07g4T6QnfEkgCBasCw6IeReqkBvfg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyqXZGzXQdyx2nXZH9UhUfgc+ENYXPTciNf3K3YGVDuvJhtkNRA
	UZ/h2fVg8g2bp+UEhx6YyTxTv4jjtCY61dlwxdL9NiPOhivmiJoYBqHJCXaVMlPYf6cTtm6U3Px
	U9kuB8qJyk+sKxEooPDHQoHvFaOPjxoRNMyegEpVqW58Bgfb/GuEZ5SMelk/muOuGfmFnbsbafm
	anBLb9cUMVf9XEnqW0AUd0tYFn58oQI7tW8Mb0GVbDDHo=
X-Gm-Gg: ASbGncsle1VYx1GbJ3VOFUz84v3OTNTvwE/zuvGXFiYeM5WINCM9Vh6sgUCuJF8vHoH
	kJB08mIFTfTVI82fHMhgHzlG10JqTcqWtssnQ7D8P3zJEyqJ7XuhYHW4X1MOCUinYqDdo49pVxm
	1BTpmN2zqiCRpadiWWzuTrjV1m
X-Received: by 2002:a05:690c:6203:b0:705:750d:c359 with SMTP id 00721157ae682-70ca7c54e00mr255934017b3.32.1747751441488;
        Tue, 20 May 2025 07:30:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGyb/+kCgQHXAaXi/OyodhVUZYLYoKdLP+7Y0zVQhc/pyvyjSSbsxkDs+hxKidbhEZDN99oNE38G0t7TnJVNpQ=
X-Received: by 2002:a05:690c:6203:b0:705:750d:c359 with SMTP id
 00721157ae682-70ca7c54e00mr255933567b3.32.1747751441002; Tue, 20 May 2025
 07:30:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250520035641.533706-1-leobras@redhat.com> <84msb7g2sr.fsf@jogness.linutronix.de>
In-Reply-To: <84msb7g2sr.fsf@jogness.linutronix.de>
From: Leonardo Bras Soares Passos <leobras@redhat.com>
Date: Tue, 20 May 2025 11:30:29 -0300
X-Gm-Features: AX0GCFsjG8lD-XbeoOQ7S0hxObU9tQ8zk_F0amKxyOWIjnKf2vstspSG1AUAc1s
Message-ID: <CAJ6HWG7d-1SqOh=H62Ycrx_owziO_CzEvPKMNgsqeWC5b139Bg@mail.gmail.com>
Subject: Re: [RFC PATCH] cyclictest: Add skip_sec option
To: John Ogness <john.ogness@linutronix.de>
Cc: Clark Williams <williams@redhat.com>, John Kacur <jkacur@redhat.com>, 
	rt-users <linux-rt-users@vger.kernel.org>, Sana Sharma <sansshar@redhat.com>, 
	Marcelo Tosatti <mtosatti@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 20, 2025 at 4:35=E2=80=AFAM John Ogness <john.ogness@linutronix=
.de> wrote:
>
> On 2025-05-20, Leonardo Bras <leobras@redhat.com> wrote:
> > When running cyclictest with break trace (-b) option, wait for skip_sec
> > seconds before issuing the break.
> >
> > Cyclictest may present high latency on the initial cycles, which can be
> > caused by initial resource allocations, and may not represent the
> > expected latency for the running workload.
>
> If cyclictest is programmed correctly, this will not happen. Can you
> provide a technical explanation for high latencies on initial cycles?

Hi John,

We are currently investigating the source of this latency, but I heard
from other team members it's also happening on Intel Secure VMs as
well.

Scenario:
Host: ARM64, kernel-rt, 120 out of 128 cpu isolated, hugepages for guest
KVM Guest: kernel-rt, 120 vcpus pinned on above isolated cpus, 116
vcpus isolated on guest

Cyclictest runs with trace-cmd attaching to a guest agent:

trace-cmd record --poll -m 1000 -e csd -e sched/sched_switch -e timer
-e irq_handler_entry -e irq_handler_exit -e tick_stop -e
ipi_send_cpumask -e ipi_send_cpu -A 3 -e csd -e sched/sched_switch -e
timer -e irq_handler_entry -e irq_handler_exit -e tick_stop -e
ipi_send_cpumask -e ipi_send_cpu bash -c "ssh $my_guest 'cyclictest -m
-q -p95 --policy=3Dfifo -D 2h -i 200 -h60 -t 116 -a 4-119 -b 50
--mainaffinity 0,1,2,3 --tracemark'"

What we see is a peak of >50us in the first couple cycles, and then a
max peak of 15 in our tests.
We also tested a sleep before the above cyclictest command, in order
to remove any trace-cmd setup that might have been in progress, but it
did not help.

If you have any idea on why this might happen, or suggest a debugging
setup, it would be appreciated.

Thanks!
Leo

