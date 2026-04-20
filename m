Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBFE23AD530
	for <linux-rt-users@vger.kernel.org>; Mon, 20 Apr 2026 21:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776721353; cv=none; b=pQETtT92SW8/dAKSvHA52IfBglwXh45VZBKa4Letoul2AX727adyfiHT1eKjfcJGU0KLOZjmdGrZJy6tnhaM9s3W3Nw4oE5ld1HN/g1I+h4aGpRkp0Qm2K+anl2pgsBfbINlUyHfEeRthZo5jcN0faWKJQASYeZRLJ8Kht/QAHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776721353; c=relaxed/simple;
	bh=RjOturwAtDBk9t+zueIeB6QclwFH+XEI0t3QYd14tNU=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=MCY+lKVqyHqG9cu0PTjbxqu7N1+UP2a/T/Cd1qDpjKFwQdnTQY7KMB9SonEfjDE0uA+Z5YUDuExcadE1BWV2s3Hx3xqfbAdRAYiKsTVNcIXToayiC/W5DH/A1ZYAvFEkQ8pWL4O1EOsVThylGp4SknkeYhKJiR0M48X4vJng1KQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W0ceDSv3; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W0ceDSv3"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-8c9f6b78ca4so436343785a.0
        for <linux-rt-users@vger.kernel.org>; Mon, 20 Apr 2026 14:42:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776721351; x=1777326151; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=2htfd8XNXV5BIDvjD90OydblodLnrDqV+exxv7VxPDU=;
        b=W0ceDSv3AvXFfd5dTDY/zejHrK9Tx0aI5Py7NKg6QqSGk/BBBzL9Zq88yWM63JQc1S
         KRybKpc4LDrsHpSOTo/eXgKzt0X3Ne/WjdRKKdRwTVcj3m2hQeCQIKRSBnewxC0LYBuu
         0q+KEd193JnZ/YEiU4B/mmqdCDEvjX7jzasTCe93YpwI5ALATsYBG4w2QTWFtXfAcm67
         Tp7itPxC3QWn1lSUCm2MzM5QIPuHT+o9F98ynY/WNk8FzLmTAdaoU2rrAc95Gk/WCx11
         cBrERwi8ljiRvYP+3FNL8nx4R1vaxusQ3F+zpXCHDdy2YYZNTKHacyZQ/AezK1Gj20I3
         nnTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776721351; x=1777326151;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2htfd8XNXV5BIDvjD90OydblodLnrDqV+exxv7VxPDU=;
        b=Vp1B407KYh69U+QJfk5cbYkDn3HQhazkp3GIaAV4CdfpHPJJbo/mQ/ykHLfHkfyTQT
         45+nu8ad16Djq+egfUNyEZMQLtbZnjdLt2dh8WVgVeHDUVoVOHZR4btJ7Z39hpEXT8Bq
         +aCFMilD+eWv6D5ggvGbhzOg9z3GM1seu1pjeTmAvv30jKbxZmBSGmImff7ElYOWJpNk
         Hbu8Z8aZsRbc1MFdqgzaR7dqqksQBzZh3llW6fvveFUur7SxrGqQAUdDhYAUhCCa/dZ9
         A5wXm//XEXnKvsyAynRHaiS4aB9J8zqo6u62nYfZxzNvgA6RnQOKhKIqlYMIu4+oJh+q
         UmSw==
X-Forwarded-Encrypted: i=1; AFNElJ9uc3QOeJ3IosKMeBxedQNOwewWvsWLkGGfjPGCouF080pKeb5qbClQzKw6UKwETUn8wAkEKRcNFSLTy9DNnA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzAvMErYudeDI7fHLX1C8QHALHP0xWUnCBOcfx1oLiHaSvkKfZ2
	ylEHIKT0BTj+9BUs+U6MAIE4ZdwslHUy25Ru9G2m1E1IDKVUy8OJGCfF
X-Gm-Gg: AeBDiet6C8GS5cUoolq5ilZ9WUmF0+KbnZouUphZj7HFfFXRok/6I2LWZtY0JgjJg7g
	z2OP/BShHmXBj6vNUlherhaUUGRDN9uzWkrL9FUl6g+ZtMlTi2H4KVRFv/GJ8L0RGU7m/ujChej
	Ij+uXMk0syqSDibnvyOn104Z+uwzl1e8B2YcWR4u8Dp0K8roCXH4PTTR4p93bYyYMpjYk7NzoFH
	Voc6MLfntZt8CtHGMHSOEnoXCdTK7a4GajOw7/zhGG1whqFKrX0d+WIVIPwbfo0wsohnxpZ3Cy4
	mwqZGS9vG7yF/X+sxG5xHN28b6ggWOdO9JjY5pg2mDhGni6ZoYzTvjX8gOdtPHBWD+OB8MhNZdB
	PiAO6nrbMhJdXeP/DP5vReXeIql9ae9E8VcvXGLCGzDITj7uzbvvMYKzmA9xtctt+f7FDV4Mdt6
	5MeZyEyMzyF+XOP9gkI25zarvy2J1GPF8asj6voE3AT09Lmm2YYNJCWVc6qMc0N0pBNK8tAGLI3
	rNhFS54OkTuCg==
X-Received: by 2002:a05:620a:1721:b0:8d9:e4d:47ad with SMTP id af79cd13be357-8e78fd1f801mr2231794085a.19.1776721350781;
        Mon, 20 Apr 2026 14:42:30 -0700 (PDT)
Received: from Cumhall ([216.209.112.32])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8eb19632130sm408042885a.41.2026.04.20.14.42.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 14:42:30 -0700 (PDT)
Date: Mon, 20 Apr 2026 17:42:18 -0400 (EDT)
From: John Kacur <jkacur@gmail.com>
To: Tomas Glozar <tglozar@redhat.com>
cc: John Kacur <jkacur@redhat.com>, linux-rt-users@vger.kernel.org, 
    Clark Williams <williams@redhat.com>
Subject: Re: [PATCH 6/6] rteval: Add --housekeeping option to reserve isolated
 CPUs
In-Reply-To: <CAP4=nvQLbPBhQva-fBqeC1_ApGDYmNG7tSzuBNxMFg-EiFp7ag@mail.gmail.com>
Message-ID: <5d7d7ca2-514e-4d1f-7440-4333d415bcad@gmail.com>
References: <20260417195113.177799-1-jkacur@redhat.com> <20260417195113.177799-7-jkacur@redhat.com> <CAP4=nvQLbPBhQva-fBqeC1_ApGDYmNG7tSzuBNxMFg-EiFp7ag@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="-1463749118-780743615-1776721350=:220518"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463749118-780743615-1776721350=:220518
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Mon, 20 Apr 2026, Tomas Glozar wrote:

> pá 17. 4. 2026 v 21:51 odesílatel John Kacur <jkacur@redhat.com> napsal:
> >
> > Add a new --housekeeping option that allows users to specify isolated CPUs
> > that should be reserved for system housekeeping tasks and not used by
> > rteval's measurement or load modules.
> >
> > Key features:
> > - Validates that housekeeping CPUs are in the isolated CPU list (isolcpus)
> > - Detects conflicts with explicitly specified --measurement-cpulist or
> >   --loads-cpulist options and exits with a clear error message
> > - Filters housekeeping CPUs from both measurement and load CPU lists
> > - Correctly excludes housekeeping CPUs from inverted CPU lists when only
> >   one of measurement/loads is specified
> >
> > Example usage:
> >   rteval --housekeeping 0-3 --measurement-run-on-isolcpus
> >     Reserves isolcpus 0-3 for system tasks, runs measurements on
> >     remaining isolated CPUs (4+) plus non-isolated CPUs
> >
> > Implementation:
> > - systopology.py: Add validate_housekeeping_cpus() function to validate
> >   that housekeeping CPUs are in isolcpus
> > - rteval-cmd: Add --housekeeping argument, conflict checking, filtering,
> >   and fix inversion logic to exclude housekeeping CPUs
> >
> 
> This might be a good opportunity to additionally pin the rteval
> process to the housekeeping CPUs, as well as pass them to rtla's -H
> option.
> 
> Tomas

  You raise good points. Currently, housekeeping CPUs are for system tasks
  like kernel threads, IRQs, etc., and the --housekeeping flag tells 
rteval
  not to touch these CPUs. For example, you might have CPUs 0-7 isolated,
  and use 0-1 for housekeeping, and 2-7 for measurement threads which are
  already pinned in rteval with sched_affinity.

  However, we currently don't:
  1. Pin the rteval process itself to housekeeping CPUs
  2. Pass them to timerlat's -H option

  These would be useful enhancements to improve isolation further. I'll 
  consider adding them in a future update.

  Thanks for the suggestions!

John Kacur
---1463749118-780743615-1776721350=:220518--
