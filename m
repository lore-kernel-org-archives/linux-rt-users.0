Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31D8D7082D
	for <linux-rt-users@vger.kernel.org>; Thu, 30 Apr 2026 19:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777577530; cv=none; b=DnjS+STb+zQApxCyzWe7MPfXDoj4DlHpPypyiGJgjuPAEeUfeXUep6+ZFcNIbttHyEoRxepdOBdPVNmgMkFnOH9waLLFNMhxoDQmWorIW3DS8VWv0Udi92T4T2DFWqYNiU1Ze9/5mwLTuexytfrKxx2gJeWnzr/h93MocMnxkwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777577530; c=relaxed/simple;
	bh=nuJPiqrxp0d+mHf+6cXlXpGYysu8UR0rI3572IoApZ0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YrtMatxJRFyUfmk043qNQqQ3U7uJWXarxSIAcWUH+68374YleCm8V8OBNd5bDYqAlRQpsv5s8VwU4MTCZf2V4IicQtm/ymtMQfWdpoTgUjg7YmkaehKSuYFMV6VAlE2+YTRQHxuRCcnO1SlQrnXTtn66c1WouQ3JDJNOXvSQhVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RZrqmZEN; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RZrqmZEN"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-50e5c7eb565so11763601cf.3
        for <linux-rt-users@vger.kernel.org>; Thu, 30 Apr 2026 12:32:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777577527; x=1778182327; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=cobZolxizjbPCD511UVWOS5L/cYvBt9bua8rjmt7KLg=;
        b=RZrqmZENyYo1UyO6ieGpwSFa/SgcERoOoQE6MCfmeIECUEz5hZgld3u6XyvZz8l1d1
         sf3EVdERiQzsUmZ+YU2YF+rQCt141TSqnYsVBj3zNS5pBMXZuYbFAIBy+WzrrVPufnGE
         2nnAIpwILWqFL9FqfHs9CTsACknFY4y2QjWCi9KmxMqzKHIaikB/riL66EUUp1Bh5gl5
         +mfTi8WHJKD4UfikN8+MWRK17DnaszNnxg02PmbM7w+S3qzY9/pr4uDoHN/Iy3w2pNbe
         Zit5UfNM5Edhw7cjlvRrOIfOMEdiD2ABs3H31XJRVWYxj6xlU4D6GHJT2+jJxtVyqhAr
         ZHfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777577527; x=1778182327;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cobZolxizjbPCD511UVWOS5L/cYvBt9bua8rjmt7KLg=;
        b=IHLRtqfkBoVkdvFbT8ek/6KdxR06dB5jsPsWKM9VZz6NfkRi8B55PmAKIYEUJsqcDE
         r5xdSPqLO5+tN90b5JNfzZYGzQBJLD/zmol3EFyzmJi1VHBBPW2BnWstEJm5iLQGIGaP
         DLdnJAanjVsBfmrRa9H84LT5if952ZnbyqnyMI4zpDk+5PVem7/mOKtNIFR0h/bkD3A7
         YAnG91TVDYHpDrTWhJyWlY0GE4/wXrsaiB7JcCYYlceJ6XmmHG/omppY2XFF57kJ5pTv
         zeQTwkflK4HxZarEy/ZAns1updpvJ1dTRvnIJi5hAXYG8h9MM6nTuDN19+MVUudQKywB
         SN7w==
X-Gm-Message-State: AOJu0Yyi6O8KL09lO7qNUnHrh45X7Vz7TJ99uK/Tgxi27zKLFW/b4Hex
	Qz0Ktrcu3ajc6f+4MIsz71SzgGvsa7OAmx9R/xgd32RJqt0LMG09wMjSlvQ6Hg==
X-Gm-Gg: AeBDievWFaHkgKW2yc0ygjJABFQqQXLPmo56bY0CBXE5jzzIyO/6SmdEFGgwULvonmo
	qraj2iaS4jS9SiKgsI4iQXBu8CA0drVGPSmee+YnwaqKhf+IpdMlXOo0PVRsdK/zDFJvp1+1/w3
	BD8qvToV7Hj0RDdbqRb1tB2Nkv7oI4Hw9OPoqreuyThGD3HWWrNmj9kSnQHSyVADZHiGqnk5os9
	UWkHve5wsRWshj+UQjFWFmucHf7zg+79rxfgzvNt/Chnejz1gquOaOGWvNFRK79IeLzgaSAHE/l
	5n5+dTf9MH9hF01OM6xeq24afO8bYPQJiBDq6VrSVux22eXbN104xXrsNreXmB7yXZKnTf1iFLE
	Jpw8EwateHoXb/XTIiGSwXlNxjmBzXFcE4EeB0cITmZZIc94vD/Lanw45CzQiImb/SwACOq8rRr
	llWSH15JnkKjxgCFe7WZTyFN5hFgTJlFq+EVgliuGB+vw4sES1RPuV62M8NGzITHUQwXUZ/6qpt
	hG2Vz6i2Gom636K7+H8MoFaH9xVZg==
X-Received: by 2002:a05:622a:1456:b0:50d:8905:7cc7 with SMTP id d75a77b69052e-5102a93b4d2mr63916171cf.0.1777577527142;
        Thu, 30 Apr 2026 12:32:07 -0700 (PDT)
Received: from Cumhall.redhat.com ([216.209.112.32])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5103d1c6957sm4270391cf.2.2026.04.30.12.32.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2026 12:32:06 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: linux-rt-users <linux-rt-users@vger.kernel.org>
Cc: Clark Williams <williams@redhat.com>,
	Tomas Glozar <tglozar@redhat.com>
Subject: [PATCH 0/7] rteval: Add cgroup v2 cpuset integration for dynamic CPU isolation
Date: Thu, 30 Apr 2026 15:31:37 -0400
Message-ID: <20260430193144.354599-1-jkacur@redhat.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series adds cpuset integration to rteval, providing dynamic CPU
isolation using cgroup v2 cpusets as an alternative or complement to the
traditional isolcpus boot parameter.

Key features:
- New --cpusets flag enables cpuset-based isolation for measurements
- --housekeeping flag now works without requiring isolcpus when used with --cpusets
- --cleanup-cpusets utility flag removes leftover cpusets from crashed runs
- Automatic cleanup using Python context managers
- Full backward compatibility (no cpusets created without --cpusets flag)

Implementation philosophy:
The simplified implementation mirrors rteval's existing isolcpus behavior:
- Measurement threads get cpuset isolation (quiet CPUs for latency testing)
- Housekeeping tasks optionally get cpuset isolation (keep system noise away)
- Load processes use taskset affinity (no cpuset needed, just like without isolcpus)

This approach avoids complexity of migrating short-lived load processes while
providing the isolation needed for accurate latency measurements.

Benefits over isolcpus alone:
- No reboot required to change CPU isolation
- Dynamic reconfiguration for testing different scenarios
- Housekeeping can use any CPUs (not restricted to non-isolated CPUs)
- Can be combined with isolcpus for layered isolation

The patch series includes:
1. Core cpuset infrastructure and manager
2. Cleanup utility for leftover cpusets
3. Command-line argument reorganization for clarity
4. Simplified implementation (measurements + housekeeping only)
5. Development directory for untracked test files
6. Documentation updates
7. Warning for edge case (all CPUs isolated)

Tested on systems with and without isolcpus, with comprehensive test suite
validating all scenarios including cleanup on interrupt (Ctrl+C).

John Kacur (7):
  rteval: Add cpuset integration infrastructure (WIP)
  rteval: Add --cleanup-cpusets flag to remove leftover cpusets
  rteval: Reorganize command-line arguments into logical groups
  rteval: Simplify cpuset implementation to match isolcpus philosophy
  rteval: Add local/ directory to .gitignore for development files
  rteval: Update cpuset documentation to reflect simplified
    implementation
  rteval: Warn when all CPUs isolated and loads have no CPUs

 .gitignore                               |   1 +
 rteval-cmd                               | 193 +++++++++++++------
 rteval/__init__.py                       |  12 +-
 rteval/cpusetmanager.py                  | 224 +++++++++++++++++++++++
 rteval/modules/__init__.py               |  30 +++
 rteval/modules/loads/hackbench.py        |   1 -
 rteval/modules/loads/kcompile.py         |   1 -
 rteval/modules/measurement/cyclictest.py |   5 +
 rteval/modules/measurement/timerlat.py   |   6 +
 9 files changed, 419 insertions(+), 54 deletions(-)
 create mode 100644 rteval/cpusetmanager.py

-- 
2.54.0

