Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCF37392C32
	for <linux-rt-users@vger.kernel.org>; Tue,  5 May 2026 06:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777964176; cv=none; b=rwa55lR/3hozm9feDvrZgVVdcx48eqf48suiTzPzf3zGLKqpfI1+DCJpxr4W/EZmFoC+r0BNjKKabRzwAVCsOoRSwnaCCgDLh+a8V5/VVIvnxiS5eCDndMTfj/rSh/uwR9q/017VSOEmdv5YQdcWA+DdaN2KY40tucL9VBYExAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777964176; c=relaxed/simple;
	bh=Z9CJq4WUw3rz/rHk3y5Ze/8PCNyZSMSCzcOQfpOBgOw=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=J017D0RVQSfcKWD9oeD+uxAbGfNwO/I6Hc4b4L/zevF3vT+qcewNHMF0AvIWCix9rrPAxSEiTRGvKpnB4FREu90LTGY+BtVc6skmHp7ZL7kcMuCFOYwKpnLeDUrp/0CZngR179KDco8r0zJmgK23XgegF6qng49jHvdrld9y6WI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AUJixhv/; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=DoQqPI1Z; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AUJixhv/";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="DoQqPI1Z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777964173;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=4yCHuVT3K4qsN+GpFaH3VyL8dwhIl63clFY/iEPXbAU=;
	b=AUJixhv/dLaunPb0QChOazeKSab20RQ5n1uxbWP8TBrljHTzZm+eCsXG3iZg3WGSfvUhwU
	4dkB9sMs2J7fvFJkbgXo6jnaH6fFThGg1bPVBxxlVVNDF7klpbtUePkItNoHQ+S5FzmzY1
	fy73ty9uMfmbu/c0//0HcSWOEuwdUe8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-682-SWLbTX7vPUGUuwEBf1TKjw-1; Tue, 05 May 2026 02:56:11 -0400
X-MC-Unique: SWLbTX7vPUGUuwEBf1TKjw-1
X-Mimecast-MFC-AGG-ID: SWLbTX7vPUGUuwEBf1TKjw_1777964170
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-4470d6d2a4fso5632059f8f.1
        for <linux-rt-users@vger.kernel.org>; Mon, 04 May 2026 23:56:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1777964170; x=1778568970; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:to:from:subject:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4yCHuVT3K4qsN+GpFaH3VyL8dwhIl63clFY/iEPXbAU=;
        b=DoQqPI1ZZbwAPcR9jW6zawHORo6CK4Ezjt8NSVnt3+bxre7eDWbv3Lso3vD1loDuKY
         /hTUYz4mMtjyDw4Ss50rh8SXQfdXTd1urKVBjPSarhDoPQJRwyd3GkUsm+lDuvowO5FY
         l4U+ibQodfnxU1ri6Ppb25ZdjGrQPzFn2X8uMkKHLfvfEOhL3Z26p3tfcnmuXr7TmpYZ
         Zb4Sl008H1/gAEsAiB22+bcLh9ColSb50NAtScq6iA2x7feJxF5Wh+3sl/YO01OPKcYu
         /xG+0ZiCzXnZ6MTyzCorgZ+oTkIQfuO3AVNR3qUfYCbk9EYpOcFP9CqmOns5aBSuS5yV
         a/Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777964170; x=1778568970;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4yCHuVT3K4qsN+GpFaH3VyL8dwhIl63clFY/iEPXbAU=;
        b=Au+Px2uU6xizsZHmzVApDWZXo1jILJS6dstQignj5Q2UGf8XpifQRp+lnhodmlC2l6
         T/WFX2DnIV+qn1CQiE0H33MEe90r39owyGaXbjM0EASqM84tRO32xknECkK3bfm4f9zv
         kKIF/Pe3LgH8lgTOkzOtq8Ze9C+7OjvwFyDpRrEsNZqH1j6tDn1MH9P0GjbnZFQkA1P1
         Uk2FPrZVDGrWq+Ik3X9fcyGIrB9TU3NgUgt/K5Fm/gJi3Zd3Z5IayGATl6AJTXDE3sQD
         TsKncm1IX+P4XmfMG6/ddW7pRP3SMPzlB5qsWig74a3tO2QRpd0I3A4ZVEvCNghRvO6L
         SRJw==
X-Forwarded-Encrypted: i=1; AFNElJ+sQMzm6d1HgGZ0qhMC/EWwBoFhgMO7OAnOU9uhgUhBHCQmxQX71zQ0qUv7Xd0J3hnuxgZs8bbkTsF1T48tBg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwY9mii81t0oLE+/Eni1TmPz3VNwxCJ40jVNSaYSwddKRIeg6FV
	m4NJmFq1cjbKeYG3kjmG2b4KMQnkLCUJMJ/8N1JEd0HEFUh9vHPJ9MFyUit13/TmNTYk1VWj9e8
	fNApOpZ+zwIDfEwa/r1+EBX2Lh+mt09WJyvz+uUaDjP9ajS/3qbjlQN+yGElC2RAtOEvY
X-Gm-Gg: AeBDievsoaJrKMOa8DCrsy8hcsXk7sr8UdUSL0wtDSYcoT45ZJdP5DbiY7RjNKrfntS
	Eju9x70RB/aKKttduEQTkyHUcurePvpx3gzzoFjkC33SKA9dXCSoILZK63d5/M3fPVd31IUDDDM
	dT/gg/exYflZWZZDjn7DTLW3wmqZwhTWsYfo4KUAHd6KsyeKcIrgQfOYpP0//i2SSNNrksB0iWZ
	dJW+i+QPLHqvVx0L52JHdXg1u6ixv7HfaQuLCaBAO4dSbpxHVOsXdd/S5v9sSKLoYh4ymr7TVfv
	NlZSfDB81WjTEhgxcTQ4SsEDICsnloTQ/5RZhcz3gw1C1mpBOX5mksFyZkEibwzmYDKwIC9lOpK
	EyFrE6rFAb5FQ3qC9vRdLnsK7uI+Lllz0cxeV6IRyMX45R2bI6vDwfRO84uSAh8ukT6/zJB4iUi
	kHQ4l3JgUqCFZTePc5ynBoRQinxQ==
X-Received: by 2002:a05:6000:1a8a:b0:439:beb9:5a96 with SMTP id ffacd0b85a97d-44bb6ab21e9mr22117241f8f.31.1777964170003;
        Mon, 04 May 2026 23:56:10 -0700 (PDT)
X-Received: by 2002:a05:6000:1a8a:b0:439:beb9:5a96 with SMTP id ffacd0b85a97d-44bb6ab21e9mr22117189f8f.31.1777964169485;
        Mon, 04 May 2026 23:56:09 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb (212-8-243-115.hosted-by-worldstream.net. [212.8.243.115])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45055960902sm2210997f8f.28.2026.05.04.23.56.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 23:56:08 -0700 (PDT)
Message-ID: <97cbeb922ebc0e5d157ed541bd3c21749bb06bec.camel@redhat.com>
Subject: Re: Question about SCHED_DEADLINE and cgroupv2/cpuset interaction
From: Gabriele Monaco <gmonaco@redhat.com>
To: Tobias Jakobi <tobias.jakobi.lr@gmail.com>, 
	linux-rt-users@vger.kernel.org
Date: Tue, 05 May 2026 08:56:07 +0200
In-Reply-To: <08b8969f-d79d-4c9b-8499-f3180fdd832f@gmail.com>
References: <ceba9f1b-0694-44ec-bdc9-a443d2127102@gmail.com>
	 <d93c4b5e7dfb1ea784d8f0f7851f37f7bee2cacf.camel@redhat.com>
	 <08b8969f-d79d-4c9b-8499-f3180fdd832f@gmail.com>
Autocrypt: addr=gmonaco@redhat.com; prefer-encrypt=mutual;
 keydata=mDMEZuK5YxYJKwYBBAHaRw8BAQdAmJ3dM9Sz6/Hodu33Qrf8QH2bNeNbOikqYtxWFLVm0
 1a0JEdhYnJpZWxlIE1vbmFjbyA8Z21vbmFjb0BrZXJuZWwub3JnPoiZBBMWCgBBFiEEysoR+AuB3R
 Zwp6j270psSVh4TfIFAmjKX2MCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 Q70psSVh4TfIQuAD+JulczTN6l7oJjyroySU55Fbjdvo52xiYYlMjPG7dCTsBAMFI7dSL5zg98I+8
 cXY1J7kyNsY6/dcipqBM4RMaxXsOtCRHYWJyaWVsZSBNb25hY28gPGdtb25hY29AcmVkaGF0LmNvb
 T6InAQTFgoARAIbAwUJBaOagAULCQgHAgIiAgYVCgkICwIEFgIDAQIeBwIXgBYhBMrKEfgLgd0WcK
 eo9u9KbElYeE3yBQJoymCyAhkBAAoJEO9KbElYeE3yjX4BAJ/ETNnlHn8OjZPT77xGmal9kbT1bC1
 7DfrYVISWV2Y1AP9HdAMhWNAvtCtN2S1beYjNybuK6IzWYcFfeOV+OBWRDQ==
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (3.60.1-1.fc44) 
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hello Tobias,

On Mon, 2026-05-04 at 09:53 +0200, Tobias Jakobi wrote:
> Actually I saw this comment during my investigation. But I disregarded=
=20
> it quickly, reasons see below.
>=20
> Anyway, I saw this term "root_domain" being mentioned a few times in the=
=20
> documentation=20
> (https://www.kernel.org/doc/Documentation/scheduler/sched-deadline.rst).=
=20
> But only there. It is not mentioned at all in the rest of the docs. Nor=
=20
> have I found a definition for it. Might as well ask this here, what=20
> exactly is this root_domain supposed to be? Yes, there is this comment=
=20
> for struct root_domain in sched/sched.h, but honestly, without heavy=20
> knowledge about the scheduler codebase this tells me almost nothing... :-=
(

The reason why you need a root cpuset is the same why you cannot simply tas=
kset:
if all your tasks can migrate freely you can use as admission control total
utilisation < number of cpus (kinda, read more in the references if you're
interested), but if some tasks have constraints on what CPUs they can migra=
te
to, that formula is no longer sufficient.

The way this is solved is by splitting scheduling domain into independent
chunks, and a root partition does exactly that: if you give CPU2 to your ro=
ot
partition, no other partition can use CPU2, so you can apply the formula ab=
ove
only on that partition (with a single CPU).

Without setting the partition as root, you're saying all tasks in the cpuse=
t can
only use CPU2, but CPU2 can be used by other cpusets as well, it's impossib=
le to
guarantee anything on your cpuset in this case because you'd need to consid=
er
also the others.

You should be able to find more about cpuset partitions in Documentation/ad=
min-
guide/cgroup-v2.rst

> > In short that's to make the admission control able to give guarantees.
> >=20
> > Setting the partition as root:
> >=20
> > echo root > /sys/fs/cgroup/workload.slice/cpuset.cpus.partition
> > echo root > /sys/fs/cgroup/workload.slice/workload-
> > core2.slice/cpuset.cpus.partition
> >=20
> > Fixes the issue in my case.
> > I don't really know how to specify that in systemd and I'm assuming
> > your version/configuration of systemd was somehow setting workload-
> > slice as root automatically, that's likely why it was working.
> >=20
> > Could you try this on your side?
>=20
> Sure, as I said above I disregarded the comment in syscalls.c after=20
> fiddling with this.
>=20
> So, first of all, when doing nothing on top of what systemd does, then=
=20
> both cpuset.cpus.partition are member. What I did not mention in the=20
> initial mail was that I tried to change the partition type.=20
> Unsuccessfully however.
>=20
> root@cm4-fat:/sys/fs/cgroup/workload.slice# echo root >=20
> cpuset.cpus.partition
> root@cm4-fat:/sys/fs/cgroup/workload.slice# echo root >=20
> workload-core2.slice/cpuset.cpus.partition
> root@cm4-fat:/sys/fs/cgroup/workload.slice# cat cpuset.cpus.partition
> root invalid (partition config conflicts with housekeeping setup)
> root@cm4-fat:/sys/fs/cgroup/workload.slice# cat=20
> workload-core2.slice/cpuset.cpus.partition
> root invalid (Invalid cpu list in cpuset.cpus.exclusive)
> root@cm4-fat:/sys/fs/cgroup/workload.slice# grep . cpuset.*
> cpuset.cpus:2-3
> cpuset.cpus.effective:2-3
> cpuset.cpus.partition:root invalid (partition config conflicts with=20
> housekeeping setup)
> cpuset.mems.effective:0
> root@cm4-fat:/sys/fs/cgroup/workload.slice# cd workload-core2.slice/
> root@cm4-fat:/sys/fs/cgroup/workload.slice/workload-core2.slice# grep .=
=20
> cpuset.*
> cpuset.cpus:2
> cpuset.cpus.effective:2
> cpuset.cpus.partition:root invalid (Invalid cpu list in=20
> cpuset.cpus.exclusive)
> cpuset.mems.effective:0

Here you got other issues though, by making a partition root, you are takin=
g
exclusivity on it's CPUs, so system tasks cannot use those CPUs any longer,
pretty much like when you make them (domain) isolated.
The thing is that unlike isolated CPUs, root domains have load balancing am=
ong
the exclusive CPUs, that fights with the fact 2-3 are also isolated!

Now you have 2 ways how to solve this: as far as I could test, an isolated
partition counts as root, so you could keep your isolcpus and do:

  echo isolated > /sys/fs/cgroup/workload.slice/workload-core2.slice/cpuset=
.cpus.partition

OR you could ditch isolcpus entirely (nohz_full can stay) and use root for =
both,
since the workload domains are exclusive, this shouldn't really make a
difference.

> I then remembered reading something in the systemd documentation about=
=20
> cgroup delegation and that changing anything cgroup related right under=
=20
> systemd's nose was asking for trouble. I guess this is what "partition=
=20
> config conflicts with housekeeping setup" is supposed to tell me here?

I don't think systemd is to blame here (it seems not to care about partitio=
n
types at all). But since it doesn't seem to support those it may be a good =
idea
to find alternatives (e.g. plain cgroup).

> After I wasn't getting anywhere here I focused on the bandwidth check.=
=20
> And since the whole thing worked after disabling the check, I=20
> disregarded the root_domain/partition idea.

Of course also disabling the bandwidth check (like you did initially) works=
, but
you don't really want that.

> But I guess the real cause is the root_domain then?
>=20
> With best wishes,
> Tobias

I hope I didn't make it more confusing than it actually is!

Gabriele

