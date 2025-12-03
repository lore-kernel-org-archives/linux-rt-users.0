Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1D942BE7A7
	for <linux-rt-users@vger.kernel.org>; Wed,  3 Dec 2025 21:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764796997; cv=none; b=sHwAY4PM4Xcuo4H6kplkDFmE333zJ+JNbxaSdmEW2m5eAHSBFAE2hHV497ogM/ARgkLuI5JUXqrytehEP/bUBL2c2mLAIWNklClZswSgP/TpVtnsgxdlOWWCXX51V/mDh8j461mfe81gl6rDlEctAWU7toMkbPBWOf8WecJ7oYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764796997; c=relaxed/simple;
	bh=KNFZFw7tRFEPKs9tNGfroq0Y5pR/V+OhDJi0pxfm2to=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=uInoXlX/ao1CPE6JyJLRUqq0czTH8aeiCPhin6YOoLAqdFqzAnFIFx8j4JbwN3MsNiWpOaNc5NpHqP8ObXzAynxyfCt0ySvZ41hVCgejlGkpZbx4SRQpW8K2TamvsE8xe5z5qjaSYoMIJvqzKyPOoDyyPAWbFmWXyxXIQ4yv+s0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nW8Z9Yz9; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nW8Z9Yz9"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-429ce7e79f8so192970f8f.0
        for <linux-rt-users@vger.kernel.org>; Wed, 03 Dec 2025 13:23:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764796994; x=1765401794; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=WURfXksCi8NRDm1fsZIoo4qusOATHOouSHqYoTGZVYU=;
        b=nW8Z9Yz9CiFYxfjgTga+HVL434hds1/HFFuaJN2kx0t0RSzKpY2o7Su8f8/xe1m5XH
         A6vGIwol1TJ+HwS8HNiQxsVFZkcyjqLrwneakk8F5q0WPIWW7CHYY6ifHElOCZqc38gu
         HlrMINGjTVnqmJas53/0/wG2YqqxXsLsxVj2fy/p/FYx9COgrSovRAl8nDzoGPJ5AuVI
         FPJ3bODOHZL+iW9ozPeWWnZ4ZjnvLJn3zD/DjAwHMlQa4snUIRIXwh9afUrGoebIwHzs
         ih6vS3Kv4jdc5GqO2NJ1AXYXWR2wqFOx4ljhw+CPUxcOFwLr8OOJrg+nqThrYyYx7JOV
         SzRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764796994; x=1765401794;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WURfXksCi8NRDm1fsZIoo4qusOATHOouSHqYoTGZVYU=;
        b=eLC11XBTlu7SZvereoE3apCbW7J3zwQ9rJKxOo0l2ZasoSHvBea8b4NdB+sXaV9PJN
         Ko329Nv4/WTNriT86NnkWNnu7ms3Z6eWhSU/wRezHmpnNKJMfqXclFVUTP6vhxl9UCRB
         CyMd6dmo2E0fZMpOpEHwtWSop9T/TOVU+XCtCKIn4uuUiqEDcB0FIREL+W9TV06wFFf7
         haI9VS42RNW13iz2c9d6sfpDx0pInSKxLcLQjKEB/w6kVnCi3vgp+HkgmnC45hRup319
         wwVYx/uZ4gnMuIDJ780Kpxq1wsgV0bIBPgKwfF2OvdgWlCQRlLIKXKD+eGji3YlOfy2R
         fGbw==
X-Gm-Message-State: AOJu0Yz8L359t5qamnfXbrAc/pxn7RUw+K9uF9EBZ3/2sutKsYKhl2cI
	gtcYum/saVxOeRT4mOJyORpyesL6zVF9Opwv0m09IpH2yl0LrPcQHC+zbOD3HTLdfcNoQ+glHNn
	w2w0Sci2ayNqHPStXhQrtV9L0KXQQHngrDXYG
X-Gm-Gg: ASbGncu+0xS8ooFf9sixhcLyCjsp2nlOHy9NuxFWEgVTk+AzSXrT9p7pXn9xz83sV6R
	XvAiSkO9wVEnnU1aaXuZSEA7g9AsGND+GDXC15otCJ62Mv979fAzyGgXi7rneokxxQlg+3b3V2y
	m01WNIg/IaWHzQscIO8rrTGbGGheoooLN/+77p+xcCYioVKCMrb+IxRBA/PDm9to8EYry0kC2+o
	3M1dYIv53LKl862lDt2kMiRl7nDf/66egfzh8EC6umWuGgQiral5GlSReAlnvn+arehH+FHMVt8
	eBJe3KHpmN1LBCGkov3cFRTBc2ZS
X-Google-Smtp-Source: AGHT+IE7kWwxGt8oGn4RQrIXDYf436rcEQuz7qGnaFxCgePbECYC7OwO4K6+qybU4ZM4rFlbz5GqTswxbiIzNQhdQPc=
X-Received: by 2002:a05:6000:2284:b0:42b:4961:eb4c with SMTP id
 ffacd0b85a97d-42f7951489emr426428f8f.1.1764796993744; Wed, 03 Dec 2025
 13:23:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Michael Schanne <michael.schanne@gmail.com>
Date: Wed, 3 Dec 2025 16:23:01 -0500
X-Gm-Features: AWmQ_bntZQx6r72plpyDzPEXFKchz9oVjcqhgws8x9WXZmT6kbDeunoeubLSloc
Message-ID: <CAC_kJhQ53MGieN29Kmx96bk-8hhnLb_7bp7cb_kFQ+Hf-_Gtgg@mail.gmail.com>
Subject: Random lockups with i915 driver enabled
To: linux-rt-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,

I am troubleshooting random lockups using RT patch 6.12.28-rt10.  The
lockups seem to be completely random, sometimes occurring within 10
minutes of bootup, sometimes several hours, up to several days.  When
the issue occurs, the system is completely locked up.  Keyboard and
mouse are unresponsive, serial console unresponsive, network
unresponsive.  There is no clear pattern of what triggers the lockups,
it can happen while the system is sitting idle.  I do not get any
output on the serial port when this happens.  At the moment, I am
suspicious of the i915 driver.  Things I have tried:

Revert RT patch - no lockups over 4 days
Install RT patch but disable DRM_I915 in kernel config - no lockups
over 24 hours

I have tried enabling hardlockup_all_cpu_backtrace=1 /
softlockup_all_cpu_backtrace=1 in the boot parameters, and had several
lockups in this configuration, but I still get no output.

Due to the random nature of this, it is very difficult to know whether
the issue is gone or just not enough time has passed.  Also, I have
built 4x systems in identical configuration, only 2x show lockups and
the other 2x don't.  Software is exactly the same on all 4x machines.

Can anyone suggest any debug techniques to nail down root cause when
the next lockup occurs?  Or are there any potential i915 fixes I could
try out?

Hardware: Intel i5-6500TE quad core CPU (Skylake), 16 GB RAM

Thanks,
Mike
