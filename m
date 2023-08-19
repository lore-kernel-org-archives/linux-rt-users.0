Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BCA1EE49A2
	for <linux-rt-users@archiver.kernel.org>; Sat, 19 Aug 2023 02:46:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244343AbjHSCqC (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 18 Aug 2023 22:46:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244316AbjHSCpj (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 18 Aug 2023 22:45:39 -0400
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA3FF3C00
        for <linux-rt-users@vger.kernel.org>; Fri, 18 Aug 2023 19:45:36 -0700 (PDT)
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 37J2DdTK010121;
        Sat, 19 Aug 2023 02:45:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
         h=from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding:content-type; s=PPS06212021; bh=RLCiB
        5DU+MhXjrEFEFt9/Gsx0yLXqjThgWktBxMUdCE=; b=C8C6DjFU3Co3Iypxfle1o
        rGAgGrSvEL5xDENeyHYpXq77kkXaGYV0jxyX1tArwK0zj+cX1G7OfPRc2z0cV18a
        Ukzq3jThnPvS0Dg9KGLz/pnRpEdZmcsgc/WrvGs2U+2gWbra13MpHHpkaejcBf49
        hD9OnY64zfPpJDJ0D298zd+vaajeSOfw0g72NbaJEsBv8HucuWuHHHXnhj4V+nKX
        qnrAAUgCkTqhCrsB6QQtJWONVDz6U6v9UkRYqhbwdhm/NNy/UcfK72fLb46v3DiE
        16gjuQHs614X5+IXqrph9q05zG2XeGvVmSNVz823vOOLaIqAziJ/awqaSCZHVWAw
        Q==
Received: from ala-exchng01.corp.ad.wrs.com (ala-exchng01.wrs.com [147.11.82.252])
        by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3sjmq5g0mc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Sat, 19 Aug 2023 02:45:27 +0000 (GMT)
Received: from ala-exchng01.corp.ad.wrs.com (147.11.82.252) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 18 Aug 2023 19:45:26 -0700
Received: from yow-lpggp3.wrs.com (128.224.137.13) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server id
 15.1.2507.27 via Frontend Transport; Fri, 18 Aug 2023 19:45:25 -0700
From:   <paul.gortmaker@windriver.com>
To:     Clark Williams <williams@redhat.com>,
        Joseph Salisbury <joseph.salisbury@canonical.com>
CC:     <linux-rt-users@vger.kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Tvrtko Ursulin <tvrtko.ursulin@intel.com>
Subject: [PATCH 6.1-rt/5.15-rt 0/1] Backport i915 reset fix from v6.4-rt
Date:   Fri, 18 Aug 2023 22:45:24 -0400
Message-ID: <20230819024525.2056048-1-paul.gortmaker@windriver.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: lbsu9mG0lRFnH8hyYwzQxRkVEBRmTzS2
X-Proofpoint-ORIG-GUID: lbsu9mG0lRFnH8hyYwzQxRkVEBRmTzS2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-18_29,2023-08-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 spamscore=0 bulkscore=0 phishscore=0 suspectscore=0
 impostorscore=0 clxscore=1011 adultscore=0 mlxlogscore=999
 lowpriorityscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2306200000 definitions=main-2308190025
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

From: Paul Gortmaker <paul.gortmaker@windriver.com>

I'd originally reported an i915 regression caused by a linux-stable
backport, and then later posted an RFC fix for it:

https://lore.kernel.org/linux-rt-users/ZJTuDi1HNp9L2zxY@windriver.com/

That eventually led to further discussion and an eventual fix from
Tvrtko that Sebastian put into the v6.4-rt queue, which is great.

However, the original regression was reported on v5.15-rt.  This closes
the loop by backporting the v6.4-rt change to v5.15-rt/v6.1-rt -- as it
turns out, the same backport applies cleanly to both baselines.

The only small change required is to fix up the context a bit in the 5th
and final chunk, because kernel versions before v6.4 dont have the commit
b7d70b8b06ed ("drm/i915/gsc: implement wa 14015076503")

Paul.
--

Cc: Clark Williams <williams@redhat.com>		[6.1-rt]
Cc: Joseph Salisbury <joseph.salisbury@canonical.com>	[5.15-rt]

---

Tvrtko Ursulin (1):
  drm/i915: Do not disable preemption for resets

 drivers/gpu/drm/i915/gt/intel_reset.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

-- 
2.40.0

