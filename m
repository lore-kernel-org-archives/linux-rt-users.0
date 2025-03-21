Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57269AD2D
	for <linux-rt-users@vger.kernel.org>; Fri, 21 Mar 2025 16:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742573003; cv=none; b=mj/8FsHhY4Fi3TSUg29oyBxk391F6WrFiDHTdsupSgMZ9NYP0NESmQL1EqgG0ygh6DDqyLdTfMgyYW9/Uw62tszg30vxYwSd2Zw/2E7hEZrxxMQizAdj4G2obC5TSif2mVSgdNCbKXxPXJZNrK7STH+pWHXY39gjpKnUYLDa9s0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742573003; c=relaxed/simple;
	bh=EKleEB8VGdRNbVoCkLwP3gPHuWp/0OZS2UeLhEZAuy0=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=cQRRIQryC3QSsPZkXFxgPSzpWNoX2S+GQQVlJEKgAkqHWCI7UQgQR4JiwdURVLWSI/s050VkwMpbPvBnKC05i2syFpESoz53ALg2vc48bLtW86pigVrt3ZheT9rFnfTV8Kt1K5shfhJzU+h/UpMxgUm2i4azSK22iWlNchvNn1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GfK2mC4d; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GfK2mC4d"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-6ff37565154so20415307b3.3
        for <linux-rt-users@vger.kernel.org>; Fri, 21 Mar 2025 09:03:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742573001; x=1743177801; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=glgBCnt1ee5lkpkIHHSBzwqX2Z21Um61dEIfuh+jAQQ=;
        b=GfK2mC4dHUkzWe1uhtjUsXDGLKcEkDfDJzeNm0d6xy09N9Clux+MdNzJe7zVWyOEbE
         UqwAgAF1TKBcfLgjGVrvs0HZX4Y9L2DLx5gUZg6hlik9eof5oXbGGkk+Qw5fa3f0sABh
         PTowtXppWLzeNiGw4eMaiY6oAXeyZ5AEeS4anYshkDtaTBY66uLfndePBfRg9KD5p1/4
         5pI55hhahFZSWP2U+C5Hmvh/HB/D0Q5KDik7JxH/yT9Cs3quyiGXF10GHrfpjvS1Y1y3
         1/jMPu57TVFng7BhKhIVv8OlNyN1JZoEwHfCRWUBBS+iVdVzv6dUSC2Y8tJJ4G/X+Eyz
         hDig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742573001; x=1743177801;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=glgBCnt1ee5lkpkIHHSBzwqX2Z21Um61dEIfuh+jAQQ=;
        b=n5crOvolfPHGkZsNurSJFgwqzgrSKPzV/ZpPifq9ASQqfeL09RHbfyDEF2SnCgZOBU
         sKuhrDcD/Gqb/7h/OG08dIxzluo9Gr79xQoBshkk+2bxRlR0Qrq9PH8jXoUC6tKmiC4e
         dA7yXlX/8XS34S7UjQ+vNOCv+ZvEZBtucN0xuMoxyaOV/kZ0cVOs2l8B8rBwpXesOtQ4
         26gJUHDbdFsEEVwYlq1uocugN4Ca4Ygo419WwCsbL8P6pwRjczUd0UaTJV/g0x4pWVrY
         lob1TSTq4/NXaQCd5it7rDG1rcgNeKaSqD4ZQKOMRL6SvwEMeDTHq2B2BYcl2jHOCJp0
         YchQ==
X-Gm-Message-State: AOJu0YyG5WrL48B0wSG+EF2yLfMGApAGArniU0auBb9GiXcsfuZSJFuy
	Z3x7eWhN/Z2KY4tObW5zGVJmEUPo1qs0qlj8D+KaxdEObjfga4NO5Zy99wzKEEWyKVhjcbM++kb
	5lqng6WhB1GsZ6UmhPlnnPMZb6sl8BFal
X-Gm-Gg: ASbGnctpqU7/c+QdhRhJRSWAZfuSJqiQrPj96ORxAEp7t2+Y8fEVFHOwGhnon8sgsrY
	aAmH2B7yZJ2XxNJl5G2dG7qlJE4ABlP/urSYr7lMTl7ItQNnqaPTOwT5I1KkK/gGlHNtMwRn7i/
	jWXIwEfDa4ldegVueQCBcYaC0Va+5BoGnATPFrKdIvW0Qt1v+NxOVOVju0HiegSBMjJ4C7RQ==
X-Google-Smtp-Source: AGHT+IEvJejxVhrTmvZNA4lq1olYgrNqd8Uo4q4hw/WmDCvJlzrrkAjREAkBdV4n4JVSLixdO9RSxYOkJvCqECra2ko=
X-Received: by 2002:a05:690c:4c0c:b0:6fb:5498:70fa with SMTP id
 00721157ae682-700bac79111mr55167017b3.18.1742573000770; Fri, 21 Mar 2025
 09:03:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Gautam Thaker <ghthaker@gmail.com>
Date: Fri, 21 Mar 2025 12:03:10 -0400
X-Gm-Features: AQ5f1JoDurxq3kvW99NOIE1lm6HQsaT6SMK0zMFWgcpeLUAamdvFXdac-o9Hqbk
Message-ID: <CA+1+E3VC4LX5X8ANf5d1Wm7QjSJZUG=mei8E5cvBUyqcd5j3yA@mail.gmail.com>
Subject: seeking best steps to go from Armbian 6.12.19 PREEMPT to PREEMPT_RT
To: linux-rt-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

I am currently running Armbian on rk3318 TV box. Runs great.

rk3318-box> uname -a
Linux rk3318-box 6.12.19-current-rockchip64 #2 SMP PREEMPT Thu Mar 13
12:02:20 UTC 2025 aarch64 GNU/Linux

My question: what is the quickest path to get FULL PREEMPT-RT kernel
running on my box?

I believe I have found the Armbian sources.
(https://docs.armbian.com/Developer-Guide_Build-Preparation/)

Are there instructions to build a kernel w/ all the same parameters as
a currently running kernel with only change to set FULL PREEMPT-RT ? I
would like to make least changes to configuration so that I may
continue to boot on my hardware.

I used to make many RT kernels in the past, but not in the last 10
years. I can't find current instructions. It was my understanding that
with 6.12+ linux kernel one needs NO RT patches, but still have  to
config FULL PREEMPT-RT and build a new kernel.

Or can I change some grub option and simply reboot my current kernel?

Gautam
