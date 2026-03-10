Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57A4618A93F
	for <linux-rt-users@vger.kernel.org>; Tue, 10 Mar 2026 16:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773161865; cv=none; b=AYhLISsf1Xu6PUptMUUr3zZ7N8l0M6OnlgVBbITAWvUunQaGdxwL8zEqThr/gi44uJgw0ulzTUNF1F5VV6AA2EyCGfxXgu6JPmY4U+bQeQ4E1jAheKfmMV4dR2MU8+3411gOrtAlMzluL9BHAq3uEAv2HQkyikD6u+hjvQqtzt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773161865; c=relaxed/simple;
	bh=6bW+zlJohjzI6JieCloSFblD9B1l6OYBq8RhBs/seG0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=npzkSy5Zg5aitE4KqX5ro8YXL7AqK01OrpLYMeiAIsYYKgmwjZyUYn0CbLUVZvzHDSsioOfxp1wpAftNbUvFoxTsqqJJm1nB1HeRBCr93P8DPrX6N+QRsx8MmVKldZcfZhE7aewz1PvsUjY31UNt6q2ks46pQ5ByDs33Y+WcBg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LwyrAhpq; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=kKrjgCpU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LwyrAhpq";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="kKrjgCpU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773161863;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aPogHKXLjsjLyAGQpNgDmfxBJLUNZyY2pNuS6tSOOH8=;
	b=LwyrAhpqKk8aI0U1uf9SXowVZlJgElvAeDHPZJnbhjKoFlyvF40QcRaOoIuzkCwKkNHkCu
	LFv/OlCu3lgbpyBYu3ujTepeAPLafM8ovY7oGaU+6405ZeGOqJ/EZqDNe/6whc5zbKl5cu
	tfOp+9ER+DZVf8iYcDuk2R/YtwSIsvQ=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-488-APvY816ROv6lte-JrUkDxA-1; Tue, 10 Mar 2026 12:57:42 -0400
X-MC-Unique: APvY816ROv6lte-JrUkDxA-1
X-Mimecast-MFC-AGG-ID: APvY816ROv6lte-JrUkDxA_1773161862
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8cd900cd3a7so939530185a.0
        for <linux-rt-users@vger.kernel.org>; Tue, 10 Mar 2026 09:57:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1773161861; x=1773766661; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=aPogHKXLjsjLyAGQpNgDmfxBJLUNZyY2pNuS6tSOOH8=;
        b=kKrjgCpUxjc2fMW9fPXGTd+ydZlDl44Bu/+JExXVnGWWFGPLm2E6xbHEQZxCtkH1Gz
         9s/pwl+wrHkQ3Zl5L5QwuvCmZ0tXha0LSinL29/0IU0p0MfwJ9++IdnXyFzkrLJ04NFO
         JsEd2uQmd5ZuhvTBQDN2Lj5/sipI7P4bxjQycnlCB5jf/E7WKrPWfTA5aivLs2xQhcd7
         eqZ9728MQbT1G6n9SfTSTT4epSA310si1SNQ8CJxURfn2KrIySfvNfPM9ZESM60xav+A
         pm+5oiHZrZLUqBynBIScjENUxSZuBZeViy0L6Qb0vGGmqhmhZBnln0c/4tOo8AO07qGl
         txyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773161861; x=1773766661;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aPogHKXLjsjLyAGQpNgDmfxBJLUNZyY2pNuS6tSOOH8=;
        b=EZKwvF2oq3EmQ6RYAP7kVmaLB00IIgHKdriRbdGWbadi4VFnpnXkK2NLwAk5ZvM6zc
         RtDNOUA0BorMXM9N2L6QBcJJNLTCV9V1kAN5HaH5jzYAYsbb7/9w0z5Sr08CmQgZY6X3
         8RW1efBEA8lNuz4hxN/639udI6AgceNFNyychafmkcPn9ux/VA+zvACM9GyuzRdxjPzg
         /lrrzpQrYTBqEQnTgpniR21xBbh/OT3NZyuU8UE6L5lzRZWc74AtliPdUj1pjbPtgMoy
         HTZLLJLYCxzLfesl3qBfG/kNL9HNozxLPiV6zv0hRDho4b7ThDruN2Mxe7jnSHAeJzUF
         +mBg==
X-Forwarded-Encrypted: i=1; AJvYcCVx5hU6ZLEfrNgukDGXqP1RUsRZB7tRV+FaTCI+Cqbicq5Q4AUuv5y10qwY1mi73h+9r3S0X3E5XB4qMPUk2Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YzDBO/H26WMVauz16bd9d4s/HzwXhcuJ/ZnI2nl8i2y7gRLJY1O
	bV4De0EOuQC7EFqh7PdqLBZ6M4nAl4o6545cLaWs7adBdh/rxUeTHIdOeIVk6eI97qB4tU4NDIv
	e82QPJjtEM0GI9XEZ1FIO9YGG9BwsqF4N+yeRopZWS5l+pgSYS/v0NDDczKCgnL0ypT1s
X-Gm-Gg: ATEYQzw0NYDQ8kro/pHbgmAtJkq/xOa5cDJ3vcrSA2hVKnNEjDROHeefwtzSI0Zzw6s
	28VWjGcmZs6otp35fcH9wxjviyeplEmwywRjeWhTJxNEnzwlcDSyjlTesowRmnWegNX5XUHTNFb
	gy47uSeIsmQV1epDz4DavL7Ik03K4h4SRIyyu27jtlUgPCFr5s82bwJJBInw6qB4yHTzAJIbX30
	4gUK8llkH+gTz8yFfvZ2RsimSvv2lI3XJOK0FVVcXON1gqOdPq+ZsDbiVaJQ40Zw+r3kNMhLfLB
	vGxvNEQFcigOSoafOhpF7PunjhnFbjjGz3dLfcgeZKhKannzd35hh6VKZHRFVuOKSpPIinWWVj2
	9/lxvcUYZ3DIQtSURPJ6B9AHmgjq44R59WfQHJHt1CzHkE1HEGdFRvg==
X-Received: by 2002:a05:620a:254d:b0:8cb:5233:8f8a with SMTP id af79cd13be357-8cd6d3403f4mr1960704585a.11.1773161861677;
        Tue, 10 Mar 2026 09:57:41 -0700 (PDT)
X-Received: by 2002:a05:620a:254d:b0:8cb:5233:8f8a with SMTP id af79cd13be357-8cd6d3403f4mr1960702485a.11.1773161861284;
        Tue, 10 Mar 2026 09:57:41 -0700 (PDT)
Received: from crwood-thinkpadp16vgen1.minnmso.csb ([2601:447:cc81:56d0:ab94:b2cb:29a6:7ac0])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cd6f56da77sm974761085a.44.2026.03.10.09.57.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 09:57:40 -0700 (PDT)
Message-ID: <c60136fdf3afa53f6dbf3dee78e57d3d2952ea9d.camel@redhat.com>
Subject: Re: [PATCH 2/2] cyclictest: simplify rstat_setup
From: Crystal Wood <crwood@redhat.com>
To: John Kacur <jkacur@gmail.com>
Cc: Lukas Beckmann <lbckmnn@mailbox.org>, John Kacur <jkacur@redhat.com>, 
 rt-users <linux-rt-users@vger.kernel.org>
Date: Tue, 10 Mar 2026 11:57:39 -0500
In-Reply-To: <85147e31-053f-1b0f-e200-5d49c1b8b123@gmail.com>
References: <20260301212407.3146506-1-lbckmnn@mailbox.org>
	 <20260301212407.3146506-3-lbckmnn@mailbox.org>
	 <f504e9c5-95c9-79e4-0274-f639a4829af9@gmail.com>
	 <9ff2d632fbbc58fda5509a26f0dee26d6c3aefcd.camel@redhat.com>
	 <85147e31-053f-1b0f-e200-5d49c1b8b123@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2026-03-10 at 12:18 -0400, John Kacur wrote:
>=20
> On Tue, 10 Mar 2026, Crystal Wood wrote:
>=20
> > On Mon, 2026-03-09 at 18:55 -0400, John Kacur wrote:
> > >=20
> > > On Sun, 1 Mar 2026, Lukas Beckmann wrote:
> > > > +static void rstat_setup(void)
> > > > +{
> > > > +	int fd;
> > > > +	pid_t pid;
> > > > =20
> > > > -	if (mptr =3D=3D (void*)-1)
> > > > -		fprintf(stderr, "ERROR: mmap, %s\n", strerror(errno));
> > > > +	pid =3D getpid();
> > > > =20
> > > > -	return mptr;
> > > > -}
> > > > +	snprintf(shm_name, SHM_BUF_SIZE, "%s%d", "/cyclictest", pid);
> > > > =20
> > > > -static int rstat_mlock(void *mptr)
> > > > -{
> > > > -	int err;
> > >=20
> > > errno =3D 0 before the call to shm_unlink for good defensive programm=
ing
> > > other than that the patch looks good, I will do a little more testing
> >=20
> > Defensive against the library returning -1 without setting errno?  Seem=
s
> > a bit paranoid and cluttery... all for the payoff of an "ERROR:
> > shm_unlink Success" message if it ever does happen *and* the old errno
> > happened to be ENOENT.
> >=20
> > And the current code uses it even in places that print the message
> > regardless.
> >=20
> > -Crystal
> >=20
> >=20
>=20
> Isn't that what defensive programming is? Guarding against something that=
=20
> is unlikely? It's one line of code that I requested in a patch that gets=
=20
> rid of many lines of code, is that really worth arguing over?

Eh, it wasn't so much an argument over this patch, as a "we're supposed
to do *what* before each library call?" reflex.

-Crystal

