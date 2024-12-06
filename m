Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 519C15464A
	for <linux-rt-users@vger.kernel.org>; Fri,  6 Dec 2024 12:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733487259; cv=none; b=bNiz0AkQNaplw065EF/c0IBi5dbL27vzrvMZnwBUbeicmlYdSgsZlygRaHbgODX5z0p1Df0PLRg1FnitcC+UIH9aZOkLelVaAoHYVAvjxNdK0TVJaRkeUKmXxFtS4TpsF4r5kuJfKD/LS+w4Dbtr07bBk0uVoLeEW9tTfTan948=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733487259; c=relaxed/simple;
	bh=NVJ93FYK5u1LUbiIWaRMUaIRaU637W2Ju4KeVmb7Ncs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KHXnI0Lr3tSRRYDFJE88gp5Gugld7C1L9kIyMJyJ+a8pKUiqLaL0wCQjXGOkobmyp9m8D48EDLI9pYe6AC0N7lhYJRO79hkxqFRY5RhqHit89/n+KO0jw4dsaGttJuRc9Om7ZN8XgpmXXutFSQR75M4SDapNUDu2uiwxvTLgtVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AVwn6O7S; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AVwn6O7S"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733487256;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NVJ93FYK5u1LUbiIWaRMUaIRaU637W2Ju4KeVmb7Ncs=;
	b=AVwn6O7SsuyhN51Uh/I+uWxu1w4nR1uywvW/7/rphFtQmE/I80Vk9ACfqxjWyqPgChphuO
	pq5ePN1hTyzzVEcQjsEKeV4LvO8Xv9Zcoe5pzOLUa7SeBVoUnDBPUkuW7YpxCWifJpRp3Q
	nc+xVdSOkZx11ZvIQN3SxabdXOobHNc=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-582-IYZXEDcZPPajWfx2YzSb5A-1; Fri, 06 Dec 2024 07:14:15 -0500
X-MC-Unique: IYZXEDcZPPajWfx2YzSb5A-1
X-Mimecast-MFC-AGG-ID: IYZXEDcZPPajWfx2YzSb5A
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-53e1b358cffso1579629e87.0
        for <linux-rt-users@vger.kernel.org>; Fri, 06 Dec 2024 04:14:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733487253; x=1734092053;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NVJ93FYK5u1LUbiIWaRMUaIRaU637W2Ju4KeVmb7Ncs=;
        b=bqK8uuMvfb0DPVDuLwx6LmXs+VhJ0Iihjd05eXcbLx+cW3ch4Gj46AHTmXtZNouyIu
         eLk9szYDGv3Ct06LS3/7ZIr/2vJm4K2UtX/RFisEEwe+Fz8W7/HXN5rGJBXhL5xY19C5
         24TZnP7PBYP13CM9JBCuaRUruJG1/TYPt26Q1bTZEUmzubckr+51tGPNT1n8Q0qhDdGR
         hhl/DahV6PVx/7/Er7yjRzDBuDReFF1chpazIhiAmJSHkRv14GYU3ZODcP2FaydRnGN4
         iNnUsN0BplWQZVNgHK6twK6zHlQNpq13Xy/D/dUF/4ijdJvYW4Ds3U2mvRJzbC1bZi6R
         lGKA==
X-Forwarded-Encrypted: i=1; AJvYcCUO7aZH06xiuaZJUgeqsErdvE7d/MAaD6H4keGmkAkfsLotKyBK5cyf8I3GSasPHXVACFvBbZUMBXL1H2bUeA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzu4biPuoJLvpGpOmbwz8nlbEPo1XVwUieVfVfwitTNmIQmiJBW
	sXvBn2gXxxv5gOgOI1aI9+EOCjagYaPF38BluzJOMmsocYsEHZVcSKemQHWWEqVzOBzI5rvwcp3
	dbZeO5bzvMiNWeDggDrkEPIu0kMie9qZQqSRRtUHuYTzSRzAAklVngw9GKctqA70Uz/+hKcswyK
	iE980Ei2bul66gNx9jQManPg2hjhvIobAJHhYrM/Y=
X-Gm-Gg: ASbGnctKznyXfZXabDZ/Gm7cnIL3Nu3yVVu49Xk4RDqw1zpKShNE6doq+UfN8kpQ6Kb
	hp1Pj/1/hg4YP8TPxsMOgR3A1LxB+WyEWpMvLuS89tzwxzKlE1h/bp7aLL2vE3RI=
X-Received: by 2002:a05:6512:4024:b0:53e:20af:db91 with SMTP id 2adb3069b0e04-53e2c2bfc98mr1306815e87.33.1733487253400;
        Fri, 06 Dec 2024 04:14:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGaesBancECt1AlxQGXT0/6cXFLeUUQ961v24LQ3271HeQo8cxugNoeTZKi/7ncxwm3PkzZbgTYnq2XJbFx3hw=
X-Received: by 2002:a05:6512:4024:b0:53e:20af:db91 with SMTP id
 2adb3069b0e04-53e2c2bfc98mr1306800e87.33.1733487253007; Fri, 06 Dec 2024
 04:14:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241113114509.1058593-1-tglozar@redhat.com> <20241113114509.1058593-3-tglozar@redhat.com>
 <c0bf98ab-ac45-eb0f-e239-47e235465ab0@redhat.com> <0da561414289c7b929da1513962756bb8630e32f.camel@redhat.com>
 <CAP4=nvTZ5nLrP6O7rSU+c269M-=OFTX=3zNSp6TDDxzg2Fq2fg@mail.gmail.com> <20241206115201.RJsDmOXi@linutronix.de>
In-Reply-To: <20241206115201.RJsDmOXi@linutronix.de>
From: Tomas Glozar <tglozar@redhat.com>
Date: Fri, 6 Dec 2024 13:14:02 +0100
Message-ID: <CAP4=nvSjcZ14e_bpGaab-Epu_FupXzCi0ovG5hbih1fjhwOTOg@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] rt-tests: cyclictest: Support idle state disabling
 via libcpupower
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Crystal Wood <crwood@redhat.com>, John Kacur <jkacur@redhat.com>, linux-rt-users@vger.kernel.org, 
	williams@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

p=C3=A1 6. 12. 2024 v 12:52 odes=C3=ADlatel Sebastian Andrzej Siewior
<bigeasy@linutronix.de> napsal:
> What is the default behaviour and what is the intended behaviour?
> Couldn't we somehow avoid adding yet another option?

The default behavior is to hold /dev/cpu_dma_latency at zero, which
disables all idle states on all CPUs, not only those on which
cyclictest measurements are running. This has the disadvantage of a
higher power consumption than needed in most cases. With
--deepest-idle-state, idle states are limited only on CPUs cyclictest
is running on.

There are two reasons why we can't just use the latter and have to
have options for both. Firstly, some hardware does not support
disabling idle states on individual CPUs via the cpuidle sysfs
interface, which is used by --deepest-idle-state. Secondly, latencies
measured with --deepest-idle-state might still be higher in some cases
compared to holding /dev/cpu_dma_latency.

>
> > I suggest deferring this to a future patch that would remove the
> > warnings and another one to refactor the code.
>
> Sebastian
>

Tomas

