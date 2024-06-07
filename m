Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8355D2E5
	for <linux-rt-users@vger.kernel.org>; Fri,  7 Jun 2024 19:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717787383; cv=none; b=XWpltLq+edAqjKWk2nSbRmkm2eJde66iuQjd7PaapEyTaG7Bx+hfORfNlgAmTFCMtEiqnM++62J2Z8w6ZeVAkRlCfTJkuxc6kblWVSpUFFjK4AHQ9bDUM9Lv+IzOXeMeGGtrUSN++cJzfRK4qMcTWrP+hfH6MX4eA/ar6wJLr0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717787383; c=relaxed/simple;
	bh=ghEKtF8byRrTUD9c0nSZO/S20V7L4XrpzVDvi4Tg/+I=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=aQPdr+tsuy01G9LB/gvoAdYiYGIfpncuQrfwhpq1bpR+ZBz2dhc2nvevIY2nxTKUpDrUkM8PbGrN5ZHYAb08XYstmziJqv1w9Mvozv+iVQNIkiiGjp/kSSlV8qdPuKAQh7j8ozaCYCNqBvuElXj6taDtf2Ck50pvpSeMj1m2bRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SmflNP+g; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SmflNP+g"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717787380;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=b+GknDFEeoDLm/gYxuuAJ4DtzLSb+uqGMXMdE+Tk+mM=;
	b=SmflNP+gNJgPyPrEL5vOmjHgRONXxYqYSjnu/Uvj2wbkfM4Ae0ZVETfVL9zBFaXrne4gz4
	RRgHMC6y3tORjMJD0dMmt1iW3Km+HPDVYfqYzcIoS8+eKB4gmiz5h98zWHppcqHqf2Qu31
	RCUJSqAwx1X6GC7djI+FwNA+BAukPgs=
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com
 [209.85.160.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-166-UxGT0fZZPcmWOxfpO9w0yQ-1; Fri, 07 Jun 2024 15:09:37 -0400
X-MC-Unique: UxGT0fZZPcmWOxfpO9w0yQ-1
Received: by mail-oa1-f69.google.com with SMTP id 586e51a60fabf-24ff8b75085so2397679fac.2
        for <linux-rt-users@vger.kernel.org>; Fri, 07 Jun 2024 12:09:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717787377; x=1718392177;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b+GknDFEeoDLm/gYxuuAJ4DtzLSb+uqGMXMdE+Tk+mM=;
        b=tvdOFOgF6GMRB46Xulrf4I9jnkYMwEPPPqYUC2yDT1/wKidkjqKAkoOGEUprB2sNab
         fuGc6c7iBY1Oa2Mw12iHkFORCSn+vMmJIOEyPwXuUYhprXoENw3ORWy5rV7L4tgoCVZL
         PlaDedkbb16zfPpUsUz7aFNK+ny26ZC6JTUu9iVSsQYR4pEdDgTbuT2jonDqTHkZmlGy
         DPokhhWy3i3+ojwj+8xkcitvjUaGzWCYApFO/LnKh0/4vVMbEOXB23hAwIdyW6VFnp0W
         7XL4AeClphDISsj0FwDqKVNDRDTif7ZQrjPaM0DWdTiLk15Ud2i3mDi/OukNCYIy8XZJ
         LcDw==
X-Gm-Message-State: AOJu0Yw2IJ+PAznIXhxs8/56HSv+Ab0gdYfp5rXt4blmROyXOqopaGl1
	99Z+gDmScrfJIPyY7ZDIs6Fihs0xkhfacDiBqWevEils+yshglxegprWQJ5UWoCmOOdhJX/AbrW
	lwXkasTQUVRPIGKKVaLc5tMoGNyS80DvVuHDR6K34iJcIx4Dfim0AQu5T7x5vLPhf
X-Received: by 2002:a05:6870:96a0:b0:254:7661:befe with SMTP id 586e51a60fabf-25476629f08mr2245507fac.43.1717787376810;
        Fri, 07 Jun 2024 12:09:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IElKUdlSUihrBnAJpSds/FBuGi2HPftY/8L8cMmbEgrD5K5yybPUUhQmU+H7dZBUrjuhKz20Q==
X-Received: by 2002:a05:6870:96a0:b0:254:7661:befe with SMTP id 586e51a60fabf-25476629f08mr2245119fac.43.1717787368586;
        Fri, 07 Jun 2024 12:09:28 -0700 (PDT)
Received: from fionn ([74.12.5.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79532813a67sm195377885a.9.2024.06.07.12.09.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 12:09:28 -0700 (PDT)
Date: Fri, 7 Jun 2024 15:09:17 -0400 (EDT)
From: John Kacur <jkacur@redhat.com>
To: Anubhav Shelat <ashelat@redhat.com>
cc: linux-rt-users@vger.kernel.org, kcarcia@redhat.com
Subject: Re: [PATCH] Updated rteval man page
In-Reply-To: <20240605182454.96479-1-ashelat@redhat.com>
Message-ID: <0f639404-41b3-b760-3607-2b02f8d1cf29@redhat.com>
References: <20240605182454.96479-1-ashelat@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII



On Wed, 5 Jun 2024, Anubhav Shelat wrote:

> The rteval man page should reflect the functionality of the
> current iteration of rteval. Currently the rteval man page
> reflects the functionality of an outdated version. This patch
> removes deprecated options and adds options that have been
> added in recent updates.
> 
> Signed-off-by: Anubhav Shelat <ashelat@redhat.com>
> ---
>  doc/rteval.8 | 50 +++++++++++++++++++++++++++++++++-----------------
>  1 file changed, 33 insertions(+), 17 deletions(-)
> 
> diff --git a/doc/rteval.8 b/doc/rteval.8
> index 578de370effa..264bf5207716 100644
> --- a/doc/rteval.8
> +++ b/doc/rteval.8
> @@ -63,6 +63,9 @@ for example to execute a ten minute run of rteval:
>  .B \-v, \-\-verbose
>  Increase the verbosity of output during the test run
>  .TP
> +.B \-q, \-\-quiet
> +Set rteval to run in quiet mode.
> +.TP
>  .B \-w WORKDIR, \-\-workdir=WORKDIR
>  Tell rteval to change directory to WORKDIR before creating any
>  subdirectories for report files. The default WORKDIR is the directory
> @@ -71,11 +74,8 @@ in which rteval was started.
>  .B \-l LOADDIR, \-\-loaddir=LOADDIR
>  Tell rteval where to find the source for the loads
>  .TP
> -.B \-\-loads\-cpulist=CPULIST
> -List of CPUs where loads will run
> -.TP
> -.B \-\-measurement-cpulist=CPULIST
> -List of CPUs where measurement applciation will run
> +.B \-i INSTALLDIR, \-\-installdir=INSTALLDIR
> +Tell rteval where to locate installed templates.
>  .TP
>  .B \-s, \-\-sysreport
>  Have rteval run the sysreport utility after a run to gather
> @@ -103,11 +103,25 @@ Log the output of the loads in the report directory
>  .B \-O, \-\-onlyload
>  Only run the loads (don't run measurement threads)
>  .TP
> +.B \-V, \-\-version 
> +Print rteval version and exit.
> +.TP
>  .B \-S KERNEL_VERSION, \-\-source\-download=KERNEL_VERSION
>  download a source kernel from kernel.org and exit
>  
> +.SH GROUP OPTIONS
> +.TP
> +.B \-\-loads\-cpulist=CPULIST
> +List of CPUs where loads will run
> +.TP
> +.B \-\-measurement-cpulist=CPULIST
> +List of CPUs where measurement applciation will run
> +.TP
> +.B \-\-measurement-run-on-isolcpus
> +Include isolated CPUs in default cpulist
> +
>  
> -.SH MODULE OPTIONS
> +.SH CYCLICTEST OPTIONS
>  These are options that affect the execution behavior of the measurement and load modules.
>  .TP
>  .B \-\-cyclictest-priority=PRIORITY
> @@ -116,21 +130,23 @@ SCHED_FIFO priority for measurement threads (default: 95)
>  .B \-\-cyclictest-interval=INTERVAL
>  Measurement thread interval in microseconds (default: 100)
>  .TP
> -.B \-\-cyclictest-distance=DISTANCE
> -Interval increment in microseconds (default: 0)
> -.TP
>  .B \-\-cyclictest-buckets=NBUCKETS
>  Number of 1 microsecond histogram buckets (default: 3500)
>  .TP
> -.B \-\-hackbench-jobspercore=N
> -Number of jobs per online-core for hackbench load
> +.B \-\-cyclictest-breaktrace=USEC
> +Send a break trace command if latency exceeds the given number of microseconds.
> +.TP
> +.B \-\-cyclictest-threshold=USEC
> +Exit rteval if latency exceeds the given number of microseconds.
> +.TP
> +.B \-\-stressng-option=OPTION
> +Pass in command line options for the stress-ng package.
> +.TP
> +.B \-\-stressng-arg=ARG
> +Pass in command line arguments for the stress-ng package.
>  .TP
> -.B \-\-kcompile-jobspercore=N
> -Number of jobs per online-core for kernel compile load
> -.\" .SH SEE ALSO
> -.\" .BR bar (1),
> -.\" .BR baz (1).
> -.\" .br
> +.B \-\-stressng-timeout=T 
> +Timeout after T seconds.
>  
>  .SH FILES
>  .BR rteval-YYYYMMDD-S
> -- 
    - Changed spelling from "applciation" to "application"
    - Removed some white space at the end of two lines
    Signed-off-by: John Kacur <jkacur@redhat.com>

