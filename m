Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011046.outbound.protection.outlook.com [52.101.52.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5FA94D37CB
	for <linux-rt-users@vger.kernel.org>; Fri,  9 Oct 2026 15:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791560050; cv=fail; b=LJR3V7QXhGl6K//IwoSJidxjrEfcQHzgPaKgm2wdSzu5/2Vc6RHTolfxER8+T79TiKYIFyvDI+G0skrnxfetUIWya4TCsRTC3mHwlfDB4HSPEHiHJ4zrmxPsWHH3R+D0x/+Umc238xzaFvqL6ClNOFEFgrfMRcpw0SBjllz3frM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791560050; c=relaxed/simple;
	bh=Lwv0dgO/FKV4GJO5YyFh6PD04gMYry5KQuXeA40bgJU=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=E7Z/8SWV0uRjjVb0jqNC8rDak9S6syxp5TcqtgbMyCsFeJZ5RRv8GeNoR6DceA9lLhqZq2p6BOsnyW+1yUSR4cOQTT/LbI0AWcPgziEg+QbuFHYMXhlevQp+Z8PQuRvdhex3Ypd3spl3ynNf9z2fXpKt8xyYjaVX85MsTl1cNLE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=eaton.com; spf=pass smtp.mailfrom=eaton.com; dkim=pass (2048-bit key) header.d=eaton.com header.i=@eaton.com header.b=pSCVXpJx; arc=fail smtp.client-ip=52.101.52.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=eaton.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eaton.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=eaton.com header.i=@eaton.com header.b="pSCVXpJx"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GOd45temTxGYI6gIWZnUbESeby+kjALH2skjxoZ2CPV/vLAvgOmGxzi3Jts0ijZBBbJxyymKP6Eb2CUMw+MmD6uwIos8nQGZJZ+8fPHV7wqvepw2QyJVWXHKmbjhjqtUdXBkW4ZilAu6o61Nl9CSZu3oYt9u7HyZIcVSq2Ofc20ZG3FpyJHIA7ngYRfK0XoDZutjfq17gdcz7JZJ8/h0P24wVtRmAW4lWgvxyrNp9VxlJ0ytsaoVKcSuZ51GJrlo/Hq7UbtdPde1DaT2vUY0DcihF4YjPCI8UPr9VlMxU2ZyC260Go9Po3uyJISgn466+AinKBNnOlpr9siOCvFCZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bcVrYx0e6VFASzGW26eb3TDvefNnraRuyfTLtGZ9kXM=;
 b=Y6e9zZ4Tpr4xguqmNRq5vveEqUfuAQzXlWqVVfbujJ2Sr7c1bOCgVd7gGFONqHZbvbjjrQdZydK2VCYAESoG1DiUPH1MACNXNLAZaQWMMETXXFrhUMIIFiVSMfW140lnvI7Re9EmW8kcGfETkix8LobE2DJuM2DrZ+29JSWDLtKQ2exE/Ks31sUWa0yItCTsCL1Aiop/TpL/lVrGR8tZSeO4r3cRZK4eDdRvDTBiyjh8wkRLXZCI9k+SQKoo2u3kN22bbZ+K4kbOTgKMwEVIQ+bmZM85gX2EKj0kDjaXnSbIBKh+zbekRszMPusfLSGPZhlVFGdBipaFjH1ynzkWTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eaton.com; dmarc=pass action=none header.from=eaton.com;
 dkim=pass header.d=eaton.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=eaton.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bcVrYx0e6VFASzGW26eb3TDvefNnraRuyfTLtGZ9kXM=;
 b=pSCVXpJxoqD5KF4awz2NHqZg6aiS03bcGvGysY0qalk0tJfJINHIWmO+4XeBTP7jY1PIPbJKEmYTQ5pHet+0a4gSS+K7DHTSRWLIG+KPL6vbsmn8gtJLBMbnxTnK9YlCdhcirE7EdOxfYrDN1fQV7Dgzsx0e2dXacYRT0tl6HNxEsooYxElRHlUAOqptPbLhu2hJuuinGC9u1ckZE/5E330hmYRQHj2NohqnNslT/0nGKJKXeMSLPjqqUn5SCT5KdLKf30/yqWefsdb8iRpJwPj1GiKK2oMbYekfIB4U5q48v+UxM4cC4kaMKP/mNY6BzAQcb0BUKpM9gJcK/BBwjQ==
Received: from PH0PR17MB4277.namprd17.prod.outlook.com (2603:10b6:510:a::15)
 by SA3PR17MB7018.namprd17.prod.outlook.com (2603:10b6:806:2f2::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.16; Fri, 9 Oct
 2026 15:34:03 +0000
Received: from PH0PR17MB4277.namprd17.prod.outlook.com
 ([fe80::f000:695f:be77:9fd2]) by PH0PR17MB4277.namprd17.prod.outlook.com
 ([fe80::f000:695f:be77:9fd2%3]) with mapi id 15.21.0496.015; Fri, 9 Oct 2026
 15:34:02 +0000
From: "Naulls, Peter" <PeterNaulls@eaton.com>
To: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
Subject: Btrfs PREEMPT_RT transaction-waiter livelock: experimental mitigation
 in kernel 6.6.78
Thread-Topic: Btrfs PREEMPT_RT transaction-waiter livelock: experimental
 mitigation in kernel 6.6.78
Thread-Index: AQHdV/zYoCdqLEUpiUCMf474Lb+SQQ==
Date: Fri, 9 Oct 2026 15:34:02 +0000
Message-ID:
 <PH0PR17MB4277167A37B20340B231443FBB922@PH0PR17MB4277.namprd17.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_ff418558-72e5-4d8e-958f-cfe0e73e210d_Enabled=True;MSIP_Label_ff418558-72e5-4d8e-958f-cfe0e73e210d_SiteId=d6525c95-b906-431a-b926-e9b51ba43cc4;MSIP_Label_ff418558-72e5-4d8e-958f-cfe0e73e210d_SetDate=2026-10-09T15:07:52.588Z;MSIP_Label_ff418558-72e5-4d8e-958f-cfe0e73e210d_Name=Internal
 (IP2);MSIP_Label_ff418558-72e5-4d8e-958f-cfe0e73e210d_ContentBits=1;MSIP_Label_ff418558-72e5-4d8e-958f-cfe0e73e210d_Method=Standard;
drawingcanvaselements: []
composetype: newMail
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eaton.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR17MB4277:EE_|SA3PR17MB7018:EE_
x-ms-office365-filtering-correlation-id: f4c916e4-20fd-4d30-2340-08df261abefe
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|38070700021|56012099006|10067099003|11063799006|18002099003|6133799003;
x-microsoft-antispam-message-info:
 egCxE8ZunfpBR+jwEVgGTCZZjlXX/vPjyRsaEQ4+uH2uaxH592SAnZCbtx0xrHBcipYxqLHGepl2+KYjdLPTCtI26NNNl82tb6x7AZwhzqln5yxixMWXzsdCEHZIk6HczuzdVEDeG/CBHedXz3PSiewyjKTUwpZwAdVXf0bPNSedgtwxJHpdVF3VUIHO8sFfYhRN6KjMXuQh0DQ1rq58xdac5Jmgj3BFc+paHj7dcz6P4qi8lV3u4yNxLktl4210n6bHB3CBPE/J6CHtIINPt8qR+pPyemNMpzR1OrhmjyRLsQ65nPJ9IFFDuczV4Zs2pLZgkfbWilw/hG6KEowQMKODBHhKZMIJ6OoBHLB2I/3lCvQ/r4Ck9NiitvI+rxcmOX43WVOkoTKEDMEJAw85+ZF+JfJM0hwTcUS9mpbW/6J6QPLjrnEyMlXxfEaIvoq7WbdyIKtohzkvz/XnIZGneLfDKQGZtuj1arADqh4p4/35x9e7+q+kHKhpWvA1kytwlxeT20hdThVTDMhBVN5YmPp7eCIXuGTCi1+G3IEKnbDSP0n7SqCVlIj4TIl0/zu+GPnCMnYAwZsA60NxXaT7kUTxFz/O3OmOHeLto6rJnWNq6+U3JTAKtkJT2J622+PcnMroSvtmVSwfvXBAOowg+tTjpcht7LOC494Kiy9gWo7cpc+l3gT62hCOV/UIhc0PJdt3NHHvjF7mp9PP0yy2E6tb4CFlNu+Vzw7VEICPabw=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR17MB4277.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(38070700021)(56012099006)(10067099003)(11063799006)(18002099003)(6133799003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?kr42ZyzZPxvw8U7ku5K9qWgLsOc5Oxd/SVZ+HMFWulffvpMbNcewrDdsXi?=
 =?iso-8859-1?Q?xyA5yhtb4fCqVR9yWswUHq6jdYh+buWZgs10zqhotMOBnxIL4PBNb/zWiG?=
 =?iso-8859-1?Q?cXkmjHHY84IBVysYqZRvGiRxc9QKoVdlM+swZ18mMt/vvXLnkALQcVo+qG?=
 =?iso-8859-1?Q?Izn2JjBXA+dIe9pVwr6SxmjP5BLuAs4W2QS+vz+OVG5qyKMeSD/D8SRNI5?=
 =?iso-8859-1?Q?83Tz8vXmp2ypywj7yzIlZTNUCPrrGn007JxMRWiJDVtxQ/YN5kD8LoU3CI?=
 =?iso-8859-1?Q?UE5j+atJt2dn1XDx2NjLCG4JQ95/h0TuYI/uA31JPrTiYKeNckIw22TPtJ?=
 =?iso-8859-1?Q?ZlXdncc/SWejOek8XRNYZuI2i99FyPZycqyl+h1JsELIj0FjfKN/ZLhYvT?=
 =?iso-8859-1?Q?n8BNruV0V9Rm5yAXA+hBpRa1Nm6YfmehJUCPG16C0kDRhzA21/lWIuDg5d?=
 =?iso-8859-1?Q?+3SnQCU81Wadf1rt9DrJ1NB6Cwdyt0yEhbGUe/NSu9kE5pQZaudOMGdJDT?=
 =?iso-8859-1?Q?TXWhFPaE6+dsh4Z+mBPkciSmQ5rK8eznordCCtTQv17eeVR9XsZXBkYN3N?=
 =?iso-8859-1?Q?UUUgnbPhs8jDUHRpjUlFspPBpDYLt5RZXm0+yy+4hGJ6r5CjpmZoW9Sj0u?=
 =?iso-8859-1?Q?gXYE1RN0vke6r3XYF+vMTgZ75jD8WYt1lF90KDfWza6TZhUlMVUowBYXTa?=
 =?iso-8859-1?Q?10Kwrofr7bPFLt+Cx2XT0K++gcgVo1PMbPGDH1qHf0KuVv0Z8rM/mfqWyW?=
 =?iso-8859-1?Q?VTnqpTZMx0srdGfohPkvr4TyhHg4/Vpc4Ljk5Tn5IiThaElyCMddn08SsS?=
 =?iso-8859-1?Q?52IgaE2kq6jQmBC+uTExuWj5KGP5pnMFYQ2GaJEHBn90dDU2wzAsFgvv7V?=
 =?iso-8859-1?Q?XFPbmSIpkn8CCEcnXIQrTk5qyyhf5pEiGIiYTVklElQNibQqnesiiORpSv?=
 =?iso-8859-1?Q?Eh1wbdIV507Iw/1VOu76kZ1JPpML7yPBECMb7voBw4nQWQfQSqZa4qWrtU?=
 =?iso-8859-1?Q?54NJ5w03xuSufkfzyzCmvGGHrEdRYsRz7Bn+GCZGD3fBQNOjCzjX+X58OU?=
 =?iso-8859-1?Q?64wELIRh1ScK9Y4FFNRiUu5MP5taoQuOCzTZGqNU+ZrHd5OGFVck4rCGEe?=
 =?iso-8859-1?Q?QMSv8O5jVwa3bJdBCpdQcPjyr6nx40LXVU8CQlW9ySkPe5NFzfj/TiN5XF?=
 =?iso-8859-1?Q?EQ3rHtR5cwNMeW7w1i1VnUGf5vf5+SHV6MnQB0jrrynGPNgn1Peq3RUfAI?=
 =?iso-8859-1?Q?iJRlAffQ3fvHka5EM72nwH/oXjljoxh9fuFC5g8jPFM5/p1STyoCwp/681?=
 =?iso-8859-1?Q?36nErMa4bWq2cwOVMsZLEymGmi5xAxCwy1KANgtA0WR20iLWjv9mYUyTyc?=
 =?iso-8859-1?Q?MHHcN2KNvzsdmBnj3VdPP8c2zbSYsyZoXHV++ZtpceDZO6H+P0FtWTqjwx?=
 =?iso-8859-1?Q?leVCSzMeRE7GKMKA35teDGo0cFRKHdiX1tWS3vBSTOal4lVnOOj0PHBzns?=
 =?iso-8859-1?Q?/g5qv/g3ssjDYqgFkt/Vx9Sf4KAcjuFb30ID3saZi193I8Skdg39ISIPPE?=
 =?iso-8859-1?Q?FT+8c5dr5Q8+Xe/uMJzEFe1F7JsCDrhXmNaaMZlaMdMFNaUXI/Sn87tW0l?=
 =?iso-8859-1?Q?3RXUPYdA4o4tU9FiC2F/2/HwGWA0wUKObsDwQJ22lx4r1XJW40KozbpAur?=
 =?iso-8859-1?Q?eT6H7fnYCbTW9C+o1WaTwRzDMahtKOK6Boyt+zhumDffPPCNYdIi8Utvz0?=
 =?iso-8859-1?Q?NyE6I5d01bt8ML4+IeYH18rqYGIoBre8rO8EbV7zRnHJFs?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: eaton.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR17MB4277.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4c916e4-20fd-4d30-2340-08df261abefe
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2026 15:34:02.4730
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d6525c95-b906-431a-b926-e9b51ba43cc4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UvYmdp/7Fzy/oHzPmjyf9edfGKD0gyj+XcveYWN4C57hTmNBxJdOwW9KHe5/bFdJxvSsC/qHYxuDWjav7swBQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR17MB7018

Long term kernel hacker, but very infrequent contributor.=A0=0A=
=0A=
We are using the RT kernel patch on x86 under kernel 6.6.78-rt51. Specifica=
lly, this is the kernel from meta-intel in Yocto Scarthgap in the intel-ker=
nel-rt recipe.=A0=0A=
=0A=
It appears under some high load conditions, and especially triggered by cal=
ls to sync(), there is a live lock condition in the btrfs code. I used copi=
lot for this analysis, with apologies due here where relevant. I'm familiar=
 with kernel code, and I'm well aware how complex filesystem interactions c=
an be.=A0=0A=
=0A=
Here is the lock we observe:=0A=
=0A=
=0A=
sync (PID 52371)=0A=
=A0 btrfs_commit_transaction+0xc48=0A=
=A0 =A0 [return address immediately after rt_spin_lock(&fs_info->trans_lock=
)]=0A=
=A0 btrfs_sync_fs=0A=
=A0 sync_fs_one_sb=0A=
=A0 ksys_sync=0A=
=0A=
ordered-I/O completion workers=0A=
=A0 join_transaction+0x2b=0A=
=A0 =A0 [return address immediately after rt_spin_lock(&fs_info->trans_lock=
)]=0A=
=A0 start_transaction=0A=
=A0 btrfs_join_transaction=0A=
=A0 btrfs_finish_one_ordered=0A=
=A0 btrfs_work_helper=0A=
=0A=
journal/fsync callers=0A=
=A0 wait_current_trans+0x33=0A=
=A0 =A0 [return address immediately after rt_spin_lock(&fs_info->trans_lock=
)]=0A=
=A0 start_transaction=0A=
=A0 btrfs_start_transaction=0A=
=A0 btrfs_sync_file=0A=
=A0 vfs_fsync_range=0A=
=A0 fsync=0A=
=0A=
btrfs-transaction thread=0A=
=A0 transaction_kthread+0x76=0A=
=A0 =A0 [return address immediately after rt_spin_lock(&fs_info->trans_lock=
)]=0A=
=A0 kthread=0A=
=0A=
=0A=
The processes are then not killable, indicting a kernel thread problem.=A0=
=0A=
=0A=
This was largely found because our userspace code calls sync() excessively =
(being separately addressed), although that's not the proximate cause. We e=
nded up writing shell script which writes blocks of data to a brtfs partiti=
on over several threads and also calls sync and were able to repeat it with=
in 10s of seconds. It is not repeatable in the non-RT kernel.=0A=
=0A=
To add:=0A=
=0A=
I have been extensively through the later kernels in 6.6, and later series =
and have not found any direct fixe or references for this. I've also been t=
hrough the latest RT changes and btrfs mailing lists/changes (and this post=
 might be served better there) and cannot find any direct reference to this=
. The only close match is:=0A=
=0A=
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?id=
=3D99da896614d17e8a84aeb2b2d464ac046cc8633d=0A=
=0A=
This is in related code. I put this patch into our 6.6.78 kernel and it did=
 not resolve the problem.=A0=0A=
=0A=
With that in mind, I had copilot (again, apologies) have an attempt. It cam=
e up with this:=0A=
=0A=
# Experimental mitigation for a suspected PREEMPT_RT Btrfs transaction-wait=
er=0A=
# livelock. wait_for_commit() can reselect a completed transaction that rem=
ains=0A=
# on trans_list after its waiters are woken. Skip completed entries while s=
till=0A=
# waiting for older incomplete transactions. This is a diagnostic hypothesi=
s,=0A=
# not a confirmed fix for the observed lockup.=0A=
# Review notes: the scan is O(n) under trans_lock. Completion state is publ=
ished=0A=
# locklessly elsewhere; READ_ONCE provides a single load, not acquire order=
ing.=0A=
# A multi-hour run did not reproduce the issue, but the lock owner and root=
 cause=0A=
# remain unknown.=0A=
diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c=0A=
index e15e1855fa0a..0f05fabe451c 100644=0A=
--- a/fs/btrfs/transaction.c=0A=
+++ b/fs/btrfs/transaction.c=0A=
@@ -865,6 +865,7 @@ static noinline void wait_for_commit(struct btrfs_trans=
action *commit,=0A=
                                     const enum btrfs_trans_state min_state=
)=0A=
 {=0A=
        struct btrfs_fs_info *fs_info =3D commit->fs_info;=0A=
+       struct btrfs_transaction *next;=0A=
        u64 transid =3D commit->transid;=0A=
        bool put =3D false;=0A=
=0A=
@@ -893,10 +894,16 @@ static noinline void wait_for_commit(struct btrfs_tra=
nsaction *commit,=0A=
                 */=0A=
=0A=
                spin_lock(&fs_info->trans_lock);=0A=
-               commit =3D list_first_entry_or_null(&fs_info->trans_list,=
=0A=
-                                                 struct btrfs_transaction,=
=0A=
-                                                 list);=0A=
-               if (!commit || commit->transid > transid) {=0A=
+               commit =3D NULL;=0A=
+               list_for_each_entry(next, &fs_info->trans_list, list) {=0A=
+                       if (next->transid > transid)=0A=
+                               break;=0A=
+                       if (READ_ONCE(next->state) =3D=3D TRANS_STATE_COMPL=
ETED)=0A=
+                               continue;=0A=
+                       commit =3D next;=0A=
+                       break;=0A=
+               }=0A=
+               if (!commit) {=0A=
                        spin_unlock(&fs_info->trans_lock);=0A=
                        break;=0A=
                }=0A=
=0A=
=0A=
Note the O(N) time here. To that end, this is very unlikely to be the corre=
ct fix, but I hope it highlights the core problem. I ran this patch for sev=
eral hours with no apparent problem (versus seconds of a lockup in previous=
 testing). =0A=
=0A=
If there's a later kernel patch I've missed, or something else I ought to b=
e looking at or test or need more info, please let me know. =0A=
=0A=
=0A=
