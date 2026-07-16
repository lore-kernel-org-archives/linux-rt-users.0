Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26F8B2D238F
	for <linux-rt-users@vger.kernel.org>; Thu, 16 Jul 2026 17:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784223973; cv=none; b=RP+Ym2KOgmjR5joDCDuzb+05aJYeQkXL/h0HGYKjq8jktgUAsnUsHjqiguh9/1UI0um2Rf74kUx10RINZdmcqyX1Onv/V24JCT/UpHJ5oaWbb0P5bebjYQQlT3+1bDLb7fjOHJpUlw1vQICPVax4KTkeiMNqHmDooUs3IDNePow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784223973; c=relaxed/simple;
	bh=C6DbbuM6FuOXbI7wGiBU/nNNFBNSQQHOmkuJ3pWDkNc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rweGcUxX3x2SayhpE6QR+/q1VRiFHh06h6zfKBAb+35jbHqmHo4ZXyCtnIzTF1DPuKwZ6YrA2T2p/VQ8MAp4K63r0JevZZo+5l8Rmc39HgIUdd2bTHftCUPZEcVsoslAQ+MFR0x96lkK6YWa4wUXGh00h6Sx3GNX2nWW4yD9jIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fcLjwc4N; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fcLjwc4N"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-8f186025973so72220906d6.0
        for <linux-rt-users@vger.kernel.org>; Thu, 16 Jul 2026 10:46:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784223971; x=1784828771; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=/xF7+sur00Ae3NhJaPHMRFV3Jf6k8/ct/Ql8jLVI3iY=;
        b=fcLjwc4N+o9FQ5zX7ZAeOSBnXTw4M7tayGU8VV5TLa8cBgF3LaW9eJEhY5DBWiN6og
         pFiePGbNv9XvjfdNiwxJQmOC7bx7dFcVqOeSoIF4JxG1ZtTvFSJxDSJ0uRDu/KcepGfW
         TPtNOuzd2Iu+2E25a2btOIhVv8/Uyy7ILZwG8RQM0g8butbHJDd3XMy29AfUAiCB6chE
         9xYIYFPVMfAqTlhgoJWDhpR+6R4su7wWBBFRGKCrJSEOw9Jtn7JeL6FRNfsTF3rUFrhp
         oOkmWnJRbrH9vXlnQDaeKPh/t0f/b1Je4g8/bYE8xCqZmNj1tnf8rmv5bEiP2TGAFshT
         wS/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784223971; x=1784828771;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:sender:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=/xF7+sur00Ae3NhJaPHMRFV3Jf6k8/ct/Ql8jLVI3iY=;
        b=i4FY5jr9UhZ/Y8MZvTP6DwMajz1gyPz0oGccoOYYmTZe22Gk/NaNasEK5Lq88eBUoc
         Cv623wR/g4TJdoMfluWHAMETPnodnug9NlbdjFUFE++O82rHYYtY+HJXl8pTKT8g3HIG
         oRZi2issV85QojIv4WUEBvkmGqKyJpmw/lYnVLzOvbeAo5My65NzOQRoaN29FIJjs8Mh
         WIMrOf5P7YkwV2cjsUDKzT68TBOP4FC6Q7M400lwu03VxXQI4/IEXP/BcF0fwqCbuRSs
         3Cm9WnBAs+G1iS9i3OeBxk7YrMuXQDu3ppkVmz1U//FbhQ5mH91imzky0cJG0apmz2Oz
         yYfA==
X-Gm-Message-State: AOJu0Yw9F0KkfSvZi/VYeJ27cfo2viIodE3hPOEf5Cl8TeeAHI1fR7D8
	QwysaOMnOwQg3JPAxWD51zFQjxAeYEtotJ7dGf8XGLoK7wQtLNtliqK12sRfBg==
X-Gm-Gg: AfdE7ckMDLfhBchaHyO5ASVkADRyZvMP+6beDUrdW4WJkrglcL9cFXODrR+V+zb19XR
	XxM5UwCYX/8vq1GvW9mCkNnwMrHXsssyK8j2zPORB3zj/Zw4q4ZaijOpIec0opALH/h9ILVCS/x
	3PE1qyZx4GsauCE23TQfhobHmA66YfiLd+poeVPoJxNC1BMz7GeUtKKiE1hyU1+jq0XCoLSyq1C
	XuOeXlEsegdQ0naXjWVUHVwjDc4w4nzRZAHrUH9IEz1smDCBcE26GnM8aVB8ADBvjXGukioN4GG
	jO+weK3JcXHAUTrNbclbFRsEudipCIRmk5bmjm1CQ3chZzBub5Bu/ArTHJbP+oHoaWHbfq6Yfbr
	0C5xtCTogeTinJTCXNtuNT2gqCFaozPXhubO5D5f4DE3wuaHB2YxPWnZLd7VKelwGMyCDCbYshx
	PvOrCo4zCBLvyJIyZOD202UVdynzbFhSFmgUpdNCRsQo+SFwCT2yeaUynRyp2Duo5K1+TWXr18Z
	OnHmCQ=
X-Received: by 2002:a05:6214:1c84:b0:8ef:24e9:4258 with SMTP id 6a1803df08f44-90758dece58mr93079476d6.39.1784223970834;
        Thu, 16 Jul 2026 10:46:10 -0700 (PDT)
Received: from Cumhall.redhat.com ([174.95.68.136])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ffd50e0347sm224952276d6.2.2026.07.16.10.46.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 10:46:10 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: linux-rt-users@vger.kernel.org
Cc: Chris White <chwhite@redhat.com>,
	Clark Williams <williams@redhat.com>
Subject: [PATCH 0/7] tuna: Add cpuset save/apply functionality
Date: Thu, 16 Jul 2026 13:45:43 -0400
Message-ID: <20260716174554.126145-1-jkacur@redhat.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This series adds save/apply functionality for cpuset configurations,
allowing users to save their cpuset setup to YAML files and restore
them after reboots or on other systems.

This builds on earlier cpuset integration work and addresses a common
use case: making cpuset configurations reproducible and portable
across systems. While the primary use case is RT workloads, the
functionality is general-purpose and works for any cpuset-based
CPU partitioning scenario.

Key features:
- Save cpuset definitions to YAML (name, CPUs, memory nodes, partition type)
- Apply profiles to recreate cpusets from YAML
- Automatic filtering of system cpusets (systemd slices/scopes/services)
- Idempotent application (warns if cpusets already exist)
- Full round-trip testing (save → destroy → apply → verify)

Example workflow:
  # Set up cpusets for isolated workload
  tuna cpuset create -c 4-7 -n isolated --isolated
  tuna cpuset create -c 0-3 -n housekeeping

  # Save configuration
  tuna cpuset save my-config.yaml

  # After reboot or on another system
  tuna cpuset apply my-config.yaml -v

The series also includes some cleanup:
- Removes obsolete top-level 'apply' command (not cpuset-specific)
- Simplifies GUI sysctl configuration to monitoring-only
- Removes unused translation files (po/*.po)
- Fixes housekeeping cpuset default (partition=member is correct)
- Renames default profile file to cpuset-profile.yaml for clarity

Testing:
- 12 comprehensive test cases in tests/test_save_apply.py
- Tests cover: save/apply, round-trip, edge cases, error handling
- All tests require root (cpuset operations)
- Tested on Fedora with cgroup v2

John Kacur (7):
  tuna: Add --show-system flag to filter systemd cpusets
  tuna: Add cpuset save/apply functionality
  tuna: Add comprehensive tests for save/apply functionality
  tuna: Remove obsolete apply command functionality
  tuna: Simplify GUI to monitoring-only functionality
  tuna: Change housekeeping cpuset default to partition=member
  tuna: Change default profile filename to cpuset-profile.yaml

 po/LINGUAS               |   3 -
 po/POTFILES.in           |  17 -
 po/ja.po                 | 718 ---------------------------------------
 po/pt_BR.po              | 634 ----------------------------------
 po/zh_CN.po              | 667 ------------------------------------
 tests/README.md          |  52 ++-
 tests/test_cpuset_cli.py |  30 +-
 tests/test_save_apply.py | 300 ++++++++++++++++
 tuna-cmd.py              | 247 +++++++-------
 tuna/config.py           |   2 -
 tuna/gui/profileview.py  |   4 +-
 tuna/profile.py          | 177 ++++++++++
 tuna/tuna_gui.glade      |   8 +-
 13 files changed, 661 insertions(+), 2198 deletions(-)
 delete mode 100644 po/LINGUAS
 delete mode 100644 po/POTFILES.in
 delete mode 100644 po/ja.po
 delete mode 100644 po/pt_BR.po
 delete mode 100644 po/zh_CN.po
 create mode 100644 tests/test_save_apply.py
 create mode 100644 tuna/profile.py

-- 
2.55.0

