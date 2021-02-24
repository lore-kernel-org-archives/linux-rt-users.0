Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,TVD_PH_BODY_ACCOUNTS_PRE,
	TVD_PH_BODY_META_ALL,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9087EC433E0
	for <linux-rt-users@archiver.kernel.org>; Wed, 24 Feb 2021 01:51:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 442DF64E79
	for <linux-rt-users@archiver.kernel.org>; Wed, 24 Feb 2021 01:51:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231154AbhBXBvj (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 23 Feb 2021 20:51:39 -0500
Received: from mo-csw1114.securemx.jp ([210.130.202.156]:60498 "EHLO
        mo-csw.securemx.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230367AbhBXBvj (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 23 Feb 2021 20:51:39 -0500
Received: by mo-csw.securemx.jp (mx-mo-csw1114) id 11O1nKsH024041; Wed, 24 Feb 2021 10:49:21 +0900
X-Iguazu-Qid: 2wGrDNODc9wqJHsmkU
X-Iguazu-QSIG: v=2; s=0; t=1614131360; q=2wGrDNODc9wqJHsmkU; m=L5qJcslNc5le9IF6+5FFoJmqYdGjHCjmYyhavF3/Sco=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
        by relay.securemx.jp (mx-mr1112) id 11O1nJZ6017349
        (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 24 Feb 2021 10:49:20 +0900
Received: from enc01.toshiba.co.jp (enc01.toshiba.co.jp [106.186.93.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by imx2-a.toshiba.co.jp (Postfix) with ESMTPS id E08A11000AE;
        Wed, 24 Feb 2021 10:49:19 +0900 (JST)
Received: from hop001.toshiba.co.jp ([133.199.164.63])
        by enc01.toshiba.co.jp  with ESMTP id 11O1nJhd008878;
        Wed, 24 Feb 2021 10:49:19 +0900
From:   Punit Agrawal <punit1.agrawal@toshiba.co.jp>
To:     John Kacur <jkacur@redhat.com>
Cc:     dwagner@suse.de, "Ahmed S . Darwish" <a.darwish@linutronix.de>,
        linux-rt-users@vger.kernel.org, binh1.tranhai@toshiba.co.jp,
        Daniel Sangorrin <daniel.sangorrin@toshiba.co.jp>
Subject: Re: [rteval PATCH 1/2] rteval: cyclictest.py: Make 'model name' optional
References: <20210126021241.112944-1-punit1.agrawal@toshiba.co.jp>
        <20210126021241.112944-2-punit1.agrawal@toshiba.co.jp>
        <291eb74f-aa88-4aee-f49e-201ef2e1bbd6@redhat.com>
Date:   Wed, 24 Feb 2021 10:49:15 +0900
In-Reply-To: <291eb74f-aa88-4aee-f49e-201ef2e1bbd6@redhat.com> (John Kacur's
        message of "Mon, 22 Feb 2021 15:16:59 -0500 (EST)")
X-TSB-HOP: ON
Message-ID: <87k0qyw7z8.fsf@kokedama.swc.toshiba.co.jp>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

John Kacur <jkacur@redhat.com> writes:

> On Tue, 26 Jan 2021, Punit Agrawal wrote:
>
>> Certain architectures such as arm64 don't have a "model name" in
>> /proc/cpuinfo. Relax the requirement to include the model name in the
>> description to allow running rteval on such machines.
>> 
>> Signed-off-by: Punit Agrawal <punit1.agrawal@toshiba.co.jp>
>> ---
>>  rteval/modules/measurement/cyclictest.py | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>> 
>> diff --git a/rteval/modules/measurement/cyclictest.py b/rteval/modules/measurement/cyclictest.py
>> index 232bd6b..afe87f7 100644
>> --- a/rteval/modules/measurement/cyclictest.py
>> +++ b/rteval/modules/measurement/cyclictest.py
>> @@ -217,13 +217,13 @@ class Cyclictest(rtevalModulePrototype):
>>          for core in self.__cpus:
>>              self.__cyclicdata[core] = RunData(core, 'core', self.__priority,
>>                                                logfnc=self._log)
>> -            self.__cyclicdata[core].description = info[core]['model name']
>> +            self.__cyclicdata[core].description = info[core].get('model name', '')
>>  
>>          # Create a RunData object for the overall system
>>          self.__cyclicdata['system'] = RunData('system',
>>                                                'system', self.__priority,
>>                                                logfnc=self._log)
>> -        self.__cyclicdata['system'].description = ("(%d cores) " % self.__numcores) + info['0']['model name']
>> +        self.__cyclicdata['system'].description = ("(%d cores) " % self.__numcores) + info['0'].get('model name', '')
>>  
>>          if self.__sparse:
>>              self._log(Log.DEBUG, "system using %d cpu cores" % self.__numcores)
>> -- 
>> 2.29.2
>> 
>> 
>
> Conceptually this is okay. Maybe we should set a default name of 'unknown' 
> instead of an empty string? Also could you please log the situation when 
> it occurs - perhaps INFO level?

I was not quite happy with relying on 'model name' being the only
descriptor. From the excerpt of /proc/cpuinfo from an arm64 machine, it
includes information that describes the cpu (implementer, architecture,
variant, part, revision) just not 'model name'. Based on previous
discussions on the kernel lists, this is unlikely to change due to
/proc/cpuinfo being considered part of the kernel ABI.

    ...
    processor       : 1
    BogoMIPS        : 200.00
    Features        : fp asimd aes pmull sha1 sha2 crc32 cpuid
    CPU implementer : 0x41
    CPU architecture: 8
    CPU variant     : 0x0
    CPU part        : 0xd03
    CPU revision    : 4
    ...

To account for this, I updated the patch to use the other information if
'model name' is not available. Let me send the new version of the
patches and we can take it from there.

[...]
