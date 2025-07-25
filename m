Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2DE28F6E
	for <linux-rt-users@vger.kernel.org>; Fri, 25 Jul 2025 18:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753467661; cv=none; b=RaWIGksriInPKcm6fWnQWw817tjyT/Y5j9uPvV9ecZvQVtDPEzNuUuw+DqRGVdi8AvgGqwCAvp06bLXq18fcxkCTN+kej7APMsSo2jUQj2pzLaUBgrdVewdd2MnPXewiODD8d35zLKVXl5yk08D4rqp3Zrv68qNDfQZG8zwzvGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753467661; c=relaxed/simple;
	bh=8K/+3BEGBXAw4XdcFFBqVZdkPvBTXdMwrBlAy+Llvw8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eoy9Kj4ruAdizVnpDZvku8a7ONTrBWh9Vnv4LNUYqAxG2nr+Wtx/hG4OUXPqBGg0I/4E6cZJnibtvZXZK53Jtira1wcx/JqBz6ZgMF36xWozJB3bpqYk37zphZ+NFEVa8fAHdqf7Od8hPSJXmFlBbf5vAN+IEIY19hwuvcDbFsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AGRcSxrC; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AGRcSxrC"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7426c44e014so2115721b3a.3
        for <linux-rt-users@vger.kernel.org>; Fri, 25 Jul 2025 11:21:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753467660; x=1754072460; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=h2Au9S0eJ8jtrPFtYeQIyNOSBaF54l9dEPCzCt/X9Go=;
        b=AGRcSxrCmwLzczQw2KwXJJCLMM/ZFmQEmnYfnrkHanW1kFeKeykxy5TgchGqshEfe0
         ssAlPYpBy53OEZAjC059YRk7PxQkJMYBxSoSMWy3mbnUoVXxPEXD3xcfGuYWrfTI4UE1
         RJmkvqyJjnUnE2mJzC/Pd10WpEF6rX6alvvBUjBTdEygajoGqUdwsDB1O7xro2i2lZV8
         zIdlI496n0Rp1oOTclRTvLY7MY8ftnHve83WV/OrDr9u/XXwtMu0gSOm0EC3Tm37ie+T
         6VWvJGDN3KTpIqP5f6ESWJldLn8dMlUyH0aKuCmYO2TbZc2nIW2PxkdK6xQVShfnWDy7
         mGHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753467660; x=1754072460;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h2Au9S0eJ8jtrPFtYeQIyNOSBaF54l9dEPCzCt/X9Go=;
        b=sj+blkvCsyJ5Ff3FXD2/c3VnM016TUixMb8n6ArzYuILzTSMzAV75SJ519dOFWiYLa
         psQsD5t/Te6ovt19kMqeSnBZOpV/YkNxSvFv7lvYAmU6ZyHxXtBd1H7ajhaStM9eIjaj
         wq8syJTQrbpr1hVngNjtfHGwTYmJzYiTS0w3NkmW4Oj1BY79sduQ/nQJVEteMlUQQL7s
         eo4S7EqEtOpySUck8cGBIvEFqVwjyjLRbfcczg2R1lT5KkvvGIOW/UUC6vUoPXnctChC
         p7SNJ7FRlaedTj3GEnrxnm2Y2Tc5RsTDsCk/8VpZxnLy4W7rdaSD5bIvRFtLZjheuNoS
         Z7Aw==
X-Forwarded-Encrypted: i=1; AJvYcCUMnUxG3/dgV2uW8gYL7L0LlZrNsWPAredQwRn+rvCYwf9DfTzOgo3d182dBqcTwU3djjjJfqrAFZoPRVoKrg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxbudMUuACHaBBbPOUBxfvB5VU4AIQ04/Uh+pNbEvYuzXzlVEJf
	uH3tYMnQkbFEY2BEgAByUnjWl2bEXk9ENK5hSQc2xl6HAAQ1Rdo2n+xO/VgB5MnV
X-Gm-Gg: ASbGncv3lUOJUlfPGIkgscdxWc8xykZqfOyZ9WP74SEadBr5EpuCsNmQ+4B8lG6ceGv
	yLqb/hifgKtNOjT3sWcvGqvDZ82zmKh4EXFmWcFX13Sph6SfUBBQceOphyn3kwSS/a7/27YzoiR
	4RYC/wNSRjC0JuG2zCQ+zixpuGXw5faR9mEHUHq7rByhR/Val71eMD7mBdQpDgTWXgQaLK9u1BP
	mr63Ly2mbWhmYcOLOvcAIYXxQK5Uia81C4I7ry3DZYjSpz3NDtYIYigFEawSQIdlDiRG/WjinYy
	aurbv+DeHiR6G+c0vEE+AhMb/pdGhN9He7jbM9Y7kTrqsf/WoWrnaccj8smr6QqcE5bA7RYDf9E
	AMws7CdhF7yMlCSPwducLfdxDurpanPNbpJXfebsjjvxNqZUbFSahyw4RErI=
X-Google-Smtp-Source: AGHT+IF7F37WVXyqz3LLll3RZfCOXVwH5MHsHZ+EnDM6cONHaXD4iN2314EuFX7mv15/HCt/9f1PMA==
X-Received: by 2002:a05:6a20:244b:b0:232:cc63:45d8 with SMTP id adf61e73a8af0-23d70087b76mr4257599637.20.1753467659613;
        Fri, 25 Jul 2025 11:20:59 -0700 (PDT)
Received: from eric-acer (36-225-98-168.dynamic-ip.hinet.net. [36.225.98.168])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b3f7f568ac1sm353683a12.5.2025.07.25.11.20.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jul 2025 11:20:59 -0700 (PDT)
Date: Sat, 26 Jul 2025 02:20:56 +0800
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: John Kacur <jkacur@redhat.com>
Cc: williams@redhat.com, linux-rt-users@vger.kernel.org,
	jserv@ccns.ncku.edu.tw
Subject: Re: [PATCH 0/8] Fix -Wunused-result warnings by checking return
 values
Message-ID: <aIPLCID1NklIUK_d@eric-acer>
References: <20250712134213.58582-1-yphbchou0911@gmail.com>
 <61792d75-d574-f255-5290-f1818807667e@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <61792d75-d574-f255-5290-f1818807667e@redhat.com>

On Fri, Jul 25, 2025 at 02:16:55PM -0400, John Kacur wrote:
> The code is generally okay, but I noticed after I signed off on a few, 
> that none of your commits have commit messages.
> 
> Please run checkpatch from the kernel on your patches and fix the 
> appropriate warnings and resend.
> 
> John Kacur
>

Got it, I'll send a v2 patch. 
Thanks for the heads-up!

Thanks,
-chengyang
