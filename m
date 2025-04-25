Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9413F1F4626
	for <linux-rt-users@vger.kernel.org>; Fri, 25 Apr 2025 12:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745585146; cv=none; b=cvWoJbh47W6XMZA1PoTHU7MLnQFiFTFMKbTIdC/x2Lx2ByXrp9SoLrq4fm19UIfWRazGfuY77FDqgvnAuwdHBbhFX3xscyqKT/WKyGJNFn+ckYr/riDQcaWyK2DgsQz11492/Sx28mK2F0gPok0IVEatrx1MSHaX4vxKiOQbFS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745585146; c=relaxed/simple;
	bh=kmmDoYhUe3DOYag00hswtXrAMGmwbZPU9tBXN/fC+iQ=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=sofIHBDoaLAoy5xKBYw/ecJ+/916M0hovqMBrET5OIeu9fvL2fdABw2LcWQOmSrU050U7Mb8Y/0hZgXevmieyMNaxzMSIx5rHxVakWZ/ow0j6WZiMZsHeBwlWI8kja/aHl9GB8V01h/soiiSKeDelxGgeny4E8T/e+yT9okZ2IQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PpO33stx; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PpO33stx"
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-3105ef2a071so22323001fa.1
        for <linux-rt-users@vger.kernel.org>; Fri, 25 Apr 2025 05:45:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745585142; x=1746189942; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kmmDoYhUe3DOYag00hswtXrAMGmwbZPU9tBXN/fC+iQ=;
        b=PpO33stxcCbfMmOQ/kIuqLEMF8KAgZN6IimEpRaZJhA/W1nYPHAREpZxhkLsIsiFAx
         MNcVsll49p9P6+5CE302wxOb5FW0JVgiKJ1On4E5sc2MOlJ44xcNRwiikuCbj/ZQendt
         vNj816FtWBQeQb5bhCZPboB2aF7VKLJcHESMe2liA74NwvhlCaiQ13jZ7QRbIi9muJt5
         tGIdozmMfVA9hEDJ4iTeTp81bhKS8HJdd7JSs1K4dOBuOBUffkQzhnjZwEEeT/U+yv1r
         ZU0Cvca7XBCAD1EspkldBvA+crLBWfAwTUylsEpKoW6pHPId1rTaURHSEqeex/SGbauH
         9h5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745585142; x=1746189942;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kmmDoYhUe3DOYag00hswtXrAMGmwbZPU9tBXN/fC+iQ=;
        b=LiN7vGfBCfhRhsKoiAyptoPrMDVnWb7LGedBtRZMYiBf56CKO4ztsGPD1Jzz8Yeu/Y
         7NRx9aBVZO3K65b6y9z0VcL0fVdjqqUEl7FtUaPuE9sEq7Tq50T9pKotX/LLAQrnVGqR
         ouEJgbsFVhe3MXcyfpufItqpuS3GdW24wZe0wqxhKjf3wdydK34hc9/UmWAYNxLuSRgf
         3Vqyd87c3vjkPpK/iJ8Eds3vD1skiOeaRYumsGGw8PaYvmFH9ids6kcdeF5YPtLSojC8
         RN3laPxL2PWi22pIPdmGHTH2CmreARdwXcwzcxi8GefvIF8fHBEfI7U2MOQmD+F0Iscj
         YUgA==
X-Gm-Message-State: AOJu0YyXIVAlyhhw5Uz8i0y6cWeTjBEl//Zl5SWds4D6iktpFoz8ETNk
	lrF4mKoBC6bMk/qaTYdyS6ZtY0L7Wbz+EZdMs95V3bI+xC9/oFsP6UGS/8y0n9F9huimttg09jg
	IM9KIa6UrkQ5juU9lBydcSV8Blxsuo82t
X-Gm-Gg: ASbGncvL1rgl6NU5wxYwRt4wbhbYdt9i3aXWKD7Vj2pWFDEFhJcZtI4AL9i/92om1GV
	uYN0OXM9MaePYmVak/Zgdy9R9YjcaI4W8v5IEGF68g73yov0l+822S1DImOIuEQMBOO1vcHgrrw
	9BKD7oSGwOR3XyxAxwWDXfrf97pBHuFqw=
X-Google-Smtp-Source: AGHT+IGGbAlEej9DIjgmzjLXZOClQU4uAtoRJq98Lm6CuDSXtiNMS7G8aL7RUfVftpYqRHB/cHgXJuQT76UqQRgU1Ao=
X-Received: by 2002:a2e:a904:0:b0:30b:9813:b00c with SMTP id
 38308e7fff4ca-31907af388cmr6811641fa.27.1745585142072; Fri, 25 Apr 2025
 05:45:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Sheng Liu <liu.stor@gmail.com>
Date: Fri, 25 Apr 2025 20:45:29 +0800
X-Gm-Features: ATxdqUE1p0OcwYlziZsg4OZ-22--EMzxZNt7ehklqhRQMcMrqVbiNwNPAjdzgqw
Message-ID: <CAPJipUVDP2sT3cwj_K-tB1-Zpmc0uGKsg=9=qxbj3SaQmo+T_w@mail.gmail.com>
Subject: How can an RT application know if it is running in nohz_full mode?
To: linux-rt-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

If an RT process needs to run in an interrupt-free environment on an
isolated CPU,
how can it determine if the nohz_full conditions are met,
similar to how the kernel uses can_stop_full_tick()?
Would it be feasible to add a variable in procfs,
which can be read by other programs and notify the RT process throught
a shared memory flag.
