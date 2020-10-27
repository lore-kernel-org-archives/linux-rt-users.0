Return-Path: <SRS0=5J30=EC=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B7C5C55179
	for <linux-rt-users@archiver.kernel.org>; Tue, 27 Oct 2020 17:08:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E26C12224A
	for <linux-rt-users@archiver.kernel.org>; Tue, 27 Oct 2020 17:08:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1816638AbgJ0RIO (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 27 Oct 2020 13:08:14 -0400
Received: from mx0b-00000d04.pphosted.com ([148.163.153.235]:41078 "EHLO
        mx0b-00000d04.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1816628AbgJ0RIM (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 27 Oct 2020 13:08:12 -0400
Received: from pps.filterd (m0102891.ppops.net [127.0.0.1])
        by mx0a-00000d04.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 09RH1PIs014961;
        Tue, 27 Oct 2020 10:07:41 -0700
Received: from mx0a-00000d03.pphosted.com (mx0a-00000d03.pphosted.com [148.163.149.244])
        by mx0a-00000d04.pphosted.com with ESMTP id 34ch7kdhwa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 27 Oct 2020 10:07:41 -0700
Received: from pps.filterd (m0214090.ppops.net [127.0.0.1])
        by mx0a-00000d03.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 09RH3GQw001280;
        Tue, 27 Oct 2020 10:07:40 -0700
Received: from mx0a-00000d06.pphosted.com (mx0a-00000d06.pphosted.com [148.163.135.119])
        by mx0a-00000d03.pphosted.com with ESMTP id 34ck9kpa9n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 27 Oct 2020 10:07:39 -0700
Received: from pps.filterd (m0167935.ppops.net [127.0.0.1])
        by mx0a-00000d06.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 09RH2TM9002487;
        Tue, 27 Oct 2020 10:07:39 -0700
Received: from smtp.stanford.edu (smtp4.stanford.edu [171.67.219.72])
        by mx0a-00000d06.pphosted.com with ESMTP id 34cgmhumhe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 27 Oct 2020 10:07:39 -0700
Received: from cm-mail.stanford.edu (cm-mail.stanford.edu [171.64.197.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp.stanford.edu (Postfix) with ESMTPS id 13CD91C1261;
        Tue, 27 Oct 2020 10:07:39 -0700 (PDT)
Received: from unknown54e1adf9a8e5.attlocal.net (c-67-161-27-134.hsd1.ca.comcast.net [67.161.27.134])
        (authenticated bits=0)
        by cm-mail.stanford.edu (8.14.4/8.14.4) with ESMTP id 09RH7Z06028059
        (version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NO);
        Tue, 27 Oct 2020 10:07:38 -0700
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [ANNOUNCE] v5.9.1-rt18
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
References: <20201021125324.ualpvrxvzyie6d7d@linutronix.de>
 <20201021131449.qlwjiq2l6embaii3@linutronix.de>
 <54d33ca5-107e-e269-8c47-a1ae0dc60b0e@ccrma.stanford.edu>
 <20201027082247.rs2h7l3wdzxc5f7i@linutronix.de>
From:   Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Message-ID: <bef33500-43b1-5895-2511-e39d8f1da1d0@ccrma.stanford.edu>
Date:   Tue, 27 Oct 2020 10:07:35 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201027082247.rs2h7l3wdzxc5f7i@linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
x-proofpoint-stanford-dir: outbound
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-10-27_10:2020-10-26,2020-10-27 signatures=0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-10-27_10:2020-10-26,2020-10-27 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 suspectscore=0
 priorityscore=1501 phishscore=0 clxscore=1015 malwarescore=0 mlxscore=0
 bulkscore=0 mlxlogscore=999 spamscore=0 adultscore=100 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010270102
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 10/27/20 1:22 AM, Sebastian Andrzej Siewior wrote:
> On 2020-10-26 23:53:20 [-0700], Fernando Lopez-Lezcano wrote:
>> Maybe I'm doing something wrong but I get a compilation error (see below)
>> when trying to do a debug build (building rpm packages for Fedora). 5.9.1 +
>> rt19...
>>
>> Builds fine otherwise...
> 
> If you could remove CONFIG_TEST_LOCKUP then it should work. I will think
> of something.

Thanks much, I should have figured this out for myself :-( Just toooo 
busy. The compilation process went ahead (not finished yet), let me know 
if there is a proper patch. No hurry...

Thanks!
-- Fernando

