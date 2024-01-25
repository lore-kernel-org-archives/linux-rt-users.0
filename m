Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99FC02C870
	for <linux-rt-users@vger.kernel.org>; Thu, 25 Jan 2024 11:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706182539; cv=none; b=LCtsO8rtwxMbNyZaatqF3rXxNx343XEULe1Aw/5sb9bXvSYuSWUlVY1gYpG/DaVT5SRAbriv3L7fqEH8QVIkA8ycCF77zo7qVuDVAm9VgDX2Flzpr3W+BP0xyg2M+aoojbfxgQh9B2mYaSSh9Ig9XU3haQvZPGQUj1qRoSBC31A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706182539; c=relaxed/simple;
	bh=QkSifBmhNnh9J/ox6L1kLoVfm7f2dkDpGrgfAkkmiqc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=iJt0XBicZnCOb9x2sedi5QfggWass1Ewl+fgv7oCHdaCdE7WtN7ApFpUsrg8X5xAFan4ai91pS5JYktnAu7De3ziptZXqMK+ctLV3PRbxlHKtxE25KRVQaqyfM1Z209Z0Z92RSeki4ebuONI7hqxafeYkkkm01bv1wFmPCD2eCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=daIsWxTC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="daIsWxTC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706182536;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ND0M38vqg/f3DX4i2e40ekWPh2ueLITyqRBQvx6nxv0=;
	b=daIsWxTCpMpVb7wlxF05W2wjFXQd0cd1EqKGIGD52661WRV9d24tLjUOJDQDTAb6ryfNfD
	XJOpJIeUFeFC2nsv2Wxyxv2hexdA2ED6Ri+82l0Rqq/CxQ/cjsIPCp+i/IcJwmcvuNX8TN
	wt3aBKHCdhEYB1sX5QxdEsr4LuwTaoo=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-43-iYTqxWeqPY-t2kB5kSsU-A-1; Thu, 25 Jan 2024 06:35:35 -0500
X-MC-Unique: iYTqxWeqPY-t2kB5kSsU-A-1
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-5f6c12872fbso103077627b3.1
        for <linux-rt-users@vger.kernel.org>; Thu, 25 Jan 2024 03:35:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706182531; x=1706787331;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ND0M38vqg/f3DX4i2e40ekWPh2ueLITyqRBQvx6nxv0=;
        b=Egwd8FjiAxe8ikK75JiLXb5x1gClm9y1sChZtfSe/18VOThdDvwLKq+//8Wzj6ZyAU
         1DIa/vDTrY97cCSqBz4z8INreRbo8KMq4Q9s2hA+EHVTJLDS5IRMwZfTBE2O9uKpbaHy
         5WvTXzq1D17WUoO41icbs5n7r3jmeGJok2+6eV1zRvgaSSVYCIXIdMy9Cv6F9OnMZ3cL
         4wPXT8owWvmQuQ0n7ZEW23jWKwzCRd/TZiCDlWgS4ppgsFU5RPTzx5qLAXg1aSV8H2Od
         PSwsLfHQ60zMR3fdqhxKCl6EiS881AeQ706fV5X64CIX+F67i5AjhO4RzcqUA2/SrlpO
         BKJQ==
X-Gm-Message-State: AOJu0YwhSwRZDXxGK8xm8qEbwnLGSxKcVB7d5EMzanNVOK30yB8Z3EJD
	zlChtMsUISOZrwGpR/09zSBJyBu3h3vQ1SfbXYQU/ALh4qgYuMOak3PEAwwXD8MwXEhcIpCD0Au
	q1CRZd4yhM2nVkLc85JNMR+8TcZ0Zxy46GU1134NYHbH2PPA6qLPMDDdOWhIIM3A1
X-Received: by 2002:a81:5702:0:b0:5ff:97d0:6535 with SMTP id l2-20020a815702000000b005ff97d06535mr552288ywb.83.1706182531053;
        Thu, 25 Jan 2024 03:35:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFlpvmBp8xlQD5XCxbHNI/yAx/NEl7+aASAlI1TcIgGwaDJTRqIImA/z84168W/ZHhbcdOW+g==
X-Received: by 2002:a81:5702:0:b0:5ff:97d0:6535 with SMTP id l2-20020a815702000000b005ff97d06535mr552276ywb.83.1706182530618;
        Thu, 25 Jan 2024 03:35:30 -0800 (PST)
Received: from localhost.localdomain ([2a00:23c6:4a05:9f01:cede:7b45:1f9d:67f])
        by smtp.gmail.com with ESMTPSA id bp31-20020a05620a459f00b007833c4dddfdsm4924094qkb.53.2024.01.25.03.35.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 03:35:30 -0800 (PST)
Date: Thu, 25 Jan 2024 11:35:26 +0000
From: Juri Lelli <juri.lelli@redhat.com>
To: linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-rt-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>,
	Juri Lelli <juri.lelli@redhat.com>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@linaro.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Georges Da Costa <georges.da-costa@irit.fr>
Subject: [ANNOUNCE][CFP] Power Management and Scheduling in the Linux Kernel
 VI edition (OSPM-summit 2024)
Message-ID: <ZbJHfiWnujLz2Pfm@localhost.localdomain>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Power Management and Scheduling in the Linux Kernel (OSPM-summit) VI
edition

May 30-31, 2024
Institut de Recherche en Informatique de Toulouse
Toulouse, France

---

.:: FOCUS

OSPM is moving to France!

The VI edition of the Power Management and Scheduling in the Linux
Kernel (OSPM) summit aims at fostering discussions on power management
and (real-time) scheduling techniques. Summit will be held in Toulouse
(France) on May 30-31, 2024.

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

.:: FORMAT

The summit is organized to cover two days of discussions and talks.

The list of topics of interest includes (but it is not limited to):

 * Power management techniques
 * Scheduling techniques (real-time and non real-time)
 * Energy consumption and CPU capacity aware scheduling
 * Real-time virtualization
 * Mobile/Server power management real-world use cases (successes and
   failures)
 * Power management and scheduling tooling (configuration, integration,
   testing, etc.)
 * Tracing
 * Recap/lightning talks

Presentations (50 min) can cover recently developed technologies,
ongoing work and new ideas. Please understand that this workshop is not
intended for presenting sales and marketing pitches.

.:: ATTENDING

Attending the OSPM-summit is free of charge, but registration to the
event is mandatory. The event can allow a maximum of 50 people (so, be
sure to register early!).

Registrations open on February 26th, 2024.
To register fill in the registration form available at
https://forms.gle/SooSmYMChBcn5rmM8

While it is not strictly required to submit a topic/presentation (see
below), registrations with a topic/presentation proposal will take
precedence.

.:: SUBMIT A TOPIC/PRESENTATION

To submit a topic/presentation add its details to this list:
https://docs.google.com/spreadsheets/d/13lOYsbNWhQU7pNbyHI97fC7GT0Eu8aMbU9ATvPJfV0A/edit?usp=sharing

Or, if you prefer, simply reply (only to me, please :) to this email
specifying:

- name/surname
- affiliation
- short bio
- email address
- title
- abstract

Deadline for submitting topics/presentations is 19th of February 2024.
Notifications for accepted topics/presentations will be sent out 26th of
February 2024.

.:: VENUE

The workshop will take place at IRIT [1], University of Toulouse [2],
France.

The workshop venue is accessible [3] from downtown, where you can find
most of the hotels/accommodations suggested below, by metro (line B) in
30 minutes [4]. You can reach IRIT by the metro B (approx one every 2
minutes in rush hours) or by bus (several lines, between 40 and 60
minutes depending on the line and the traffic). Several buses arrive at
the metro station of the university. A map of the city center with the
venue, transportation and food/drinks places is provided here [5].

It is recommended to pick a hotel close to a “Ligne B” subway station,
anywhere between “Jean-Jaures” and “Les Carmes”.

From the station, choose “Ramonville” direction and get off at the
station “Université Paul Sabatier” [6]. The station is right inside the
university. From there follow the map [7] to reach the IRIT building
entrance. 

Toulouse airport, “Aéroport Toulouse-Blagnac (TLS), Blagnac”, has a lot
of direct flights from European airports like Paris, Amsterdam, London,
Munich among others. There is a shuttle “La Navette” [8], every 20
minutes, bringing you to downtown in more or less 30 minutes depending
on the traffic. 

A list of hotels on the metro line B (direct to the workshop location):
http://www.hotel-oursblanc.com/
https://www.athome-ah.com/
https://www.discoverasr.com/fr/citadines/france/citadines-wilson-toulouse
https://www.pullman-toulouse-centre-ramblas.fr

[1] https://www.irit.fr/
[2] https://www.univ-tlse3.fr/
[3] https://maps.app.goo.gl/rdcrKx6x8ntm4uij6
[4] https://maps.app.goo.gl/Y8UPRvHmbrjCSnvu5
[5] https://www.toulouse-visit.com/interactive-map
[6] https://metro-toulouse.com/ligne-B-metro-toulouse.php
[7] https://goo.gl/maps/ojiAeQoL5Ewgb2gp7
[8] https://www.toulouse.aeroport.fr/en/transports/public-transport?tabs4633=tab_4631

.:: ORGANIZERS

Juri Lelli (Red Hat)
Daniel Bristot de Oliveira (Red Hat)
Daniel Lezcano(Linaro)
Georges Da Costa (IRIT)
Tommaso Cucinotta (SSSA)
Lorenzo Pieralisi (Linaro)

