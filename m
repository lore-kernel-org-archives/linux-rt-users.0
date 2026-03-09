Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D07BD21507F
	for <linux-rt-users@vger.kernel.org>; Mon,  9 Mar 2026 22:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773096972; cv=none; b=axyAAVdP4QpgXV9tYELyaE57X5p76FtsHC8T7Zbj6aObYD8qFoy82bfBIixNkm9adU+GkRi0i7uFC1+sisln6agWCEYFaekYMHjkqSf7aIOeitT+v4Kzsu2aTGqcJZ+YX1ilyPXafYuQ7r0DGzLGu1fmD5W66sef8BH+iQMG8V4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773096972; c=relaxed/simple;
	bh=XLHAbOmKHY0hiI+w4Xjw2p/p/2GkV7MWKox3iblYwKg=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Vwoo/nKDA6TEfE590QqzxChPH531TBkl+bH0mIsXYohc0DYy4HjXJTS2t7D1Mxeji+/1XuIY20/LB92RGw7PS/hXDmS9Pl9oRm8QKKTd7CTV+87MKlnLd55ED3ryfnr9TvzE7SbVQRab8jt7MAgnppXQCsu4ItNfG+SQUGjOVUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CbtpMG/s; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CbtpMG/s"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-509217e84a3so8429091cf.3
        for <linux-rt-users@vger.kernel.org>; Mon, 09 Mar 2026 15:56:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773096970; x=1773701770; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=FrnlFcK9BmLUB8jSIdfGyua0DXHE6zF5KerwMkRxC/Y=;
        b=CbtpMG/s7iMAeq4Yn73rS7QGhZ/uBjlkq45n0Nkk+cdg9x/t3ZnpHGugrF6DbVDNOv
         eC551lzqqQLFbwGYx418cKoMx3IW0r2DWWvL+hfTywE5xPSiFhmF6rt+2UkexobgBzC7
         u6gEeGs5Sc5DS3ePaaa4sZzwNSYvJV2io+wUp1CkvhY8BN+Bg+uW7CeZxhNqUbSmmwgX
         53ivB8mXXm1ic9cXNj1ns5+Oriza9OA1ni/PVbpNO1pCL+P6WW6t6ZNT42JvoIx5QxXW
         ZYViImvc5HN+7CaBtLkK/SGhEBaZwDSgXLmQdMl4wAW4QdP95K6M0unLDJfzPzc6A9fA
         agVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773096970; x=1773701770;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FrnlFcK9BmLUB8jSIdfGyua0DXHE6zF5KerwMkRxC/Y=;
        b=WH2sB/s+2YIZ6fsVAA8SYeoAYpo1RyFwk9J3pqGhdwgPxTxqwBIE3STiCbFirYb+0D
         wVuRZV4/2PBF5PUYQkYwt/MLebehXZs5uEzNo4MoOACVzO3SvWvtzBN8QuxwWJBbsC8L
         /g8otTtOx03EWtJOoFdCmuq5e2vixTyWyekYVDOq5lB/tvNKF8GLDqgOOL4KkLAnJ3om
         zZ1mnuAI5bydbNNB3FBY667q/ASP/5ebNpMBJILPkt9O/RuadDPXfLphaurnJS5Jms7r
         po2zn+A/HZw6S5VkBqU5W6JoPcpdaq6gng+fa981D3PtnQ2y2Hj8NOBZF17Wlybgf6NH
         ihPw==
X-Forwarded-Encrypted: i=1; AJvYcCXPgBoFNTcTGmUoNvlO43/Ju57PanCwKQhBUOkoJv7qs+n7khXOkzqaO3MfM5A0nBiEffF5za+QDGxoUPrfNg==@vger.kernel.org
X-Gm-Message-State: AOJu0YziHpnBT5LiwhuJpvX47gx5S7GLe0hzX1mF4/DcxSl4/zP8vRLL
	8E++oLfkDDwZaGWXBV8KZCpQpQLQxRPhzdCXB+NbcumgyEUjhLjcPU61NfzOQA==
X-Gm-Gg: ATEYQzyPD2Plh+pxgK+IVTTKniSZVrKR/bXaB4p91qbts9PgfCUiP888rf4QQT2VgB9
	ldqO514J1d3bfTOju3o05x6zYv+NRLizeJd5/xJBGbcwUJoBnghVSPYKTocP5rnxNezfu6Ra0qY
	0UHb3dusIwQD/EFZwAr4zbpFeaVCt1/ADcNKvJb+xKUMOKJ+CZRGseOS60Y/Z4wUO3N5AsSvAQK
	1kfgnPWG8gnKjz+21oTqCZGqY/7VPvrvl7pgogNpn2zdv0XJxddiRn28HjbFpmf6srKsVZqjusM
	0FI1FsISK9b0Y1c2my6raqs0SpJGg1x+OoAdOJcXo3P7PGKy9COQLqbGbXa4kJ1POQASMZriu0N
	luHjpU2aVjmdlQM8CxWfQRmzAphonmWmkIdThCr7LJfrl8+D1OXLToKH1FGuYwxqDXzSjeS3Fuu
	u6a4z4zRUQTMuzOGxyPfiQEq0fwp/fULHFOFyPwcgDxi2IkfkaikoQi5qsbji1iG6VTKN0Tph7J
	Q==
X-Received: by 2002:a05:622a:450:b0:4ff:a40d:d2b2 with SMTP id d75a77b69052e-508f46f10d7mr167298161cf.16.1773096969783;
        Mon, 09 Mar 2026 15:56:09 -0700 (PDT)
Received: from Cumhall ([70.50.116.180])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50924937718sm9748501cf.29.2026.03.09.15.56.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 15:56:08 -0700 (PDT)
Date: Mon, 9 Mar 2026 18:55:56 -0400 (EDT)
From: John Kacur <jkacur@gmail.com>
To: Lukas Beckmann <lbckmnn@mailbox.org>
cc: John Kacur <jkacur@redhat.com>, rt-users <linux-rt-users@vger.kernel.org>
Subject: Re: [PATCH 2/2] cyclictest: simplify rstat_setup
In-Reply-To: <20260301212407.3146506-3-lbckmnn@mailbox.org>
Message-ID: <f504e9c5-95c9-79e4-0274-f639a4829af9@gmail.com>
References: <20260301212407.3146506-1-lbckmnn@mailbox.org> <20260301212407.3146506-3-lbckmnn@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII



On Sun, 1 Mar 2026, Lukas Beckmann wrote:

> The shm file is truncated to zero each time before it is written.
> It does not make sense to truncate it to something non zero on setup or
> to mlock it.
> 
> Signed-off-by: Lukas Beckmann <lbckmnn@mailbox.org>
> ---
>  src/cyclictest/cyclictest.c | 89 ++++++-------------------------------
>  1 file changed, 13 insertions(+), 76 deletions(-)
> 
> diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
> index 960c905..7b959ac 100644
> --- a/src/cyclictest/cyclictest.c
> +++ b/src/cyclictest/cyclictest.c
> @@ -1771,33 +1771,6 @@ static void trigger_update(struct thread_param *par, int diff, int64_t ts)
>  	pthread_mutex_unlock(&trigger_lock);
>  }
>  
> -/* Running status shared memory open */
> -static int rstat_shm_open(void)
> -{
> -	int fd;
> -	pid_t pid;
> -
> -	pid = getpid();
> -
> -	snprintf(shm_name, SHM_BUF_SIZE, "%s%d", "/cyclictest", pid);
> -
> -	errno = 0;
> -	fd = shm_unlink(shm_name);
> -
> -	if ((fd == -1) && (errno != ENOENT)) {
> -		fprintf(stderr, "ERROR: shm_unlink %s\n", strerror(errno));
> -		return fd;
> -	}
> -
> -	errno = 9;
> -	fd = shm_open(shm_name, O_RDWR|O_CREAT|O_EXCL, S_IRUSR|S_IWUSR|S_IRGRP|S_IWGRP|S_IROTH|S_IWOTH);
> -	if (fd == -1)
> -		fprintf(stderr, "ERROR: shm_open %s\n", strerror(errno));
> -
> -	rstat_fd = fd;
> -
> -	return fd;
> -}
>  
>  static int rstat_ftruncate(int fd, off_t len)
>  {
> @@ -1811,62 +1784,26 @@ static int rstat_ftruncate(int fd, off_t len)
>  	return err;
>  }
>  
> -static void *rstat_mmap(int fd)
> -{
> -	void *mptr;
>  
> -	errno = 0;
> -	mptr = mmap(0, _SC_PAGE_SIZE, PROT_READ|PROT_WRITE, MAP_SHARED, fd, 0);
> +static void rstat_setup(void)
> +{
> +	int fd;
> +	pid_t pid;
>  
> -	if (mptr == (void*)-1)
> -		fprintf(stderr, "ERROR: mmap, %s\n", strerror(errno));
> +	pid = getpid();
>  
> -	return mptr;
> -}
> +	snprintf(shm_name, SHM_BUF_SIZE, "%s%d", "/cyclictest", pid);
>  
> -static int rstat_mlock(void *mptr)
> -{
> -	int err;

errno = 0 before the call to shm_unlink for good defensive programming
other than that the patch looks good, I will do a little more testing

> +	fd = shm_unlink(shm_name);
>  
> -	errno = 0;
> -	err = mlock(mptr, _SC_PAGE_SIZE);
> -	if (err == -1)
> -		fprintf(stderr, "ERROR, mlock %s\n", strerror(errno));
> +	if ((fd == -1) && (errno != ENOENT))
> +		fprintf(stderr, "ERROR: shm_unlink %s\n", strerror(errno));
>  
> -	return err;
> -}
> +	fd = shm_open(shm_name, O_RDWR|O_CREAT|O_EXCL, S_IRUSR|S_IWUSR|S_IRGRP|S_IWGRP|S_IROTH|S_IWOTH);
> +	if (fd == -1)
> +		fprintf(stderr, "ERROR: shm_open %s\n", strerror(errno));
>  
> -static void rstat_setup(void)
> -{
> -	int res;
> -	void *mptr = NULL;
> -
> -	int sfd = rstat_shm_open();
> -	if (sfd < 0)
> -		goto rstat_err;
> -
> -	res = rstat_ftruncate(sfd, _SC_PAGE_SIZE);
> -	if (res)
> -		goto rstat_err1;
> -
> -	mptr = rstat_mmap(sfd);
> -	if (mptr == MAP_FAILED)
> -		goto rstat_err1;
> -
> -	res = rstat_mlock(mptr);
> -	if (res)
> -		goto rstat_err2;
> -
> -	return;
> -
> -rstat_err2:
> -	munmap(mptr, _SC_PAGE_SIZE);
> -rstat_err1:
> -	close(sfd);
> -	shm_unlink(shm_name);
> -rstat_err:
> -	rstat_fd = -1;
> -	return;
> +	rstat_fd = fd;
>  }
>  
>  static void write_stats(FILE *f, void *data)
> -- 
> 2.53.0
> 
> 
> 
