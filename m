Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BC1A2264D6
	for <linux-rt-users@vger.kernel.org>; Fri, 17 Apr 2026 19:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776455494; cv=none; b=hArhuYoyZY1iUNg+sf3wGPFGSQbE0xpSQysXtFhfyW0x+PTZ+1HvnA+cUqT7qBYUo1YMAQPEUln5OYOkK9iZLFrrVyDdHgj8e+yCd/O/ajHIzDmHsCMMaTC2nZNQJLpC9tD7fe2xzeehbfpBiHEt0aW8emvEA9GBcmo93YMSiWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776455494; c=relaxed/simple;
	bh=lgkj3QBx2nHhguxFdJ/rO5LcNxGiQ4tD0lfvrythx4k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=stkDdSzd9r6lG+m7EIomsBzfdCDZ7r8XDtp+P7UHi2bwSsgpy4eoTHrJMlfFJVqr39IME/oUpkdHJ+t8tpIu3lrWa2b3nYaeAI9eE5fI8DXnwedRCatHC3iCkeo7r2ft0TSjcl96TuEM640C5NpMKLqlBYYSoLWiUB2Rws53ps4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XZG4ryFW; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XZG4ryFW"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-50d6b9bca48so12859951cf.2
        for <linux-rt-users@vger.kernel.org>; Fri, 17 Apr 2026 12:51:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776455492; x=1777060292; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=pIUS8Vw/6NJJnzthu4GFxotpmVxTDbX/A8z0h4OOOWs=;
        b=XZG4ryFWVC45HcA2SYAYroCN3oLBMPHAyt1bJZTEoPRyf1Pr5cRsxnDB6fYD5wFPu2
         NhFRXv5+8B5E1EUJQ3MK5QIDBynGKxXEzTalvsgTGRc84wikTPbklYXs7EalBz2mYmrR
         cfXRqUMQDOzia4m342GKD6JxvziYqF7SL5QJqaYmAjbYmmatWOXCGyMLg/VXm9qrAQQ4
         ofVeQTu8O3lkjfFHCZT3Ji6fTPjMcL/DZm9H7gwevXIF+EBt68/Mz/Wulg9Io0mtZ7/E
         WVKtzpDwt6hM7PoFrjRMBhRgWJxS+xaH26maCLsJI/m3Ba1F2dHC2uk+edIctZVgQ4Oo
         sSWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776455492; x=1777060292;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pIUS8Vw/6NJJnzthu4GFxotpmVxTDbX/A8z0h4OOOWs=;
        b=pKqK7orsrY1QBjrgjmRYPCb8FFuWiRpuLF6ftKivY0sNOyyvy6QhCQV05H+EWFMGQa
         lyBFrlTCfIr1qi3IYYqiNVZ9kQwzzukwht6APssGrCBzTiasqKXuyxUQRUZqDLD73hG9
         SyjGJTyW2IbUSyH/9qngf2ngEPw3pF8GxVqYfidpT3jwF1KZadw8Ed89Q74NFLzyTR1h
         tOwAbe9zPL0fidy6SFnks8yd2+f7cY8UPLfj2ObZUqLTRc3AWjf4VCDzMg1dTQ3KPS3M
         TtzlgIIUDMDhh4+BvqHhN+CgeSgaXo/KcXNf//NpALSM3+kZ5GxNpoLjbdYs+Y3aGxlg
         9DsQ==
X-Gm-Message-State: AOJu0Yx5upx2VeRYmzt5P2l7fDGDHUeYKkL1rPVl0jwGl+lAGbSvziWJ
	FGKGf+4yRyWz+CkUZz4qE9xLAz3kNjW9uT8u/MeiL7XbQ3rdGzZqWCIFzz4g4Q==
X-Gm-Gg: AeBDietr/hlIB7+uIdporFlABlsdGXLm3RcI/QTkX5ropxUvczrXIsDI3G8d82CzKQK
	U+ngD+1ZBPzyEHgipUH3nTRy8ZX2lPsIWPUKLwnd5TClAclyf1TTXD62uYEZ7kdYcsgFGv+KGQ5
	YDxeYuanTOaMOBjX3ZWpH8DWy4njmTDipdW8twsqRnSlr6ytl0siS6mBUkohC7vfHEiznNOFuI3
	Q1p8bzWYqLNHeXN9kkjZPG37eAOQflU8GeakCGIGcQbzm0SLUiSyMSWLEOrvCHDKHmfEe2VBn31
	nM+XBQIaHcRM4GZtL7Ih99te6msX6QoDyXrXqLHKk+3By3NBRMYvMLLjIXpeXOyuM0Fn6RNk+fJ
	6MK4oe4IowkPTAnKYWFG2x1BWdU1k1jG772ly5Ol3ZUdFRgTDADf/O5nOk0xT6uQX1l8JWFevXL
	DnAMLTj5b56Q3nleUedh65Ph6Z1gw3gMRZuw+bLp7smeO+vQ4d0+AWfigMjmr4x5lxY44he5ar/
	lfdgrzxjcotsNkrnh4HGJa0HOerCA==
X-Received: by 2002:a05:622a:5a13:b0:50d:ea46:7eb3 with SMTP id d75a77b69052e-50e36b640d9mr62827981cf.26.1776455491790;
        Fri, 17 Apr 2026 12:51:31 -0700 (PDT)
Received: from Cumhall.redhat.com ([216.209.112.32])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50e3bf260fbsm20673601cf.10.2026.04.17.12.51.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2026 12:51:31 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: linux-rt-users@vger.kernel.org
Cc: Clark Williams <williams@redhat.com>,
	Tomas Glozar <tglozar@redhat.com>
Subject: [PATCH 0/6] rteval: Improve CPU management infrastructure and add housekeeping option
Date: Fri, 17 Apr 2026 15:51:07 -0400
Message-ID: <20260417195113.177799-1-jkacur@redhat.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series enhances rteval's CPU management capabilities by adding
cgroup v2 cpuset support, refactoring CPU list handling, and introducing
a new --housekeeping option for finer control over isolated CPU usage.

The series includes:

1. A new cpuset module providing comprehensive cgroup v2 cpuset management
   with support for cpuset.cpus.partition and modern Linux interfaces

2. A minor test fix for the xmlout unit test XSL file path

3. A new CpuList class that provides an object-oriented interface for CPU
   list manipulation while maintaining backward compatibility with existing
   module-level functions

4. Migration of existing code to use the new CpuList class where it adds
   value (chaining, filtering) while keeping functional interfaces for
   simple operations

5. Comprehensive unit tests for the CpuList class covering all major
   functionality

6. A new --housekeeping option that allows users to reserve specific
   isolated CPUs for system housekeeping tasks, preventing rteval's
   measurement and load modules from using them

The --housekeeping feature is particularly useful for systems with isolated
CPUs where some cores need to handle essential system tasks while the rest
are dedicated to real-time workloads.

All changes maintain backward compatibility and existing tests pass.

John Kacur

John Kacur (6):
  rteval: Add cpuset module for cgroup v2 management
  rteval: Fix xmlout unit test XSL file path
  rteval: Add CpuList class to cpulist_utils module
  rteval: Migrate call sites to use CpuList class where beneficial
  rteval: Add unit tests for CpuList class
  rteval: Add --housekeeping option to reserve isolated CPUs

 rteval-cmd                             |  62 ++++-
 rteval/cpulist_utils.py                | 161 +++++++++++-
 rteval/cpupower.py                     |   4 +-
 rteval/cpuset.py                       | 350 +++++++++++++++++++++++++
 rteval/modules/loads/__init__.py       |   7 +-
 rteval/modules/loads/hackbench.py      |   9 +-
 rteval/modules/loads/kcompile.py       |  14 +-
 rteval/modules/loads/stressng.py       |   8 +-
 rteval/modules/measurement/__init__.py |   6 +-
 rteval/systopology.py                  |  52 ++--
 rteval/xmlout.py                       |   4 +-
 tests/test_cpulist_class.py            | 121 +++++++++
 12 files changed, 738 insertions(+), 60 deletions(-)
 create mode 100755 rteval/cpuset.py
 create mode 100644 tests/test_cpulist_class.py

-- 
2.53.0

