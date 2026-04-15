Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AF673D6694
	for <linux-rt-users@vger.kernel.org>; Wed, 15 Apr 2026 14:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776264474; cv=none; b=L9Viop/diuBnq1Pfa6sf4JHkifaz9L45aTmRJj4KlpeN3dIxrWLzW04EfK92wis0NmRFaRItWikTbaNxYmIpFZgqxKZClJzKqiFdvVd0Lab1CypBOVRGGocSyE4H0RjjiwjpbRJw2S+/yoiM7AZ8an1l+tCiiVf5a8L+mH1+NhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776264474; c=relaxed/simple;
	bh=cZd2U9bN4hfD4zVr1j0kUAgpy5IY7iwFRoVho3OMpKI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y26pTqCFlSVzOdcsr9FpM53CgnaTNz8VdcrEnnZrl9cY+Cr2whTmYZj7+v2WUmZhQEWsB9OZ3GCIO3keuVxiGMSQe6ofYk2BrvYqm+uRmeYU5wqVaJm1vr1ykxVVp/BD+uX3hbFzMimX0F1ziVE8kue0tz9FmSCvXJCal4nbFlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=n6apEGPJ; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n6apEGPJ"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-8e0a768331cso359171185a.0
        for <linux-rt-users@vger.kernel.org>; Wed, 15 Apr 2026 07:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776264471; x=1776869271; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cZd2U9bN4hfD4zVr1j0kUAgpy5IY7iwFRoVho3OMpKI=;
        b=n6apEGPJOOKgHclBfG+ZRD+6sldvxXaQRqp6BjokUtyeEGczfMyuUWiiLelJk2WnBz
         SzqiHSqY4U5bTDO5IvVnAuzP+4afrpGs4rEtAba47Xu6BYEjgYAuMwgKgMDEkf4BN45f
         2iD/Qbjh6l/uXDLUAUPJo4SHoBelT0nr531Qorp1JzUM1JPrUPcqYCUZamabLNMZkWYk
         wzNoGwrsRd+Dczz2/8Yt6dCSBGUnN86h+XL29z2YKlHAppxqFnrvUiUY911/MB63Br87
         PMct3p+0EDPj2y/G2XAbhqZIJD/RrrLhA1pe4zFoYsrHBAckunKk4fbqPxx/uhYJh8Wc
         zF2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776264471; x=1776869271;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cZd2U9bN4hfD4zVr1j0kUAgpy5IY7iwFRoVho3OMpKI=;
        b=gE/7MEBdVdW8QAtRN5T3ETO0KeJjFdNMz8Fy1J8a/hAgh0dWKnow0V1PaAz1f7e7O5
         Pf27/JtdBr/8i+k0g3m2zDJR2F2S3P3Fn+KNsfwmfR99dXGNIkyQsZWc0MrLjcYYLNRp
         fz0LaAKoQil8fCGKZqBhg9N9bBv1JyUDCIOSiCgohV0jaLI0GR+xdG1GITFmzA9M5I7S
         0ahrPT6bvpYXNwRejUH5mgy0kyK1XYBBtlc+tM8YT6j3YeBS+JvFb4sJ8sC4WNgUMwIT
         BBMtKqLAP42gqxZ4gqX9e7S8296jpnHvrhrlXNxulCO4xq5QzgPvJ0g6BC29P/nZsHBB
         TG2g==
X-Gm-Message-State: AOJu0YwKGAwfb/gqVu8il2qvG/AcsjC0x7bYW6U+b2xJzXeUsNEwW9mH
	iuJPRe/Sfl/bmCBm6TIkcvYZvU8YLngXfYUBK09spj7doPsx9V6fPqtZ
X-Gm-Gg: AeBDieu3cko72BtowHy3uDVpOgZxaOgwbwkZ4+cGwCphTwt5q46Wfk2ZGVSoYIxKgX1
	QLcgOX3A9jInrX7uh9juU1FU4IsMkg6fYkTP4OudnAxtvDCJNeDm1KQpOGnRRbijRdlzibe9zI+
	lrk6PNU0VI9FmUuXzRfDW5DbXzsZoSIqY54emYKnCfRX2NBYSvCSorWVfzHCW4ItdlevC9Tubwp
	+g4Acs1ymqGthw8L2v2Tvb0ypzhlEXO8e4xl6MqW21vPpUBq9PdN32rdxDohThaLZv5IuNHNyXW
	lHbXo1z5x2KdWCMrGdx+lEtzGIDdYKAIg2p04ywdZHdLbzMMKaonRkzfUxsSvSymXWvcb15zIOZ
	Pq/zLbh6UmZRMnA94Omu+OApbYUv+B072vTm02STuuIcd5/ONTH4YtWzg6Kd5inwFAIxsuUu5Av
	EeZduFpNemmtzcjdV0FYLXa7D8Z7Yphig6hzlLZwHvJlyAOwyRn8jGqxlu/Stc2O7r1olByB4Xl
	nG+zWSqKMRJveyTUGez4SaS1jxJvg==
X-Received: by 2002:a05:620a:4082:b0:8cd:aa61:ad8f with SMTP id af79cd13be357-8ddcedba288mr2664326185a.14.1776264470756;
        Wed, 15 Apr 2026 07:47:50 -0700 (PDT)
Received: from Cumhall.redhat.com ([216.209.112.32])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8e4f2dffa0asm130882985a.38.2026.04.15.07.47.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 07:47:50 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Cc: linux-rt-users@vger.kernel.org
Subject: Re: [PATCH 3/6] cyclictest: Fix error error returns for uclibc clock_nanosleep() fallback
Date: Wed, 15 Apr 2026 10:47:35 -0400
Message-ID: <20260415144735.109476-1-jkacur@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260407-auxclocks-v1-3-1ef80d14eb0a@linutronix.de>
References: 
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Tue, 07 Apr 2026 at 08:48:43AM +0200, Thomas Weißschuh (Schneider Electric) wrote:
> cyclictest: Fix error error returns for uclibc clock_nanosleep() fallback

Applied, thanks!

Signed-off-by: John Kacur <jkacur@redhat.com>
