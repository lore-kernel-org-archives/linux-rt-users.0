Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46E3438DF5
	for <linux-rt-users@vger.kernel.org>; Thu, 22 Feb 2024 10:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708596997; cv=none; b=Ctd5b6Kjbkgl/ExRvxqCfFMSorZwuEE6C0O/Ber6rtfUyorRhve3+A+2eg2SuY9lMYE99UgFXzUYzFYNCyTFBxsp1f6jZ5vAtM3YmLjF//YQXcSnRhJJrEwHDFcROEycSptyNu+BIYxYaWlBtnUjrNvQQ5LTr4I2Mr4cBVl4WoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708596997; c=relaxed/simple;
	bh=o2DrFshnpue/Ii5hPrhGsilPniNQmVAPShUMFgQjXn8=;
	h=From:To:Subject:Date:Message-Id; b=HtGn12CEx8E7o6CRKRYWkhDOMNzT5F1qzxVTIlPS0xi/ze9AUj6pWtCK7yWY11vBkPCZfqmMRsQFS6fpBH6aQT6hOSU5SH2LMXB8i8KC5V3tJwyuBaavLMuEOyl5g+p3MtV3wfisIBHCuQR2rf5yeO8H1pvoMQCw5MMWNbAY0/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=AnoQuwJN; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="AnoQuwJN"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41M7hBFN022119
	for <linux-rt-users@vger.kernel.org>; Thu, 22 Feb 2024 10:16:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:subject:date:message-id; s=qcppdkim1; bh=y2seuCJQJEujc2s
	A5jKuSV/tCAl+op3GUeyBDcSNjNY=; b=AnoQuwJNhjs2fU0lxfXy5AWhS0Ymmil
	gUOdxiMQxANPDYHyMPOlpR9uTgc+2PfiCZoC3MoyIvdg9JD6pGIUZGjODgcREgpn
	l7SghN62AgRtoZo02ww4axfNQmnRfQsdeuurYLUY1DYSPcTs1rvZiZ03R0jWTGyo
	XVZMcNhDfIUA9HKK8ysdu70mkfv/YUepB/+k2W7lus9dz5TNGiXsP+8AzPD0jfoa
	oN1u+Zy2icThaE3vEYNGxOABaSiCL90caOlsCVtFg156taj8RqKz6wBcwhNeov7L
	TYg4QkmP3iAIUS+Y8KTgsbxsoBrfLUoOPP7lUNRFDh8fL8mIFN4nFxw==
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3we24agj2j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-rt-users@vger.kernel.org>; Thu, 22 Feb 2024 10:16:33 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 41MAGUAH009761
	for <linux-rt-users@vger.kernel.org>; Thu, 22 Feb 2024 10:16:30 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 3wanvkmfuu-1
	for <linux-rt-users@vger.kernel.org>; Thu, 22 Feb 2024 10:16:30 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41MAGUp4009755
	for <linux-rt-users@vger.kernel.org>; Thu, 22 Feb 2024 10:16:30 GMT
Received: from hu-maiyas-hyd.qualcomm.com (hu-chandna-hyd.qualcomm.com [10.147.242.90])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 41MAGUEV009754;
	Thu, 22 Feb 2024 10:16:30 +0000
Received: by hu-maiyas-hyd.qualcomm.com (Postfix, from userid 2303763)
	id 2C271529765; Thu, 22 Feb 2024 15:46:29 +0530 (+0530)
From: Sahil Chandna <quic_chandna@quicinc.com>
To: linux-rt-users@vger.kernel.org, quic_chandna@quicinc.com,
        quic_akdwived@quicinc.com
Subject: [PATCH 0/1] Fix NULL ptr dereference in nbcon driver
Date: Thu, 22 Feb 2024 15:46:25 +0530
Message-Id: <20240222101626.1142-1-quic_chandna@quicinc.com>
X-Mailer: git-send-email 2.17.1
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: zi6HTQl7RO7Cxee2FyzCvEQlmjpBRQTB
X-Proofpoint-ORIG-GUID: zi6HTQl7RO7Cxee2FyzCvEQlmjpBRQTB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-22_08,2024-02-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 clxscore=1011 lowpriorityscore=0 priorityscore=1501 adultscore=0
 mlxlogscore=737 phishscore=0 spamscore=0 mlxscore=0 bulkscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402220081
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>

Add a missing check in nbcon driver which is causing NULL pointer
dereference bug.
Summary:
Testing with PREEMPT_RT patch version 6.6.12 on 6.6.13 kernel and crash
is seen during serial geni probe.
Patch applied from:https://cdn.kernel.org/pub/linux/kernel/projects/rt/6.6/older/patch-6.6.12-rt20.patch.gz

crash signature:
DMESG Log
=========================
0x0000000000000000 |      0.000000:   Booting Linux on physical CPU 0x0000000000 [0x412fd050]
0x0000000000000000 |      0.000000:   Linux version 6.6.13-rt20 (oe-user@oe-host) (aarch64-qcom-linux-gcc (GCC) 11.4.0, GNU ld (GNU Binutils) 2.38.20220708) #1 SMP PREEMPT_RT Tue Feb 20 17:59:33 UTC 2024
0x0000000000000000 |      0.000000:   KASLR enabled
0x0000000000000000 |      0.000000:   Machine model: Qualcomm Technologies, Inc. Robotics RB3gen2 addons platform
0x0000000000000000 |      0.000000:   efi: EFI v2.7 by Qualcomm Technologies, Inc.
0x00000000000164F7 |      2.788805:   Internal error: Oops: 0000000096000004 [#1] PREEMPT_RT SMP
0x00000000000164F7 |      2.788812:   Modules linked in:
0x00000000000164F7 |      2.788818:   CPU: 5 PID: 118 Comm: kworker/u16:4 Not tainted 6.6.13-rt20 #1
0x00000000000164F8 |      2.788826:   Hardware name: Qualcomm Technologies, Inc. Robotics RB3gen2 addons platform (DT)
0x00000000000164F8 |      2.788830:   Workqueue: events_unbound deferred_probe_work_func
0x00000000000164F8 |      2.788844:   pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
0x00000000000164F9 |      2.788852:   pc : nbcon_release+0x30/0xa0
0x00000000000164F9 |      2.788865:   lr : serial_core_register_port+0x4a4/0x64c
0x00000000000164F9 |      2.788877:   sp : ffff8000808a39d0
0x00000000000164FA |      2.788879:   x29: ffff8000808a3a00 x28: ffff8000808a3a38 x27: ffffddb447ba6718
0x00000000000164FA |      2.788890:   x26: ffff6024fd9fcd30 x25: 0000000000000000 x24: ffff602400fafb60
0x00000000000164FA |      2.788899:   x23: ffff602403c8c800 x22: ffff602400fafa18 x21: ffffddb448518b88
0x00000000000164FA |      2.788907:   x20: ffffddb44870ac60 x19: 0000000000000000 x18: ffffddb448582b10
0x00000000000164FB |      2.788915:   x17: 000000040044ffff x16: 005000f2b5503510 x15: 0000000000000000
0x00000000000164FB |      2.788924:   x14: ffff6024ff5752c0 x13: 0000000000000001 x12: 0000000000000000
0x00000000000164FB |      2.788932:   x11: ffff602400f7d9b0 x10: 0000000000000ba0 x9 : ffff602400f7d950
0x00000000000164FC |      2.788941:   x8 : ffff8000808a3574 x7 : 0000000000000000 x6 : ffff602400cf9000
0x00000000000164FC |      2.788949:   x5 : ffffddb446f93e48 x4 : ffffddb446f93e8c x3 : 0000000000000000
0x00000000000164FC |      2.788958:   x2 : 0000000000000001 x1 : ffff602400cf9000 x0 : ffffddb448518b88
0x00000000000164FC |      2.788966:   Call trace:
0x00000000000164FC |      2.788970:    nbcon_release+0x30/0xa0
0x00000000000164FD |      2.788978:    serial_core_register_port+0x4a4/0x64c
0x00000000000164FD |      2.788985:    serial_ctrl_register_port+0x10/0x1c
0x00000000000164FD |      2.788993:    uart_add_one_port+0x10/0x1c
0x00000000000164FD |      2.789001:    qcom_geni_serial_probe+0x2a4/0x450
0x00000000000164FE |      2.789007:    platform_probe+0x68/0xdc
0x00000000000164FE |      2.789016:    really_probe+0x148/0x2ac
0x00000000000164FE |      2.789022:    __driver_probe_device+0x78/0x12c
0x00000000000164FE |      2.789028:    driver_probe_device+0x3c/0x164
0x00000000000164FF |      2.789033:    __device_attach_driver+0xb8/0x140
0x00000000000164FF |      2.789039:    bus_for_each_drv+0x84/0xe4
0x00000000000164FF |      2.789044:    __device_attach+0xac/0x1b8
0x00000000000164FF |      2.789049:    device_initial_probe+0x14/0x20
0x00000000000164FF |      2.789054:    bus_probe_device+0xa8/0xac
0x00000000000164FF |      2.789059:    deferred_probe_work_func+0x88/0xc0
0x0000000000016500 |      2.789064:    process_one_work+0x160/0x3a8
0x0000000000016500 |      2.789072:    worker_thread+0x324/0x438
0x0000000000016500 |      2.789077:    kthread+0x118/0x11c
0x0000000000016500 |      2.789088:    ret_from_fork+0x10/0x20
0x0000000000016501 |      2.789098:   Code: f942dc23 f90017e3 d2800003 a900ffff (3942e260)
0x0000000000016501 |      2.789102:   ---[ end trace 0000000000000000 ]---
0x0000000000016501 |      2.789108:   Kernel panic - not syncing: Oops: Fatal exception
0x0000000000016501 |      2.789111:   SMP: stopping secondary CPUs
0x000000000001650C |      2.789446:   Triggering bite
0x000000000001650C |      2.789451:   platform hypervisor:qcom,gh-watchdog: Causing a QCOM Apps Watchdog bite!
0x000000000001650D |      2.789461:   platform hypervisor:qcom,gh-watchdog: vWdog-CTL: 1, vWdog-time since last pet: 1349, vWdog-expired status: 1

Sahil Chandna (1):
  printk: fix NULL ptr dereference in nbcon driver

 kernel/printk/nbcon.c | 3 +++
 1 file changed, 3 insertions(+)

--
2.17.1

