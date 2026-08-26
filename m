Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1340B43C069
	for <linux-rt-users@vger.kernel.org>; Wed, 26 Aug 2026 17:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787764165; cv=none; b=HIw4Ao4KHi0VharE8Z6wcscoOGqO7GxfzAwyuY9YZ3lJd3J5cONtdRFE0du0GyYDbVTItD+4MoYBn7QDhYrOrKLzp77PLx0ORmeirElcF0mvWNdyI+nIDzWdxCA+TeRfZmQCTuwZqCo5HRq9HGSwfHIHeU1w8DtOakhQyqNLYso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787764165; c=relaxed/simple;
	bh=Sd4T4PyB8zhgfFT+pd0/WajNodqVXkT1fEqkQSYCCq8=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=BZxKh8vXmG3+oe+2UAl2twpW1F7FeBCbMe1f3ExyqG/X8ivN5DNGLsr7AnPAwYQAjC8+XyCbSrjaqk0+gR69VPnNAXD2f7QfuueGkdcrStDDEXeBkt2cVPgGXgQwVcP7ozz9sausI3XW2gOR0XTdpeAlY8HUR56hNrZiH8YVPXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AQDd1QZu; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AQDd1QZu"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-51c149c5722so1087551cf.0
        for <linux-rt-users@vger.kernel.org>; Wed, 26 Aug 2026 10:09:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787764143; x=1788368943; darn=vger.kernel.org;
        h=content-type:mime-version:references:message-id:in-reply-to:subject
         :cc:to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qzzY8VIzoblUfV63TY4CZ4+2bgfMDEMaEZ66cjEGExA=;
        b=AQDd1QZubNv0qWvOa5CqKYhk1XmuEIvfvaxCVMBoAJODaEaDxmLf3uLXKnJSnqzW95
         cQzKgSlBxxMWeAdEDzyOQmQjxXnCSUpc9TLt5bU76dHyjKy2H4iTKHPk/DSSbYf8ztR9
         55rxB33jbmPHjv/+l0gr2YL/0YNZU7VpYQ5TkpHdtlMv1oSL3+SO4kXNs4ghqetI43GJ
         6CPpYK1WHbI4mokSG6grjGi7ffyqWjwVVyzqipRyFpQ95ITS0Cf2YS1zYoeacIsB46T1
         SZKKYccuWwh5LK4LsI951MMNyFatZaEh0U1796EUuFIvsomGLxtl1rtw1vEDJ9AdxwlR
         RSow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787764143; x=1788368943;
        h=content-type:mime-version:references:message-id:in-reply-to:subject
         :cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qzzY8VIzoblUfV63TY4CZ4+2bgfMDEMaEZ66cjEGExA=;
        b=KrrzWBCAuh1t8Iev1I5ulsNc4pTrVFSL11/vHC5Px0CakGHRoAdXQj2ULiffpxlie4
         6KTnB4OR6x2OCglGleR8AySSzYocaGik3h8dD00VgP7qnZpt5WBRKlfx5/sOVGdzBpsy
         zazeZv719D9Z/Hl/O/8qwuhgKFfxOwtbYdHxNjzdrKUKSwbSErS0Npffkhc+nQhQliz1
         JoO4nD9/vmHMua38d9ALXw59ZFVWZIasUu+xLhrDQQn2O1jmq4RfIvfqzOEEK0ohIMxN
         AOIEh+N1xZoyu/dDtfRfXa1OlHGoyZQvnA8g4Zv0HED08vkYvtyYWY5IhyChM4ZBo0AR
         Wflw==
X-Gm-Message-State: AFuF++n79URpsTprhajdao2cgFkjpc0wrAxvfjfW+HF2iwZdxwoiB8PF
	nSX4rvWWF1og2qFw7kVqz1E/7HpLB52xtuztrHfiW/9M1SIy0CSJwmq8
X-Gm-Gg: AR+sD10PrMipfNRHz2cLMH6R+NIId5lVW1u2IHC048PYNfmHd2PrfEhDvpBaLwdF1cD
	55sc7Pd54EPqIwUxGIDqt+vxVZ+h9+HWtjNIUtWfjJp+Cv3qtCH0Sw1DKboxPnilqtzryIrIhtR
	A8GsoBJFHTISvlHyD1xxEsEHjELKP/t2Zi1SD7zDKUI95xz6SqJQcyIapiHmmlxPpgDwObrJDq+
	VvlVvXDYAebjT5crHCfSoDeninrd89o/P9RErfRQYL6ecjFJXsyCiC7rvmo7unMCPooGwNoMimf
	2OmASCvvmO5932EiMrPWLfMuQTPvOtju7vBQgzqrKwIp8neRyMfXMSqoNPH4Zpsw6AOfgngt2NJ
	EYn+ar/dOt/ACc531yIZuXs/VW73Qiy3G0UPpWpKMK6fQ7MZu0Fg53NBJrtFnZ9J5adZ49eP9A+
	l/8+llFOC1n5x/kGUdzRwBUwYddiKcWB/AVhc6tEnVXwE7qM69KtysHKCpsF2qR7EMUQ4/lyb5F
	LkGMR5uQxOMA1m8DNiKxGmm9bqY22PMeqJxhrI=
X-Received: by 2002:a05:622a:408:b0:52e:2d19:b30e with SMTP id d75a77b69052e-52fa1a5ce7cmr7986421cf.3.1787764142811;
        Wed, 26 Aug 2026 10:09:02 -0700 (PDT)
Received: from Cumhall ([70.53.55.174])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-52fa18a8cdbsm2006771cf.19.2026.08.26.10.09.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2026 10:09:02 -0700 (PDT)
Date: Wed, 26 Aug 2026 13:08:51 -0400 (EDT)
From: John Kacur <jkacur@gmail.com>
To: Sana Sharma <sansshar@redhat.com>
cc: linux-rt-users@vger.kernel.org, jkacur@redhat.com
Subject: Re: [PATCH v5] rteval: Adding stressor validation for stress-ng
In-Reply-To: <ao8Y5tpZbpK-IPbc@fedora>
Message-ID: <41098708-757d-5c63-4544-7a3f54c6c3a8@gmail.com>
References: <ao8Y5tpZbpK-IPbc@fedora>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII



On Wed, 26 Aug 2026, Sana Sharma wrote:

> Previously stressor names were unvalidated.
> This has been changed so that now if the user inputs an invalid
> stressor name, they get an error message telling them to check
> "stress-ng --stressors". The list of stressors is created dynamically
> during "WorkloadPrepare()"
> 
> Added error handling for when stress-ng is not installed
> 
> Signed-off-by: Sana Sharma <sansshar@redhat.com>
> ---
>  rteval/modules/loads/stressng.py | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)

[snip]

Signed-off-by: John Kacur <jkacur@redhat.com>
