Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5B0C1459F7;
	Fri,  1 Nov 2024 20:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730492413; cv=none; b=YmivPTwB4TlZ1YophzCz+lsrdqdbflSce3S5lxuPeiin2hrDRp6nu9R1W1cDLNhwbu2EFzpG44EZjvPi9vQhsF2PqufXk4X2eOnI7XyOfD0yZTPEwhudsrceKpA57t0bsVFoBG7/y2CLPUg1B8T1qhHl6KRgrQ/0VpMilj/6UEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730492413; c=relaxed/simple;
	bh=QiwaHqB5UUt5ViOkX8lb99CvDY8LzzCAw5N/01DUxnE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UrxzEbogHbnVdcnqqbP/gsOOyFTN8htTodYWWDY8VCMijQ7YbNoknGiZ6vXnl87LaFsrfRheUtnvKZ6euYVjywbYTo9gVflnQzMege/38D7kWaaxVN1aMvUyc4NLBEJ6oarCx22eMpr4X07ihZHS7U0a+Xeexz9aq9RNn41iJdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=j6656zZ8; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="j6656zZ8"
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A1GBcUF017330;
	Fri, 1 Nov 2024 20:19:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2023-11-20; bh=LZ3I0njphEMc0KJzaIDDtdKS92wuv
	Pp3hfnAEJGQZ8U=; b=j6656zZ8X9S075CcOY4EuNYiKOQKfR4U2o0HmlZdsMEHD
	15IdIXuSz+HDW6SUzSM8P5tU82b+LrLtHFE2njyBGzNu+KLbRGYwIyNSJPvWoLkw
	OVCnZ2GY/91cmFW0Gotpy/maL+EuzORZ2/JpDOXpSrQsOW7YHdLrc0l2uxg+o5Kt
	l+fvhIyyD2swcJajxTVhsXj9/5POBQc+ERX9trR7tV7i0JjiZ3HWJ4/+ApG17o6d
	JXHlK1UkpqJzWRsq1vzcEqUP2f11OmmqyUht7cvG3cs43gAfze3rLLXhFPFmKj3K
	q5PpTMTwd0fji7zM9YSq/iPIRlb7Gqdu0G+2Q1ypQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42grgwmxg1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 01 Nov 2024 20:19:26 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4A1IHrSj035042;
	Fri, 1 Nov 2024 20:19:24 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42hndbxf28-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 01 Nov 2024 20:19:24 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 4A1KJOG1009855;
	Fri, 1 Nov 2024 20:19:24 GMT
Received: from jupiter.nl.oracle.com (dhcp-10-175-4-20.vpn.oracle.com [10.175.4.20])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 42hndbxeys-1;
	Fri, 01 Nov 2024 20:19:21 +0000
From: Joseph Salisbury <joseph.salisbury@oracle.com>
To: LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>, Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Wagner <daniel.wagner@suse.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Clark Williams <williams@redhat.com>, Pavel Machek <pavel@denx.de>,
        Joseph Salisbury <josephtsalisbury@gmail.com>,
        Joseph Salisbury <joseph.salisbury@oracle.com>
Cc: Joseph Salisbury <jsalisbury@kernel.org>
Subject: [PATCH RT 0/2] Linux v5.15.167-rt80-rc1
Date: Fri,  1 Nov 2024 16:19:15 -0400
Message-ID: <20241101201917.2010908-1-joseph.salisbury@oracle.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-01_14,2024-11-01_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 spamscore=0
 phishscore=0 mlxscore=0 bulkscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411010145
X-Proofpoint-ORIG-GUID: wZsUHb_ViWkIkr6MI2h2FS-L2pl2wsER
X-Proofpoint-GUID: wZsUHb_ViWkIkr6MI2h2FS-L2pl2wsER

From: Joseph Salisbury <jsalisbury@kernel.org>

From: Joseph Salisbury <joseph.salisbury@oracle.com>
Subject: [ANNOUNCE] 5.15.167-rt80-rc1
Date: 2024-11-08
Message-ID: <173049234501.2010158.14585351570068520903@jupiter>
To: LKML <linux-kernel@vger.kernel.org>,linux-rt-users <linux-rt-users@vger.kernel.org>,Steven Rostedt <rostedt@goodmis.org>,Thomas Gleixner <tglx@linutronix.de>,Carsten Emde <C.Emde@osadl.org>,John Kacur <jkacur@redhat.com>,Sebastian Andrzej Siewior <bigeasy@linutronix.de>,Daniel Wagner <daniel.wagner@suse.com>,Tom Zanussi <tom.zanussi@linux.intel.com>,Clark Williams <williams@redhat.com>,Pavel Machek <pavel@denx.de>,Joseph Salisbury <josephtsalisbury@gmail.com>,Joseph Salisbury <joseph.salisbury@oracle.com>

Dear RT Folks,

This is the RT stable review cycle of patch 5.15.167-rt80-rc1.

Please scream at me if I messed something up. Please test the patches
too.

The -rc release will be uploaded to kernel.org and will be deleted
when the final release is out. This is just a review release (or
release candidate).

The pre-releases will not be pushed to the git repository, only the
final release is.

If all goes well, this patch will be converted to the next main
release.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  on the v5.15-rt-next branch.

Or to build 5.15.167-rt80-rc1 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v5.x/linux-5.15.tar.xz

  https://www.kernel.org/pub/linux/kernel/v5.x/patch-5.15.167.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/5.15/patch-5.15.167-rt80-rc1.patch.xz

Signing key fingerprint:

  AD85 102A 6BE1 CDFE 9BCA  84F3 6CEF 3D27 CA5B 141E

All keys used for the above files and repositories can be found on the
following git repository:

   git://git.kernel.org/pub/scm/docs/kernel/pgpkeys.git

Enjoy!
Joseph Salisbury

Changes from v5.15.167-rt79:
---


Joseph Salisbury (1):
  Linux 5.15.167-rt80

Sebastian Andrzej Siewior (1):
  netfilter: nft_counter: Use u64_stats_t for statistic.

 localversion-rt             |  2 +-
 net/netfilter/nft_counter.c | 91 +++++++++++++++++++------------------
 2 files changed, 48 insertions(+), 45 deletions(-)

-- 
2.43.5

