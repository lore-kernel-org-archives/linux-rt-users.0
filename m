Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 842613191AF
	for <linux-rt-users@vger.kernel.org>; Wed, 12 Nov 2025 12:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762949549; cv=none; b=ZfX2C97+i8nPu9QtJMMk2KgGXKiknTxqe67hXoCOKouGO98i9lwS1Pt1fQ04atgjbK7Wz7fGPO52E61LJutgJNxn7fIM8fOpmg0VZILnF3KdPqUkOC4PiGn3vQEZluZveFaXid6zWOJg79gKkPVwbXiFsAP1J6zzZw4Kzk6hjNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762949549; c=relaxed/simple;
	bh=u27z0hM0e2Om6U+oENuQdF1t2VL2iQ5tTcQnuYnoZ78=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eeC9FEMRZhvRCBNFu2fcIIecheMv0enRfxRQXtPvd7gDdyu4zH5M2Y80MARuc9nnSluD6d9bL2t26ah0waawm1nImB1lQoiM/BbDXcoyMa4p/UgNdjDC/UWf/NcTE7rauCa6XLumE3floPuyxheOVjEcJwUfaMd3U7us8zowyNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=T8GeTD+I; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T8GeTD+I"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762949546;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u27z0hM0e2Om6U+oENuQdF1t2VL2iQ5tTcQnuYnoZ78=;
	b=T8GeTD+I6k1ZOqWDuMWkGVG3OJuoPQ+55xWPq5cxpQjJ1JrOkIU2yxBx4aN8KH7Qqhz2wA
	8xAP9SiwoP+kZWJizzgJw3v/0wgNVOkf10HbNuPDFBuR5tSaRSihQXndsTQMs0A0n3cTp5
	gKoWh4bITsHX5+u45K/2aFRfEXBwC3I=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-441-3r6yEePSNCO-X6wGcKUFow-1; Wed, 12 Nov 2025 07:12:25 -0500
X-MC-Unique: 3r6yEePSNCO-X6wGcKUFow-1
X-Mimecast-MFC-AGG-ID: 3r6yEePSNCO-X6wGcKUFow_1762949543
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-594259bf71aso485880e87.3
        for <linux-rt-users@vger.kernel.org>; Wed, 12 Nov 2025 04:12:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762949543; x=1763554343;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=u27z0hM0e2Om6U+oENuQdF1t2VL2iQ5tTcQnuYnoZ78=;
        b=KfFShjsPK8lezC8sI2Q6k1aH0bLjOR5NjQN98Q34PvKuSs/ZJGozVTCpuCAhI4cxNM
         ZoAj5QeQd23vV0bvfAy9VsS/se+BkhDpc1VdCPHChRZeaxBuCbMv4c53/C0AhTnlboh8
         VGfdG63johFJT4demeUW4vsW3mb2mODNjBSdZEslKuvEcYepgTGVNPwUoOYKHMF9sRJS
         E1b+gR4QEOE7IMkKRzLUt2J3sLBwpf5smyx43DhhmS21GPBlTlSt1FR8599VTw+5Xohc
         gmNWAvLWn7fFgHKSB8suHuq2e60UzIc0B9nVEvn2Z59KRlhqlJE0skja5y9EY8ZYPXxh
         3tzw==
X-Forwarded-Encrypted: i=1; AJvYcCUi4sklIGEQ9d48gq5+bx9a0X0t5UDPpVtbqRcOD2hNwHl+EKXd6GOexo5MCm3pcj8swU/Xs2r5O0NEpaybFA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxCrm8xAd3aYMKVE/JVej1b0w+n5lW3Tk3ndrMGx65awZL4RSfP
	++4U4NzD1qoF5pgxnN2KOa3qs4szVEKnduYjqSxmkduYJAoDKW1EqbqgfyaOp6MWT4TU51JpyM+
	o4L+LfS7d+BrpPIqfGy5xfni8frOmCkmNMetcvrso+9wDNu/W6InMYb/JXu/Gl9YV2W8/LKC38D
	F5HKHm0Aj1T/jfZSBgNvDUmGEuGsenyRG7jWabJDDylMc=
X-Gm-Gg: ASbGnctGfC1UCWuof//4kwS29NG1B4u1EIZh1XcI0hJYapKyPx2Sd+RlLG1QtMNX8pX
	vHVqX7ofaXeAxkgmLkdZYXLjoaDVtjfs6I3I2NwDVfPlGTq6X4Ec/3RJ3tzZA9d3MuJ6U3TT/cK
	1KNtk/5R94EpWllLdOU7L999WqBTNN4S94fbHrdfTec3jZvlVMNKuKE/nq/dVZTnbCGzCoehXZ+
	6ZPZuraDeNTQxZa
X-Received: by 2002:a05:6512:2312:b0:594:2cdf:1940 with SMTP id 2adb3069b0e04-59576dfb21emr923178e87.17.1762949543422;
        Wed, 12 Nov 2025 04:12:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGmmKk3ptPB7WK/SXagcJG7uB0SLEMrAZOzEBYSalvAlkl3CAd4Ecc8QruoirVO+ptbYQ1846Iij3HJJwRkBw8=
X-Received: by 2002:a05:6512:2312:b0:594:2cdf:1940 with SMTP id
 2adb3069b0e04-59576dfb21emr923169e87.17.1762949542999; Wed, 12 Nov 2025
 04:12:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251107161729.320087-1-wander@redhat.com> <20251111145020.C7DI111V@linutronix.de>
 <dgm5dmxmq56rtcorzcapb6ibzlch73xwqfavwtbzrbpi6ukfgv@h32wjmfahkfm>
 <20251111155032.r8XNNyFU@linutronix.de> <lufi4xb6bbpllszjdfsasor3ehkn3lyynpnmtogegm2l65eop2@4j64xkvwlw4g>
In-Reply-To: <lufi4xb6bbpllszjdfsasor3ehkn3lyynpnmtogegm2l65eop2@4j64xkvwlw4g>
From: Wander Lairson Costa <wander@redhat.com>
Date: Wed, 12 Nov 2025 09:12:11 -0300
X-Gm-Features: AWmQ_blJV1ZAvBVLqP2Q6ixKmLhLJoMzKZju4QYzkQeeFPBhhYYNnVf3xWMlXBg
Message-ID: <CAAq0SU=EhpdM1fAWBvJGPWZzcDsH8St2ni++-oL7sMvivAD1TA@mail.gmail.com>
Subject: Re: [PATCH 0/3] Improve Makefile robustness and explicitness
To: debarbos@redhat.com
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, williams@redhat.com, 
	linux-rt-users@vger.kernel.org, crwood@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 11, 2025 at 1:29=E2=80=AFPM Derek Barbosa <debarbos@redhat.com>=
 wrote:
>
> On Tue, Nov 11, 2025 at 04:50:32PM +0100, Sebastian Andrzej Siewior wrote=
:
> > If the package maintainer decides to add a certain flag, such as
> > -fcf-protection, despite not working on all architectures then he can
> > keep the pieces.
>
> Tagging Crystal as she has weighed in on this topic in previous threads.
>
> > In my opinion the package should not fiddle with what the upper layer
> > (build system) specified/ requested. It may have a default set of flags
> > (such as -O2 -g) which will be overwritten once the user supplied
> > something.
>
> Agreed. We've already stripped out a lot of the RHEL-styled options of th=
e
> makefile with this logic.
>
> Wander & Clark, any thoughts?
>

Some time ago I spoke with Clark about how we are setting the CFLAGS
and not allowing the builder to create additional flags.
Furthermore, I found all those architectural dependent ifs strange.
More recently, we've talked about adding a more robust build
system to stalld, to avoid the hacks, we are adding to the Makefile as
well as complying with standard Linux packages.

> > The default set should not be something that is not required
> > and is not always provided by the compiler specified as minimum.
>
> With this tidbit in mind, what else do you propose we strip out and leave=
 to the
> packagers? Is it worth retaining some of the debug & hardening flags, and
> leaving the rest to them?
>
> Cheers,
>
> >
> > Sebastian
> >
>
> --
> Derek <debarbos@redhat.com>
>

