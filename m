Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A752C224AF2
	for <linux-rt-users@vger.kernel.org>; Tue, 25 Nov 2025 19:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764097509; cv=none; b=VqSii4zh+i9MRMOvfZnuWywnpEHaHFFQXjaWc4Ui1v/niFL04xaV7KHyEGe5lj6S3NZJAa5n4odfCnNEX7EDvBA/uAiP/yeIk92kkDcd5TaIuXGJeu5lJcGIEJV56wOtfflG7hBhwSCRNWqFqy1IvIOaPYnRBzPVlIWSK+0jS5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764097509; c=relaxed/simple;
	bh=buipgehurtGZVo9psYZ7PYiXR+tHoCYxIdHqyACN66w=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=k3ZydCf2tIWi/gk59zpDo1buIlH1+s/bTVPRDxpYkRLb6SJRh52huTVF6oldABQ+lEO8mCbJHK62AbhOJ1LpZNaGstuUWUPf4Sf2b9TDpAPqOs0/wgMEWsA3g9AOnjqjnFF2Ui8jsoNZSomVc7gdAxucDh5kxwxnKtdco2fZAZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=U8AF2XI2; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=XUAhDy5c; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U8AF2XI2";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="XUAhDy5c"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764097505;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9MRw7BxzSY0dsjl1Ue4nPp+Gpp4WY4KoSWi8DTEJdt0=;
	b=U8AF2XI2rn/gFv1bD02LCBwQUKIYWHuzlbxnpuSzEswnGtpunS2tZu/vrbvICTqWShZhIv
	f6W18hmnmepeSBV716FA0bipa2hQy6cKd4ZLNFZ/whSQsNzDWvrXuHxNBy3XFvg3FWG8Az
	LY7ueNET9sYYBSjYgyt+/eQRx13NCxA=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-650-EsMaP7T3M3KB3U7noy03hg-1; Tue, 25 Nov 2025 14:04:57 -0500
X-MC-Unique: EsMaP7T3M3KB3U7noy03hg-1
X-Mimecast-MFC-AGG-ID: EsMaP7T3M3KB3U7noy03hg_1764097486
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8b2e19c8558so1349564085a.2
        for <linux-rt-users@vger.kernel.org>; Tue, 25 Nov 2025 11:04:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1764097486; x=1764702286; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=9MRw7BxzSY0dsjl1Ue4nPp+Gpp4WY4KoSWi8DTEJdt0=;
        b=XUAhDy5cSmKx52ismrKziXwdRQzw9vfIRd11ypL9aF4PKlUtBe6lRegkO/O8ARrzn8
         EoXjbKauwsTTjcVeDGIwgBIiYRB6b7Hw6S+KB8hhY85y7RR4xDKiCcOD/SdTj10b4iVM
         HJuSZTg8wu4RxTHleJJP8fJnHGp7/O864Y/toOVJEEj0Tuk3CsRAtE33Yl3B5HAN8C+W
         2ewR0suE1NUsgkGkYobpQuVKLAN24PH6JpvJtRgBTlMXyhZiWuxvC54zezzHUIQH1IV0
         vWWiEVgEReDNqUHTZ5gwgtQIdeH2fQCL2CFi6GyzJzoTx83hrKd/eEEP7ipcoNhVdzWX
         Wqvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764097486; x=1764702286;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9MRw7BxzSY0dsjl1Ue4nPp+Gpp4WY4KoSWi8DTEJdt0=;
        b=Q11MHjjtBuD3WGXdIlh1lkcSMjBkaVjB1isteNC8jIu490BzRlFVptdWx2dE18eneC
         1tr5wIGrGsC1W1u6bNnKnRwwg4U7YzndNOiB2qF4ceEMBqzdYd6xTvAQrEH+wbMwODnK
         KHpJToI6AyBgzcCbJOSzNfVV12cyep2pGFw1dyoze9OAJBXcvYcYUYEtG1/TdmdYnqLy
         fB4oVdN0fxORzpT548ZP1rlLLgqGZ7oI/NkkLV0hRIizFZPfhQRYUP2JMHGNJSy0Ga7E
         dybhQhMpMNlkO1y3WeuLsff9LepXxlKRMIbVd1IYTtySk1XN9fPikkP+mw0VodiqALMJ
         DX4g==
X-Forwarded-Encrypted: i=1; AJvYcCU+eeUS5Q2Jlk41Uot++VycsB45g7eXwbhJ274G9rZEA1JXKjN9dwuR3yV6MNWrXFy/AJhD0jRMVdOzoiFevQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwbIaBXHFHhV34OmD1pECj39AUEAV6XC7w+sfv9lq8ixmCe+SK+
	JrvsApujZFgaEZsWr4aAnQl7Zm02q0PHHQXuM7pBSiSXRmi9SvXAS+HFoevbVbz6L0O625edlxs
	Lb2Oa0ru0xxbsXs+bYMD+oQREtpcM/CIY3VklpwEpkJD7LFGKu+si3Nj1iXYZBoMcGL6XO9vQ5d
	7n
X-Gm-Gg: ASbGnctaB4xXJTF6H/jbIzu10SMeWSw3xs6d4Q3VqPCWLw4lWiN4UlXOmufLwOOhB7I
	9zxDWqFVni7VA5Gs8ZfpHLKk+TqELDs4gVFqkzW1kSpaCjbpDydnKRlJXexyC7hXp6r35acM+5T
	Yzyv+rFfW26Q4Hdn1/OBsvnve/9EQ32XNKA8hZ4jc7pVe6cgeWalyO8XdIDba1Oqusz+B6OL8yP
	ulAH3RZmXdfpB96v1wFMnMrv23aq1+byLFD9tDndi8BZRiJdsRVCMjk/U3HS0vhS/s2+ry9ZzKY
	0X4m9qt3HX1VRFv2zGgedu7navSXXrQBWH2eqSQf26Gyowu36z5gKAaZYBon90tB3tzcggRl
X-Received: by 2002:a05:620a:842:b0:8b3:c8ee:7240 with SMTP id af79cd13be357-8b3c8ee732dmr601636585a.5.1764097485631;
        Tue, 25 Nov 2025 11:04:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IETPFUr2/dfYTcprJhFStfKnelIp1fgywHUGnvXCIXQ0DEwl+kGpw70MQ9+fnT4xWOup8xmjA==
X-Received: by 2002:a05:620a:842:b0:8b3:c8ee:7240 with SMTP id af79cd13be357-8b3c8ee732dmr601631185a.5.1764097485221;
        Tue, 25 Nov 2025 11:04:45 -0800 (PST)
Received: from fionn ([174.88.40.44])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b357f0355fsm806214085a.10.2025.11.25.11.04.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Nov 2025 11:04:44 -0800 (PST)
Date: Tue, 25 Nov 2025 14:04:33 -0500 (EST)
From: John Kacur <jkacur@redhat.com>
To: Tomas Glozar <tglozar@redhat.com>
cc: Clark Williams <williams@redhat.com>, 
    Linux RT Users <linux-rt-users@vger.kernel.org>
Subject: Re: [PATCH 1/2] rteval: Move unittest.py to
 tests/unittest-legacy.py
In-Reply-To: <20251125110241.277542-1-tglozar@redhat.com>
Message-ID: <7bd18465-259f-aa29-8ce6-da923666734e@redhat.com>
References: <20251125110241.277542-1-tglozar@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII



On Tue, 25 Nov 2025, Tomas Glozar wrote:

> We now have a tests/ folder. Move unittest.py there, rename it to
> unittest-legacy.py to prevent conflict with Python's unittest
> module, and remove the now empty directory unit-tests/.
> 
> Signed-off-by: Tomas Glozar <tglozar@redhat.com>
> ---
> This is a follow-up to [1], in place of patch 2 and 3. Patch 1 got applied,
> patches 2 and 3 required changes following the merging of [2].
> 
> [1] https://lore.kernel.org/linux-rt-users/20251107134749.257350-1-tglozar@redhat.com/T/
> [2] https://lore.kernel.org/linux-rt-users/20251107182645.19545-1-jkacur@redhat.com/T/
> 
>  unit-tests/unittest.py => tests/unittest-legacy.py | 0
>  1 file changed, 0 insertions(+), 0 deletions(-)
>  rename unit-tests/unittest.py => tests/unittest-legacy.py (100%)
> 
> diff --git a/unit-tests/unittest.py b/tests/unittest-legacy.py
> similarity index 100%
> rename from unit-tests/unittest.py
> rename to tests/unittest-legacy.py
> -- 
> 2.51.1
> 
> 
Signed-off-by: John Kacur <jkacur@redghat.com>

