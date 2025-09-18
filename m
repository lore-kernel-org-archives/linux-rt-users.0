Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10B6234BA2E
	for <linux-rt-users@vger.kernel.org>; Thu, 18 Sep 2025 18:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758219361; cv=none; b=CTlYB8dFw86DHxWYsYlhFW5aypqKyVUE1y+stx6Pq5HUE6LDSlpXjYgkgULpvcQFluBTTLq1RSiczJNa6L/Ylfbtzi+LS+Ky0ccQ5tMUFHOxgTgYG837YLCXO7NngGTlE1zkblYMOBwadRBxoGZnmYSUHszmVJ5h1C3oYnzzlkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758219361; c=relaxed/simple;
	bh=yrNAsPCCXPVSYYZth/2x3ipZ+eRaq+vq8iLsBkMNHp0=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=af52UTEDnWt4yIxsP0CTtnU/O/25EoNooUHYcM0nKFFqk3PKbUpGzNXWxGLxtLO1Ja+oA69t35PHtk0vhUvcipjuOMQskd0io6PhdLDZJcKMr5rsaj7i0lESrbvNFzS6+MOnYIwzIHLx37/Ghxt5GZ5Gt1ndCDFakAJw3p63SwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Lgdx51PG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Lgdx51PG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758219357;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=X+r0WrKvbsShXOqRYdT3MzkVzjYjGjQup2XsC1kH3LU=;
	b=Lgdx51PGa+MwVShNwQ+5gMS2KDCP2AuuwEK89Bt8laFjoFir5tiW7Sjy8N3hpvVT/ZaFe6
	FR74tNGY5Nmup+CryVBVxqZC2x1fw1lGqzql9GDCzBl697zfowrlIFPSFN8dh1P/wpR82G
	876Hi2wkX1g4wc1/8t17IZVYkz5Q/Zc=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-584-QFHaa6raOQO_FgKJNsBQww-1; Thu, 18 Sep 2025 14:15:56 -0400
X-MC-Unique: QFHaa6raOQO_FgKJNsBQww-1
X-Mimecast-MFC-AGG-ID: QFHaa6raOQO_FgKJNsBQww_1758219356
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4b5f31ef7dfso43545131cf.1
        for <linux-rt-users@vger.kernel.org>; Thu, 18 Sep 2025 11:15:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758219355; x=1758824155;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X+r0WrKvbsShXOqRYdT3MzkVzjYjGjQup2XsC1kH3LU=;
        b=ZOutKhhK2jYseEtox1e22fKGAXU5GmE9P/ueY3HJeYZxQ/W+LOw1UgUdG8zRQQRP1X
         /H/20wuqHHVBLmD4ysfqMJvdTWxbApscsvMPHrGUV8iUerpUz58BibI2TWVDW2TOar4b
         D3xKQjNaHlC5UPiruCC508i1BDPf4pqI9xfeiA9h/eYzplhIqAK9CCaFgnmk5jNVUaTw
         wb1NuLRGDFdJe0RsdJtERDM0I1ZXovcEebvhFaYGfAEpdy0mOCkJV19pkTdzTKLdnG8M
         ZNgDEVDjeIrt33l7nBXqi0FYhUnN3iAe9hL4ON4KImgWH/2+PNIWSP3/6VL7DYbzuF1W
         1Bbw==
X-Forwarded-Encrypted: i=1; AJvYcCXf0b7moxJzqkaZvp+gNQbhRVnUjQLIcBczytzA3s1ElAYobjnnZnfidnuMBulu5f+72io+38QnSauNRQWmJw==@vger.kernel.org
X-Gm-Message-State: AOJu0YypF5UD+IR/NxHNtDpl4gBM0xyv9NVH7q2L7gp4AyupcvgwMhCp
	7SX56z2Eo9iRVckE70bsZa6K24+XQSvLpkwOulWf4W0N0ca/5+iDsLDa/pw552bt8IEm1c1DCm/
	ou6b6loeAILLidLmfoq76URz6tgb1hte0tsVMOLeWeanJPEM6aK9IuMnO10XXfoRT0rKBjWUYlD
	qGdms=
X-Gm-Gg: ASbGnctRolK8+z/TUH7uSHNdc2hHDdybRiMh9ee+ZmEoxboANIvaKJDQdCXL/N5Ri/G
	VjsTIJoFUAZmCeRIpk7It03Acn0jjxt4N+iBbyASJbOpo1sjidobgX4rEPqHbgBYRDcUE9UHfMy
	R5TMwQ4wpSUjAGqgkR59jPb3/pZAKQtA2laT+IdnYCCczaE34QXnlkkgajYTlJRLzM2qapJM5XQ
	5HaHoljO66BMRntvGqrTG/AkFYsAuW7kUHPddvr5vUYbEISrJ0kbvOwVXgVzIli+VCV0yqxjJ3D
	+g2AfYBOofmNXtrJSJbj+/DaVw==
X-Received: by 2002:a05:622a:206:b0:4b5:6f48:e55a with SMTP id d75a77b69052e-4bdaa89c121mr47213851cf.12.1758219355383;
        Thu, 18 Sep 2025 11:15:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHZBW2jAvcB/5q04sjbj5QpL6xYHtE0RVITYrhbGkDCUMBsFie98adjOjVTKqAhcoMu4WQ8vg==
X-Received: by 2002:a05:622a:206:b0:4b5:6f48:e55a with SMTP id d75a77b69052e-4bdaa89c121mr47213321cf.12.1758219354750;
        Thu, 18 Sep 2025 11:15:54 -0700 (PDT)
Received: from fionn ([70.53.55.167])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-83632ac0b2dsm195936485a.59.2025.09.18.11.15.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 11:15:54 -0700 (PDT)
Date: Thu, 18 Sep 2025 14:15:43 -0400 (EDT)
From: John Kacur <jkacur@redhat.com>
To: "John B. Wyatt IV" <jwyatt@redhat.com>
cc: Clark Williams <williams@redhat.com>, linux-rt-users@vger.kernel.org, 
    kernel-rts-sst <kernel-rts-sst@redhat.com>
Subject: Re: [PATCH] tuna: replace match with if statements
In-Reply-To: <20250822024321.61951-1-jwyatt@redhat.com>
Message-ID: <74bb0b8d-8e1e-159b-e636-49c7dc86aa87@redhat.com>
References: <20250822024321.61951-1-jwyatt@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII



On Thu, 21 Aug 2025, John B. Wyatt IV wrote:

> The match-case keyword statements were introduced in Python 3.10. At the
> time RHEL 9 and other older distributions only have Python 3.9. This patch

Note we want our upstram code to work well with any distribution, so avoid 
referring to RHEL variants in your commit messages. That being said, newer 
python variants are available in rhel 9

I'm going to take this patch though, to make using older distributions 
easier. python-3.10 is fairly old at this point, so we might need to work 
on ensuring that tuna is run in a more up-to-date environment.

> will make it easier for older distributions to use newer versions of
> Tuna.
> 
> Signed-off-by: John B. Wyatt IV <jwyatt@redhat.com>

Signed-off-by: John Kacur <jkacur@redhat.com>


