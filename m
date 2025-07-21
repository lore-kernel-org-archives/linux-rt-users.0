Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B29B6A95C
	for <linux-rt-users@vger.kernel.org>; Mon, 21 Jul 2025 19:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753125005; cv=none; b=kEJu2A1rCmXYdM8HPfeItkr07Mm6/tqjSk4Pyi4E72+ZCUWlaQBL3ItnXkMXP6EfMBhzzts+uLVTZv17/nbO9LGK6XYCA7OrbghpZ5h6Baxu1V5O5CyhoGpJkfYStCaamGWa/RVNZytsWgUDjiRlSOCOdk+iF4X/jvLugngB+k8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753125005; c=relaxed/simple;
	bh=1rR1AyUg2Yye/KiZEviIX47h1W1O5Je/PDeIZ1sMeys=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=E8Hw3X303CGUZSMNkrzxThvsKJYlGTAnjjNz+md9qwyatTV726rtKrihOIOKN5QmaqH0EqAnhmdlfTJaYPdJpNUx4WVsd7uEa1arKdjjVpbH2VwcpHjtvc0hepZer2ctW36f8bDqr4xWwHus2c5u4X81zJBmeuy0pY0w+kC45iQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WNZIcYUw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WNZIcYUw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753125002;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WC9PDgKKznuZtp5e1tMN++GJtgYalAnWlSOnFx5oHwc=;
	b=WNZIcYUwKUftcXGnrUUouixfmENiqUXFdEDOADxQzz1LZ0jRy8Anm878QeAEkSswFRWYML
	WuUZ6ntR9amadcNd5DUIC96h7O0jaWxx3tntnA9tj8djo7xcfDvQ1S2MDKd7/nyei1uhcs
	sF65h5auFoU6GBNhoAhGYsgXkX5AoQg=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-655-TrGEyZEUMCmbI5aeyFwSPA-1; Mon, 21 Jul 2025 15:10:00 -0400
X-MC-Unique: TrGEyZEUMCmbI5aeyFwSPA-1
X-Mimecast-MFC-AGG-ID: TrGEyZEUMCmbI5aeyFwSPA_1753125000
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7e4ca52aedaso118109785a.1
        for <linux-rt-users@vger.kernel.org>; Mon, 21 Jul 2025 12:10:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753125000; x=1753729800;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WC9PDgKKznuZtp5e1tMN++GJtgYalAnWlSOnFx5oHwc=;
        b=W//pEa6jfIXMvhEccibJVDuGWZbz2V5TkoMYkv3QF1RiyGh/LOfIkgcW/xO1kcdoyz
         mdStKe1Mj1F44TJV6YBsKF4HRb3HWMMaB8O4JCyByKP35pEMXZsn5NYpzECBvBmjc6d8
         W/zrnUcACqqUsPznr/VqwHu9zban3TczGmiiDNaRFByaw6fvtFUKMCxxSpAHZyeKEhjw
         vUesBxDbfe/X+5xUkr/e2DHis0tVTX2pyFsuh+KOHVUvGwEz0Nlolh0558GsrFO0S89y
         2hEPPpB83kK2p/6AeL4OVi13+/HyCMaDhnR1JthrZ9mj3DNZWlvao1uc3yucWEIp2Cdk
         OWzg==
X-Gm-Message-State: AOJu0YxbkxyJh4dccX4fxABvhzCQNoKa3HIxHmXeA16qOi0qUmGGnop+
	kzTv2XkrAoWw0yM+olLO7STlGAXuBKdm/WWGs0b4mlIScKylgnUgd7C4ypAlNMSRx7c0JMDUTH3
	N9lJO0tWKCMjQpvlfLs+TUFd6epVTpBjByTMlmTz1NyArB9sOxuqNe4YzttLzxtgxBGHLKpJE5N
	K5
X-Gm-Gg: ASbGncvFZnxymlD6NrkJN2ZFhFs09feMMfPBG+7L8uEMbvkM+xbf0zYtfaX7Ew99a/G
	QcktDnqugInef7F4dIi1dE4Hgky50K0j5kuYLPZEMmPYLQ83rtbSYF58y03ksyfyC/QckFmI2wh
	hoyhFgyBEzqqV46wOQ5vXL6oImgfkLvIyfGeMH8GMx4Fof7HNOGArTbbirT1hg0hH2Jk0twUCIX
	37rOF+73cnXWMkmCdyY6z5gGnVebsgfhYGNMLrVVsk2Tmit5O5RtZhViC19CB3YPfz30JyoMbYv
	0K0w3lYAkZVntlKc9y+ZVtPeQmaKQQ==
X-Received: by 2002:a05:620a:c55:b0:7e1:38c7:d073 with SMTP id af79cd13be357-7e342ab1761mr3163748485a.14.1753124999871;
        Mon, 21 Jul 2025 12:09:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHHy/yHZnrHoy7s+n63XrjSV/yEq/pJ6VmsVO8u8xOmNig839NhAOpZpbYzMhHXpubHtL6pjw==
X-Received: by 2002:a05:620a:c55:b0:7e1:38c7:d073 with SMTP id af79cd13be357-7e342ab1761mr3163742685a.14.1753124999255;
        Mon, 21 Jul 2025 12:09:59 -0700 (PDT)
Received: from fionn ([142.189.102.151])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e356c40b33sm441873585a.63.2025.07.21.12.09.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 12:09:58 -0700 (PDT)
Date: Mon, 21 Jul 2025 15:09:57 -0400 (EDT)
From: John Kacur <jkacur@redhat.com>
To: "Ahmed S. Darwish" <darwi@linutronix.de>
cc: linux-rt-users@vger.kernel.org
Subject: Re: [PATCH v1 07/28] cyclictest.8: Remove left-over comments
In-Reply-To: <20250704132721.13325-8-darwi@linutronix.de>
Message-ID: <d87f38ff-2d60-8658-8b49-76929a54de4c@redhat.com>
References: <20250704132721.13325-1-darwi@linutronix.de> <20250704132721.13325-8-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII



On Fri, 4 Jul 2025, Ahmed S. Darwish wrote:

> Simplify the cyclictest manpage source by removing all obsolete comments.
> 
> Per commit 79ad2eca9abe ("COPYING file and cyclictest's man page added"),
> most of such comments are random leftovers from the original template the
> cyclictest's manpage was based on.  Namely:
> 
> (a) Remove emacs markers; modern emacsen do not need them.
> 
> (b) Remove the roff macros description table; they're all already
>     documented at man(7).
> 
> (c) Reference groff_man_style(7).  Per man(7): "man page authors and
>     maintainers who are not already experienced groff users should
>     consult groff_man_style(7)."
> 
> (d) Remove legacy, commented-out, earlier cyclictest descriptions.
> 
> (e) Remove a reference to info pages; cyclictest does not have any.
> 
> (f) Remove an obscure joke about the manpage being written by "The Rise
>     and Fall of a Fooish Bar."
> 
> With this, further documentation cleanups will be easily stacked on top.
> 
> Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
> ---
>  src/cyclictest/cyclictest.8 | 25 +------------------------
>  1 file changed, 1 insertion(+), 24 deletions(-)
> 
> diff --git a/src/cyclictest/cyclictest.8 b/src/cyclictest/cyclictest.8
> index 803c5fd..d4ce648 100644
> --- a/src/cyclictest/cyclictest.8
> +++ b/src/cyclictest/cyclictest.8
> @@ -1,18 +1,6 @@
>  .\" SPDX-License-Identifier: GPL-2.0-only
> -.\"                                      Hey, EMACS: -*- nroff -*-
> +.\" For a man pages tutorial, check groff_man_style(7)
>  .TH CYCLICTEST 8 "April 22, 2016"
> -.\" Please adjust this date whenever revising the manpage.
> -.\"
> -.\" Some roff macros, for reference:
> -.\" .nh        disable hyphenation
> -.\" .hy        enable hyphenation
> -.\" .ad l      left justify
> -.\" .ad b      justify to both left and right margins
> -.\" .nf        disable filling
> -.\" .fi        enable filling
> -.\" .br        insert line break
> -.\" .sp <n>    insert n+1 empty lines
> -.\" for manpage-specific macros, see man(7)
>  .SH NAME
>  cyclictest \- High resolution test program
>  .SH SYNOPSIS
> @@ -21,18 +9,11 @@ cyclictest \- High resolution test program
>  [\-h " histogram " ] [\-i " intv " ] [\-\-json " filename " ] [\-l " loop " ] [\-o " red " ] \
>  [\-p " prio " ] [\-t " num " ] [\-D " time " ]"
>  
> -.\" .SH DESCRIPTION
> -.\" This manual page documents briefly the
> -.\" .B cyclictest commands.
> -.\" .PP
> -.\" \fI<whatever>\fP escape sequences to invode bold face and italics, respectively.
> -.\" \fBcyclictest\fP is a program that...
>  .SH OPTIONS
>  These programs follow the usual GNU command line syntax, with long
>  options starting with two dashes ('\-\-').
>  .br
>  A summary of options is included below.
> -.\" For a complete description, see the Info files.
>  .TP
>  .B \-a, \-\-affinity[=PROC-SET]
>  Run threads on the set of processors given by PROC-SET.  If PROC-SET is not
> @@ -184,10 +165,6 @@ Use POSIX timers instead of clock_nanosleep.
>  .SH SEE ALSO
>  .BR numa (3),
>  .BR numactl (8),
> -.\" .br
> -.\" The programs are documented fully by
> -.\" .IR "The Rise and Fall of a Fooish Bar" ,
> -.\" available via the Info system.
>  .SH AUTHOR
>  cyclictest was written by Thomas Gleixner <tglx@linuxtronix.de>.
>  .PP
> -- 
> 2.49.0
> 
> 
> 
Signed-off-by: John Kacur <jkacur@redhat.com>

