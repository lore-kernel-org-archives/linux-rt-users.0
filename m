Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A50D2BD031
	for <linux-rt-users@vger.kernel.org>; Thu, 19 Feb 2026 18:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771525450; cv=none; b=ghN2kwlue7x3P8+GA90zXSBvfnSPiTF/q+AMT/sgJnfTdCH1nfnGcrjbt4ugMWqEttmieVVrtwBUssczStoNUknilQcWbzcTg+kG6TqSVeBxVQuvuivfe9i7as+Bugu41fXNu+/pOcQCUn0M3ileL2oJ18ySzANMGd7MhC9Rpv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771525450; c=relaxed/simple;
	bh=k/MC3iYI3hLP5llHb521BAu6XZOLFT/PJRjwEzibfV4=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=YWoOinn2NXiM4CACILyLeGpNuCg/YqDKjgcrNOr/SCu2PA3GRTwqfEnJuWDsn0ngQ8tagSYufmNnJiCdaC4F5g/LYwBxZmqxHjvaFBy8GFYJ0OdXaoL7wG0bOtPWvQSNPej0u/zAPuI243hZhz6lxmwpGUE2ZyV0ebni4mVidnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kYtM84Rx; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kYtM84Rx"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-8cb4acdacb2so157340385a.3
        for <linux-rt-users@vger.kernel.org>; Thu, 19 Feb 2026 10:24:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771525448; x=1772130248; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=fggLOZk7M5FkCw4X8HB49yoYqihnCbNHn72tUP+wyVc=;
        b=kYtM84RxiOgWaPabzYgmmDrLPL7k3B4EJjcqGyj4Ke/4Ug8bmDxAbtaWCnhm76F+rx
         0Dkuk7GBcPvTVt4DZayVmUtBuFtEHtGepbiOymabN8MlMtXO+D1WYVyxn9W5hKhs6lnH
         l9sIkyTrSZyWGIkRgh0D6CUcj3wfEwQxEoF7YpXi5i25Q2kamhnHfMZXsEhMd1m92uD/
         HsY39d0LsTvXTXN4U839Cn2ZPnDMcUmupmWHhZbckrIS561YhL8WcucicVrZ/EGQlLnm
         Lwlxl/ktRT9QayckC7046CZeGiyznbn/aTfzzyWyjp2DV9cmJuguwMFWbFL0x1cDTh5/
         +Wxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771525448; x=1772130248;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fggLOZk7M5FkCw4X8HB49yoYqihnCbNHn72tUP+wyVc=;
        b=JE9mC22na0N/OKGB08+5m8g4msV++E6VKAMUNRCSZXuBq+yLhxLqDGXB8EhnBvXc+l
         aWjFPBe74Fsxr38dj5SDb5A7SoBgAdBV3OOY0kj1c9SUOx9A5ykcyG8O+V5N9lZomHK3
         fZtUIaZVL3e/u9Jx49Ei+I6Lw9UCm54fFp49xsFZ/jfz+Uyk20dDJOvSwY6ocak2oyrZ
         jRKWHFqwJhBk7VTmEgypfwj0cFUZsdSWkZSmtmjBDrDld8aD9ob1C54vkQgZ6gYTR05B
         AGDLD0mb51s9M5TSc6i/k1zVvTzaaRTqnR9Lv6d4gNittB/Y3x7MD1slfSQqzmBjvePT
         vyqA==
X-Gm-Message-State: AOJu0YwZrhYYsLWEH2v2QemI0TWAbE78b3J7ymO9uACHXpxuDd6/d3BC
	yyY4GhHYMu2q1m8zMjUTX4WGLVPNLAhUIpeIEkJYfFewKdwF+44U4z/ZOO0IMA5V
X-Gm-Gg: AZuq6aIDUtYiQteDMSu3DVbiJaA7eLbfqd9mQM7HzPS0fDVYTEE51EUbRU9oDR5xsg5
	XqbJrvkFgBSi/mHr6UmungFO6PgM+W/07SQJKp2uGe0NgnSFx6DyU3Wn6RW/NOw8ab/ucMl43eF
	8Tjfwfa8ArRabQW4ZDU6xl0GgTYsS+AsPisY/uR767b2ZioNRYAgd6mbs2J2fjHqWWlk0csB4IS
	kSYPsQit76kHt525ydg0oRTp8dN1viSgo4GXPf4yzkqvqMLcQXwkZ+rwNRzx3IT+2j9Miiom259
	4D9i9C2BuwAwzNT1SZ2Q49rLagXx5U1fdkjkwq8X724Uh9M4XUAAdN2JySLQNME9Oq/rypKpj4n
	9qrqTn3rwB2ePrkET8s8O0hVBAEh/xpW9zRi1EfGdvAC1OlezlLuAMu7v0lsPNEDF35Xfq8NXqK
	4zECDCeOGnofQTnxdYPsSu/1Of5BWAqbWmVrocVtTYhSHrE6wisQAc3Ll1/8fbbEKoFRM8RfRY2
	g==
X-Received: by 2002:a05:620a:400b:b0:8c7:132f:ba95 with SMTP id af79cd13be357-8cb4c018c47mr2441918685a.81.1771525447930;
        Thu, 19 Feb 2026 10:24:07 -0800 (PST)
Received: from Cumhall ([142.189.59.50])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cb2b20f240sm2146037885a.40.2026.02.19.10.24.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Feb 2026 10:24:06 -0800 (PST)
Date: Thu, 19 Feb 2026 13:24:05 -0500 (EST)
From: John Kacur <jkacur@gmail.com>
To: "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
cc: linux-rt-users@vger.kernel.org, John Kacur <jkacur@redhat.com>, 
    Clark Williams <williams@redhat.com>
Subject: Re: [PATCH] hwlatdetect: correctly get CPU number from different
 sample formats
In-Reply-To: <aY9mBeyzm5Mae7SH@redhat.com>
Message-ID: <ddc60f24-ccc5-6fd4-0bb9-adce544e10ce@gmail.com>
References: <aY9mBeyzm5Mae7SH@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII



On Fri, 13 Feb 2026, Luis Claudio R. Goncalves wrote:

> Make hwlatdetect able to get the CPU number from samples in both
> 'nolatency-format' (currently covered by the code) and also from
> samples in 'latency-format'.
> 
> With this change the code is now able to get the CPU from samples
> in the following formats:
> 
> - nolatency-format:
>    <...>-3820    [007] d.... 22851.463472: #2     inner/outer(us):    0/233   ts:1770937572.925294075 count:1
>    <...>-3820    [011] d.... 22855.495526: #3     inner/outer(us):  308/305   ts:1770937576.805213360 count:49
> 
> - latency-format:
>    <...>-3835     13d.... 12608167us : #2     inner/outer(us):  307/299   ts:1770937629.988530678 count:49
>    <...>-3835     16d.... 15632212us : #3     inner/outer(us):  308/296   ts:1770937633.322710076 count:24
> 
> Fixes: 96e780938322 ("rt-tests: hwlatdetect: Add field cpu to samples output")
> Signed-off-by: Luis Claudio R. Goncalves <lgoncalv@redhat.com>
> ---
>  src/hwlatdetect/hwlatdetect.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/src/hwlatdetect/hwlatdetect.py b/src/hwlatdetect/hwlatdetect.py
> index 68f312db639f..26694abe099a 100755
> --- a/src/hwlatdetect/hwlatdetect.py
> +++ b/src/hwlatdetect/hwlatdetect.py
> @@ -246,7 +246,7 @@ class Tracer(Detector):
>  
>          def __init__(self, line):
>              fields = line.split()
> -            self.cpu = int(fields[1][1:-1])
> +            self.cpu = int(fields[1][1:-1]) if fields[1][0] == '[' else int(fields[1][:-5])
>              i, o = fields[6].split('/')
>              ts = fields[7][3:]
>              self.timestamp = str(ts)
> -- 

Signed-off-by: John Kacur <jkacur@redhat.com>
