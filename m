Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A334944A710
	for <linux-rt-users@vger.kernel.org>; Thu, 11 Jun 2026 20:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781210333; cv=none; b=OnHdCPnGfA+XhrchKjnXIURfXejiHWJfYm7NBaU6mV/csl+bcXyOOX1vrYYYrSDaKWl1P6K+M+1kkIhQJS8cc3mUmZMZrmsr5pq58hRgjaV2oFJToofGyQygdwMXsttX5HMPiBEG52Z4Qy7URsRHq96/Dn0dnOHEeENZcjzYo0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781210333; c=relaxed/simple;
	bh=dsej5ou8b2zYZHlHbkKYS/jEozL7JHHFmNlxy34GxQc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=toJJLtg5Xm8orlYVOWDM3bsRjNNSF6f8/wEdMVpMJOWIwUazj1cbPTOXCoW1+U/ILL6ah8fhUkz+vrJssaUOGe2Tc9ooh4jPmGuLvoOsrmJDjCDfPg67W/Hmge3MsNLutkMukDPwWrjZebeJBw0hoKAE2ATHUSLME4RYIl115W8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kBJ1osFr; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kBJ1osFr"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-517b1f2c668so2007871cf.2
        for <linux-rt-users@vger.kernel.org>; Thu, 11 Jun 2026 13:38:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781210329; x=1781815129; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=8vLxQHbQlcpytHx7o/eDybv2/XnO+ZDtGS0Spmi1Ju0=;
        b=kBJ1osFry1U6x8ewyUT2EsaNBEakVDcn2XsOEA0XZgx5afe4Y0PaV/DmYtglaq5bHm
         /t0qUQ5FarrWlWrovuDZNpyqNVVVOkYynsiJ+BrgryH9WsnG2lPTfGKFtPd/eWUUCRNp
         9GF/54rT3s7wxcYKkzz1tvZEUBmtScNXbyiG3EfAQun9nmyNc/tMs4t46fsIItMlCHVw
         cmsHk9dbI3D5/GMM+ModaIUh7Qbt5D6x6skz6ZYWY4ISlSe2vBsNeoMbfjt7Tl7fXqaF
         sblOwYkg1QbHvmNnrbbtPH/o56cweo1hlN6IlCFRtzknqWkazgz3tHYmMbkUQ3EFPXQf
         104Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781210329; x=1781815129;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8vLxQHbQlcpytHx7o/eDybv2/XnO+ZDtGS0Spmi1Ju0=;
        b=n6wH5R7DF8AoH1/SA5KjZlh5TMfuEuFI0IpV9/gVVb6Wtza3FTObYS5HDfIwty7Ofv
         L/8FSBD/xmaR9OXZRnxXhZWZ5Uhi3G3eU9NpyrhhxBFYYEJdreZ4SuCNeCUlT05XvNSa
         ez0warrt3aR2b86OxtCcOBV/oOVLRlB1MTBbuRIzHuNkAU/2EzGZxDeDC+KwJNrxEWKx
         oScP2Z7bLBFuH+GRvZ4SNM4TVgNr2OVzsLgybzd4CskhoN8PvN4BGvHoRr3U1dHbpHb5
         i38lLfGaiKJVPUqPek4UhrGIcj5LkaEM4mT/oYMC67a5tjGwUFPENc4z6u75hJXgOFBe
         5iRw==
X-Gm-Message-State: AOJu0YxXRz+af+1mGKm+flNkWkD7mp61j3/hXW/qp5/QMpLBp2ZTcW7d
	hP+psyR4oOehCzzJPc9senUZwTcuCYPziLcNKS61c21LyDeCPZ7NR9syf+Di9A==
X-Gm-Gg: Acq92OHiznpRZtZyHlAhLNIyfHMCBUsrGX4fAFxYpMNUlCI+yTH6xFd2f0gHHieBJYN
	HnIjsgpmdh5Tbqtqnoj6imhIK20e5YrHuLIuKz3HNSIH324IB8pNTK4ikV3OVkhk6rlQevGYF8K
	hH4PYe5g8tlxYoO+hzI0tohJgwQ7YqTmjlS8UxVczAm6HuRax6OHrWNRB4xH/30RrY7kVNiUrie
	aKdsAVpLAtbcDHjoFJ3DFNm1jCTv9xeZatQ5Pp/Tmb0nQP4qN//SyNFPU8yk6rLQ6m5BEDXrNwD
	xfNhS4gOFMNzMgl7c9ZZirWo9AlaG6yyzpuu4r3904+WBjoogaR29Cvt1IXEVxFxnrozdaxyYYk
	mbAsAG8HEGXoS6/8PSn9280MKB/qnsp2tvmFD/kUaTeiWPOHK9lGKWEcWZIh5cQ8IvW8+7Mhazo
	4zcweZOVZEg5U5xmnavjHL9+MnmQVU1gM7Mib2cyhWTN8owSRTGq0qSwmMaaErBZDgd1+a6Cz8d
	S2eviYUiA0JuVx9RNU=
X-Received: by 2002:a05:622a:6201:b0:517:5e32:f3ad with SMTP id d75a77b69052e-517ee1bf667mr70158551cf.26.1781210329425;
        Thu, 11 Jun 2026 13:38:49 -0700 (PDT)
Received: from Cumhall.redhat.com ([216.209.112.32])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-517fb642541sm3214051cf.10.2026.06.11.13.38.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 13:38:49 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: linux-rt-users@vger.kernel.org
Cc: Clark Williams <williams@redhat.com>
Subject: [PATCH 0/5] tuna: Argparse refactoring and testing improvements
Date: Thu, 11 Jun 2026 16:38:27 -0400
Message-ID: <20260611203832.176805-1-jkacur@redhat.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This series refactors the argparse implementation in tuna-cmd.py to eliminate
side effects during argument parsing and remove global variables, making the
code more maintainable and testable.

The main improvements are:

1. Replace bare except clauses with specific exception types for better error
   handling

2. Defer type conversions until after parsing completes, eliminating side
   effects during argument parsing (parse → convert → execute pattern)

3. Remove global variables (ps, irqs, match_requested) and pass them as
   function parameters instead

4. Add comprehensive unit tests (12 tests) for argument converter functions
   using mock objects to avoid requiring procfs access

5. Update test documentation with detailed examples and explanations

All tests pass (18 total) and run without requiring root privileges.

John Kacur (5):
  tuna: Replace bare except clauses with specific exception types
  tuna: Eliminate side effects from argparse by deferring type
    conversions
  tuna: Eliminate global ps and irqs variables
  tuna: Add .local/ directory to .gitignore
  tuna: Add tests for converter functions and update test README

 .gitignore               |   1 +
 tests/README.md          |  85 ++++++++++++++++++++-
 tests/test_converters.py | 160 +++++++++++++++++++++++++++++++++++++++
 tuna-cmd.py              | 114 ++++++++++++++--------------
 4 files changed, 300 insertions(+), 60 deletions(-)
 create mode 100644 tests/test_converters.py

-- 
2.54.0

