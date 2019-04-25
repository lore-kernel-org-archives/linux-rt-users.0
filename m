Return-Path: <SRS0=auL/=S3=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 360F5C282E1
	for <linux-rt-users@archiver.kernel.org>; Thu, 25 Apr 2019 12:17:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EED40218D3
	for <linux-rt-users@archiver.kernel.org>; Thu, 25 Apr 2019 12:17:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727812AbfDYMRr (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 25 Apr 2019 08:17:47 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:47918 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726071AbfDYMRr (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 25 Apr 2019 08:17:47 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3PCFBhj166512
        for <linux-rt-users@vger.kernel.org>; Thu, 25 Apr 2019 08:17:45 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2s3bsbjrc7-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-rt-users@vger.kernel.org>; Thu, 25 Apr 2019 08:17:45 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-rt-users@vger.kernel.org> from <zohar@linux.ibm.com>;
        Thu, 25 Apr 2019 13:17:43 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 25 Apr 2019 13:17:40 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x3PCHd3d46203030
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 Apr 2019 12:17:39 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2B702A4051;
        Thu, 25 Apr 2019 12:17:39 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6196DA4057;
        Thu, 25 Apr 2019 12:17:38 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.95.60])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 25 Apr 2019 12:17:38 +0000 (GMT)
Subject: Re: [PATCH] x86/ima: Check EFI_RUNTIME_SERVICES before using
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Scott Wood <swood@redhat.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Cc:     linux-integrity@vger.kernel.org, linux-rt-users@vger.kernel.org
Date:   Thu, 25 Apr 2019 08:17:27 -0400
In-Reply-To: <20190423224807.4008-1-swood@redhat.com>
References: <20190423224807.4008-1-swood@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19042512-0020-0000-0000-000003358D64
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19042512-0021-0000-0000-00002187F932
Message-Id: <1556194647.3894.106.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-25_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904250078
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Tue, 2019-04-23 at 17:48 -0500, Scott Wood wrote:
> Checking efi_enabled(EFI_BOOT) is not sufficient to ensure that
> EFI runtime services are available, e.g. if efi=noruntime is used.
> 
> Without this, I get an oops on a PREEMPT_RT kernel where efi=noruntime is
> the default.
> 
> Fixes: 399574c64eaf94e8 ("x86/ima: retry detecting secure boot mode")
> Signed-off-by: Scott Wood <swood@redhat.com>

Thanks!

> ---
>  arch/x86/kernel/ima_arch.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/arch/x86/kernel/ima_arch.c b/arch/x86/kernel/ima_arch.c
> index e47cd9390ab4..2a2e87717bad 100644
> --- a/arch/x86/kernel/ima_arch.c
> +++ b/arch/x86/kernel/ima_arch.c
> @@ -17,6 +17,11 @@ static enum efi_secureboot_mode get_sb_mode(void)
>  
>  	size = sizeof(secboot);
>  
> +	if (!efi_enabled(EFI_RUNTIME_SERVICES)) {
> +		pr_info("ima: secureboot mode unknown, no efi\n");
> +		return efi_secureboot_mode_unknown;
> +	}
> +
>  	/* Get variable contents into buffer */
>  	status = efi.get_variable(efi_SecureBoot_name, &efi_variable_guid,
>  				  NULL, &size, &secboot);

