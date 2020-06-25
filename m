Return-Path: <SRS0=JJAB=AG=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A5ADC433E0
	for <linux-rt-users@archiver.kernel.org>; Thu, 25 Jun 2020 17:17:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C65620707
	for <linux-rt-users@archiver.kernel.org>; Thu, 25 Jun 2020 17:17:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404394AbgFYRRb (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 25 Jun 2020 13:17:31 -0400
Received: from mx0b-00000d04.pphosted.com ([148.163.153.235]:54614 "EHLO
        mx0b-00000d04.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2404187AbgFYRRb (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 25 Jun 2020 13:17:31 -0400
X-Greylist: delayed 1314 seconds by postgrey-1.27 at vger.kernel.org; Thu, 25 Jun 2020 13:17:30 EDT
Received: from pps.filterd (m0102895.ppops.net [127.0.0.1])
        by mx0a-00000d04.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05PGkGc0019232;
        Thu, 25 Jun 2020 09:55:35 -0700
Received: from mx0b-00000d03.pphosted.com (mx0b-00000d03.pphosted.com [148.163.153.234])
        by mx0a-00000d04.pphosted.com with ESMTP id 31uus2032t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 Jun 2020 09:55:35 -0700
Received: from pps.filterd (m0206578.ppops.net [127.0.0.1])
        by mx0a-00000d03.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05PGq3EI002471;
        Thu, 25 Jun 2020 09:55:34 -0700
Received: from mx0a-00000d06.pphosted.com (mx0a-00000d06.pphosted.com [148.163.135.119])
        by mx0a-00000d03.pphosted.com with ESMTP id 31uussgxar-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 Jun 2020 09:55:34 -0700
Received: from pps.filterd (m0167936.ppops.net [127.0.0.1])
        by mx0a-00000d06.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05PGr4l6026422;
        Thu, 25 Jun 2020 09:55:33 -0700
Received: from smtp.stanford.edu (smtp6.stanford.edu [171.67.219.73])
        by mx0a-00000d06.pphosted.com with ESMTP id 31uur62f3u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 Jun 2020 09:55:33 -0700
Received: from cm-mail.stanford.edu (cm-mail.stanford.edu [171.64.197.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp.stanford.edu (Postfix) with ESMTPS id 53A1681DAE;
        Thu, 25 Jun 2020 09:55:33 -0700 (PDT)
Received: from unknown54e1adf9a8e5.attlocal.net (108-233-45-179.lightspeed.sntcca.sbcglobal.net [108.233.45.179])
        (authenticated bits=0)
        by cm-mail.stanford.edu (8.14.4/8.14.4) with ESMTP id 05PGtPFQ004214
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
        Thu, 25 Jun 2020 09:55:29 -0700
Cc:     nando@ccrma.Stanford.EDU,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Subject: Re: v5.6.17 (was v5.4.17-rt10) does not boot on intel
To:     ycollette.nospam@free.fr
References: <238119586.495839939.1592647783365.JavaMail.root@zimbra35-e6.priv.proxad.net>
From:   Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Message-ID: <79b3de69-0a62-0591-a7c0-e5c24fa6cd4e@ccrma.stanford.edu>
Date:   Thu, 25 Jun 2020 09:55:25 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <238119586.495839939.1592647783365.JavaMail.root@zimbra35-e6.priv.proxad.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
x-proofpoint-stanford-dir: outbound
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-25_12:2020-06-25,2020-06-25 signatures=0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-25_12:2020-06-25,2020-06-25 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 cotscore=-2147483648 phishscore=0 priorityscore=1501 malwarescore=0
 lowpriorityscore=0 spamscore=0 mlxscore=0 clxscore=1011 adultscore=100
 impostorscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006250105
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 6/20/20 3:09 AM, ycollette.nospam@free.fr wrote:
> Hello,

(best if you start a new thread or change the subject line)

> I am trying to build the last RT kernel on Fedora.
> 
> So, I've downloaded linux-5.6.17 and the last rt patch from kernel.org
> I apply the RT patch to the linux sources.
> I clone https://src.fedoraproject.org/rpms/kernel.git and checked out to f32 branch
> I run $ ./build_configs.sh linux-5.6.17
> I copy linux-5.6.17.x86_64-fedora.config as .config in the linux-5.6.17 directory.
> Then, I do a make xconfig
> I check "General Setup -> Configure standard kernel features (expert users)" to be able to check "Fully preemptible kernel".
> I save the conf and copy the .config file to be able to build the kernel via a spec file.
> 
> I used to build regularly the RT kernel via this procedure (the check "General Setup -> Configure standard kernel features (expert users) is new to 5.6) and it was working fine with 5.4 kernels. Now, the installed kernel doesn't boot.

Any errors?

> Is there something new I am missing to be able to boot the kernel ?
> 
> Maybe it's the options selected by the fedora script which have a problem.
> I doesn't apply any patches to the RT kernel. I just wanted a "vanilla RT kernel" with fedora options but without fedora patches.

Hmmm, I just built a 5.6.17-rt10 for Fedora 32 a couple of days ago and 
it boots on one system I have here (Intel I7 8559U processor, a small 
NUC mobo in a fanless case). I based it on this .src.rpm (from Koji):

kernel-5.6.17-300.fc32.src.rpm

I don't remember doing anything different from previous versions (it is 
now in the Planet CCRMA repo).
-- Fernando
