Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E6531946DA
	for <linux-rt-users@vger.kernel.org>; Fri,  7 Nov 2025 18:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762540028; cv=none; b=GyikU3do1IawAK5EOjJel6HyDkhgDfVxiF/koWPWhrk8uVSAhShQInOnkp4iypqbFGnvgSIq6cBdXwCjAfKWFXRHj5V/1Pfso8sQA7XoipkZgGCU9heyy0kLR2DFSHb2ui0IFFlEIfvSzdqmWOf33NWgdoVtYSgAMW95WjFwtlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762540028; c=relaxed/simple;
	bh=qsGQbMPxnNJiIOqYTd+2l3JExcVLJzJUQRqliGzuCSM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Jzh03SSnz6LKvujKuSX7rUDwbHFlKSzWj6nO5dMSCzu4ygPOH2iib61KSyOQwIgPPYSOJQb2VzAOxM1H3o0FBgrz9W74kHqtO/pa0oMyEGbTuyKWkm8TeKcbIuNkTMDlg4gx+9+mhrpzjT+kc05QMwRYJhV70Y/5DfnLktvATLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NLH/WJyc; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NLH/WJyc"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-8a3eac7ca30so74282985a.2
        for <linux-rt-users@vger.kernel.org>; Fri, 07 Nov 2025 10:27:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762540025; x=1763144825; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=Vg3yOZ46N2mcArffbLnZi7zfDnPG5SlpiXe4VaTf7yg=;
        b=NLH/WJyczG1EXUunOmdZkB1RF/q5GISVz0IeOrljav9fu1gIO+aYpTR7jScZa3/PxO
         BJ9WDLC1tw2i4fgHS3FN4kUMK/9Z2pHi7tw+zb84KS2BVfQe9NVTmNMfaUc3VdIhNgeO
         EMMTTC9J//uaZBrWdO68HNxaVrZN3akFwumLgYUdpC5VRWfMLq0IpAi4em6RQJ9X89pz
         KP0FJKvCuvtuFSJfWUUqb9R0SF09QmD8zH/XeyDWAGoiGV9koUiiQKTzHb1oudPscZL2
         q25f5Om99VR0DblOfxfhYk5F/fyYK5GsI9UOzn5BEHMPe0mXcKtQJOGMRJessGqm9+EC
         i+ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762540025; x=1763144825;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vg3yOZ46N2mcArffbLnZi7zfDnPG5SlpiXe4VaTf7yg=;
        b=f3EWu9TX9ZXsxZrI/pUmPK93zb/m1VaCNM0BMKk+p666iXPNENa9HxG4MSUIIAWcVD
         0jjPHduqt2ru0498TdiZSQEtSto893bjhZZ4viV2D9dXz8Bq9SpSyhyecRGm5L4SiSwG
         63hEoMX3ct+ZL15ASqL7WkdGncxYm3366rNH1LvWZPizwKkzP0QfjLH7ZkMgnalQRE2X
         abqCk+EBiyB4NVdAcKL6l8/iMrQku8I2+h9LDmbzKAEflZSWpXWb92gpIzXaQ8zqf2k5
         tkbhQZ860EFHua+QtVXpzkO+HIHZQeWUCz7tMMl7KIZDcDAq1uLW8mwpcVV5EbstRk2t
         tyhA==
X-Gm-Message-State: AOJu0YxyCEvv4gNag+g7+EeR7DrwrnrY2MMgF3VoyAER9aSajRky1aKl
	f6AC1GxOGx2+DcZSM0iOCI3Ryl4dQjMRxFcpaoue+V3ldhz05Wp0R8VyrcYRv1pS
X-Gm-Gg: ASbGnctf2QIlxRpO7Sdckkl6WncJ/9gE6j13Toreuvx4iOco7+ISBlm3uSbdslkj5CA
	zzA+hMFXpnWHs6wDZBRXcQJI3B0SDv6g/pkPAf1O7L0JspF2xwnKvdL1aL0H9K7gQH3nabDBi4Z
	+DFky5YFd7+FuUBy0cioLEByGN9pd9rrfGAICQC3wjytUm/Zqgp+tJgvb42BjW5tijA+cu3SyMm
	rF3gxDB5snhmWBOTLEHibUNFF7Phr0u58rLSBSpbCG/KlpDeOMtyiSlfqXCVjK/udiIa/wPOyRF
	HNAFplBSIOI8q5Sep+uA5m4bdztMp+3Jvnp+KpJDyue9mzD6ScpakhAcscx3j8j9FQgdwr6hep6
	Sk4ZJfJGcc2qxBndvmaDJx6oIGbpdfKeyB8SfH4s9E1r6XmQVqaCRG92whGajbAj9CAsrlCzjQw
	==
X-Google-Smtp-Source: AGHT+IHUX5QN1n2HruGP/0XCjNF1wVeFDACjOhuYI9+8nywY89WchmC4AP1kPzooerz9BsiOwex91A==
X-Received: by 2002:a05:620a:4113:b0:8b2:271e:a560 with SMTP id af79cd13be357-8b257f69940mr32421685a.72.1762540025302;
        Fri, 07 Nov 2025 10:27:05 -0800 (PST)
Received: from fionn ([174.88.40.44])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b235828514sm452141085a.53.2025.11.07.10.27.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 10:27:04 -0800 (PST)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: linux-rt-users <linux-rt-users@vger.kernel.org>
Cc: Clark Williams <williams@redhat.com>,
	Tomas Glozar <tglozar@redhat.com>,
	John Kacur <jkacur@redhat.com>
Subject: [PATCH 00/12] rteval updates
Date: Fri,  7 Nov 2025 13:26:23 -0500
Message-ID: <20251107182645.19545-1-jkacur@redhat.com>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Notable here are the patches to add

--measurement-module MODULE so that you can choose cyclictest or
timerlat without modifying the rteval.conf file

The patches that adds
  --timerlat-dma_latency USEC
                        Set /dev/cpu_dma_latency to USEC (set to None to
                        disable) (default: 0)

And finally the addition of pyproject.toml for a modern type of python
install. We will still carry setup.py for older distributions.

John


John Kacur (12):
  rteval: Fix spelling of 'occurrences' in measurement modules
  rteval: Fix typo in comment
  rteval: Remove unused function remove_offline
  rteval: timerlat: Fix typo in log message
  rteval: cyclictest: Fix typo in comment
  rteval: rtevalConfig: Remove redundant 'is True' comparison
  rteval: Clean up MANIFEST.in and fix newnet.py copyright header
  rteval: Add pyproject.toml for modern Python packaging
  rteval: Improve argparse implementation and remove manual sys.argv
    parsing
  rteval: timerlat: Add dma_latency option with default value of 0
  rteval: Add --measurement-module command-line argument
  rteval: Add unit tests for --measurement-module argument

 MANIFEST.in                                |   3 +-
 Makefile                                   |  10 ++
 pyproject.toml                             |  58 ++++++
 rteval-cmd                                 | 122 +++++++------
 rteval/modules/__init__.py                 |   7 +
 rteval/modules/measurement/__init__.py     |   2 +-
 rteval/modules/measurement/cyclictest.py   |   8 +-
 rteval/modules/measurement/timerlat.py     |  17 +-
 rteval/rtevalConfig.py                     |   2 +-
 rteval/sysinfo/newnet.py                   |   3 +-
 run_tests.sh                               |  89 ++++++++++
 setup.py                                   |   6 +-
 tests/test_measurement_module_selection.py | 195 +++++++++++++++++++++
 13 files changed, 443 insertions(+), 79 deletions(-)
 create mode 100644 pyproject.toml
 create mode 100755 run_tests.sh
 create mode 100755 tests/test_measurement_module_selection.py

-- 
2.51.1

