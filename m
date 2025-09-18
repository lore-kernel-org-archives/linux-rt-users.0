Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ADEE72628
	for <linux-rt-users@vger.kernel.org>; Thu, 18 Sep 2025 19:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758223503; cv=none; b=sQS8ZRqKSac9eTPY6fsKRqmjx95Q0uw4f9BFo4gnaQ7dX7Kheug3hNZ0uGBWcYs62fCZNmFzrvIX4AIQARzhc1hnlXBv5o2mWnKyZWHN7eHyaEbSlnJY5eJN0RXKriFmc7H7n+6tXgC0+H9XdgwmVuafnwtDcnjVCJfslnpp/LM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758223503; c=relaxed/simple;
	bh=VHCfdlG719s0k1ksLtr4Nhp95cK2smCJPpmpFncsg/A=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BG14by5WA+mTPvY38mCZs/Oz0Co4CsImpsi8CSpl4QyIpnED43ZtTit9pPYCpZ3NPaLH8939mOcTX9xWlRlaIxnydWUEBWsOEPvY5d5nyTEPeKiBjyXWYRh315sS2iM/6LfN9dh9y+rIeMqztOHGvuCZKSNA3mpGmm4nDTS9YSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Q2sRlZrs; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q2sRlZrs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758223500;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0b/LDe6XAt2J/AnSwXtVAb1NjnlJH6Bn/u0jlqXubpI=;
	b=Q2sRlZrsuFUJXpfStPCTuqd2r5nGZfFr4PR33Y1UJTyRWODRUa4Yatz+twKA8s90+EwYYa
	5z+rGoH7cFOvU8Es68zed1mh4Q3PHQVdDKiKVxETf1jbxX4tigB+DvQYEIVqiHw3BfpVMC
	EXpuiVJzgGb8eaoGJlhaNU4AaG74KjU=
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com
 [209.85.166.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-655-nlsEui-SOrafQbJ6CMAx0g-1; Thu, 18 Sep 2025 15:24:58 -0400
X-MC-Unique: nlsEui-SOrafQbJ6CMAx0g-1
X-Mimecast-MFC-AGG-ID: nlsEui-SOrafQbJ6CMAx0g_1758223498
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-42404bb4284so17368215ab.0
        for <linux-rt-users@vger.kernel.org>; Thu, 18 Sep 2025 12:24:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758223498; x=1758828298;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0b/LDe6XAt2J/AnSwXtVAb1NjnlJH6Bn/u0jlqXubpI=;
        b=cDDbDXUKU0VrQ+Cr4T+FdR0RgitmsliNTsCYAZDm5gNrXGr/Jl9ak2TZSqLLUAnr1v
         sl+ZCFtYfqOwCVNeAeq58g/X3TLog01OZfwWlC1rQ5chY6SBnQI7Gzj79kJwXC9uShKK
         rBZANIkJ471n09IDCLE6kee47RppnOMWXCYTr+ixlVaZkev7+2XjQIqCBXmh7PwXC3/p
         U8PYBu5kUzuAnfmtcy3jLsBY89ZJ01gGiQ84XdTQ89c+VFf2XoEVllY4wq1XFQdoBxiA
         f6ozXn9GxQUH/KriSDjSE6iUP6Gxm9oUTW1a6ldM9N+L+guUOQNn0uK6NLIAZt2FjU0H
         pLxQ==
X-Forwarded-Encrypted: i=1; AJvYcCXK1XP98Ndl/i1nAuah9QJ1ol9DadgokzSEsBQA5BOj04PVfObRCdCGIy/UfiYSEHZpip4oFgRcc8rkC7Lc/Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YzzxvJvxtXEXx0jUFT1ecc6jykplNegpsxwPbxZh6LavNLThE8S
	K5SVK+XVZQpFePF9L+kOLQhylpzutqfhr1VVIUUnLNwI+XYZpsT4ii2ycfsMnFb2OiRnNarre/F
	Epyj/W3sgZH3HBpkWbrdGWckJ4Mx/T+Ug+lX2YFVjVId06yWCNCh3ykhkuSgPq/GHKFsA
X-Gm-Gg: ASbGnctYXmoVIG5JXrl0iIjiRh3YrgWLoFzPv1k6Li54SkPCgff0NoszOujoVk5oWpa
	L8rGQrwrejg9R8keGT2iHAkz5fLYjtIOq6fjBhcsUrAg1crtIK6Jid2N9fSYxwXFEbl1W91sBZc
	+BBPhmzu1ldm+CNJEyraY0DZU0V1I4DfjWU/NiyZ7V+okExhLEXhnpPNrYAhAkgRSGekf7fYVNl
	KEFQRwMCSIBZN7WHzbJ06wKE1hb+wo8f3J4i9oxch6uobiW9KhXez6xIvjZIhvH58nsfd7Jq4d4
	0beYIGsozv577x4gQ67+lvaa3JSdn+l7GyvNI0IB/fNIGg8zk/npMV+Aiuvk2mUHGF9V3Xg=
X-Received: by 2002:a92:ca0f:0:b0:424:5e84:f253 with SMTP id e9e14a558f8ab-42481991885mr10883815ab.31.1758223497927;
        Thu, 18 Sep 2025 12:24:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IELNMgzyy/46cJqsrROFHXzaso+G1ZsSf16YE00pCEgpcy8eTT8y/IenXKeXpgiGIZJfHYPQw==
X-Received: by 2002:a92:ca0f:0:b0:424:5e84:f253 with SMTP id e9e14a558f8ab-42481991885mr10883555ab.31.1758223497543;
        Thu, 18 Sep 2025 12:24:57 -0700 (PDT)
Received: from crwood-thinkpadp16vgen1.minnmso.csb ([2601:447:c680:2b50:ee6f:85c2:7e3e:ee98])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-8a483cb9200sm107456039f.27.2025.09.18.12.24.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 12:24:57 -0700 (PDT)
Message-ID: <f0ed388cbd078cfe9a90366f2a3d40d18e113df4.camel@redhat.com>
Subject: Re: [PATCH] rteval: Introduce E2E tests with output checking
From: Crystal Wood <crwood@redhat.com>
To: John Kacur <jkacur@redhat.com>, Tomas Glozar <tglozar@redhat.com>
Cc: Clark Williams <williams@redhat.com>, Linux RT Users
	 <linux-rt-users@vger.kernel.org>
Date: Thu, 18 Sep 2025 14:24:56 -0500
In-Reply-To: <6f2a6564-ecf0-e77e-2ccf-5250eddab97f@redhat.com>
References: <20250725090201.32656-1-tglozar@redhat.com>
	 <6f2a6564-ecf0-e77e-2ccf-5250eddab97f@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-09-18 at 13:56 -0400, John Kacur wrote:

> Test Summary Report
> -------------------
> e2e-tests/loads.t      (Wstat: 0 Tests: 8 Failed: 1)
>   Failed test:  5
> e2e-tests/measurement.t (Wstat: 0 Tests: 19 Failed: 6)
>   Failed tests:  13-14, 16-19
> Files=3D3, Tests=3D33, 308 wallclock secs ( 0.06 usr  0.00 sys + 146.20 c=
usr=20
> 281.79 csys =3D 428.05 CPU)
> Result: FAIL
> make: *** [Makefile:22: check] Error 1
>=20
> How do I identify which test is test number 5?
> Am I failing tests because of performance reasons or because the tests=
=20
> expect an environment different from mine?

Passing -v to prove does this; not sure why we aren't using it in make
check.

-Crystal

