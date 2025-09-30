Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43CB32C0290
	for <linux-rt-users@vger.kernel.org>; Tue, 30 Sep 2025 22:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759273061; cv=none; b=CngnnpP+9ei9SexxKBqZiu3UuDJLMNB4j7b6W7qiORZ2+7RxOn1EzL6249a7SUMg26PHUsvGcVk2A1VkzVpkGhrqXJYbWuv5gr+YW0uICXG7oHiQ7PLO2K5wF2RoK0ewIyb/ILLTn5gidvAkszfu17g2OwdLQlQrIPYQal91LUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759273061; c=relaxed/simple;
	bh=INBiH3PlynArAtSfipI54Nj5ztK3126CRykleHRsA34=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QjLqwfM5p+ovvJDLCaFAzuMWMQLFU/1ufjhOnYCncNSANQuRJHhIy5rm1wmvCumiJSLml73zsvPKMfznMyW0BTMBWUzzL+uvOZ2Fc42QxFIb+KaIF5zkYzIidIpIgRbfBiDsBi1qWxeo9q5AM9iHML03Bi6A3TbS0SNy19qXcWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ad19Glx/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ad19Glx/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759273058;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lTbLwT3UsmoKnTJdg8804mfWWPA9qqsWSxZwWwdopdQ=;
	b=Ad19Glx/GMneA8p8rj+c/czNVr2nYJMV3kO5Xx/3DVGWmJ1OIfwnSQ1bVLx7vL4xM2sYk8
	NLG1AzOrgQ0NDLOdr1akmcKHjD44DHIzd7GmWJjAG2VZ8jg/gJI9mVTnzSx8kS77HnDBmq
	PfN7rrx20w8lytIBpkAS5Th00ClS5vc=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-652-eqp8s6rbPdiTDUqPzigFYg-1; Tue, 30 Sep 2025 18:57:36 -0400
X-MC-Unique: eqp8s6rbPdiTDUqPzigFYg-1
X-Mimecast-MFC-AGG-ID: eqp8s6rbPdiTDUqPzigFYg_1759273055
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-84a63a0c496so457496385a.3
        for <linux-rt-users@vger.kernel.org>; Tue, 30 Sep 2025 15:57:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759273055; x=1759877855;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lTbLwT3UsmoKnTJdg8804mfWWPA9qqsWSxZwWwdopdQ=;
        b=tjdxFOaq8R8TRbFb23eCn1bzAA4tpM67M/7uBFTJ7EOStNlvNMzj/ZQrnWbUBT4jca
         ZMNa4/IjEcA1/Z6E7ST7PCfPD/2qJNMHHL9d9flN9oHjftOdnPhxi/MTff9HN27Xo+0x
         khIosaV6DGgGZc2iOLfdLfQqGnwMD9ZzpDfwf8DW4m2WyEXhi5JWT4RVRUu16/PmUmzz
         Pmm7mE2o76blPdi57S5VfY2qqtcwimOml3AeVP13brEOTjnNcVEwOsVpXzR+2lUdqRhR
         YSaap2ZaVa5T4FHORci+qbyOEAbV1Z0KC5/QXYwEPJ7ZYK/uhubJWyPBOhRonDIvZvqh
         u9cg==
X-Forwarded-Encrypted: i=1; AJvYcCXPzhqCbgpV+sEWTO29X/qNtESg2nlMNahcz7W37S3rlVJVKi0XCiXYF2bhMF6Kl2l4DrDx7cHD11W7OkXcew==@vger.kernel.org
X-Gm-Message-State: AOJu0YwzoVzQbQQZDLPUhzcAL12lz2rKJLZhuV2sOQo53z8E1MI0yQch
	GUvspz18VRWTkjXAj+EZvqIRF26qIYHA1YiqdjBL8+9Ceabu2fIMtPmLhWbmoPhEnGUPDgFxX2I
	pNjmhecCYYXJretxyQcqmtXhfGZni9oCHqbFsM85zYXfj/g2I1AMKaI9yWvZdK7LjFkwU
X-Gm-Gg: ASbGnctYOUadL5KXZgwv4s6+hHtuapsZCWbMxdQK2z8VzC0CIXiA3Nyk/r5BoNfAoQP
	cAOvklqLab1s/wQb6mQIufNRuQ91/qumiT8E+wbpiVEAQE8gC6eOrRKBF8UJF82TKnAKh2ruCwQ
	/WlwazjdFLn6S5Q5MRkQurWolRo50NPjnjGdvXbe6wSpmx16USeTXONFbb/vjPaZ9Az31DbD8e6
	PoeRJMbO5+Eb9Q+pWX7XzTgLwtz5OqT5XbtzXeqVuKuxlYD4woXx4w7Qa42uj/rfJFbFIl9aYxb
	6bDzScx3zM42yfMQoVqbG9cJBf6Wgk0WLaNv/gzstKOIvJdp8xv2YwXauKCDP2j4PJK5r/EcFNb
	z
X-Received: by 2002:a05:620a:2993:b0:857:4e89:87da with SMTP id af79cd13be357-873767a9229mr241363085a.65.1759273055616;
        Tue, 30 Sep 2025 15:57:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG3Ckok2mN/FWrHYQSeNRhlJa018m8CL2c5rkRROZ9qvUG4Ly5LOoKo8CEe1I8mROi6EH0dYw==
X-Received: by 2002:a05:620a:2993:b0:857:4e89:87da with SMTP id af79cd13be357-873767a9229mr241360985a.65.1759273055229;
        Tue, 30 Sep 2025 15:57:35 -0700 (PDT)
Received: from crwood-thinkpadp16vgen1.minnmso.csb ([2601:447:c680:2b50:ee6f:85c2:7e3e:ee98])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-862e20312f8sm889191285a.42.2025.09.30.15.57.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Sep 2025 15:57:34 -0700 (PDT)
Message-ID: <5a7d763f259deda4bbcfed32982aa876f379649c.camel@redhat.com>
Subject: Re: [PATCH] rteval: Introduce E2E tests with output checking
From: Crystal Wood <crwood@redhat.com>
To: Tomas Glozar <tglozar@redhat.com>
Cc: John Kacur <jkacur@redhat.com>, Clark Williams <williams@redhat.com>, 
 Linux RT Users <linux-rt-users@vger.kernel.org>
Date: Tue, 30 Sep 2025 17:57:34 -0500
In-Reply-To: <CAP4=nvRXtcYdKLbMn-U9TZ3bv+RV_bMkeVoKTMevv9q5+uK64A@mail.gmail.com>
References: <20250725090201.32656-1-tglozar@redhat.com>
	 <43c97d17c3dc4c97a4ec47968c1c52d58c57e4ea.camel@redhat.com>
	 <CAP4=nvRXtcYdKLbMn-U9TZ3bv+RV_bMkeVoKTMevv9q5+uK64A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-09-26 at 13:09 +0200, Tomas Glozar wrote:
> =C4=8Dt 18. 9. 2025 v 21:22 odes=C3=ADlatel Crystal Wood <crwood@redhat.c=
om> napsal:
> >=20
> > Can we just put all the tests in tests/ rather than making this
> > distinction?  And have the unit tests be something that can be run just
> > like any other test?
> >=20
>=20
> I agree that the organization is not the best. This patch only deals
> with end-to-end tests, though. As long as there is a top-level
> unit-tests/ directory, adding another one named tests/ would be
> confusing.

I was suggesting putting *all* tests in a single tests/ directory,
including the unit tests.  So, there wouldn't be a unit-tests/
directory.

>=20
> > > +             if [ $exitcode -eq $expected_exitcode ] && [ $grep_resu=
lt -eq 0 ]
> > > +             then
> > > +                     echo "ok $ctr - $1"
> > > +             else
> > > +                     echo "not ok $ctr - $1"
> > > +                     # Add rtla output and exit code as comments in =
case of failure
> > > +                     echo "$result" | col -b | while read line; do e=
cho "# $line"; done
> > > +                     printf "#\n# exit code %s\n" $exitcode
> > > +                     [ -n "$expected_output" ] && [ $grep_result -ne=
 0 ] && \
> > > +                             printf "# Output match failed: \"%s\"\n=
" "$expected_output"
> > > +             fi
> >=20
> > Any reason to not take the updated version of the engine from the rtla
> > consolidation patchset?
> >=20
>=20
> This patch was sent quite some time ago, I think it was before the
> updated version of the engine.

Ah, I thought it was a new patch, not a reply to an older patch.


-Crystal

