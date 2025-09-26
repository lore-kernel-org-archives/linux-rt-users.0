Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2415261B6E
	for <linux-rt-users@vger.kernel.org>; Fri, 26 Sep 2025 11:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758885139; cv=none; b=OjQzBDde1sBk7c95TsgRPGnvYE7iTlL8WZoIfL80lFiSwBvSXef7apXwL7nyfZg4q00yUA/C6clDqTLF0gmZ39Ghf3S6nJ4vu+j37Cw1mfiqDct33vgPhr5UyhkhAoaV2qw4F3Paygxenz9wfVmngiccVYL1J0TTd/i1bg47tlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758885139; c=relaxed/simple;
	bh=HsnoSGuGmC0v6XR11mmIrTof7Hp/S5baiA3U3JQifTs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dYrVl7yJfqiU5PIKOKWLgWnx7uPHDFP11HYq5c8YqL+2Dd7zVV8wBcc7eqC+B7kDnzrFkT6qLS840GNk+ojU1x31H71DFWHe+FK++WPXmN5NmW3f5zIlvIdnazYiDHVR5ixOtxYzqWxo8x8YgJVWCPnZmQ2UxHMnW8ufqaW217I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gok43qYR; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gok43qYR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758885135;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yRRLn7yAZESwvoO3zbtU1eFVV3lM3zZ5dXMuYRW/IfA=;
	b=gok43qYRLpmDbVr3juC7MQuisPUs/1Hn3BVKMSAnsWnkVCjjun6BQkkat5CkgrMwiZ0oR4
	TNmHSsZfX6Mh5nF1h7YeECmDslLw80P0U2gW66aBOve5z0fE0t6q2zmtLVV2bw2/mXt8He
	5efy4zxExjeLNCZA8keNufdKCbn7w8M=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-539-6xfCnO35OKCGqbdFyB2EIg-1; Fri, 26 Sep 2025 07:12:14 -0400
X-MC-Unique: 6xfCnO35OKCGqbdFyB2EIg-1
X-Mimecast-MFC-AGG-ID: 6xfCnO35OKCGqbdFyB2EIg_1758885133
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-b335ec149a8so163085266b.1
        for <linux-rt-users@vger.kernel.org>; Fri, 26 Sep 2025 04:12:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758885133; x=1759489933;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yRRLn7yAZESwvoO3zbtU1eFVV3lM3zZ5dXMuYRW/IfA=;
        b=Tg5Yet76ledgv9op4rrNvFY50dSmwecWNe/6+HCcvgm2eAKsKzknkD0JUDkau5UHX/
         JsJJNa0DvN/kSEOPsHdx00hSmGp1SOYOfoyIYfhymBX5j5pqGYfGEitRmfiLZoygvCCp
         FFInyAd7WKSsITKPSj7nB65/rLMZA7oUSWLi5lJFzPJHL77yWSl9eTcfn2inzalsxXMz
         9gvQCk6+uS/Q8eyXpnHcLSwHXuwTD2er12Exgs2dUI3/1UhaByi8OB3etnChQ2ks/cU8
         HOWPsbpuyAX/+bTU6VX3Bs3mPAM8vF+q/qi/6IevymZA6vJBkUg09zcWlm5+IDOpLBg9
         myjQ==
X-Forwarded-Encrypted: i=1; AJvYcCW1iguKzvndiepUdWMt6UkZvCgU2pc+tA2W8MAk5g8iZNNjCUTlLHtBW9ERq6NUgy++N4MNEvy15w6F5gWEtQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzFYbU1tQ6ZW3zRI9L+B+2O6Scwm8t7t5zsHt2wZLqcE3VhXixY
	LcfMx3Sa+lFUMX2ecM3yKyQT+VTKpOelZEMnQ2nSc69MZerX/VSWzgFJX+zjz6fFarJ1n2jCBa2
	TKXhduIucBDj95a0sOnAfBRNn/t4D1N7P4Uw3eOq5FLjTyUbN47M5P5Yo4/24RWDxuw733puROz
	MxHq1NRPiDFrVe0n7/6XTyQJ+VX1BUql/NTR46aUrTN18=
X-Gm-Gg: ASbGncs3PffL2dK8MRUFzb0oxrTG5jhB7CwnWGxhKaKKLofAhOjCh9wlSOgGPicVhRv
	Vgz1fn2eAovNmSw3VVJnGUGCK6EefTe6tqEe6kA7aBebvwBkoakAaZ6Q3mtH/8WU2Mig5vxYyiT
	BDFX5AR9E8Wa2MMj6FtL8=
X-Received: by 2002:a17:906:a24a:b0:b36:4f39:3158 with SMTP id a640c23a62f3a-b364f393739mr392727866b.5.1758885133057;
        Fri, 26 Sep 2025 04:12:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFRz/MXN70B3vZ7jWyubfql8OdBW6CmLXhsXgwCuvhJXrbl1pkx0lsr7qNX6aNmTkzLV8f83r2ah2Ip8nkUXic=
X-Received: by 2002:a17:906:a24a:b0:b36:4f39:3158 with SMTP id
 a640c23a62f3a-b364f393739mr392726166b.5.1758885132625; Fri, 26 Sep 2025
 04:12:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250725090201.32656-1-tglozar@redhat.com> <6f2a6564-ecf0-e77e-2ccf-5250eddab97f@redhat.com>
In-Reply-To: <6f2a6564-ecf0-e77e-2ccf-5250eddab97f@redhat.com>
From: Tomas Glozar <tglozar@redhat.com>
Date: Fri, 26 Sep 2025 13:12:01 +0200
X-Gm-Features: AS18NWDzb1wLKv0lNLL8zk6icI5g4bfmjm4K0tZx93HdKPeZu29sZUwB77J_w50
Message-ID: <CAP4=nvQQDeKOEPG8E61rv_epTji26A=+BuZNOd8kV=yi=kDw6Q@mail.gmail.com>
Subject: Re: [PATCH] rteval: Introduce E2E tests with output checking
To: John Kacur <jkacur@redhat.com>
Cc: Clark Williams <williams@redhat.com>, Linux RT Users <linux-rt-users@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=C4=8Dt 18. 9. 2025 v 19:56 odes=C3=ADlatel John Kacur <jkacur@redhat.com> =
napsal:
>
> Interesting.
> Note the correct spelling is "deprecated"
>

Oops. Thanks for noticing that.

> I'm not sure we want to deprecate runit and loads, they have different
> purposes. I often run in a non-rt environment and without tuned if I'm
> just testing functionality and not performance, and I got this after
> running make check (skipping some of the output before that)
>
> # Output match failed: "Command: rtla timerlat hist -p1100 -P f:95 -u
> -c[0-9|-]+ -E3500 --no-summary -T1 -t=3Dtrace.txt"
> e2e-tests/measurement.t .. Failed 6/19 subtests
>
> Test Summary Report
> -------------------
> e2e-tests/loads.t      (Wstat: 0 Tests: 8 Failed: 1)
>   Failed test:  5
> e2e-tests/measurement.t (Wstat: 0 Tests: 19 Failed: 6)
>   Failed tests:  13-14, 16-19
> Files=3D3, Tests=3D33, 308 wallclock secs ( 0.06 usr  0.00 sys + 146.20 c=
usr
> 281.79 csys =3D 428.05 CPU)
> Result: FAIL
> make: *** [Makefile:22: check] Error 1
>

> How do I identify which test is test number 5?
> Am I failing tests because of performance reasons or because the tests
> expect an environment different from mine?
>

The tests should work in any environment, I have to fix that.

Thanks for testing the patch.

Tomas

