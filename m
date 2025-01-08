Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F17DF200138
	for <linux-rt-users@vger.kernel.org>; Wed,  8 Jan 2025 18:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736360269; cv=none; b=SSir/GUBcay2px2+Q0l+dqioeqK2emvN5OiDKes85hxi+qzEkPH/qBFvNFdIEduAXtIY6UN3JWiFiCHv7AsmWubKoDyTGiWDlQyxlNbk9OGpw6YRThUyww3cjVd1mxd2DG8Z9ZWK8j2VWI9/85H0vs24YF4nPLV8yxyoWfxVgso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736360269; c=relaxed/simple;
	bh=XLa1smcbtHqLoNFa8m4HphAi6ecwR4t+CSrfN1V8vGI=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=mHgrnmDTzo1gvuhVPBjPohajIOqdUMu74Rl+ivSkGiF2jB9qcUzzYRSuJYF130HH/ReYQTOtF9QYMePqmgk67Z3zvs9cQKUUpnBTV9x3AmAF49lE0JlyGIjOYEg5Cu5LtQePElQuFEeeYJKJFcXVsmh/Ep3o03B7fBGa0241aqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Q+OPCOz3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q+OPCOz3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736360266;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NjSqqe+S8DIxCy3qas8xCUD2GisbTT4Hy9QM4TWYk9w=;
	b=Q+OPCOz3HOQ2DgMCf1lKIwMM1fNYDBsDNI00k2001VmrUkWYQa8H3VvGSaE140DmmISYlv
	KWZmmSgwa9Mwhy5J2IRBJ7WENsl9kEyNhRdVWSvhWJKJ7faROOdX8vq0R9s0CNjX1JZqNC
	YEqV5hM05ThyV6eYtydJX7tx3auyf4o=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-12-fyjHkccTPbisLHiidGxINA-1; Wed, 08 Jan 2025 13:17:45 -0500
X-MC-Unique: fyjHkccTPbisLHiidGxINA-1
X-Mimecast-MFC-AGG-ID: fyjHkccTPbisLHiidGxINA
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4679fc5c542so248891cf.0
        for <linux-rt-users@vger.kernel.org>; Wed, 08 Jan 2025 10:17:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736360265; x=1736965065;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NjSqqe+S8DIxCy3qas8xCUD2GisbTT4Hy9QM4TWYk9w=;
        b=bGRhPYDa3WjD9nxtz1QLnMnK7BK3TrlZZXfKGasYqVXCSPstbbTN8Tk7r83HdDTBeP
         mL9V23GpITaSrbC9YfPpoicGwbWTB2e+JkSStvFUDl2k6fv4vNRUAjITM/ajzwjy5Z/C
         UCLBfC6dWJ4zv26gFwtJorfBqke/kIiwOSDUXfGjU7TKyUFb8ZrjfHBWTHGrx9OJ/i3z
         dEOZ6CbvKgCNSELZPtarJOHOkDU6pHJejgsWW4E9tNFyELiymXpizk7cJsAzDgO5Rbwr
         W4dUjnDboRHBWXDYyo02IWuO3DxSyAGrZChAtRbW4MtH30Pt5o/BzTWeTAFZPtxCxsL/
         mhww==
X-Forwarded-Encrypted: i=1; AJvYcCWn8pB+JV28mFTlsAMUVdnjGu/W5ecQMXxxOf9QW5IvFgrjnRlC1ehGZYegtCJ5ThRnFL6gvcv0mR3WYjqDqg==@vger.kernel.org
X-Gm-Message-State: AOJu0YycYoMn9P9RQaZgTkz9WR6/2PL3GhoFg76I+vXq5FPqnxd0ZdOm
	EYrgkHZxuBNMos04vlYUSy5zVvGIVEP7gCsPTZzN6nURBjtsaNFpq04kEprGh6MPyqouFk/xU9G
	ongBeMLclAMbRJElmqtnjNnWSLfUhaHSAC4noPfPjB8PgA4DRTMvAL6q6n1CUGOTc
X-Gm-Gg: ASbGncvqNxtj2r+eY+K0rQR1xOnmkWgbr3kEUrmwn/kj6kFUzO+wlksszrmF7FBYIDO
	jP8VyiiM4ylR5KtkbAWC1gK5Y8D4tvXEY7LILFYqMoL1fMhc456pOI7yLBfGlXuq7wN1o3si5ib
	S/41SAlPXnYFb2+by2LkQZ1JKhjWPpNaiHiyXYzjInmgMhUTwhu10BdZDRrYY4nSw7418bdpXKK
	UofbY5yO49jHd5Ib1Aog3sHXhxm/9a1ITQ7zCG1eXmuYw8=
X-Received: by 2002:a05:622a:d6:b0:46a:3579:d137 with SMTP id d75a77b69052e-46c7108c3f5mr58766191cf.43.1736360265123;
        Wed, 08 Jan 2025 10:17:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGk3T9Wq0xQFybz3ZfioUdM9remnZ9ba9qc4Q+I0a79ofFln9MMYo3yM5zZczIkhT5cUL43aQ==
X-Received: by 2002:a05:622a:d6:b0:46a:3579:d137 with SMTP id d75a77b69052e-46c7108c3f5mr58765921cf.43.1736360264823;
        Wed, 08 Jan 2025 10:17:44 -0800 (PST)
Received: from fionn ([142.189.102.234])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-46c77b71b94sm4183231cf.73.2025.01.08.10.17.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2025 10:17:44 -0800 (PST)
Date: Wed, 8 Jan 2025 13:17:43 -0500 (EST)
From: John Kacur <jkacur@redhat.com>
To: Kurt Kanzenbach <kurt@linutronix.de>
cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
    linux-rt-users@vger.kernel.org
Subject: Re: rt-tests release tarball location
In-Reply-To: <87h66b2c6m.fsf@kurt.kurt.home>
Message-ID: <6569931b-16e5-5965-dfd0-7ffdf80fffab@redhat.com>
References: <20241228114346.6020d6b0@windsurf> <87h66b2c6m.fsf@kurt.kurt.home>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII



On Tue, 7 Jan 2025, Kurt Kanzenbach wrote:

> On Sat Dec 28 2024, Thomas Petazzoni wrote:
> > Hello,
> >
> > I am one of the co-maintainers of Buildroot, an embedded Linux build
> > system. Among many other packages, we obviously have rt-tests as one of
> > our packages. When rt-tests is built, we download it from kernel.org.
> > Unfortunately, the rt-tests tarballs are moved around: the latest
> > release is available at https://www.kernel.org/pub/linux/utils/rt-tests/,
> > but as soon as another newer release is available, the older release
> > tarballs get moved to
> > https://www.kernel.org/pub/linux/utils/rt-tests/older/.
> >
> > This breaks the build for build systems such as Buildroot, that expect
> > a release tarball to stay at a given location, and not being moved
> > around.
> >
> > Would it possible to keep the tarballs at the same location? Either by
> > not having the older/ folder entirely, or by populating it immediately
> > with the latest release, so that all releases are always available from
> > the older/ folder?
> 
> +1
> 
> For Gentoo I had to add both URLs to SRC_URI in the ebuilds. It first
> tries rt-tests/ and then rt-tests/older/ location, which is also not
> ideal.

Why is it not ideal? This seems like a perfectly reasonable solution?

John

