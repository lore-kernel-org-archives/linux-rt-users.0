Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55E4E39FC7
	for <linux-rt-users@vger.kernel.org>; Thu, 22 Feb 2024 10:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708596998; cv=none; b=awqMvSB7BnEXoi4P+LjYnsM03NbyUpbtqliJKpVGS2Gu/KKjtFS+1ojheqve8IVchfnf1uAX5YIyiKWI2c1tZlFgPQWkRXl+AuQmpbJ7JouKxQZP+3nJX9hIYsu6T2j2taz3+AWYJUaQFDx9N2JuIiE+byCCF8oGW/E5+SIWJe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708596998; c=relaxed/simple;
	bh=FBKMBxrwmVvetT2bMhsSv3y9VTFQT+/3pui8TxBP1mA=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References; b=pQZLfQy9beoz8R5CTzHOib/VCBz01YFuAVx/XhSlI81L+vYvRT172G3HFajhjCjGuZSMPpikt5Ud1V6lGBu4SnR4VIqS8n5oLfnDhW+EnTHhqFkfi7DEaj8DHOmv4UbKjlco2t0XqLbHhV7vNb2EykiL8K0olJfGkirXoqkpd6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=X1VWcxEE; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="X1VWcxEE"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41M4vTuA032530
	for <linux-rt-users@vger.kernel.org>; Thu, 22 Feb 2024 10:16:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:subject:date:message-id:in-reply-to:references; s=
	qcppdkim1; bh=WANmLYKyGauKKoAx3g3JsRZ4f76A6JkCghrHb2OT0Dk=; b=X1
	VWcxEEQlzvCEitrLjxMkDEVkS9G8FNOoG/ExDz3VOvqyiXnQTuntHz9GBelf3B/5
	+0u5tzZlD8fefxRbzJ4IQY7TNbER5htNR8G3b7lIxuNl29yaTJh75FXb5m6JwViU
	DWo657MjctonsiB7tn+03zDnNU2oSRtM5vtqr64ik5/cHfc6YVSTHT/N/6X73Dmn
	x78rqYFsN6s0p6KKfWPRvaH5Ejui5sW3F0TINvLOO5uJEsC23U1qdVJVd/vuuKb+
	pk+B6AxvXvnXg7e6sqAn3rfxyS48YwCi0rtJte+aRhd/ZeHcLzob5EssNKTs32xe
	cSYLsEhHVsRaYq7cde3g==
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wdwmd15gp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-rt-users@vger.kernel.org>; Thu, 22 Feb 2024 10:16:36 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 41MAGWvF009797
	for <linux-rt-users@vger.kernel.org>; Thu, 22 Feb 2024 10:16:32 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 3wanvkmfv3-1
	for <linux-rt-users@vger.kernel.org>; Thu, 22 Feb 2024 10:16:32 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41MAGWTl009789
	for <linux-rt-users@vger.kernel.org>; Thu, 22 Feb 2024 10:16:32 GMT
Received: from hu-maiyas-hyd.qualcomm.com (hu-chandna-hyd.qualcomm.com [10.147.242.90])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 41MAGWw4009787;
	Thu, 22 Feb 2024 10:16:32 +0000
Received: by hu-maiyas-hyd.qualcomm.com (Postfix, from userid 2303763)
	id 62A2C529765; Thu, 22 Feb 2024 15:46:31 +0530 (+0530)
From: Sahil Chandna <quic_chandna@quicinc.com>
To: linux-rt-users@vger.kernel.org, quic_chandna@quicinc.com,
        quic_akdwived@quicinc.com
Subject: [PATCH 1/1] printk: fix NULL ptr dereference in nbcon driver
Date: Thu, 22 Feb 2024 15:46:26 +0530
Message-Id: <20240222101626.1142-2-quic_chandna@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240222101626.1142-1-quic_chandna@quicinc.com>
References: <20240222101626.1142-1-quic_chandna@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: KEPqj3W7t0MPsecnD-VbzPh-jE7mzGeM
X-Proofpoint-ORIG-GUID: KEPqj3W7t0MPsecnD-VbzPh-jE7mzGeM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-22_08,2024-02-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 impostorscore=0 mlxlogscore=922 suspectscore=0 malwarescore=0 spamscore=0
 bulkscore=0 priorityscore=1501 phishscore=0 mlxscore=0 clxscore=1015
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402220081
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>

Add a check for NULL console in nbcon driver.

Signed-off-by: Sahil Chandna <quic_chandna@quicinc.com>
---
 printk/nbcon.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/printk/nbcon.c b/kernel/printk/nbcon.c
index e697a8e..398739d 100644
--- a/kernel/printk/nbcon.c
+++ b/kernel/printk/nbcon.c
@@ -1623,6 +1623,9 @@ void nbcon_release(struct uart_port *up)
 		.prio		= NBCON_PRIO_NORMAL,
 	};
 
+	if (!con)
+		return;
+
 	if (!con->locked_port)
 		return;
 
-- 
2.17.1

