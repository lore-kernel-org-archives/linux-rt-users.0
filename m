Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 471ED210F6D
	for <linux-rt-users@vger.kernel.org>; Fri, 10 Jan 2025 16:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736527567; cv=none; b=HxGW9klsN0JaeBDPQ1XNWIKv8Bi4IxUQsTsOlhkJUr20XQ2YseQVIiXh1O5p0cMxKBnTXfE8TzrE0qfGScc4buHxSgmr4IJVKAK5fo58X+TQWPGCbd5/g3hzbEcSc5q14Ai06+H7KUKLyBA2AIDVGRB5/rhTXRR87OkZCt+wyCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736527567; c=relaxed/simple;
	bh=XYWi4/KOeLLAt3k2AkXmESuRavr0frkiVK4RuSiVju0=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=NXNw22jnTlstyP0fUGfBDfupKUa4AzBaTNtJrhxESKrJ+2LKqFI3SomNWt3oTAirkjRnTPovecDdR1p88LgCVKYzd0oJqyNEHdP0r/8qSjT8P2eO5exsnw8FiGx6zOu27wQH7ZjWh9+MJLMhIXq+0hyBX5wtJWU8H8YIbinkvIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=F825qpBR; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F825qpBR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736527565;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xGlmlZg9SusYOXbt9SUoXHjBkSyk1lJgFaY+nFobG1E=;
	b=F825qpBR22oH7iqmGAITSLRMsLJuAAK/tO8iNI+RYZcADKaqA9Ji/MS4x0GlhjX0XcCawY
	qoYHWspjpvWslCHaTXPhNQyLfKEoCImjJ9uU3/L/pWTDUdNzzIpCieTzrF/jgmlrtdRoaK
	Mr1d/S0rRWcOq9G8NrLX5icHkNXfsD8=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-591-hyVYOqK6Mm2zjeuCm09_6A-1; Fri, 10 Jan 2025 11:46:04 -0500
X-MC-Unique: hyVYOqK6Mm2zjeuCm09_6A-1
X-Mimecast-MFC-AGG-ID: hyVYOqK6Mm2zjeuCm09_6A
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-467ae19e34bso62120791cf.2
        for <linux-rt-users@vger.kernel.org>; Fri, 10 Jan 2025 08:46:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736527563; x=1737132363;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xGlmlZg9SusYOXbt9SUoXHjBkSyk1lJgFaY+nFobG1E=;
        b=v9MbvenHQbsRTk799C7yklTGm181+YPpWUGT1EG10aY/5IKa+MElJhFNL05LCOEGtG
         JPe0dRC24F+1QCrtS5tCNGsHNWyPFag7UAGvj+Qzm6OMSk8KXD2pl5Wroqdab5WU0SyD
         PApmBwqhiJAgZ69IHTQEgMsiz9f0txftsYZuSIb+j4HY1b3C/2lS24G7a1Ds3dtEf86L
         k/vL+SKHu5cWkHUXuaiuVyWTNhSbAEkac/2s4Z2Uk22BNBTBq23JQWM8TRhZDDsHsSyu
         WAwt94Xdo2RjqbfbzwWIhePSfnqK0XykLNZME8KvdfmQSuyRNCwU+Q5cgJPxFd25hMNs
         a6yA==
X-Forwarded-Encrypted: i=1; AJvYcCXNN+ILnwlimbwgMVcSY5e7ATljioxUoc2cnmjwWnVepyoyaixWK/ejGkZ5g1EcqEAZnltUqMbeJMGYe7uHDg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzdzi+TUS6nSCBJs5cKwNQS+2hzDesOBpoxfDBNNzM86P3M30wm
	cATBz2fcZW/rZNqeLcVHtFE3wNRGwgXIlnI1Aivv0BTDP1nt/N9PXs5XwyQjdcyZqcR5rYNpjMu
	3m67KC/unsnOg/pBKETjwe5KsMMo5NxdEdu9MafJh42oAD5vPZ38DmzoipwteuCF0UuV6sgj8
X-Gm-Gg: ASbGnctU9rn5f/QZac9EIuCZeP3TS9Q6Y8ZNybXSt52mBYgoLEWH67e1ASN57HQCQ5Y
	9C2A/QB7tX5SUlOBSh5SIqiuUSdiB5nl1MXMBu4YWdd9WtOqtrQs3u1x5kr2vGHVfA4UNhMklqP
	AMn/mVRnKI+DtrB4IAiJExFYnllYjq4eecbNUTclyjFEW1mZObltG9/W13PI+rf4v2/T50VlNnz
	Ih68Aq1Hpym/HUrO6sjamxUnwM11Si5I3L1+P9B1BTGSPk=
X-Received: by 2002:a05:622a:450:b0:464:af64:a90a with SMTP id d75a77b69052e-46c7102c391mr193518891cf.23.1736527563601;
        Fri, 10 Jan 2025 08:46:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHl/SwCyc2pFAQC9s29fcVNamZ2osklDmzgeFkhcs6RbUn68ww/NvosCIyjdBzF1dNy92YdMQ==
X-Received: by 2002:a05:622a:450:b0:464:af64:a90a with SMTP id d75a77b69052e-46c7102c391mr193518711cf.23.1736527563341;
        Fri, 10 Jan 2025 08:46:03 -0800 (PST)
Received: from fionn ([142.189.102.234])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-46c87321555sm10915351cf.8.2025.01.10.08.46.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2025 08:46:02 -0800 (PST)
Date: Fri, 10 Jan 2025 11:46:01 -0500 (EST)
From: John Kacur <jkacur@redhat.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
cc: Kurt Kanzenbach <kurt@linutronix.de>, Clark Williams <williams@redhat.com>, 
    Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
    linux-rt-users <linux-rt-users@vger.kernel.org>
Subject: Re: rt-tests release tarball location
In-Reply-To: <20250109080555.WpQmRgu0@linutronix.de>
Message-ID: <bb91bdda-8a07-1c99-5448-706460fdf1ce@redhat.com>
References: <20241228114346.6020d6b0@windsurf> <87h66b2c6m.fsf@kurt.kurt.home> <20250107141424.EoC5uS6y@linutronix.de> <f87b2d77-7925-8678-d0fe-9a0d471a38f1@redhat.com> <20250109080555.WpQmRgu0@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII



On Thu, 9 Jan 2025, Sebastian Andrzej Siewior wrote:

> On 2025-01-08 13:21:19 [-0500], John Kacur wrote:
> > We've been doing this for 15+ years. Normally I would expect the package 
> > creators to come-up with a work around and not expect the people offering 
> > the packages to accomdate your packaging software.
> 
> This does not mean it does not deserve to be fixed once people complain.
> Debian and Fedora download the source package and host it themself so
> they don't rely on upstream's copy of it. Other, such as buildroot or
> Gentoo or even yocto download it on every request.
> 
> > How many kernels back to you need to keep? Could we come up with a 
> > compromise where we keep the newest kernel, plus say the last 3 in the 
> > rt-tests directory before they get moved to the older directory?
> 
> What I am asking is to either please keep all rt-tests releases in
> 	https://www.kernel.org/pub/linux/utils/rt-tests/
> 
> but this would also mean that the older folder becomes removed and this
> might upset more people.
> Then there is the alternative especially if you prefer to have only the
> latest release on top to please keep all releases in
> 	https://www.kernel.org/pub/linux/utils/rt-tests/older/
> 
> even the current one.  This does not sound annoying, does it? The latter
> is what I do with RT patches while I release them after people

This option seems the least disruptive from my point of view.
I am now keeping all versions including the current version in
/pub/linux/utils/rt-tests/older

Thanks

John

> complained so I have the latest release in
> 	https://www.kernel.org/pub/linux/kernel/projects/rt/$version/
> and
> 	https://www.kernel.org/pub/linux/kernel/projects/rt/$version/older/
> 
> > John
> 
> Sebastian
> 
> 

