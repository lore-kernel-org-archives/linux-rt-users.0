Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1C16470136
	for <linux-rt-users@vger.kernel.org>; Tue,  1 Sep 2026 08:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788251721; cv=pass; b=cSedssQ08vG5/00OrnIXrjO1LyUEQFIUB5mj6B8K1NLsRYMFytOTu/j/TTI6K1RBy9QjPE028PSMRS+RXgnE2OManSZv5Xj8C+jH/SGMi5pwAE693uSDJQ+o2kJQoapyHOdVbc6nDyC1vECPz6plPoe3grcUNM9dhkLTa0N3Wsg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788251721; c=relaxed/simple;
	bh=eqFIIU/VcOWKdpY9+5KYRLiKy2b1eCfTnVVPGZcxvRE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WEr10pnhKMXBpBQ9/Z07e6fPviFOrn448KfXIufNZc7I1omjKzZnR2J/XkLTECC14MveD0Pkh8OMxl1l4Kw2/Jhy4o+kevYwsMowJ/0GWxsbVmlVfn6uVektPSh1PultkM4sD5Uc+4Nh5KSdcBqHPlfvAqE/fRje7GbBG14mcz4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Zc8L8Pns; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=kgRZqJv9; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Zc8L8Pns";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="kgRZqJv9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788251718;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UKHW+1qiyQQnh93lj7HKCA6A+MKop6YfFvObo2qlj58=;
	b=Zc8L8Pns5pnS4DTSkQ3/ptBDuXafTFxm5d4rmGaTdSzy2GIwhzDwdzYSmMXmXsghDCYqGP
	6zNeJ5+PZB4tszz3FT7hzANTMv61hxsqgAH7RKTdrQeHtH6fuOS1IgKZYa9p+zN6uX/+2v
	58me9V5gheGsmBhnTRkFFUqK7LRQxCs=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-581-vWsfrTFzOfq7YLPww4DzVA-1; Tue, 01 Sept 2026 04:35:07 -0400
X-MC-Unique: vWsfrTFzOfq7YLPww4DzVA-1
X-Mimecast-MFC-AGG-ID: vWsfrTFzOfq7YLPww4DzVA_1788251706
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-c2531b5afe6so70560166b.1
        for <linux-rt-users@vger.kernel.org>; Tue, 01 Sep 2026 01:35:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788251706; cv=none;
        d=google.com; s=arc-20260327;
        b=WcpBtUDIAHvY0WNdpKNZ9P/Qre4GdLY8U9MEcAzfOX0TISWiGj7qXriknOpWL/PP7J
         d3E++7hXgXBcjK92IMKpX3ws/lKM8mXUVC07WEh7jCL8VvizfK+jeM6B/NnPEKuqAm8D
         ctvCbcgZqe+5TBtJNySPR3X9ObwNhELMTUgZSl+t4nS+WP9QRKuMSIHt3Vzc9WUOmZxV
         jR8W8rSYmaiMzR5TV1eTZn8/FqhWlHJFrQyBDtIir/5KTOJ0FpcMJQhC++M6vvC1guAh
         04m68w+PS+HedvAWCSfA45t2/JNzTFtBvkxaxb32Q6bh02cP1HZWDGUeY/RMaz7T+s6C
         mflQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=UKHW+1qiyQQnh93lj7HKCA6A+MKop6YfFvObo2qlj58=;
        fh=SDvYxnR9Rdba7s2oETOGNODZS+qjdPLNTnQl1eazQJQ=;
        b=X/5jodaFZtrJVvujqj2nNSRnvxS5bAeCcknT5B98dHtJ1R8hAPwAgqJZw1kccSIUM2
         bfq1oVAnpFE5J2MdDLXr0fAGSBQsdczUL1uWtBnR8W7cXNh9H3YtabKESqh/t6RzFsKd
         yLw4zknlYnIagubxAlNXT8+gmNEl+dlD1uio+R2TVCev69X3ihyxwGRZxkrmcQyZwLAL
         EheIvhC9vBYcXbfnDItQKPDUuTaAYGkRmbP4VYu26/A6OtVRfRlKOsz+mj4Gd6T0afh7
         a2A0LthIMzYFjdGHFeAtlKief43OrQsaPJsbz+Q03Q7xPEcqvVEwowvoKNxDc1iM/IxI
         5Bfw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1788251706; x=1788856506; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=UKHW+1qiyQQnh93lj7HKCA6A+MKop6YfFvObo2qlj58=;
        b=kgRZqJv9q1eWML48yh8vB3wgvZ75eFs/XgbCTYzGqM0BkHbC+07B5GZi9Wwog9bk5f
         UZ+I8aFvPH7V4tObCZHPdoRZQKqm3VPAy4Q/vv5CWXk0D8JUDCjkEyDChEGD694i2v+B
         4o/zn3o2BGT4P1HaYtaf1oW2sIvZTexDufisq9RbIpa1KBW0U7kRezmUFuKnMuqzfwBd
         BNHdL/EV2OvyPFJCUDJpYUN7RCu6dfJqeiuy3XMDYZPhOJo0NASkFLfvqa5q/nELAZKE
         lf8C1cOXsP+cklJ1v85js49JDAqDUevioOXfcJAhshbMlZ6C0mwyfmFnKJox6MPQN/6R
         zIbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788251706; x=1788856506;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UKHW+1qiyQQnh93lj7HKCA6A+MKop6YfFvObo2qlj58=;
        b=CSzriJtBPw7ZJ3kezRW4144/TLisRK6yhMr2NhDuc+eCR9IXcBp5J30aM1tSwQELqn
         MBebJb36ha/o7/4XXRXWa9b3jALLW6gxvaie4RQiHQFYZvV6QfrD55MTzN10ESAk6Jqa
         cPRA7j0ywiU/rdH2Jjs7+D08/sGNqR5aZlqOqf5+LvNSWVMC738/+EHaP/qsYZ4X9Yk2
         oSRJPajKLwirqmQiJBwT7eDTrqmh0eghhhGc4XSvxfmmyS3C/fTBru8ncrFtQCX6+gJ8
         2Y8MJ6a4FewH6HSUmil7+aMd9sva9k/43DpaECUlUdZmI7dokBYtpeK0Cmt2yUuQf8hs
         XCIw==
X-Forwarded-Encrypted: i=1; AHgh+Rodm2e0nqMMvnXCvjV3km+n3IBO/zMaacoqBdiioYVA3aujChbm6BBquwpzaJd2113wZHtP18orR0jwB48xdQ==@vger.kernel.org
X-Gm-Message-State: AFuF++n9OOI3rXPpWnz17n9toc/0VjhirPzU/yZIzlh25dtNZT7M6te5
	uOaE485g9wdGBd0oAFiAm0PhRflufccDouUMpLmoduyvlcsuV+EKfU+5ANLh8WETIdw+Cpuild1
	VkZHKOhNl73rYJWt0aSUh1nfW8CsNRR6ECthjOB87p6EP4cW9Id59kgr0YrvSC0pPO6/W0F/rA9
	qvau5R8Th4po+V/zDwi+KwUhmxkGurSR1LTgl66DFaNRk=
X-Gm-Gg: AR+sD11LqsT+XzgD6Z1idHSD/ysiMkImiUYinHPsjUTOJxxTinM+H7E/DMKUVM4oFIG
	adHgV9gz6o2CqVWWlc+sPrXog2I1s4kSiCP9o9+ZM1OAInVr5CJZTGwm6uAdP4cFcbooo9f1SxF
	oV0uFcVApilIKWfOH/gbvtvJVaCbUEQuFwH3XZKJwIzvSRShIEz7iUQ40/
X-Received: by 2002:a17:907:94cb:b0:c25:5081:a9f7 with SMTP id a640c23a62f3a-c25b9243b0fmr237675266b.14.1788251706335;
        Tue, 01 Sep 2026 01:35:06 -0700 (PDT)
X-Received: by 2002:a17:907:94cb:b0:c25:5081:a9f7 with SMTP id
 a640c23a62f3a-c25b9243b0fmr237671666b.14.1788251705705; Tue, 01 Sep 2026
 01:35:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260826132153.2476006-1-bigeasy@linutronix.de>
 <20260826132153.2476006-3-bigeasy@linutronix.de> <4ce24139-5f7e-4180-a290-bcc15fb4f559@amd.com>
In-Reply-To: <4ce24139-5f7e-4180-a290-bcc15fb4f559@amd.com>
From: Tomas Glozar <tglozar@redhat.com>
Date: Tue, 1 Sep 2026 10:34:53 +0200
X-Gm-Features: AcwNN1Wt8WXE-7L6E-ejw6rDIYpWfTVTkyYlaZ5V9lwG0r-1O4Ie4bQR6jTWZL4
Message-ID: <CAP4=nvTTrHeOjNX3juTvUwVU5ouJma4fmdAPjnJ=hAbH5+eARw@mail.gmail.com>
Subject: Re: [PATCH 2/5] cyclictest: Acquire a lock before invoking pthread_cond_signal()
To: "D, Suneeth" <suneethd@amd.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, linux-rt-users@vger.kernel.org, 
	John Kacur <jkacur@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 1, 2026 at 10:20=E2=80=AFAM D, Suneeth <suneethd@amd.com> wrote=
:
>
> We use rt-tests/src/hackbench for Kernel Performance Regression testing
> and with the latest HEAD on rt-tests/main, fd45df830803 (cyclicdeadline:
> Fix potential path truncation in open_cpuset()) I'm observing build
> failure with the below mentioned error message[1]. The caveat with this
> build failure is that it happens only when compiled gcc_version < 14.
>
>...
> src/cyclictest/cyclictest.c: In function =E2=80=98timerthread=E2=80=99:
> src/cyclictest/cyclictest.c:653:9: error: unknown type name =E2=80=98bool=
=E2=80=99
>    653 |         bool need_refresh_max =3D false;
>        |         ^~~~
> src/cyclictest/cyclictest.c:580:1: note: =E2=80=98bool=E2=80=99 is define=
d in header
> =E2=80=98<stdbool.h>=E2=80=99; did you forget to =E2=80=98#include <stdbo=
ol.h>=E2=80=99?
> ...

GCC 15 switched to C23 as default [1]. The patch appears to be using
C23-only bool type, see [2]:

[1] https://gcc.gnu.org/gcc-15/changes.html ("C23 by default")
[2] https://en.cppreference.com/c/language/bool_constant

Doing #include <stdbool.h> should be an easy fix.

Tomas

