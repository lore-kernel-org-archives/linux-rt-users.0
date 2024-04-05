Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99420174ED2
	for <linux-rt-users@vger.kernel.org>; Fri,  5 Apr 2024 21:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712352157; cv=none; b=V0IsgYOJ6/K+E7fNUVkdHypfQP8/G6y47wd9oRR96aVRrvJLwhiHCSzyaDYXR0rNIl9YPydmX0tg6ZW/v6+W+ZEkLxFafkseQ7gieogf/cYDGdWvMKMmScM0pfTgj50k8PcjYKli54frQbb8VzG2LgrdMShdtJXdmLzZmWN9F94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712352157; c=relaxed/simple;
	bh=oTmqp/FgWdzN2qaEVQYUTkOu9+kg7eLD0lUCr1wSHcE=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=jBqZkXOpJuqklkwR1fKjmuzcLQisr73aOBRNf/FJkk+JjpPeU+OOLCW0D54xtiDpLOHMrtdl1+KTnSx59EZN0q9mqcw/QvVtPLey4Ksfq3SkAJ/0xrMYhRjufvKAgqBTwXTDwiYqDEkVVInsPFq0Qyg4LMGNw7lJGUBcAJQdlL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JtpH+SX9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JtpH+SX9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712352154;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/U6nzb9Z/1dELb7qNDPvzXcd+dZi0wmk99jQhBOv3E8=;
	b=JtpH+SX9iS8O/k6qSmRousCGB6SRfuE2s95Go86Ws6NWhVEyI92bR4d0ZzqHsFQ4ZOBlor
	zc4vqefzbz7MBHRa+S0YkN1yJPue+LnYxU8d+aVwhLofODUyMc0uOOoSOxc9AbZXhvB9fI
	Q8tyQFr9gEoQhQk6Kg5pdvP6ZuvJ0Ps=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-404-WlGk_vuYNpayAEO4dIe0jw-1; Fri, 05 Apr 2024 17:22:33 -0400
X-MC-Unique: WlGk_vuYNpayAEO4dIe0jw-1
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-3c5df537123so339413b6e.3
        for <linux-rt-users@vger.kernel.org>; Fri, 05 Apr 2024 14:22:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712352152; x=1712956952;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/U6nzb9Z/1dELb7qNDPvzXcd+dZi0wmk99jQhBOv3E8=;
        b=p2oQHEXs07IATD3v1i85S7PAyAJaIj5YgvK95V15f7Q2/J05JepHKVWkMZQHqxW7sn
         8dH1O1oF/cL2cR6p/UAgWTy/2kxBT+ZDA/fgMxd1cSlRlriufWcdjcpjYSXoypAmbfss
         LYYR1VQKmmmU/3wb75jKisZ2jE2KJKkrX77rKOEqLF1jPm5sDBYeSaMMi82SAIENWdvI
         ft52B8ESXSUuWFofET4N0J//6i9F7tns6PAxeoxQ5wcybaL7DbK7VCoeddHHcDhCcy6+
         MS2O+VzyTHdqofaqJjtt32qK5Hky815MQphLkrghctL2SXb2ndHevSmzzM22b/mBeLnA
         0oRg==
X-Forwarded-Encrypted: i=1; AJvYcCVtSgluargm4euUWhJNIAUDpodtfb0LLyJRqaHz7Lkx3APWpWOcxiW3rT9wfOV0KaaEDABFZhJBP+a0OAchpcmYQI+ZI0S1V214974H4kU=
X-Gm-Message-State: AOJu0YzNkGxuQmmdXKzsTqihe6brYCM5KJQRzl2CjlCFvtsiZGaDvhQZ
	VLNwmtDW+zG8Dx0Gm/JZFocGpWg6O1+TRxt428FOW6yuJrtqievDeMqOhnGpZHuMA9UihfsR/85
	m9PiH5mzG7iM4rAMtpphr+/lC5a8wCYcTt/qwdJ/jobWDtCcuSetA68WTpqZqFIfT
X-Received: by 2002:a05:6808:209f:b0:3c3:f6d6:1c1f with SMTP id s31-20020a056808209f00b003c3f6d61c1fmr3484112oiw.3.1712352152362;
        Fri, 05 Apr 2024 14:22:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGL+cRUQ0QsewcBCpGtxOQ8u2ZWT39W9N0FlWkgaXzOrWEk3sTDvnhPs6wL+8i5c98q43mubQ==
X-Received: by 2002:a05:6808:209f:b0:3c3:f6d6:1c1f with SMTP id s31-20020a056808209f00b003c3f6d61c1fmr3484099oiw.3.1712352152118;
        Fri, 05 Apr 2024 14:22:32 -0700 (PDT)
Received: from fionn ([184.147.142.166])
        by smtp.gmail.com with ESMTPSA id cp4-20020a05622a420400b0043167d8c57dsm1110122qtb.56.2024.04.05.14.22.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Apr 2024 14:22:31 -0700 (PDT)
Date: Fri, 5 Apr 2024 17:22:22 -0400 (EDT)
From: John Kacur <jkacur@redhat.com>
To: Nam Cao <namcao@linutronix.de>
cc: Clark Williams <williams@redhat.com>, linux-rt-users@vger.kernel.org
Subject: Re: [PATCH] rt-tests: hackbench: drop incorrect and unnecessary
 usage of optind
In-Reply-To: <20240402174659.202695-1-namcao@linutronix.de>
Message-ID: <727bda74-8540-1463-9afc-14f3f881fc74@redhat.com>
References: <20240402174659.202695-1-namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII



On Tue, 2 Apr 2024, Nam Cao wrote:

> Variable "optind" is used as the last argument of getopt_long(). This
> means it "is set to the index of the long option relative to longopts"
> (from man page). NULL check is then performed on argv[optind], which is
> not valid, because in this case, optind is not an index to argv[].
> 
> There is another "optind" which is a global variable, which actually
> holds the index to argv[]. This is likely the actual intention here. By
> locally define another "optind", the "real optind" is shadowed in this
> scope.
> 
> Furthermore, the original optind "is the index of the next element to
> be processed in argv" (from man page), not the index to the current
> element. So doing NULL-check on argv[optind] with the "original optind"
> is also not valid.
> 
> There is no reason to do this NULL-check, since argv[optind] is not even
> read. Only optarg is read, which is never a NULL pointer in this case.
> 
> Delete this incorrect and unnecessary "optind".
> 
> Signed-off-by: Nam Cao <namcao@linutronix.de>
> ---
>  src/hackbench/hackbench.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
> 
> diff --git a/src/hackbench/hackbench.c b/src/hackbench/hackbench.c
> index 4430db0..d4924b3 100644
> --- a/src/hackbench/hackbench.c
> +++ b/src/hackbench/hackbench.c
> @@ -405,8 +405,6 @@ static unsigned int group(childinfo_t *child,
>  static void process_options(int argc, char *argv[])
>  {
>  	for(;;) {
> -		int optind = 0;
> -
>  		static struct option longopts[] = {
>  			{"fds",		required_argument,	NULL, 'f'},
>  			{"fifo",	no_argument,		NULL, 'F'},
> @@ -422,13 +420,13 @@ static void process_options(int argc, char *argv[])
>  		};
>  
>  		int c = getopt_long(argc, argv, "f:Fg:hl:pis:TP",
> -				    longopts, &optind);
> +				    longopts, NULL);
>  		if (c == -1) {
>  			break;
>  		}
>  		switch (c) {
>  		case 'f':
> -			if (!(argv[optind] && (num_fds = atoi(optarg)) > 0)) {
> +			if ((num_fds = atoi(optarg)) <= 0) {
>  				fprintf(stderr, "%s: --fds|-f requires an integer > 0\n", argv[0]);
>  				print_usage_exit(1);
>  			}
> @@ -437,7 +435,7 @@ static void process_options(int argc, char *argv[])
>  			fifo = 1;
>  			break;
>  		case 'g':
> -			if (!(argv[optind] && (num_groups = atoi(optarg)) > 0)) {
> +			if ((num_groups = atoi(optarg)) <= 0) {
>  				fprintf(stderr, "%s: --groups|-g requires an integer > 0\n", argv[0]);
>  				print_usage_exit(1);
>  			}
> @@ -446,7 +444,7 @@ static void process_options(int argc, char *argv[])
>  			print_usage_exit(0);
>  			break;
>  		case 'l':
> -			if (!(argv[optind] && (loops = atoi(optarg)) > 0)) {
> +			if ((loops = atoi(optarg)) <= 0) {
>  				fprintf(stderr, "%s: --loops|-l requires an integer > 0\n", argv[0]);
>  				print_usage_exit(1);
>  			}
> -- 


Signed-off-by: John Kacur <jkacur@redhat.com>

