Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8255024C692
	for <linux-rt-users@vger.kernel.org>; Fri, 25 Jul 2025 07:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753429013; cv=none; b=h2Bm+F8iQpg6IWqepUa1b6t8tE9Hx6GV2Nx+s7pn8K8YLz8dZZ4VieHzNkLpXFX29/1GzIzSIlEY1rS84zNKrv7TxNQRlwV+Ch/SCNnzMBKtWXxickpasvzT+eoAztBzUHVUViKrLOB0MzxC523UowifOHGtjc5qxuYuMA9yte8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753429013; c=relaxed/simple;
	bh=iMBI16cru7e9C9GIZMv1+hVvgeFyM2Xitmww/ILR89w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XaD8F2y2N4cIaQGJ2/f5aenpEE72zbRC0sJHlvC/vasCKf8dtKGpkWstLBQ11VqRoadAqEv/e73y4ivOu+CsoriJ5pv8G80EUS7lv1ufTpsU0//8CAD0DZcRbbpTA5Hk7jchJEHFUtobMK7Kua6n5EM8wzFplv5rHjVMcP/yf00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=DOFJtDKT; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="DOFJtDKT"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-ae3a4a773e1so14548866b.1
        for <linux-rt-users@vger.kernel.org>; Fri, 25 Jul 2025 00:36:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1753429010; x=1754033810; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F8GmRdCOPYhPsOuj0Ef7wj0OUh3m6zsMhgZo5B6ztiQ=;
        b=DOFJtDKT+mqY39zLAAbrHbCdB4v9N6EJNjrMuuGwdFmuf5ChCRqEgoAelTwUmUdC8x
         Yw+e+3p+LRzQjmqzNEOH5n8+byogZa3LQuGmjH7l3l/vl1IR7aGov4DPvC9YqPoAK6RI
         E3NyAMm1qQQfoYaSvRP/vgdPplj0FN1gm7MbR7smcSfKxwg2XObK+FHls4qrnPKrA9yt
         VgQ5UbO6u2gudtbdZ+1rn/hXWBPOe1FyHEg58MFcLuIlvS0rUNdDBeeLBHA5tW0yH2L4
         ZCuxCrVM9dzSZL7NS7Ia6spmYtVUDu3qgAyY7GIvg1SGwaT8WMQHhu3uQsOxaEWgpBgF
         3tEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753429010; x=1754033810;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F8GmRdCOPYhPsOuj0Ef7wj0OUh3m6zsMhgZo5B6ztiQ=;
        b=a5j9VNSce+8fZBCreqda9guSQlzGescDVn+HDATLxUG7fToEuqB5+8xrHq085yiJRh
         avMYM6RMKcd5u8yOrsCcrpqHjNcZQCZEoFM8KdUhavYlMsBUi7Tj76MGvj03Gkyr5rCT
         FMiv6+NxhZ6F6CYJqIugN14VP8SPYev0cpwpCIMinwaGbCiCShix6nGStwX3NEhszsiE
         2aTVHvNEk3HDPHY9WSon2IXWs2A8WlcSlDX3Sw5rpw/axtg0G2k+0eg0+Ss4kl1fWbBC
         rUvTQgEKMO5sDczyTZ6TiVOur7Wh5Ut+cNe3fD8ptzz1WJDIfdqs5f0aMsdb9a17JEYy
         7PhA==
X-Forwarded-Encrypted: i=1; AJvYcCVhhdqGucxYGvypc3n43+n7EbdigxB9mYlySOaendNwJz05xYFzDE3pdNI/9latCRvPhsj8520fVsmNMFn96Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YytecgVGqv0NrnCMUMIfqV1egb0PxdaCmmIUmXoBdp2opslodVn
	8YCds9YvvsG1+4egzpLjNMhFcCnoWHt92oKVDSmxgnICooBW3Nn8NVOxDCwg0xaSpRU=
X-Gm-Gg: ASbGnctjroXh72OStSEPKHmi1tiUqpl4xc48qNlZb451IU/UYfHA6MhDc8iKuRn2EMZ
	1FsV9l94SD2g51NrxCvtm02w7718jjChrEdHgtwxeTrCIFWnIEnDMXxRVLK8NkEq3eUdGC+6Xfs
	4uKi1amWDa0jy9RTUDydbDtPm+CE3qcsBIDk2IcOrkpGI4EcyDnH256ZxiH3gc8VHtKzuAlRPXq
	i4Qx7ILax8+sPJK6PA7AUjf+9C9b7yN3h+kH2QoqjQ6Dp17xcOdMqdupyMagwn9Wke4b0hOlSuJ
	bg8SKb4BfKWtLayxqcVpZyKcQHOrUrO8dO9l6Fh99ZpHCvJe5jb/WuOZ3zg22HcHZCTXvTCn3u5
	wibSx2WSPbGjFDfDK7JYu44L6j3Cdv97sRCJ+dghsMla1D37tgNhpR71VweOlKWYPjznWn3OUdW
	9AtKLQ5MPCds9kq7hEeSlXSQI/fJw=
X-Google-Smtp-Source: AGHT+IHvpVhQGtidk248ry+TV85fY8I9QTbGer8+fUzzug0AzPgQ6z7v2JA/2LAk4E8W5obRIp8pmA==
X-Received: by 2002:a17:907:6e9e:b0:ae6:eff8:bab0 with SMTP id a640c23a62f3a-af61d96b41amr48627766b.15.1753429009698;
        Fri, 25 Jul 2025 00:36:49 -0700 (PDT)
Received: from mordecai.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-3010-3bd6-8521-caf1.ipv6.o2.cz. [2a00:1028:83b8:1e7a:3010:3bd6:8521:caf1])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af47cc6e6f0sm229761966b.46.2025.07.25.00.36.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jul 2025 00:36:49 -0700 (PDT)
Date: Fri, 25 Jul 2025 09:36:46 +0200
From: Petr Tesarik <ptesarik@suse.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: "Ahmed S. Darwish" <darwi@linutronix.de>, linux-rt-users@vger.kernel.org
Subject: Re: [PATCH v1 04/28] cyclictest.8: Synopsis: Remove -y
Message-ID: <20250725093646.792347ee@mordecai.tesarici.cz>
In-Reply-To: <20250714122002.o9yIrxhv@linutronix.de>
References: <20250704132721.13325-1-darwi@linutronix.de>
	<20250704132721.13325-5-darwi@linutronix.de>
	<20250714122002.o9yIrxhv@linutronix.de>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.50; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 14 Jul 2025 14:20:02 +0200
Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:

> On 2025-07-04 15:26:57 [+0200], Ahmed S. Darwish wrote:
> > @@ -41,7 +41,7 @@ in the set in numeric order, in a round\-robin fashion.
> >  .br
> >  The set of processors can be specified as A,B,C, or A-C, or A-B,D-F, and so on*.
> >  The ! character can be used to negate a set.  For example, !B-D means to use all
> > -available CPUs except B through D.  The cpu numbers are the same as shown in the 
> > +available CPUs except B through D.  The cpu numbers are the same as shown in the  
> 
> This looks identical. Is this white space clean up?

Yes, it removes a trailing space. I can understand why it's not a
separate patch of its own, but maybe it should be moved to patch
07/28, which already contains a lot of small cleanups.

Petr T
