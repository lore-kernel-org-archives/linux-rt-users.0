Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F10D9463;
	Thu, 28 Nov 2024 21:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732830673; cv=none; b=uYAIcZF/CMtdjQOv53M4GPjn/jYazAxWvmIpUPE5g/wLmEMx+y5VuwMtyCYojglXS5ZjdCj6depjphxa8AK+3CkHdH6VRxhciPij93I2rrkI5ajVMI7c5XHpjkFV8N1yBtUadvW3WMp2JtOM6HGvpAELWRrBcgq73v77bsgaWEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732830673; c=relaxed/simple;
	bh=YQhwy3k6zFY7PS+Hb3mt3RsGwW4p9dQ1NWB5H6WET80=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OpfSoza8U05K9BnFGc8nD2Ce18U7gyqkSwXgNpW5JCa6EuBT1mJqm/QLo/Rnu2F1OTMdQ6iuwvkg3O7E3/K7wTOtM0mui+ytJLybIi8cY4+i/WuD3Qhar6c4VaLxXgXkrHQgG1RXScKF/pLItu4og2q4N/q40ErHn4iottm9FnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hAACs7yi; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hAACs7yi"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-46679337c24so8922611cf.3;
        Thu, 28 Nov 2024 13:51:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732830670; x=1733435470; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=B/0P/kkOOn0Emox8f2ASqKm3nT6bT0ghGONfV88YlVA=;
        b=hAACs7yiK5L1d+otwmJyavWVSd7E1nk4ZyKQXZGZANP/OhJRpnIrfO8MBT4qTXAhXa
         tjqlOhQOxMTC88QvblU5njNjPK6h/WdO40BKZ/ltjCl6d6lPDs6DskSlZwzX/OuiQ0XL
         Bl4WIz6CVWSCqMGdrnedyWhAN4uq4Ef5j2UE5e7cFpiu5/+WQfqLhE2GeOYarrSF2IaM
         PpZAUYrfRH6dlFq2VJvlB1IC4JvEN5a6K2K5poBHwou0NNygcuBsXwS1S4+M20yz10S1
         B1Ipnp879IViJ0T2a3USWB22fu1XX1Ok2ro+Xl0et6uqd+Pq18yTbk8PswJxSKTnP2Kf
         bP2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732830670; x=1733435470;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B/0P/kkOOn0Emox8f2ASqKm3nT6bT0ghGONfV88YlVA=;
        b=PbwrPEweaWw/pywHOjH54b97LERxy/a7/UmeCGeV8aFQD/5rnJFIB+9KLU/AeBV2fU
         V9SRj+HMAc8I6IDHFdFDwbPf7aA9hV4a5syGYRDygiMxG5lT749A+d2f4uNarhJgQ4x1
         xSYyHn7Kx9CQNnB1cAYSRzKi6aRxtHeZyDeEfCQn2VToJlKytBb7gTcV/av/g0G/qpwb
         Hr5npk4TMQzi4N7nlHOTWvDjIKo1mB4Rfmj3V8nsXOvs+hwzlg8xNX0GQW3GyCnNj19t
         oC8Y/pEv6oEVkVcUaiIyuaRg3Cm0pGBjZT0ioVejNdyPwk3T92PnnQuSkZldswFWDImS
         3V8A==
X-Gm-Message-State: AOJu0YxFe11KT6x5f1z3tLELtGtEtv7RpYzUkSNkCDak1lImYcXd+QR3
	nqkb0G1PTo64aNSBl7jvY/IACHZxESmE9K7q6qTUbFwmicZpKYBYH8itr0rb
X-Gm-Gg: ASbGncsNia1SMeBn15D0aNqa6WK+b3MAJtk36F2ateeQ0HXYm7wyblKyB9SUVHuJ1MW
	odnUs7JLkvl6OESagQnMJqxUjipnKjpmHqgCeShMXosYO+096KjiJN4PYdeW0gUYjskVhuH3YOr
	lHv41ouCPBUZBqnZSeQWLdX8coad1dMUIKAHfZbrZZbYIYQOFIUx4nmfHa3cm2wyoTQKKlpHnuu
	8V7TKWUEAHBrm/r48xrgiUIvqmEiVVzQSO0qy21sG7ARh0=
X-Google-Smtp-Source: AGHT+IHyUdObtxfjeGYjZO8kCr2GNZZXz83fSwks2FQsdK+NE9qPtvpw5zrKY8j9ruSeyyBLqGRTUw==
X-Received: by 2002:a05:622a:341:b0:460:a82a:39a8 with SMTP id d75a77b69052e-466b35166c9mr134763141cf.13.1732830669693;
        Thu, 28 Nov 2024 13:51:09 -0800 (PST)
Received: from fionn.home ([142.189.102.234])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-466c407cfdcsm10229741cf.45.2024.11.28.13.51.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2024 13:51:08 -0800 (PST)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: RT <linux-rt-users@vger.kernel.org>
Cc: lkml <linux-kernel@vger.kernel.org>,
	Clark Williams <williams@redhat.com>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	Tomas Glozar <tglozar@redhat.com>,
	Tan En De <ende.tan@starfivetech.com>,
	"John B . Wyatt IV" <jwyatt@redhat.com>,
	Anubhav Shelat <sanubhav1000@gmail.com>,
	Eder Zulian <ezulian@redhat.com>,
	John Kacur <jkacur@redhat.com>
Subject: [ANNOUNCE] rt-tests-2.8
Date: Thu, 28 Nov 2024 16:50:59 -0500
Message-ID: <20241128215059.40116-1-jkacur@redhat.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We are pleased to announce rt-tests-2.8

To fetch:

Clone one of the following
git://git.kernel.org/pub/scm/utils/rt-tests/rt-tests.git
https://git.kernel.org/pub/scm/utils/rt-tests/rt-tests.git
https://kernel.googlesource.com/pub/scm/utils/rt-tests/rt-tests.git

Branch: main
Tag: v2.8

Tarballs are available here:
https://kernel.org/pub/linux/utils/rt-tests

Older version tarballs are available here:
https://kernel.org/pub/linux/utils/rt-tests/older

Thank to everyone who contributed.
patches, bug-reports are always welcome.

John Kacur

Anubhav Shelat (2):
  rt-tests: hackbench: removed extra use of optind
  rt-tests: hackbench: properly recognize when integer arguments are
    negative

Eder Zulian (1):
  cyclictest: Fix help text for '-a' option

John B. Wyatt IV (2):
  rt-tests: pi_stress: Move unlock into if block with matching lock
  rt-tests: Add console_commands.json to gitignore

John Kacur (3):
  rt-tests: cyclictest: Reformat help for 80 char screen
  rt-tests: pi_stress: Refactor pi_stress creating a header file
  rt-tests: Change to version v2.8

Tan En De (2):
  rt-tests: queuelat: Fix wraparound in __clock_gettime()
  rt-tests: determine_maximum_mpps.sh: Get frequency from
    timebase-frequency if cpuinfo fails

Tomas Glozar (3):
  rt-tests: Detect libcpupower presence
  rt-tests: cyclictest: Support idle state disabling via libcpupower
  rt-tests: cyclictest: Add --deepest-idle-state to manpage

 .gitignore                             |   1 +
 Makefile                               |  17 +-
 feature/Makefile                       |  12 +
 feature/test-feature.mak               |   5 +
 feature/test-libcpupower.c             |   8 +
 src/cyclictest/cyclictest.8            |   3 +
 src/cyclictest/cyclictest.c            | 219 +++++++++++++++++-
 src/hackbench/hackbench.c              |  12 +-
 src/include/pi_stress.h                | 133 +++++++++++
 src/pi_tests/pi_stress.c               | 298 ++++++++-----------------
 src/queuelat/determine_maximum_mpps.sh |  10 +-
 src/queuelat/queuelat.c                |   3 +-
 12 files changed, 501 insertions(+), 220 deletions(-)
 create mode 100644 feature/Makefile
 create mode 100644 feature/test-feature.mak
 create mode 100644 feature/test-libcpupower.c
 create mode 100644 src/include/pi_stress.h

-- 
2.47.0

