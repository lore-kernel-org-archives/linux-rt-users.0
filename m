Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 189FC1DFD84
	for <linux-rt-users@vger.kernel.org>; Thu,  6 Feb 2025 21:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738877017; cv=none; b=b7WgLZO+8Z9Cps1Xm/U24I7dfSdpMpO0BCDATcijRZhUDeKKbxbarlnwkmetb9xydg8g6iRYjIXaiogOWZO2muO9HuuQTN+kXOW4N84r2UMZFbbT89mwzWs/cyt0NnTRcFHRuDe50bMd346flpRMjrBthx8HeIBAiQU/ES47Xz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738877017; c=relaxed/simple;
	bh=QC2ZHMhlbB3OGw779MFzkcGu47Gmup8JjccfOmMYqSk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qhH2GmO05F7TADUkVZXVwWrXz2jb/pb6Q257O7d2dTnv2wkIUUR0CrcB660qlJFcP9JFX66wMl7y6GGXdfpsb4TET4MJrGzzUuyvdbRS3UIrEWLv5a/sZYRFFKObRr4EGtvziUCf6SMgeDDmbR4CzL6cWkbAI+5NGkg81s/MmOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QtUNmiUf; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QtUNmiUf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738877013;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n+4XoSRYG0e5K2iUC62l3WqL0ho8hlh568/Qr2yAR2s=;
	b=QtUNmiUfk9W7RjL8hXKljQjgFDS9t8DPGBHUDlEDFHzSXs3penZSitsQl11HtMK4elua84
	zXkGFmeaA49E9W4f86xY5cPfj3FTjcClQNYWnuPs0k9W24ZZv2B4Y/7KNw88voDEIW3ufs
	kmJa0Bx7NTbiE894T5PWyWYEOayKT5g=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-163-v20J6gh4NJq9hVXtsALT4A-1; Thu, 06 Feb 2025 16:23:31 -0500
X-MC-Unique: v20J6gh4NJq9hVXtsALT4A-1
X-Mimecast-MFC-AGG-ID: v20J6gh4NJq9hVXtsALT4A
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7b6f1595887so186006085a.1
        for <linux-rt-users@vger.kernel.org>; Thu, 06 Feb 2025 13:23:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738877011; x=1739481811;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=n+4XoSRYG0e5K2iUC62l3WqL0ho8hlh568/Qr2yAR2s=;
        b=MEDFn7U6vpajykleOHXjmpU58qZEWVBMbIvoU6PGs1D5wfIkZpb9/er6IeL+qTxKQn
         0XqV9epD9yOvRjvG/3eq1Fs7vhXqYHezY1l2HTNSYd09NJqUQz97cY0+2JE3Uif1gQAn
         EZBlPRWYIxRfbmND77eJPG2REeEAHiCZpWRMVM8GPB0lygp+6S8nt5atJ4agIMajNFsh
         WcxhpwAWQfvM6xGNdtkQl96EdZEtE9h3yGaGQgDdnZysoEBnepfN94+j6pftcTQD0MzG
         tApdQiG64nF99IY1M5/bmSx4a7jbVLhI9iKCdfqQ8IvqkQ7MZkZ3lpsZhLhophlPnKAq
         vuHA==
X-Forwarded-Encrypted: i=1; AJvYcCVZu2JdzB/K3Idx5kv8jhoUoqaD5xiNB2O86HcSJI3GvMweu7/KBoBIuWv9r5GYTwU2KYdL0DagJmlx5vTH1Q==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6KfT8dngBHxbsJo45B9Y2Oc/naovLkFH6zHComawpgFNe4gZR
	o2mAoSDpF6aCWwnSClb9g4Me6KEl3EkECzoPeCei4/rOnoHetflvA7xjiq1K1W7CWFHFUSenuBT
	HPs2MNL4f/6wGXde2Q0qupDRkuu7quFIpHuQZP3t5WplgNt51wkHmzzLo2we/kqlwmzt5twLn
X-Gm-Gg: ASbGncvb0JNTENWIcwlOgEit7K4oi+ThJOfUkisuM+tSvIYc1mu4asXHXxRFFeZLvMX
	uNAKbM2dUBxs4exMOwcMTP85MK7kMryvopFDZhRdN5JQjfReWnJ3DrJib7rZaOBvZOVpVAEvvIt
	sWbC0pedLgv+Y/R0GgaxkzU5JQsYuRrk1VchLzH+vLRIF/UzCf7sHzbJ7UwIlCOgb1pcuhND3kl
	+rWPkNHGancxOG+8m6QL3g+wmOfaArbOPAwigB/SyzEdu2yRMX9soZGqPCDLTuuLqLi8uzYR/NZ
	dwUOUAOaEtNvTkwdrqsXjThWhy6mBiIZjzY5
X-Received: by 2002:a05:620a:1903:b0:7be:6f05:1b2a with SMTP id af79cd13be357-7c047cae609mr111509385a.56.1738877011114;
        Thu, 06 Feb 2025 13:23:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH/qGpgw54tJwqyuv4obm7wR55A8FB6qWIcszR59K7rsAl+Ri/6cgowF9MtjPUlL6Let3/QWA==
X-Received: by 2002:a05:620a:1903:b0:7be:6f05:1b2a with SMTP id af79cd13be357-7c047cae609mr111506685a.56.1738877010853;
        Thu, 06 Feb 2025 13:23:30 -0800 (PST)
Received: from crwood-thinkpadp16vgen1.minnmso.csb ([2601:447:c680:2b50:ee6f:85c2:7e3e:ee98])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c041e0e2e4sm104771185a.49.2025.02.06.13.23.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2025 13:23:30 -0800 (PST)
Message-ID: <8144971da4d48d1f3fc75decfff2434fc44f082d.camel@redhat.com>
Subject: Re: [PATCH] Change min/max to float numbers
From: Crystal Wood <crwood@redhat.com>
To: Rafael Folco <rfolco@redhat.com>, Sebastian Andrzej Siewior
	 <bigeasy@linutronix.de>
Cc: williams@redhat.com, jkacur@redhat.com, linux-rt-users@vger.kernel.org
Date: Thu, 06 Feb 2025 15:23:29 -0600
In-Reply-To: <2cb9215a-61d8-4b97-af66-6ef4194f3e04@redhat.com>
References: <3a9f0f10-2e7a-4eb6-b094-e5492b43505f@redhat.com>
	 <20250206120056.oE88fgG6@linutronix.de>
	 <2cb9215a-61d8-4b97-af66-6ef4194f3e04@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-02-06 at 12:02 -0300, Rafael Folco wrote:
> On 06/02/25 09:00, Sebastian Andrzej Siewior wrote:
> > On 2025-02-06 06:16:22 [-0300], Rafael Folco wrote:
> > > Make min/max consistent with avg by recording the latency samples
> > > as float numbers instead of integers.
> >=20
> > Why?
>=20
> - More precise numbers of Max/Min for extreme low latency cases
> - Distinguish zero latency in bucket 001 (us)
> - Distinguish values from upper/lower boundaries in a bucket
> - Clarify confusion on average (round up) vs maximum in the next bucket (=
casting)

If you want more precision, set --bucket-width to something lower than
1000 ns.  That will cause everything to be reported with ns precision
(though maybe not quite ns accuracy, depending on the hardware).  We
were hesitant to make ns precision the default in case it misleads
people about the accuracy (plus I didn't know if the change might
confuse some tools that consume the output).

I don't see the need to change things here -- and I definitely don't see
the need to hold on to the unit_per_us stuff if we're going to always
print ns resolution, regardless of whether we use fp.

-Crystal

