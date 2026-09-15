Received: from mail-qk2-f13.google.com (mail-qk2-f13.google.com [74.125.230.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BE2D4BAA1A
	for <linux-rt-users@vger.kernel.org>; Tue, 15 Sep 2026 16:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789491485; cv=none; b=u6M0q89SJk+5ZC80TGbtKKwrZZKlSdmQm/FpFx2QgtX8TnumMA9awgF9zzn9hUE01zqYkSGYr/+wF0/GDVbCvIrrEp/uqmyxflRxK10GXxJKhGbZQLYIy8xS+fQ5+gglg4T2hdDGhtg5yYUAibuwmhi4Ovy9y1HIzfhPemWL6yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789491485; c=relaxed/simple;
	bh=mVSxFHid+/PbczeQL9lv9xJmklH4nQ6g9b4uuIuNyrc=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=AVeXtUmVNdMg9OJOyo3n0AkKhBK9HEbEV9N7gnGvDf6to2g0lPOH8X9OMspgl7JRaNHiI1JvGX2wEp9XvghDW9YWPdd6Yer/s7ovdl/uNFUE/zNpbaUNPuuZfJleXniBiELQDEYuZmRCioLkpm0WKE6lSX+Z1izkYxl+XQcmO9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CP19ujrH; arc=none smtp.client-ip=74.125.230.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CP19ujrH"
Received: by mail-qk2-f13.google.com with SMTP id af79cd13be357-939109fafd6so360111285a.3
        for <linux-rt-users@vger.kernel.org>; Tue, 15 Sep 2026 09:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789491483; x=1790096283; darn=vger.kernel.org;
        h=content-type:mime-version:references:message-id:in-reply-to:subject
         :cc:to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JlqbD6Zsa2sSI1ISCaf1uK/m7jV9c5fIzkhpX1HzCLU=;
        b=CP19ujrHuCXgknJwBT6j+bAlWQe5idxYJ7aKMJE0FQNDl7rSlt7UDP90kuBHisrSeU
         bRFtBKaga8hqlq7Ycs89VdFkg+UwnkaIBpY3x/gtIszBra/cowah4vkzjvja133iRgrS
         lnuGc8REOgDHrPihB8xsWTvOeHCsaZ6FDMhTwI9ZGhyVeION1JZE9jNVi+WeVmfrekRs
         QEGcbGd73loOTHGuS3P1R7ttgzaO9DJ5GhF1YKsphqMlLZvM+fxAI39UWWxokeDPbMOS
         nWNf9R52t/mkDbrRCRhGm5OIl+8ZUJ5h5q06mnfv+6f9834LUDEsK3CxuWBjwH+A+BQB
         2vbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789491483; x=1790096283;
        h=content-type:mime-version:references:message-id:in-reply-to:subject
         :cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JlqbD6Zsa2sSI1ISCaf1uK/m7jV9c5fIzkhpX1HzCLU=;
        b=rT71xsdE6Y2LWXEZYMrdoxd2xUTjCSiK+26OB7F9mZ2twNAsr7M4w+hy/tfkgIIHvJ
         RMTSbm/2GHj+ywmcH3CppufStn/XFEE96KMsqe46yidKyOKqL7m7rKNK+cmf6hUvzXAe
         4gZTorGeqQi7RFzEn0XXZOc+yvoawcf214Mxua+Dg9v619ZJnTJtbDLFophrNna1jxVx
         AG3Sq3oQxhr2UnvGm56fKE1pKzjWoxcPKLEFnYSnryAGCHLh0MPd0QJM23fVsOrYmLcX
         23EGDxZimQQkuHWcezvK9pMXYZoZDHVgq0XxL11r5GZXrX4F7bM4crueAH5BZ96s9HmD
         PGYw==
X-Gm-Message-State: AFuF++kToami8kZTyZnplTXsTR2fMBspY7SqCXh8wJtDgrpZLNWLtBEx
	D/zsur6ewNl7PvkKlXbkDCdKrrfTqI2Liv/YBKSkiWIdWFmGXSCQ3Hw1
X-Gm-Gg: AYBFou1LGpXLJSE1VzAPP7Z7quVQVvcpI7mhpZ0qDcVKjKEMYn/kJWfC5J20NoOAOvI
	Oqy9NiF9mmbN1Bk25LgnlI1k5FiOwiVYxS/x1rzJMKWI2iJ4O88/FyAFyR46e3sw5TAKZRNJX0u
	R6bUSV7rzmuqmhKJ9wWoyXX5Dgt17FW3P6jW6E8T2qFgwpVSGwOrPsehnPAMk+1O3Y+aEuMDei8
	9xE5D/yiUM/ayHS0fw7ttVYOG/vSUCKaG+wPwjM9UdzLo0KitPLJ0ENweh4ZyL3HG4Cr9PMG25r
	tW50qy0BVwn4G1oKUNyGBW1zzOk2gJN+nNvrDuug59iMFya+zwGz9bm4++ubsfLbVZB9fF8YjuD
	e6c+N4mGUgn4OKRQUg6F7+LSu61q7WOXdiBip24tXHAZ9O1+e60truwFUvLuhf98eVSTAM294Kn
	CPOB713EzxYggupq6icGp2YkkPrdRv0J+FekGARPFsEuNDVBMHbUj0Scby6/wGIWGndkYN3SpDg
	Cd2XjsDq6kJjSQ6aFS6S56YicLlQzNdqRoIy6hJdMWkyhqfR8f+EV/4Dg==
X-Received: by 2002:a05:620a:4455:b0:939:6dea:ce79 with SMTP id af79cd13be357-93a29be9db9mr1244553585a.47.1789491482824;
        Tue, 15 Sep 2026 09:58:02 -0700 (PDT)
Received: from Cumhall ([70.53.55.174])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-939e80d453esm1316957985a.38.2026.09.15.09.58.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 09:58:02 -0700 (PDT)
Date: Tue, 15 Sep 2026 12:57:51 -0400 (EDT)
From: John Kacur <jkacur@gmail.com>
To: Sana Sharma <sansshar@redhat.com>
cc: linux-rt-users@vger.kernel.org, jkacur@redhat.com
Subject: Re: [PATCH v6] rteval: Added unit tests for stress-ng validation
In-Reply-To: <aqk6ur3jcn5tFD11@fedora>
Message-ID: <4e97b834-e825-07aa-112b-1a25ed2bc29c@gmail.com>
References: <aqk6ur3jcn5tFD11@fedora>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII



On Tue, 15 Sep 2026, Sana Sharma wrote:

> Used the python unittest capability to add tests that check the
> code paths added in commit aecc7c6e47d4 ("rteval: Adding stressor
> validation for stress-ng").
> 
> Signed-off-by: Sana Sharma <sansshar@redhat.com>
[snip]
Signed-off-by: John Kacur <jkacur@redhat.com>
