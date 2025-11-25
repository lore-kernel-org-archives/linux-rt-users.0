Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E669132C93F
	for <linux-rt-users@vger.kernel.org>; Tue, 25 Nov 2025 16:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764089956; cv=none; b=gwIPzOJ5mbJxDSzfvYjm0ztUjMS/pv7cSJ2r1S9zvGkl7TNdlD1IGFxQJw3z4r1//ejPD62HI6cMl+vjh/6E79EZHwUzev9HSQWsfJaehOAMV38kZzbm/+iliQUTUrsiuH4ThtjOaaG216Xulnl4lZqm+ArxVHY9i35asNhkhVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764089956; c=relaxed/simple;
	bh=QrCXwTVbTY2L/QXOdA+AJKifzsbPegD16vH5IBkdGJg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=tkkPu/+2p7v62rNpjUyoc7NVCafkq4hljz5zUjAlETN92eAQI0/CVpkdDgAeLltYWF0yzUZhRQDW344WnocPn8cdzvAOvi/AgmTaLqabTTVcU3pJoPiX4Y4OQOv/AOj1F00am4ofYFDq83P/7YU0H7P3lmVNWTj3lLlcWbUGDX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=i03fx97g; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=UNS8YvUH; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i03fx97g";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="UNS8YvUH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764089952;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=hG/yosQtNPsaLgr5tkw6oyaa1Fhacq6iGIxAKL96B5c=;
	b=i03fx97gQiJgQ3EXcQnfqtTfaPLSDEmIiKDAgK+HnP6i7FmijPOyeqCuf3+nosIGqSn1E7
	xPcE8jv8XCirJwDm1fg5hmgTl2I2w/FjFcjdkxU2foutCOfSfDnrp3p9XSMC52wYir15AU
	lzyRt+BWI1LqdPfal8gaohKz8ErtIHk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-554-LY8yHX8INYyqMVSrE_WX5w-1; Tue, 25 Nov 2025 11:59:09 -0500
X-MC-Unique: LY8yHX8INYyqMVSrE_WX5w-1
X-Mimecast-MFC-AGG-ID: LY8yHX8INYyqMVSrE_WX5w_1764089947
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-477cf2230c8so19131075e9.0
        for <linux-rt-users@vger.kernel.org>; Tue, 25 Nov 2025 08:59:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1764089947; x=1764694747; darn=vger.kernel.org;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hG/yosQtNPsaLgr5tkw6oyaa1Fhacq6iGIxAKL96B5c=;
        b=UNS8YvUHTYtcrPkW7zJRWp51Oirzp785bbqqoJdf66vfc7LAIXwMDDERXK43YgaZ+q
         Q6UbfgLcebAsxTTQ6KjtzqZ2EP5UlcBvyuRhze9rp2S5X2yVYseYtgvzeObkrVDogsPN
         m7OEZF1AS3Kuqk35U0YXLfnXfG+OnH6YnIXsuVxRPuQT26C/TwE5zG/NGt0pq7oynTEy
         Q7RiW3L/bM48PrGDUW7GutP39roAW+BvizuyVL6jIx9KnU1sDGu0VwGed6o0kveWEPHg
         ZRjsPjd9OmpsHZ+5kZUogt6iu6xt1mDrliNCRrZNI3ZBs6tO/RHR6B5xYHahVEzVMKv4
         QZmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764089947; x=1764694747;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hG/yosQtNPsaLgr5tkw6oyaa1Fhacq6iGIxAKL96B5c=;
        b=JUekHD2a4KQtnAsURkPrPzkhprP9WuCEHfdbgRsJTAAySY9kbjLUqWtUouRvl57VCG
         abWVB2Ts7v/p4qTqPtI3gHIVY7l+mP7XT29iJey2ehmqVi4gWN3tLuhzVsSN9AlspZQH
         GEITap5wjN8NqhyoUlYx9lu4Ewemh657N4ch0fT21CVCCjCfQVbT4+YtVh+q+97T2lFn
         eh6zAUMFGeyJoV4MBTdfSe+UgjQfWPdpTjDXtshz/1xBScNmCaS5VTdAUf8QjmkSJQgD
         7WUzz6UkFG/TqCmIw/wkdziV3Noi0Y0KvzZiYdUQkLPCQXAL99sLrJPt2yv5Wib213O8
         BkUA==
X-Forwarded-Encrypted: i=1; AJvYcCX5EpaVxdPgs31/46HfsPlrO48PwxYxlFXJDSRm8dKSRDGBqQNsPfsuBov3LcFbi4hRckTywKjQ4KFQfJPqVg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyTfyLmj90G8MBxfFkDUNB/HGUw7QJUZzyJ1dNDu7B1Sg9MR/+V
	b4SR591jJ5mg4WRL2+ReTJZmFxnlGQmAf3pmD7gy4y8QVtDyZvvssZvvWkKF4iUqXf3QnE23vhS
	eeFdhohNqxjeqz7Wly3cU67OWEups069f0Yz/T4MP1C6hOGjnNNBmOUVbK1Ynt9HMCJqC
X-Gm-Gg: ASbGncvqQevMFix79EKbDq+UyC+D0UNeAdboMDjI68tKn88LtwiU2RzSXOv9NQ/1uZL
	49AOyM3FiuwoG0mhuEMeolOocpR8vGyD9Fk/2/bLEiOoVfwnB1QEqwokQfwyyaEqnpddoWF9Sqz
	Uz+iESzBDqjfLN41qIdcT9pLJR0M22e9aAbJFPuPOHi0RSycQ6ml0Sd9oSI/dE6AYvXDVAs0SGy
	aXEIG0Jy3qwmrjR6RLER0Hnc2UTO7ibBli7PWpwCJ7LHLdGAdOdY9HXv0ohOCzk3aIa4cbgY2ir
	jLhxSsByHavhzLnU2qcB7EnKdEOebKTP+x7JVaqnlxLuiIGRN7b5c6q9zMVR7bEPuvNJfujrGK9
	Ne7sGrQIIPMRlETq8BhJfg6+JVr03AMZJ7FGIUdAgC6Y3FwLNJp8namaarUumqB3UYdXBmQ==
X-Received: by 2002:a05:600c:4f49:b0:46e:761b:e7ff with SMTP id 5b1f17b1804b1-47904b24957mr33441285e9.28.1764089946774;
        Tue, 25 Nov 2025 08:59:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHfZ6NgVrVjPGwjj83mk0cuZy70V+eAj/GkF9EsNDbbjKbkEF6o0Lstb1Ac7PYBzJ0qoAHtSg==
X-Received: by 2002:a05:600c:4f49:b0:46e:761b:e7ff with SMTP id 5b1f17b1804b1-47904b24957mr33441015e9.28.1764089946293;
        Tue, 25 Nov 2025 08:59:06 -0800 (PST)
Received: from jlelli-thinkpadt14gen4.remote.csb (host-2-99-207-158.as13285.net. [2.99.207.158])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4790552c3c9sm21068055e9.0.2025.11.25.08.59.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Nov 2025 08:59:05 -0800 (PST)
Date: Tue, 25 Nov 2025 16:59:04 +0000
From: Juri Lelli <juri.lelli@redhat.com>
To: linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-rt-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>,
	Juri Lelli <juri.lelli@redhat.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@linaro.org>
Subject: [ANNOUNCE] Power Management and Scheduling in the Linux Kernel VIII
 edition (OSPM-summit 2026) - save the date
Message-ID: <aSXgWOmJZnvEFYaH@jlelli-thinkpadt14gen4.remote.csb>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Power Management and Scheduling in the Linux Kernel (OSPM-summit) VIII edition

April 14-16, 2026 - Arm, Cambridge (UK)

.:: SAVE THE DATE

OSPM is moving to the UK!

Please note that this is a “save the date” announcement only.

Given that the Linux Plumbers Conference 2025 (LPC25) is scheduled for
December 2025, the call for topics and registrations will open in early
2026, after LPC25 has concluded.

More communication and further details will follow. Stay tuned!

.:: FOCUS

The VIII edition of the Power Management and Scheduling in the Linux
Kernel (OSPM) summit aims at fostering discussions on power management
and (real-time) scheduling techniques. The summit will be held at Arm in
Cambridge (UK) on April 14-16, 2026.

We welcome anybody interested in having discussions on the broad scope
of scheduler techniques for reducing energy consumption while meeting
performance and latency requirements, real-time systems, real-time and
non-real-time scheduling, tooling, debugging and tracing.

Feel free to take a look at what happened previous years:

I   edition - https://lwn.net/Articles/721573/
II  edition - https://lwn.net/Articles/754923/
III edition - https://lwn.net/Articles/793281/
IV  edition - https://lwn.net/Articles/820337/ (online)
V   edition - https://lwn.net/Articles/934142/
              https://lwn.net/Articles/934459/
              https://lwn.net/Articles/935180/
VI  edition - https://lwn.net/Articles/981371/
VII edition - https://lwn.net/Articles/1020596/
              https://lwn.net/Articles/1021332/
              https://lwn.net/Articles/1022054/

.:: FORMAT

The summit is organized to cover three days of discussions and talks.

The list of topics of interest includes (but it is not limited to):

 - Power management techniques
 - Scheduling techniques (real-time and non real-time)
 - Energy consumption and CPU capacity aware scheduling
 - Real-time virtualization
 - Mobile/Server power management real-world use cases (successes and
   failures)
 - Power management and scheduling tooling (configuration, integration,
   testing, etc.)
 - Tracing
 - Recap/lightning talks

Presentations (50 min) can cover recently developed technologies,
ongoing work and new ideas. Please understand that this workshop is not
intended for presenting sales and marketing pitches.

.:: SUBMIT A TOPIC/PRESENTATION

Please consider this a "save the date" notification only. Information
regarding important dates and how to submit topics will be announced in
early 2026.

.:: ATTENDING

Attending OSPM-summit is free of charge, but registration to the event
is mandatory. The event can allow a maximum of 50 people (so, be sure to
register early!).

Registration is scheduled to open in early 2026.

While it is not strictly required to submit a topic/presentation,
registrations with a topic/presentation proposal will take precedence.

.:: VENUE

OSPM26 is hosted at the Arm Cambridge campus (in Cambridge, UK), in the
lecture theatre and breakout area. We appreciate Arm's generous support
in providing the venue.

Although the event takes place on Arm's premises, it is fully
independent of Arm's business operations. The summit is organised by and
for the open-source community, and everyone is welcome to take part in
an open, collaborative environment.

.:: ORGANIZERS

Juri Lelli (Red Hat)
Dietmar Eggemann (Arm)
Tommaso Cucinotta (SSSA)
Lorenzo Pieralisi (Linaro)

http://retis.sssup.it/ospm-summit/

