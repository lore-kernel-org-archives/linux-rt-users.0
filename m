Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93DB8C00A5A
	for <linux-rt-users@archiver.kernel.org>; Thu, 19 Jan 2023 13:29:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230127AbjASN3v (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 19 Jan 2023 08:29:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230054AbjASN3q (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 19 Jan 2023 08:29:46 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B9D178AB2
        for <linux-rt-users@vger.kernel.org>; Thu, 19 Jan 2023 05:28:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674134937;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=jQ7TZ/uWcR3rMx72VYX8JKupiK67GA9GFvn8roRQmyo=;
        b=fCZ76x1vofh0i2XVFPTIx8OjzQ/t+4K2KR3zQYmLL6GJAbd5RSxt5KfM9Ggh98P0Nr6KQy
        lxjdNSjX/bWNgmBKso9ZsvWWRIZQp9wr7Xy5aeu3dQ2ycf71dU7pKyJ98Sd1afF26rC0bN
        NqQYcdt5cKUiVEc0fBBV980Qex0ddI4=
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com
 [209.85.222.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-103-3y074HfmMN-cOHrE_UUuCA-1; Thu, 19 Jan 2023 08:28:56 -0500
X-MC-Unique: 3y074HfmMN-cOHrE_UUuCA-1
Received: by mail-ua1-f71.google.com with SMTP id k12-20020a9f30cc000000b0059bd6246237so517054uab.7
        for <linux-rt-users@vger.kernel.org>; Thu, 19 Jan 2023 05:28:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jQ7TZ/uWcR3rMx72VYX8JKupiK67GA9GFvn8roRQmyo=;
        b=Ey/ReVouDrTy773yv35wksM+NGHsbxFYBjLNuiuK04XbE4NWXlXLSAUfkx797/qoRR
         QVeAA9RRQH4lhYxKR4jabOMKPsKjKJ9AjrIpYQYs6zIaAvCM3WwPny0H6f4xcMu+c2Gr
         C0bzjDzp+FKjxNclb5yJKKp39Wf1S3PKJTs4ixVp8BEaeV/cXqEa5l2ukPbLSXJVNbvr
         Lvwh396dcwDMaHH2tvNuuh0ft0JK4tRIbjL0BJ9eWJF/TwbeQjZuOYMLLc+Lt02BIdgj
         ZF2aWTOODVqrVYJW97rISu+ghcc7rBbBIvH6jT1r9i6s6/LVUvILLW3ujBe/y0Bv2xUk
         cvtQ==
X-Gm-Message-State: AFqh2kp9OyvtgR5ixKGq8LeZZYkO/uyZKAKu0eWoFb9axyLbW5J0EWF5
        UjrSKR1AgrFViQVpMvOsEAxd+wNkvcVC1MxrYwjO9XwnIC3KilKRiQu9r3zBzZ2xwpgGOy78E0o
        eTfkgU2mXzyGF+31fzdI+/TSdYKc=
X-Received: by 2002:a67:e0cb:0:b0:3d3:d872:c821 with SMTP id m11-20020a67e0cb000000b003d3d872c821mr6701197vsl.27.1674134935658;
        Thu, 19 Jan 2023 05:28:55 -0800 (PST)
X-Google-Smtp-Source: AMrXdXsW2d4f3aJCvFi7ZPx3NN62wzdS1amESGFPao53yYXylhQRkBmdMXNQCs3VYkD3aCbWzy7zUg==
X-Received: by 2002:a67:e0cb:0:b0:3d3:d872:c821 with SMTP id m11-20020a67e0cb000000b003d3d872c821mr6701165vsl.27.1674134935144;
        Thu, 19 Jan 2023 05:28:55 -0800 (PST)
Received: from localhost.localdomain ([176.206.23.228])
        by smtp.gmail.com with ESMTPSA id m8-20020a05620a290800b006fb8239db65sm24355107qkp.43.2023.01.19.05.28.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 05:28:54 -0800 (PST)
Date:   Thu, 19 Jan 2023 14:28:49 +0100
From:   Juri Lelli <juri.lelli@redhat.com>
To:     linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-rt-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>,
        Juri Lelli <juri.lelli@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@linaro.org>
Subject: [ANNOUNCE][CFP] Power Management and Scheduling in the Linux Kernel
 V edition (OSPM-summit 2023)
Message-ID: <Y8lFkbJ6nluNdVYO@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Power Management and Scheduling in the Linux Kernel (OSPM-summit) V edition

April 17-19, 2023
Universita Politecnica delle Marche, Facolta di Economia
Ancona, Italy

---

.:: FOCUS

After a couple of years break, OSPM is back! In a different venue.

The V edition of the Power Management and Scheduling in the Linux Kernel
(OSPM) summit aims at fostering discussions on power management and
(real-time) scheduling techniques. Summit will be held in Ancona (Italy)
on April 17-19, 2023.

We welcome anybody interested in having discussions on the broad scope
of scheduler techniques for reducing energy consumption while meeting
performance and latency requirements, real-time systems, real-time and
non-real-time scheduling, tooling, debugging and tracing.

Feel free to take a look at what happened previous years:

 I   edition - https://lwn.net/Articles/721573/
 II  edition - https://lwn.net/Articles/754923/
 III edition - https://lwn.net/Articles/793281/
 IV  edition - https://lwn.net/Articles/820337/ (online)

.:: FORMAT

The summit is organized to cover three days of discussions and talks.

The list of topics of interest includes (but it is not limited to):

 * Power management techniques
 * Real-time and non real-time scheduling techniques
 * Energy consumption and CPU capacity aware scheduling
 * Real-time virtualization
 * Mobile/Server power management real-world use cases (successes and
   failures)
 * Power management and scheduling tooling (configuration, integration,
   testing, etc.)
 * Tracing
 * Recap/lightning talks

Presentations can cover recently developed technologies, ongoing work
and new ideas. Please understand that this workshop is not intended for
presenting sales and marketing pitches.

.:: ATTENDING

Attending the OSPM-summit is free of charge, but registration to the
event is mandatory. The event can allow a maximum of 50 people (so, be
sure to register early!).

Registrations open on February 17th, 2020.
To register fill in the registration form available at
https://forms.gle/QbRhGS3HWXinKBZq7

While it is not strictly required to submit a topic/presentation (see
below), registrations with a topic/presentation proposal will take
precedence.

.:: SUBMIT A TOPIC/PRESENTATION

To submit a topic/presentation add its details to this list:
https://docs.google.com/spreadsheets/d/10AJFQporrCPH9Gn6-MaRotdfO4Hm4LG6dVAoDrQdj5A/edit?usp=sharing

Or, if you prefer, simply reply (only to me, please :) to this email
specifying:

- name/surname
- affiliation
- short bio
- email address
- title
- abstract
- 30min or 50min slot

Deadline for submitting topics/presentations is 10th of February 2023.
Notifications for accepted topics/presentations will be sent out 17th of
February 2023.

.:: VENUE

The workshop will take place at Univpm [1], Universita Politecnica delle
Marche, Facolta di Economia, Ancona, Italy.

The workshop venue is within walking distance [2] from the city center
[3] and in general from the hotels/accommodation suggested below.  You
can reach Facolta di Economia by public transportation, via Conero Bus
[4] (approx one every 10 minutes in rush hours)  from the station (15
minutes to the venue).  A map of the city center with the venue,
transportation and food/drinks places is provided here [5].  A smaller
map locating the Facolta di Economia is also available: How to reach
Facolta di Economia [6].

For flights to Ancona, there are multiple options:

- Flying directly to Ancona airport (direct flights from London Stansted
  and Munich among others) Ancona Airport AOI [7]
  Bus to Ancona city center from the airport Ancona airport shuttle [8]
  Taxi service from Airport AOI to Ancona taxi [9]

- Flight to Bologna airport Bologna airport [10]. From Bologna Ancona is
  reachable by train, tickets purchasable from Trenitalia [11] (destination
  “Ancona Centrale”). Bologna Centrale railway station is connected to
  the airport by Marconi Express [12].

A list of hotels within walking distance from the workshop venue:

https://www.grandhotelpassetto.com/
https://www.grandhotelpalaceancona.com/en/
https://www.seeporthotel.com/
https://www.thecityancona.it/en
https://www.nh-hotels.it/hotel/nh-ancona
https://www.hoteldellavittoria.it/it/

1  - https://www.econ.univpm.it/?language=en
2  - https://goo.gl/maps/9GRDxYPnUYuBSh5h9
3  - https://goo.gl/maps/VGHaTsNi4GTgHGSj7
4  - https://www.conerobus.it/
5  - https://www.google.com/maps/d/u/0/edit?mid=135LJkfG6wq9rO2MoWPV2ofv1I2DfHvc&usp=sharing
6  - https://www.econ.univpm.it/content/how-reach-us?language=en
7  - https://www.ancona-airport.com/en/
8  - https://www.ancona-airport.com/en/passengers/transportation/bus/
9  - https://www.ctftaxi.it/?lang=en
10 - https://www.bologna-airport.it/en/welcome-to-bologna-airport/?idC=62175
11 - https://www.trenitalia.com/en.html
12 - https://www.marconiexpress.it/

.:: ORGANIZERS

Juri Lelli (Red Hat)
Daniel Bristot de Oliveira (Red Hat)
Lorenzo Pieralisi (Linaro)
Tommaso Cucinotta (SSSA)
Adriano Mancini (UnivPM)
Luca Spalazzi (UnivPM)
Stefano Squartini (UnivPM)
Emanuele Storti (UnivPM)

