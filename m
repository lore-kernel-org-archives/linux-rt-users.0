Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDAC11AE00C;
	Thu, 14 Nov 2024 21:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731618780; cv=none; b=q2vxvoew8cWTs/pmT6CfZxnYZUqPncTJKkzQkj2dUlFEuDjM7T0Ic8GEWhViRh69vkF0Fs6aSRbI6fzzzYM6rUjMCiJalAULFMC2n4SgzN64x1w58bo6lSzSL65UA//LschffQq4wHAfttDhHOtCIh6E58rDSILat/Dqx34ektk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731618780; c=relaxed/simple;
	bh=7IfugFnQn+CKrMF2cBVGqs04H4THF3zDs9euY7HJyZk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=g4RRjktt2c+6nbGfyyz5oliLbHnhf8gaoyneHwPNRcAXImumg0JFCLN115ywiJZVh9sXhe3XqiU0UzvOjpYiWESexTXXtDFe3geYXSOe1HfpcQYsJsvwCP0/MDd43BTZsZeNARB38xIZ8I+X696pXQYYDpMndGSqhuaVoGJJo+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e+VDQjHP; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e+VDQjHP"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7b1511697a5so60518985a.2;
        Thu, 14 Nov 2024 13:12:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731618777; x=1732223577; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=Xfz0P8jsq3TcqwcN9EH79/QdWXmvC8vSfU+3QkiqMrw=;
        b=e+VDQjHPodvvCy1/ZJ8WZcZXVo6sNNqOKMf/CDlXOfxXmWGyeXhsabg15rt7frb7qm
         VAEtoF3xhICV2b5jzc8DyVGKJpneOTaY4AzAR5ZJkv/nM6Ohl1U5lj9XBTXKStFRaDJZ
         /F4BD9K6LwgHmupUflTDSv+qTx0fdsSo04SZK+xDYziqVPlvlAhAiYXTyqjMS03qlHKp
         lFFHpZAsRMZHxmwuD31xyrWgvMNVsV7FUz3QxugC1PoLXpGQnx+15+8sphPLOaInPyVr
         LcnMpYDW+S6JbSmsr1LaISwTFZK/Jz7cB/yNoYCUfUirC+CTwRKEvr4gP0BXcRSwAErl
         j+Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731618777; x=1732223577;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xfz0P8jsq3TcqwcN9EH79/QdWXmvC8vSfU+3QkiqMrw=;
        b=JOqXKDBh7rjKuUa0ZTuZJCCOrI9BxlGTAcp4lLFxJ1IWWF+UDd2abH45/VrliGBGyH
         kjqRJEzk5OJ31skSMsemDhDQa+6cxrGAU45+JUVvL+QYS2SgILyFmKVEt3i/rKU4tI7E
         rCHFptx5KcmUo7UtU2EEsjukU70AZybAS6u5cZOh84zgp8mPUYc7Hb8nR/TIGIkFe5Lm
         mKE81RSguGNX8dZnnrZinzWSRcbq/SKBo2utm+GTMjaToA5S4SnnTRJ2u+HMalT8MBa8
         Z5cREicUJwTeq2nK4eWob72SCfEluPHRbN7TLZpqGuYRs6pEzw8ipR6Gh/30dlwbbmiQ
         In3g==
X-Forwarded-Encrypted: i=1; AJvYcCUa+YiHrzKeM+Pr4TkaYvUp6PbKSKkdcZtiJ2lZVdeZYozhboEe8zJ3aYPji44LyJUkSUbYUg6i/nY1RVM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwH+YaPk6sCW+LDi9AgXKmIbU1ukFsMtFgU6UwPBoxeh5WzzPth
	rZCwCKy0QFfyEu3yaVVAHvNHlFdPcOq9kEfHEQR3rVr7YcmC8r/9x1ht3w==
X-Google-Smtp-Source: AGHT+IHEfmjXB8P6diOGd7arllqpXsp0vAR42DSW6tdeMMdXzSLOYika2RsasFspPq/+WPVyAiQohA==
X-Received: by 2002:a05:620a:4049:b0:7a9:bc46:2d13 with SMTP id af79cd13be357-7b36229f120mr50830885a.7.1731618776857;
        Thu, 14 Nov 2024 13:12:56 -0800 (PST)
Received: from fionn.redhat.com ([142.189.102.234])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b35c9abc23sm90455285a.54.2024.11.14.13.12.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 13:12:55 -0800 (PST)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: RT <linux-rt-users@vger.kernel.org>,
	lkml <linux-kernel@vger.kernel.org>,
	Clark Williams <williams@redhat.com>
Cc: Crystal Wood <crwood@redhat.com>,
	Chris White <chwhite@redhat.com>,
	Tomas Glozar <tglozar@redhat.com>,
	John Kacur <jkacur@redhat.com>
Subject: [ANNOUNCE] rteval-v3.9
Date: Thu, 14 Nov 2024 16:12:48 -0500
Message-ID: <20241114211248.256377-1-jkacur@redhat.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We are pleased to announce version 3.9 of rteval

This version runs rtla timerlat as the default measurement module.
You can still run cyclictest as the measurement module by editing
rteval.conf

John Kacur

To fetch

Clone
git://git.kernel.org/pub/scm/utils/rteval/rteval.git

Branch: main
Tag: v3.9

Tarballs available here:
https://kernel.org/pub/linux/utils/rteval

Older version tarballs are available here:
https://kernel.org/pub/linux/utils/rteval/older


Anubhav Shelat (4):
  Updated rteval man page
  rteval: fixed manpage to include stress-ng header
  rteval: Added functionality to allow user to set the cstate of
    specified cpus when running rteval
  rteval: run cyclictest using '--default-system' when setting idle
    states

Crystal Wood (9):
  rteval: sysstat: Convert base64 data to text before wrapping
  rteval: measurement: Remove ModuleInfo()
  rteval: Remove MeasurementProfile
  rteval: RtEvalModules: Remove unused methods
  rteval: Enforce only one latency measurement module at a time
  rteval: Add --noload option
  rteval: Fix default measurement config
  rteval: measurement: Change latency flag to latency_test
  rteval: Print useful exception info and exit on missing measurement
    tool

John Kacur (12):
  rteval: timerlat: Add timerlat tracing to rteval
  rteval: Fix sysreport traceback when utility sos not found
  rteval: timerlat tracing clean-up
  rteval: restore all load module options
  rteval: Upgrade load kernel to linux-6.10.5
  rteval: Fix parsing in kcompile of the kernel to compile
  rteval: Change constant name to uppercase
  rteval: Update the kcompile kernel to linux-6.12-rc4
  rteval: timerlat: Add --timerlat-interval
  rteval: preface idle-set IDLESTATE with --measurement
  rteval: Make rtla timerlat the default measurement module
  Create rteval-3.9

Tomas Glozar (3):
  rteval: Fix -aNone being passed to cyclictest
  rteval: Add module for tuned state
  rteval: Add tuned state to rteval text report

 Dockerfile                               |   2 +-
 Makefile                                 |   2 +-
 README                                   |   2 +-
 doc/rteval.8                             |  54 +++--
 rteval-cmd                               |  31 ++-
 rteval.conf                              |   4 +-
 rteval/__init__.py                       |  97 ++++-----
 rteval/cpupower.py                       | 125 ++++++++++++
 rteval/modules/__init__.py               |  99 ++++-----
 rteval/modules/loads/kcompile.py         |  34 ++--
 rteval/modules/measurement/__init__.py   | 189 ++---------------
 rteval/modules/measurement/cyclictest.py |  23 +--
 rteval/modules/measurement/sysstat.py    |   9 +-
 rteval/modules/measurement/timerlat.py   | 212 +++++++++++++++++--
 rteval/rteval.conf                       |   2 +-
 rteval/rtevalReport.py                   |   3 +-
 rteval/rteval_histogram_raw.xsl          |  24 +--
 rteval/rteval_text.xsl                   | 247 ++++++++++++++++++++---
 rteval/sysinfo/__init__.py               |   5 +-
 rteval/sysinfo/osinfo.py                 |   6 +
 rteval/sysinfo/tuned.py                  | 191 ++++++++++++++++++
 rteval/version.py                        |   3 +-
 22 files changed, 968 insertions(+), 396 deletions(-)
 create mode 100644 rteval/cpupower.py
 create mode 100644 rteval/sysinfo/tuned.py

-- 
2.47.0

