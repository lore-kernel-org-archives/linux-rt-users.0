Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5234E3BFAC8
	for <linux-rt-users@vger.kernel.org>; Fri, 10 Jul 2026 07:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783667121; cv=pass; b=sQtsqtioUd8jx8ZTHy0CJAS7m2LSSwmJ7QtjApRH3Jmuxlbr1RTtxJjn/8velc9weNWB1fBnbc5Qm36BGms+Wv1epjyZAA3Xykx/nUpWoGyqI2MjaE+CIALfPAokIBHSDGSNG048pwtse0xuDJHAxEgPUUv3eLlqtkDb6OnXO2c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783667121; c=relaxed/simple;
	bh=SSEFVYhF2Pg3TbzBC13FrS3vwkfQJZGZ4K20/HU793s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hNcLa82V9DfeIklv2yWd+H3HX2ZjLz7TOESwVe5lFe52rXP3arPF4JrhkpOG5fWasvUJm28no6R/H+5cZMR852IShsdblxip3/p2Lr35Igk2x3GK5y/yEij28XbZ529Ihs6BkaTKTBKBArfgMKK2CrhEwpB7+cCEKAGYjc3+tfQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YEF1GnnX; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=jGEXtoXf; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YEF1GnnX";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="jGEXtoXf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783667119;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TBLtI1cgq6P50LRB2gR35deeL3jow5HhR1wudht4FTI=;
	b=YEF1GnnXoRxftdBKMN9S9hsLuPWtkjaiuXv0RlanHMtFpBBEfHCw8vPdzFnMnNkZXK98IJ
	PV+JrFRMe/k5D4L7eTQoomqIcymjloUn+qysnmL4o/H94kUlMTLC5u5wf6nnaS7t9RuHy2
	TdnWORwCMaqCaH8X+NQgtj9WzoXMkRo=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-478-rp0mKiv0Pyasx4PaSbb3kg-1; Fri, 10 Jul 2026 03:05:18 -0400
X-MC-Unique: rp0mKiv0Pyasx4PaSbb3kg-1
X-Mimecast-MFC-AGG-ID: rp0mKiv0Pyasx4PaSbb3kg_1783667117
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-c15d4107068so69732966b.1
        for <linux-rt-users@vger.kernel.org>; Fri, 10 Jul 2026 00:05:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783667117; cv=none;
        d=google.com; s=arc-20260327;
        b=Tl9099yJ6Q1LkKSMy40oymyJx5XSEZwTu1uL4L4jnnUz7HIoc2bSm+VeWVcqb6SsOd
         MgxpazLh0dqS7AbRlju/iKQHyMEm+tieI8utv0asb2W/jPu5s6U0mprEf9qiBgqY8xTX
         f+S31EN8arUNTtwogZYt4BbVnKRpiW6SZsBHuftV8JFczpePDaaLNauLXxqkPFxVdnkq
         Fs1MqtzoIZFQYP+9aqvG2PjcaGXHDlyv5YArQaBLAZZRavFsEMJmuCyNHdo1mwBpcJKO
         l+siyvZ3de6TRMiwGVQHzfZJK2BprvaNxIGfbOM6QrZ/rt0NbuT+NvRe7THozWgpMxbH
         NVVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=TBLtI1cgq6P50LRB2gR35deeL3jow5HhR1wudht4FTI=;
        fh=dfxcFkqlbz8Skub0JZ6oQetdE9EQbv8mwsqylR/UUKg=;
        b=ncmVK8tcfnNvAMBOyTUJasrjuVdfeKNoK91+45EWuixz3GopdPurNNUhOBVlgK1hvj
         7dmPPlDYSySJ0UwuNh+C2eFCvgK1zduqz8L4S4KHeD0LNn4xeoXbdDJS/ZgbKDEwNpWq
         nGmrQUw3NmijrTOUbBwlVmFUwezlcpE9TRalBEvgAdkQ0BuEbY7vt45ulrcSpyOo2Va1
         WJMIgzG3IR1f4KZkqvj9xoL58Qnln8zZYLQmEs2C/mEp3u3+J0FCeX0xQg3Nq48z9PbB
         qMoDvTUa7W4vDQGtAdt5N2jUibqKeNCYhl1M6sHfhMNXwcqXI7TySU2tDgfc77ZHc10k
         Kf5g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1783667117; x=1784271917; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=TBLtI1cgq6P50LRB2gR35deeL3jow5HhR1wudht4FTI=;
        b=jGEXtoXf7X/k6d+nUwGX7lWbPXLJzmi4e3tLBlZ4+VqUfC4GY1PLsZNoEmgFrtkNXS
         dR7vtuNYmyf/1IY479EHw2ft3di1nNGEl5OHnaZtsZt/2ZD3o4G3ZQmUnK4pWVujs+Rz
         cnCZtVK2zMBkwf0x3bBv5m/nGQSfLMasmpHY4NqUtvoR0pN6q0z7olfOThjzAqFK7mzk
         NPiOipXGueO6HXy2siuwomLF3bURfc7cD+MOZdIfPk1wiK/e5SeUfUwvOa0ZK8rd+4Ji
         NMU8SNNBB4nPgsCXl/c00M7tyj6Di1jPPt38xu6CSnAW2pSlKB9/sssVwAtpeIxThbgV
         QcvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783667117; x=1784271917;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TBLtI1cgq6P50LRB2gR35deeL3jow5HhR1wudht4FTI=;
        b=H0I3wpV12RKmMsF4zYJ16DU/Bj5nnV/LWOgVM6XElee+tsCNcX/QHjosOtLL7jWZpJ
         LVGXXTQWcPvsmfSCfTGuhoKk3+bUPR8VO70W+jScl2u88Rvqj2UWUmbFIZgfKKZkj8m9
         s4oNtX0Sj5gBpHuDAdL5+lbzlrFBh/RRXeb+gnD+ndeWRouY5Q7M9HWbF6KRWloa9Ip2
         gu2rJFyTxr75+8h3WsrhzLESFB2mf9IwCia+fNjSFTJASHnBcqbdBlqOy1v1UZoNtwOE
         te2f6ExHqmCe2oKmLhPR70TLiXsp3pcGJ20PYGvfgxCX6RZLdecNrVHlHF+NFHh0KmDX
         M1/Q==
X-Forwarded-Encrypted: i=1; AHgh+Ro0CGrLsMlquaoyDRwpZLX5wV/z+MqOQTW71R0GMQMbUBIDlyNACuHe/q5aiKcJXTwP5CNAmVVQI1XLXgoceA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxVDp+LXWt82rWCw1VSaYYPkwuzYJsf4ukrm4tQcXdyIx/QLH/o
	6AEPl/F749MlbYOiH5yTh32zediUb/1wn40x1ZxLlLaOA31J/6NM4KL4yEFsMOW4CLnmO5FKwnl
	fOSR8bUPzpx5g0oYT3N7BDi0XDBmnJFvT9ecau34j9xV1LqHbDQ5sNHmGzO/byEJNRQCg7R/DvE
	NmA5wRiQaxWEur06ToVqi85LXpoZ5Yyr5zgNDznJlgJMg8R8Rhf2w=
X-Gm-Gg: AfdE7cnrVqxOTo8yg2wNMwuILo8hn0wKpAZGJks7bJpRc6T2UsMFcighO3DROea6Il4
	QlpCEbp51ibXhGGu1PPEfCP+iuoftW3kg/lxG/JMDmKK1zuojqFFHmXepxEekwdEVdeaeQIK+PM
	kOVbHfjZTebmRcSsBTSGJA6a+4LhV+u+5/J/xNI3rvieETPeZSPjcy7ungq4jfeb9WCzoumvBeD
	qPCh5rEtbUgXuyvnqDKAbVulA==
X-Received: by 2002:a17:907:e153:b0:c12:b227:c0c8 with SMTP id a640c23a62f3a-c15ce128cecmr304103166b.50.1783667116712;
        Fri, 10 Jul 2026 00:05:16 -0700 (PDT)
X-Received: by 2002:a17:907:e153:b0:c12:b227:c0c8 with SMTP id
 a640c23a62f3a-c15ce128cecmr304102366b.50.1783667116222; Fri, 10 Jul 2026
 00:05:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260709143108.UYeCUUcd@linutronix.de> <2026070922-kilowatt-matador-5e1c@gregkh>
 <20260709152214.rH1O_8SM@linutronix.de> <ak_GDsJS6kVoUM2f@lysander>
In-Reply-To: <ak_GDsJS6kVoUM2f@lysander>
From: Tomas Glozar <tglozar@redhat.com>
Date: Fri, 10 Jul 2026 09:05:04 +0200
X-Gm-Features: AVVi8CeKVQ0uRzsjMytyaivMBV1vQN3ibqcr-YnmwljEDV3qGuwBSJSahwRmcYU
Message-ID: <CAP4=nvQ1GNkD5h9Phr43Usm3pK9xQJT68eOPxoQ3kLMHE0v=Tw@mail.gmail.com>
Subject: Re: [RFC PATCH] sysfs: Add /sys/kernel/realtime entry
To: Clark Williams <williams@redhat.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	driver-core@lists.linux.dev, linux-rt-devel@lists.linux.dev, 
	linux-rt-users@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, Danilo Krummrich <dakr@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=C4=8Dt 9. 7. 2026 v 18:03 odes=C3=ADlatel Clark Williams <williams@redhat.=
com> napsal:
>
> > cyclictest (from rt-tests) is using this file but only while collecting
> > system information, nothing else.
> >       https://git.kernel.org/pub/scm/utils/rt-tests/rt-tests.git/tree/s=
rc/lib/rt-utils.c#n528
>
> I'll ask around, but I'm betting RTLA checks for this as well.
>

RLTA doesn't check for a realtime kernel, neither using
/sys/kernel/realtime nor PREEMPT_RT. The only mention of "non-rt" in
the code is a comment saying you will only see softirqs on non-RT.


Tomas

