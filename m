Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A60671C7287;
	Fri,  1 Nov 2024 20:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730492406; cv=none; b=QKZ0wCIzFGfZhhztTGO6OFRBgcS89y8ZuvWwgjxGa1JsL+e8SCgITW92QGp02NMIj/a4Urdbnnu6GH8BGenoD8dkA7n55i8wvGymir9fl6kp+FXQLCFFLFGJ0AlOKdErkFKlC28k51kbBLsvT2SgZ1Vw3rUIvARCoXgl6cRalUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730492406; c=relaxed/simple;
	bh=woheSRu8QXlgXJPPuLCeAL/JOsNwEL1apTHiQ9sMSCM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yfzi4HQ9d3tMwvh3Y0+8/0flBEJpxCXBsHLkFzjj4YHcl2TqfWv6f7lHNQuLsXp1Px4/TuBUNaamMnCtpbymEvZ2FybTPWjgWQX965xkVMq8mZ3JsF8KlupJlM5APIAj43+cJirq9sdreGg/G7d3OVXDrj6oGuzm+WYBvvP53+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=o2pGWQcu; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="o2pGWQcu"
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A1GBZbB010864;
	Fri, 1 Nov 2024 20:19:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2023-11-20; bh=zRc29
	yAjjjcb6HjRKWOOU9rolmrIUBUoChVdf6ixpXQ=; b=o2pGWQcuWesqDpC1bmQca
	KvO3Nb2+34A/kY9Gje9lpDl4vsq6ZVES7beUX6kxK+XBr4Hgs+P11grswYwVthPA
	zJKxAQYB8RG0PrcSmAkaOG+cmAfXARWvN1LwF0QTFCrivv+Cpa20GyXTHDsG6Xp+
	SShHrNUW/EItZHUYcyYKhS6CEfAXNKr6fYB3LfbWxZC2BG6oOfAzKjVgJU+YhbQy
	DlaSVoGRNdbDYTmZKZ8dJWxUvnfLsyH1pOtX/GZDjk0UxgMYdbeQHFU5ci89GP+Q
	Ssv/BMM00hXms4w+M3R/gxgCKt84w/S9aUIPuxxl7Yv89vD5BHR+15PSpRNm3MA5
	A==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42grysd3jr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 01 Nov 2024 20:19:38 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4A1I5AI9034737;
	Fri, 1 Nov 2024 20:19:36 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42hndbxf60-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 01 Nov 2024 20:19:36 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 4A1KJOG5009855;
	Fri, 1 Nov 2024 20:19:36 GMT
Received: from jupiter.nl.oracle.com (dhcp-10-175-4-20.vpn.oracle.com [10.175.4.20])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 42hndbxeys-3;
	Fri, 01 Nov 2024 20:19:33 +0000
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
Subject: [PATCH RT 2/2] Linux 5.15.167-rt80
Date: Fri,  1 Nov 2024 16:19:17 -0400
Message-ID: <20241101201917.2010908-3-joseph.salisbury@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241101201917.2010908-1-joseph.salisbury@oracle.com>
References: <20241101201917.2010908-1-joseph.salisbury@oracle.com>
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
X-Proofpoint-ORIG-GUID: qTYK_htRc4v64ULESdJU_7RmlJXIisWf
X-Proofpoint-GUID: qTYK_htRc4v64ULESdJU_7RmlJXIisWf

From: Joseph Salisbury <jsalisbury@kernel.org>

v5.15.167-rt80-rc1 stable review patch.
If anyone has any objections, please let me know.

-----------


Signed-off-by: Joseph Salisbury <jsalisbury@kernel.org>
---
 localversion-rt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/localversion-rt b/localversion-rt
index cf94a551bf32..5ba2c2091cf9 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt79
+-rt80
-- 
2.43.5

