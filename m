Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52F8C2BEFFD
	for <linux-rt-users@vger.kernel.org>; Tue, 10 Mar 2026 13:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773149423; cv=none; b=mffmc5PIatx8cUD3cQfzu9iNmD4LyGohi/B5rcxbUoECwXHT7sNKW3nF8tpWEYt0MCyq2AQP/9404/LGqIk8rXwmEN5tshER/mp2YuuB1Mx4YnQl7HerUvRsrrgGYkHjoAVevhTLNXYX6+OB/u++jvDlhW7MOykmdvxkOZeQLXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773149423; c=relaxed/simple;
	bh=/400aC9AYaJe8U0wTfuFX+99IIOqBzBaxeX5aqVH+d4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZyMjXrgkn7/sc3A729jpO4opmibx3HD+1k3POzhN+2RGSX2EUFavNNr/8so5rIiYTEsgNJu0JgAJ7y+tCmkomMVd4/gwTedlcDo0lwJejP9TcVHhInuc6DldMlYf90oYzeJtf/4g+C00eVMXrGfYsl2xr1kn4SdWhcPihYTzLiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PpitHF6d; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=b6BByPQj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PpitHF6d";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="b6BByPQj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773149421;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zyk5m5xZkIfTRpmDErRz3Ggw+VyFgkXbHoqIgguedNc=;
	b=PpitHF6dZp6yY2CdTpa0iQh5R7CZLYZvDkg1qpijTbhWAtXoVH0heLcry/TUZRKRtB1CuA
	BEciGhTQaRBU1huQJk2ay13ffPG/FJKtG/NJE6h/OMtu+a18kL7CmuFK8jriE/3NmvKcMq
	I/uzDYVgazxbTNnSOF4v3imaaT8Kqpk=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-581-FLgepBFtPeGREfRLILTHdA-1; Tue, 10 Mar 2026 09:30:19 -0400
X-MC-Unique: FLgepBFtPeGREfRLILTHdA-1
X-Mimecast-MFC-AGG-ID: FLgepBFtPeGREfRLILTHdA_1773149419
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8cd7a25c5a9so1512512985a.2
        for <linux-rt-users@vger.kernel.org>; Tue, 10 Mar 2026 06:30:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1773149419; x=1773754219; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zyk5m5xZkIfTRpmDErRz3Ggw+VyFgkXbHoqIgguedNc=;
        b=b6BByPQjJ5Kz5jQ3UybktZT5BOafG1gx4mvpgITcmJbT/XSThNenwfPi1rI7sJ/QcV
         ViJY/lnbjpblnwdwEmkxoBVUernEayfKxm7J6VKDlAN/qLpr4m/mPDVvr0pEO729SV0O
         bX98zogQPBk+iRnpG3jmaaXc62tvCpF2K4DVnubbg3mn1Op9Cvbw/Drq2SYWqBqOwbVi
         FUruyTmmorBw8UKbQZEWS8xe+DqFjOGRzaWlVdZhudL/5RQEjlRsMTrW/R/u9UiCV6HA
         fCfu7GyZ6rN8eX4US0zD4LepltkIpf2OJRaXppIZoaft77IQGNXrqNrEFXv/PQeeUzX7
         pKaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773149419; x=1773754219;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zyk5m5xZkIfTRpmDErRz3Ggw+VyFgkXbHoqIgguedNc=;
        b=cPrWPOYPgBseyf3HbXDhjeHQHknPCWf0VzT0wi1jT6luzS5fjV82o+kouHAvCI6bu8
         jf6bkySZ1RBQ4TiHb6PC56O5a3xJdpzQ3F4GMGqDvn6E8UmLxxaAKXuFWHdHRDpmZXUA
         pe/7XPBSaTlUDvdfYspNYI31xrmGnvfRzv5Q0rddxsHVGQAOu3iUV77IEDaxmOGIqMQ2
         GxowRwXMT0EO1kQ29TFeKiYy4Lu80bEwaYpmvOV7DWDERubkWJmhytfXyOQEvDXC4F1Y
         kv0kV5k/TlFKkgIu68Ip3AoBY7Iz/wfYBNOuzvEZSjSL441Ltv3qzcHDqmv5td0p7NFr
         IUfA==
X-Forwarded-Encrypted: i=1; AJvYcCX3ysws+m81pQJSmtSAoKRFlROhuLha1a5fOGFeKMD3ihZvyc4TwHQLDZVYFm67Cb/y18BvCpM/RCGc8aQhiQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzV0AL3bZ0Zc6cdGTh61d2nX5Qpw+DJBsH9GDjqXWSRNWEY+sx7
	6EF6nnoGWgovNUMqghc4xZ/18Myd6Eai89qY6mbfIsk1WE2Q21VR9It2hAp4TRORcq2zAsgTcjF
	wHl/TVbGqV8yv58p6Oo5qnhtC/uY4L0xdXGp7UPDpvzyTcJDXYjPXG7CZxOAc+TFFS14GifYIte
	7s
X-Gm-Gg: ATEYQzw8j6CO5uU6va7Q++Dat7/ZKPJXYaSuZpeASlbhF8ViKEJq9TS/re14FWvrmOH
	+ZDvZ9IHc5Na4cTbg7miV5LTQz5KMT4K9loOGsLJO/L8SiIrX0Irvvrlwgjj+RDOGpSgiO15VcA
	yPT597uo2Sl//3FZ2lYTqIDPBhB2P10Fvzvv6YRIF0W3BMg1w43Xg9t0dw70tRrIh6X3R6CmxlT
	ibz9HqxWgma+ylbbK8vRmfRe90ni4N4x9tCqeBK/Elj2lY5FSXqSdRBB7dvm5uWweeMuDYVW3ul
	tRVDt1bMsOoIC1tv7Mfu0wztXQGZeeS2XXatkFrnkei7tWZkNShRfTvS5DGkW20EZMKLnMVWwMm
	HYDjns+FdT14pJuqR3lZhJJdBcGCzobgJacR2HJG29dbyzJ1jZPh6qg==
X-Received: by 2002:a05:620a:31aa:b0:8cd:8f04:50f5 with SMTP id af79cd13be357-8cd8f045625mr598694585a.77.1773149418889;
        Tue, 10 Mar 2026 06:30:18 -0700 (PDT)
X-Received: by 2002:a05:620a:31aa:b0:8cd:8f04:50f5 with SMTP id af79cd13be357-8cd8f045625mr598685585a.77.1773149418266;
        Tue, 10 Mar 2026 06:30:18 -0700 (PDT)
Received: from crwood-thinkpadp16vgen1.minnmso.csb ([2601:447:cc81:56d0:ab94:b2cb:29a6:7ac0])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cd7c18915fsm600602285a.0.2026.03.10.06.30.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 06:30:17 -0700 (PDT)
Message-ID: <9ff2d632fbbc58fda5509a26f0dee26d6c3aefcd.camel@redhat.com>
Subject: Re: [PATCH 2/2] cyclictest: simplify rstat_setup
From: Crystal Wood <crwood@redhat.com>
To: John Kacur <jkacur@gmail.com>, Lukas Beckmann <lbckmnn@mailbox.org>
Cc: John Kacur <jkacur@redhat.com>, rt-users <linux-rt-users@vger.kernel.org>
Date: Tue, 10 Mar 2026 08:30:16 -0500
In-Reply-To: <f504e9c5-95c9-79e4-0274-f639a4829af9@gmail.com>
References: <20260301212407.3146506-1-lbckmnn@mailbox.org>
	 <20260301212407.3146506-3-lbckmnn@mailbox.org>
	 <f504e9c5-95c9-79e4-0274-f639a4829af9@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2026-03-09 at 18:55 -0400, John Kacur wrote:
>=20
> On Sun, 1 Mar 2026, Lukas Beckmann wrote:
> > +static void rstat_setup(void)
> > +{
> > +	int fd;
> > +	pid_t pid;
> > =20
> > -	if (mptr =3D=3D (void*)-1)
> > -		fprintf(stderr, "ERROR: mmap, %s\n", strerror(errno));
> > +	pid =3D getpid();
> > =20
> > -	return mptr;
> > -}
> > +	snprintf(shm_name, SHM_BUF_SIZE, "%s%d", "/cyclictest", pid);
> > =20
> > -static int rstat_mlock(void *mptr)
> > -{
> > -	int err;
>=20
> errno =3D 0 before the call to shm_unlink for good defensive programming
> other than that the patch looks good, I will do a little more testing

Defensive against the library returning -1 without setting errno?  Seems
a bit paranoid and cluttery... all for the payoff of an "ERROR:
shm_unlink Success" message if it ever does happen *and* the old errno
happened to be ENOENT.

And the current code uses it even in places that print the message
regardless.

-Crystal

