Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3398419CD13
	for <linux-rt-users@vger.kernel.org>; Fri,  7 Feb 2025 23:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738970647; cv=none; b=bA7CH1optMHzcBCbjvPgL42fLwn478KgOt/ikjtq7Dhz6DtID4U03udVFrXF0jX6gn1twfG78S14oYb+Ei3YLHFj9xm4IzxNQffhEuh2Uvgnkl7G0VIj4gud2s9vcReCi1MpTORyj4Rwoc7Rmvy5jlghof0HJTv6yD0vrrhcW+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738970647; c=relaxed/simple;
	bh=kCkcoudRP8kbl15wNTNzvLNs1sTfryBWoKW4eGcTbqM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=A9H78kTrpciSbl817WEHAjgOfIyhxGlF03gaFq62acPFkOTA/TLWs9FbJtchswYZwnigDs+RqmsA8WfhCexQ6Aw7HjBibGk8AqzEAG9SHAiyRUosdOsaGhiTE8EUroNt2hIeC9ml7euK+bwkuM8xjrsB6YQvkOuHVNiUj3uyrz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bQ4wZ6VD; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bQ4wZ6VD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738970644;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5U1aGGw5s7APxkDuS7aTTH6RJ0SW/00UW/mH23JuMF8=;
	b=bQ4wZ6VDJ0N/jIClMtc5R81NQaKYu3Gn5f07mCLCwJ5EdavPy3QlWEqKg5CJTvCd1IVDix
	bzDGvs9jAcM3LMKwz6wHFSX1ozMeeGaL4c31UaYAoRIQN1rf6avhQhU/Ldn1DLxV16iO5H
	Y/NzulWile5k2E+BMRy6PwrVMCOm1jk=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-68-6-bdt8yzOcCKOn7jyJ80Vw-1; Fri, 07 Feb 2025 18:24:00 -0500
X-MC-Unique: 6-bdt8yzOcCKOn7jyJ80Vw-1
X-Mimecast-MFC-AGG-ID: 6-bdt8yzOcCKOn7jyJ80Vw
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-844d5c4a27fso517133239f.0
        for <linux-rt-users@vger.kernel.org>; Fri, 07 Feb 2025 15:24:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738970640; x=1739575440;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5U1aGGw5s7APxkDuS7aTTH6RJ0SW/00UW/mH23JuMF8=;
        b=HnxvAG+vvW9WQGvXKohakQrf26dFpLNm1KJnWJHCV79EkfzTFQdflh5AQSJWBSOv5r
         XL6K3e3ihg0NJ8IdD4ySZtA2GReu5FVtZKA2OGFYw6B1XEzgVAl/c7vin3fYtm5513Ji
         mqWQTGnKB2nE9rx8GTJRYkybLlirEkkN3nQlQkIbdF13rMsqD0iG+m+e7BFk5fVD5UDe
         crpCxeH1MQ201s4ILK33Nl6adR+dWEOW9YKQinzj+csOqFMpfVmKNaTwjLXJlqrAbrn/
         +bkGB6O2tCSBQiUD5XpDQ+kGruAJfD3k2GcKvEaRAKt9rI4QW4sx2mZAQRgsGCm7Uynv
         VQTQ==
X-Forwarded-Encrypted: i=1; AJvYcCVbjFMBirK6dMgV6G2/M1H/d+p2kfMzsVMi7AZo44iP3KKFD4AVBmDx6ZG/O+///0gpFjEilFH7J8bSu95GcQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwLz6BAWDokUfUGghLhHWlzkooHguYb7w0agZABk/0X78pw7d3N
	n1UWXggzFMg5CgbTLPHlvuAWf2sy8zKmE88WCK85IAGDtj4hSpTxupIJD+AKvDN6qBoJIcnrSJa
	JgO1rQ4DNNMnGdB2hSBlmXUCbemWXNUr3kcXog2df+ornvHKkjYcBQVBu9o4/9HgA
X-Gm-Gg: ASbGnctaADQ5LuDvsR7hGhGbh9oowmqf89KRQjcTDbvGUhx95m5qxhX5iE+rn6b0NaC
	3WZD1Qfj6mJYqBCYVaDKmYkWJ4scPPJvZaqiDxyoSAYK197RpG7WI96iLFKGtsSKuML6v7dke/I
	e12xANOOj3rSjbOhNRpN/xD9hHGwpYm1OQWsSy97ylQ8sDp8njJOwugKdwvkKqSD+ua4WcuKngK
	LfIwd+E6byJ5sQrhrWlh7pd9I0wquo8YnWLYZxj31NXjiwr8bUxj8AVuvqtyNUxPdoWJ171T3qp
	6pTPS61FM3vxZkjczu+fxj5nfg+RIvpnogx/
X-Received: by 2002:a05:6602:4895:b0:83a:b74c:800e with SMTP id ca18e2360f4ac-854fd90748dmr544860939f.12.1738970640187;
        Fri, 07 Feb 2025 15:24:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHHEqk3xC6ZABU8BlN3YTMfiBcToLXLyVXbkovhIrDhAOgKRf5/V8bfMCn35joygLgYdBPPGQ==
X-Received: by 2002:a05:6602:4895:b0:83a:b74c:800e with SMTP id ca18e2360f4ac-854fd90748dmr544859739f.12.1738970639936;
        Fri, 07 Feb 2025 15:23:59 -0800 (PST)
Received: from crwood-thinkpadp16vgen1.minnmso.csb ([2601:447:c680:2b50:ee6f:85c2:7e3e:ee98])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-854f67b90b7sm89941339f.40.2025.02.07.15.23.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2025 15:23:59 -0800 (PST)
Message-ID: <4bcef79ddfd9e149cd6434a038a265060a320e9d.camel@redhat.com>
Subject: Re: [PATCH] Change min/max to float numbers
From: Crystal Wood <crwood@redhat.com>
To: Rafael Folco <rfolco@redhat.com>, Sebastian Andrzej Siewior
	 <bigeasy@linutronix.de>
Cc: williams@redhat.com, jkacur@redhat.com, linux-rt-users@vger.kernel.org
Date: Fri, 07 Feb 2025 17:23:58 -0600
In-Reply-To: <37c7e3c7-d9fe-4e8a-9b5d-61d041a9151a@redhat.com>
References: <3a9f0f10-2e7a-4eb6-b094-e5492b43505f@redhat.com>
	 <20250206120056.oE88fgG6@linutronix.de>
	 <2cb9215a-61d8-4b97-af66-6ef4194f3e04@redhat.com>
	 <8144971da4d48d1f3fc75decfff2434fc44f082d.camel@redhat.com>
	 <37c7e3c7-d9fe-4e8a-9b5d-61d041a9151a@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-02-07 at 11:20 -0300, Rafael Folco wrote:
> On 06/02/25 18:23, Crystal Wood wrote:
> > On Thu, 2025-02-06 at 12:02 -0300, Rafael Folco wrote:
> > > On 06/02/25 09:00, Sebastian Andrzej Siewior wrote:
> > > > On 2025-02-06 06:16:22 [-0300], Rafael Folco wrote:
> > > > > Make min/max consistent with avg by recording the latency samples
> > > > > as float numbers instead of integers.
> > > >=20
> > > > Why?
> > >=20
> > > - More precise numbers of Max/Min for extreme low latency cases
> > > - Distinguish zero latency in bucket 001 (us)
> > > - Distinguish values from upper/lower boundaries in a bucket
> > > - Clarify confusion on average (round up) vs maximum in the next buck=
et (casting)
> >=20
> > If you want more precision, set --bucket-width to something lower than
> > 1000 ns.  That will cause everything to be reported with ns precision
> > (though maybe not quite ns accuracy, depending on the hardware).  We
> > were hesitant to make ns precision the default in case it misleads
> > people about the accuracy (plus I didn't know if the change might
> > confuse some tools that consume the output).
> Yes, it works for precision. Average is higher than max with default buck=
et width, though.

This is due to the average being calculated from the histogram (rounding
to the top of the bucket), while min/max is the direct value.  Maybe we
should keep a running total to compute average from?

We may also want to think about whether we should unconditionally use
ns.

-Crystal

