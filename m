Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AE3212B94
	for <linux-rt-users@vger.kernel.org>; Fri,  7 Nov 2025 18:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762541877; cv=none; b=aM12+oweTpJ2pT/GPZ4tLLp/oCeZ8+hE0NGXbH+eS60Lu9bZlvnu54ysEIgbFS1Oe6gupuVriObeDjGp4iewf5ktXVSaHyJA9mkOQby6vb67eAHmqa7Vi9R5p6wyJQTBGQfg7PsNrvuwvqMHf5frulmBXYB1YXvIcVqFZQnqVa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762541877; c=relaxed/simple;
	bh=+5vJVBz/TdTB873PS6aN0zH/EFmwLiZakIhmqnkBCFE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=obRC1Im8a7d5iutDvlgShCnJ4o+pgDsWcbRxI3wRfFwLacy1E121f0cUIuGcR/8NIye0FHWEFd5fPYAufg5nTta7shrY30oLFwt7ai98CPlvYie56U5cDKZkF8YeaXyeD/ILugA6KIfEZhnGfJ7YCkIPGc2d96+peHYqHMcxfTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SY+u/uoY; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SY+u/uoY"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4e89de04d62so8743091cf.0
        for <linux-rt-users@vger.kernel.org>; Fri, 07 Nov 2025 10:57:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762541875; x=1763146675; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=NynGEazn6IX/svgSZt5k/IJ1RxqIup8UpGU8oEX/25o=;
        b=SY+u/uoYyFWNZ4SLe/+Nfq1ofaZiDbVMKtyzHpMRm3wInKZbke1wFsNcY58KMHd+0n
         FaRxA6Uk4aI79noWVyVmXXFx5VvK8O03eU/3w+/8VlhpW0sC5xf47Gf4GNiCoDFNXmdi
         6t3AFBgXK79N7RrLUNuis6Y9kpkTZBF+zSoPKN/iUoHSPKmMRerOBWU6CrUc4eB7dupB
         ju64oGF30RrRkaTCvdjt4Ll0rWuDYBB8l+TjIEhSbhXOcKLPZPrNiruj50mt/dLLiWFe
         p+oxZ55mVhw3+ChI+6ugyE2dDHHUDr14yoWFH3F00d8IzQv0u/82YxEzUpucsQcxkgfv
         7FqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762541875; x=1763146675;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NynGEazn6IX/svgSZt5k/IJ1RxqIup8UpGU8oEX/25o=;
        b=QOe7M0in42jHdQp6dOK61EAHg+8PmkE5XVGLvVUnNZ3Yz8oC69cdUp4uDKYvml4oB8
         HjSuK8bA/vgWQWc2SdhbEwHtmYRKv5tTrtLySCrmAqayjQpS1TSuRuDqpYQT2Dl+GHLR
         txuB9zh3VrKnJf0qeHrmNx7Sj/6gz3NdyLupNYPvUjoPxt2V8+yOyuysmDd2t1dHvaqN
         W5mgj66hJgyar7vkLZlzN4KOgjjMX05j8z8eWquNAJfGK5bDHwS0tjbVxkvT8rkd+DBT
         ySBqkrDk7u+g4isp2HytWvRvhub7MZJX5U4BQgkTIogKEklJ28DAFSofU4dpU3uI0+0R
         hcuA==
X-Gm-Message-State: AOJu0YxvBSkriaF8xaq2YFz1JUh9aWCZcA4VwRpOzZMpqZjrWCQdlNgA
	y/kdV0Gua6HRDPNYnZmO6emkYM+Dc5D5CxJ56woMd69K6LMDufr12QbGjS0Ka8EQ
X-Gm-Gg: ASbGncsgKGk9Z4Ei+1ONk91psaTfCTDiQF1lRcI1QPF/Rn9nDHcwMNGTMBO0hM/V227
	/IK9xRWwfp/7xLqUrJ11sBDbNLsv/phWGiouxC6gt5EvYfPnCKwev5ArpON5nolGWDfr45aaFCG
	h3pFWIUbU2pzfGu/SYiSfl8jq8SimezI+1TNF7N7tUpiOzspr8ieryAiujnSRQUPUgF1bZTHYc1
	k3FDTh6Njnc5ia4KSMO4wzApwJ1QizExsl0sJDNazm/Zf59K7+XM0gbWo5ne6YnkB8FrOJ/ttFf
	2GiNzV8pBSDx7WjM9Bp1GNxhVbIobsqR+UAnycmS742AnMKasnEgiQ2JD2suv9ondER4HXcdAF/
	ovT1JnSSOXeXHJkq/JhEkWcfUEFrYLVkN/tQ5zhPzjSV+hljVCddkPqDiPuqgMRCxwBz6oloXvA
	==
X-Google-Smtp-Source: AGHT+IFA+st054/GY6Rlejazjr/encwVCrPeDd7T95lt7JPzwKlNQFQ1OrqcX/Nst9uLkhEJrghvdA==
X-Received: by 2002:a05:622a:216:b0:4eb:a622:d95b with SMTP id d75a77b69052e-4eda4fa45d4mr1801721cf.51.1762541874601;
        Fri, 07 Nov 2025 10:57:54 -0800 (PST)
Received: from fionn ([174.88.40.44])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b235828514sm458103785a.53.2025.11.07.10.57.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 10:57:54 -0800 (PST)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: linux-rt-users <linux-rt-users@vger.kernel.org>
Cc: Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>
Subject: [ANNOUNCE] tuna v0.20
Date: Fri,  7 Nov 2025 13:57:09 -0500
Message-ID: <20251107185732.23992-1-jkacur@redhat.com>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To fetch tuna:
Clone one of the following
git://git.kernel.org/pub/scm/utils/tuna/tuna.git
https://git.kernel.org/pub/scm/utils/tuna/tuna.git
https://kernel.googlesource.com/pub/scm/utils/tuna/tuna.git

Branch: main
Tag: v0.20

Tarballs are here:
https://kernel.org/pub/software/utils/tuna/
older ones are here
https://kernel.org/pub/software/utils/tuna/older

Enjoy!

John Kacur


Clark Williams (1):
  Add SPDX license identifiers

John B. Wyatt IV (9):
  tuna: Fix string syntax warnings with raw strings
  tuna: Fix help.py syntax warnings
  tuna: extract common cpu and nics determination code into a utils.py
    file
  tuna: Add idle_state control functionality
  tuna: Add Pyright helper
  tuna: Update man page with cpu_power command
  tuna: replace match with if statements
  tuna: Proofreading fixes
  tuna: Remove broken testuna

John Kacur (13):
  tuna: Remove spec file from git
  tuna: Don't start the gui if a display is not available
  tuna: help.py
  tuna: utils: A few tweaks
  tuna: Fix show_threads -t and show_irqs -q
  tuna: Fix run command failing to apply BATCH policy
  tuna: Add -U and -K to the move command
  tuna: Add -U and -K to the spread command
  tuna: Fix setting a realtime scheduling policy
  tuna: Update setup.py with co-author and metadata improvements
  tuna: Add pyproject.toml for modern Python packaging
  tuna: Update version to 0.20
  tuna: Fix pyproject.toml build issues

 .gitignore              |   1 +
 MANIFEST                |  30 ------
 Makefile                |  42 ++------
 __builtins__.pyi        |   1 +
 docs/tuna.8             |  18 ++++
 etc/tuna/example.conf   |   2 +-
 org.tuna.policy         |   1 +
 oscilloscope-cmd.py     |  15 +--
 pyproject.toml          |  42 ++++++++
 rpm/SPECS/tuna.spec     | 137 ------------------------
 setup.py                |  20 ++--
 testuna                 | 230 ----------------------------------------
 tuna-cmd.py             | 110 +++++++++++--------
 tuna.desktop            |   1 +
 tuna/__init__.py        |   2 +-
 tuna/config.py          |   2 +
 tuna/cpupower.py        | 176 ++++++++++++++++++++++++++++++
 tuna/gui/__init__.py    |   2 +
 tuna/gui/commonview.py  |   2 +
 tuna/gui/cpuview.py     |   1 +
 tuna/gui/irqview.py     |   1 +
 tuna/gui/procview.py    |   1 +
 tuna/gui/profileview.py |   3 +-
 tuna/gui/util.py        |   9 +-
 tuna/help.py            |   6 +-
 tuna/new_eth.py         |   1 +
 tuna/oscilloscope.py    |  15 +--
 tuna/sysfs.py           |   2 +
 tuna/tuna.py            |  24 +++--
 tuna/tuna_gui.py        |   1 +
 tuna/tuna_sched.py      |   1 +
 tuna/utils.py           |  30 ++++++
 32 files changed, 399 insertions(+), 530 deletions(-)
 delete mode 100644 MANIFEST
 create mode 100644 __builtins__.pyi
 create mode 100644 pyproject.toml
 delete mode 100644 rpm/SPECS/tuna.spec
 delete mode 100755 testuna
 create mode 100755 tuna/cpupower.py
 create mode 100644 tuna/utils.py


