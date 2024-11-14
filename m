Received: from mail-ua1-f65.google.com (mail-ua1-f65.google.com [209.85.222.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15A8E7C0BE
	for <linux-rt-users@vger.kernel.org>; Thu, 14 Nov 2024 09:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731577234; cv=none; b=LOplgdXWkcOBA9EWxtk1FuCeWcSu6PlmvppOuEgGcpTPO8LSgF8MHghMQ1+5A1SXLUsC5HNul88rrcbqt5r0wFqxet91rEJn+6AvnujQUpCZwGbP9opEeVQdZ7bjEHXVJthQhTy2d4mZAwvdTlG4T0vTKJWgv8/LXWKvDlo9ZbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731577234; c=relaxed/simple;
	bh=Pv7ifVKGEAUcqyK/sEws8ewj9tACMA1STwbMCopYUe0=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=MDEYivIlXjrF/1p3EtLf16EFcQiSq1VzIGLVZq5aHE+h7GDpRxp/UU9+oowhEITPdFpdKmfsjkSgl8veCEsPRX34pDVGjxRFIx3uJXAdkLuEG2UKLa2vOxrrNuqopTb3QkGXilcTvI1l63KB9yZAg1PGz0Yfj3LgZ6JQpH3ajw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Em4Y/Zsx; arc=none smtp.client-ip=209.85.222.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Em4Y/Zsx"
Received: by mail-ua1-f65.google.com with SMTP id a1e0cc1a2514c-85054107836so205563241.3
        for <linux-rt-users@vger.kernel.org>; Thu, 14 Nov 2024 01:40:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731577232; x=1732182032; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Pv7ifVKGEAUcqyK/sEws8ewj9tACMA1STwbMCopYUe0=;
        b=Em4Y/ZsxTj9UqobOD5A1AP9KUM7S8UoyD6GaBzmZN0xDI2a+DWHurotU38wapGXn2E
         Edk8W6tEMvNwoVft/h2iCFkY+wX9NSLiwefwbPaSI82KbIrVHnSXpXRvdiLPitgeI8yK
         8yAbObj1KU6ZquYVMJy6fFe5CIcs0fIrffUCOyDlBw6ztXsvz6/zuDbSalIc27QvG6S2
         9sEjftamqbRi0WQD3BmEJfvsLVoWuUlA4eA4k6jLbBaJerPsnAkHTCfun+mj1WhInZk1
         X3XkTP8uYyfABGEClcOmkmaP+98Qw4OChqzB8IEa3BVppihlcZLHzVL3BaMq2B9sazAd
         z5vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731577232; x=1732182032;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Pv7ifVKGEAUcqyK/sEws8ewj9tACMA1STwbMCopYUe0=;
        b=oxyG5bsvfc+P+7BgMp/FcZUZZ9d2vaLl5tGlazvrk0qN5dDNWtDoHc17txECjpKmub
         hVCw+DN0ByiYRTX2UI7D1iO8o2ZLDg/qyRGD99EDmYhH018u1blcj8mAwjC/SkZkabHI
         2ojxg87PwXbWSGA3NwoaK9TCxy4mkjZZd84Qucwo+cfCBYi2jWSzXEJfOW1IuVMxe2KY
         raxQynPbXylIJJ2rAiMG6nSjYWNNqazVaTiubENQIbYQJRoe6s7300Vv+dph6yvsHakF
         SAsLDU4jqOlj48yDFZeixw6f4uzQcYjMwKX+laT2/i5uLDJzJ12L4Oy29BwBSe/MbObL
         Ekxg==
X-Gm-Message-State: AOJu0Yz+190tj/RranOqFfND0H1sJNm2d39kdXbWjilecGdNWS6DzdrJ
	C9SKezoMYdd441xHSVWlU8txhcRyCWHhn/OgnI4VbkeMkF4K6AJnEgo+7hPHRbJANkOYuxBVhH5
	dCUnPSVnbuUnd1Zj/zFd0hMJ+8+3JdhIlfWmrWl0aCcvGbQ==
X-Google-Smtp-Source: AGHT+IE3qNOilwqDW/l+4VQ/KO78nwZhq9Xy5WcWevED5diJSBst5GVyLMUr0hraMZ2m5ZwToL/V2jh5lRP63mfvU24=
X-Received: by 2002:a05:6102:374c:b0:4a9:635a:b0ec with SMTP id
 ada2fe7eead31-4ad581efe1emr1482306137.0.1731577231773; Thu, 14 Nov 2024
 01:40:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Prajwal Gowda <prajwalgowdahm.1@gmail.com>
Date: Thu, 14 Nov 2024 15:10:20 +0530
Message-ID: <CAOJh2-kFD7fd6km5PEBDXdYNwwWZXi2n8MKkz-Y6TEn643-Q1w@mail.gmail.com>
Subject: Information regarding rt-kernel patch
To: linux-rt-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi @linux-rt-users@vger.kernel.org

I would like to know when a new patch for rt-kernel v5.4.y will be available.
As I could see last patch release for rt-kernel was in June for
v5.4.278 after that there are no new patch releases available for
v5.4.y.

Further I would also like to know about the future of rt-kernel patch
release for 5.4.y.




Thanks,
Prajwal Gowda H M
SiemensEDA Pvt Ltd
Bangalore,INDIA.
M:+91-8892612268.
